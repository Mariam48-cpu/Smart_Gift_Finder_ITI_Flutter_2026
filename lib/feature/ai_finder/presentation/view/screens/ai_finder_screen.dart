import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// ============================================================
// 1. Models
// ============================================================

class AIGiftEntity {
  final String name;
  final double estimatedPrice;
  final String reasoning;
  final String imageUrl;

  AIGiftEntity({
    required this.name,
    required this.estimatedPrice,
    required this.reasoning,
    required this.imageUrl,
  });
}

class AIGiftRequestEntity {
  final int recipientAge;
  final String occasion;
  final String profession;
  final List<String> interests;
  final double budgetLimit;

  AIGiftRequestEntity({
    required this.recipientAge,
    required this.occasion,
    required this.profession,
    required this.interests,
    required this.budgetLimit,
  });
}

// ============================================================
// 2. Pexels Service
// ============================================================

class PexelsService {
  final String apiKey = dotenv.env['PEXELS_API_KEY'] ?? '';

  Future<String> getImageForGift(String giftName) async {
    try {
      final url = Uri.parse(
        'https://api.pexels.com/v1/search'
        '?query=${Uri.encodeQueryComponent(giftName)}'
        '&per_page=1'
        '&orientation=landscape',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final photos = data['photos'] as List<dynamic>?;

        if (photos != null && photos.isNotEmpty) {
          return photos.first['src']['large'].toString();
        }
      }

      return '';
    } catch (e) {
      debugPrint('Pexels Error: $e');
      return '';
    }
  }
}
// ============================================================
// 3. Gemini Service
// ============================================================

class DirectGeminiService {
  final PexelsService pexelsService;

  DirectGeminiService(this.pexelsService);

  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<List<AIGiftEntity>> fetchGiftRecommendations(
    AIGiftRequestEntity request,
  ) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/'
      'models/gemini-2.5-flash:generateContent?key=$apiKey',
    );

    final prompt = '''
Suggest 3 gift ideas based on:

- Age: ${request.recipientAge}
- Profession: ${request.profession}
- Occasion: ${request.occasion}
- Interests: ${request.interests.join(', ')}
- Max Budget: \$${request.budgetLimit}

Return ONLY a JSON array with objects containing:

"name" (string)
"estimatedPrice" (number)
"reasoning" (string)

The estimated price must be within the maximum budget.

No markdown.
No commentary.
Only valid JSON.
''';

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": prompt,
              }
            ]
          }
        ],
        "generationConfig": {
          "responseMimeType": "application/json",
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch from Gemini API '
        '(${response.statusCode}): ${response.body}',
      );
    }

    final data = jsonDecode(response.body);

    final String rawText = data['candidates'][0]['content']['parts'][0]['text'];

    final List<dynamic> jsonList = jsonDecode(rawText);

    // ========================================================
    // Get a real Pexels image for every gift
    // ========================================================

    final gifts = await Future.wait(
      jsonList.asMap().entries.map(
        (entry) async {
          final item = entry.value;

          final name = item['name']?.toString() ?? 'Gift Idea';

          final imageUrl = await pexelsService.getImageForGift(name);

          return AIGiftEntity(
            name: name,
            estimatedPrice:
                (item['estimatedPrice'] as num?)?.toDouble() ?? 50.0,
            reasoning: item['reasoning']?.toString() ?? '',
            imageUrl: imageUrl,
          );
        },
      ),
    );

    return gifts;
  }
}

// ============================================================
// 4. Cubit & States
// ============================================================

abstract class AIGiftState {}

class AIGiftInitial extends AIGiftState {}

class AIGiftLoading extends AIGiftState {}

class AIGiftSuccess extends AIGiftState {
  final List<AIGiftEntity> gifts;

  AIGiftSuccess(this.gifts);
}

class AIGiftEmpty extends AIGiftState {}

class AIGiftError extends AIGiftState {
  final String message;

  AIGiftError(this.message);
}

// ============================================================
// 5. Cubit
// ============================================================

class AIGiftCubit extends Cubit<AIGiftState> {
  final DirectGeminiService service;

  AIGiftCubit(this.service) : super(AIGiftInitial());

  Future<void> fetchGifts(
    AIGiftRequestEntity request,
  ) async {
    emit(AIGiftLoading());

    try {
      final gifts = await service.fetchGiftRecommendations(request);

      if (gifts.isEmpty) {
        emit(AIGiftEmpty());
      } else {
        emit(AIGiftSuccess(gifts));
      }
    } catch (e) {
      emit(AIGiftError(e.toString()));
    }
  }
}

// ============================================================
// 6. UI Screen
// ============================================================

class AIFinderScreen extends StatefulWidget {
  const AIFinderScreen({super.key});

  @override
  State<AIFinderScreen> createState() => _AIFinderScreenState();
}

class _AIFinderScreenState extends State<AIFinderScreen> {
  final _formKey = GlobalKey<FormState>();

  final _ageController = TextEditingController();
  final _professionController = TextEditingController();
  final _interestController = TextEditingController();

  String _selectedOccasion = 'Birthday';

  double _budgetLimit = 100.0;

  final List<String> _interests = [];

  final List<String> _occasions = [
    'Birthday',
    'Graduation',
    'Wedding',
    'Anniversary',
    'New Job',
  ];

  // ==========================================================
  // Add Interest
  // ==========================================================

  void _addInterest() {
    final text = _interestController.text.trim();

    if (text.isNotEmpty && !_interests.contains(text)) {
      setState(() {
        _interests.add(text);
        _interestController.clear();
      });
    }
  }

  // ==========================================================
  // Submit Form
  // ==========================================================

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_interests.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please add at least one interest tag',
            ),
          ),
        );

        return;
      }

      final request = AIGiftRequestEntity(
        recipientAge: int.parse(
          _ageController.text,
        ),
        occasion: _selectedOccasion,
        profession: _professionController.text.trim(),
        interests: _interests,
        budgetLimit: _budgetLimit,
      );

      context.read<AIGiftCubit>().fetchGifts(request);
    }
  }

  // ==========================================================
  // Dispose
  // ==========================================================

  @override
  void dispose() {
    _ageController.dispose();
    _professionController.dispose();
    _interestController.dispose();

    super.dispose();
  }

  // ==========================================================
  // Build
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AIGiftCubit(
        DirectGeminiService(
          PexelsService(),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'AI Gift Finder',
          ),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // Age + Profession
                    // ==================================================

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Age',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _professionController,
                            decoration: const InputDecoration(
                              labelText: 'Profession',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // ==================================================
                    // Occasion
                    // ==================================================

                    DropdownButtonFormField<String>(
                      initialValue: _selectedOccasion,
                      decoration: const InputDecoration(
                        labelText: 'Occasion',
                        border: OutlineInputBorder(),
                      ),
                      items: _occasions
                          .map(
                            (o) => DropdownMenuItem(
                              value: o,
                              child: Text(o),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(
                            () => _selectedOccasion = val,
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    // ==================================================
                    // Budget
                    // ==================================================

                    Text(
                      'Budget Limit: \$${_budgetLimit.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Slider(
                      value: _budgetLimit,
                      min: 10,
                      max: 1000,
                      divisions: 99,
                      label: '\$${_budgetLimit.round()}',
                      onChanged: (val) {
                        setState(
                          () => _budgetLimit = val,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    // ==================================================
                    // Interests
                    // ==================================================

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _interestController,
                            decoration: const InputDecoration(
                              labelText: 'Add Interest (e.g. Coffee, Tech)',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (_) => _addInterest(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.deepPurple,
                            size: 36,
                          ),
                          onPressed: _addInterest,
                        ),
                      ],
                    ),

                    Wrap(
                      spacing: 8,
                      children: _interests
                          .map(
                            (tag) => Chip(
                              label: Text(tag),
                              onDeleted: () {
                                setState(
                                  () => _interests.remove(tag),
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // ==================================================
                    // Find Gifts Button
                    // ==================================================

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => _submitForm(
                          context,
                        ),
                        child: const Text(
                          'Find Gifts with AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // ==================================================
                    // Results
                    // ==================================================

                    BlocBuilder<AIGiftCubit, AIGiftState>(
                      builder: (context, state) {
                        // ============================
                        // Loading
                        // ============================

                        if (state is AIGiftLoading) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        // ============================
                        // Empty
                        // ============================

                        else if (state is AIGiftEmpty) {
                          return const Center(
                            child: Text(
                              'No gift recommendations found.',
                            ),
                          );
                        }

                        // ============================
                        // Error
                        // ============================

                        else if (state is AIGiftError) {
                          return Center(
                            child: Text(
                              'Error: ${state.message}',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          );
                        }

                        // ============================
                        // Success
                        // ============================

                        else if (state is AIGiftSuccess) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.gifts.length,
                            itemBuilder: (context, index) {
                              final gift = state.gifts[index];

                              return Card(
                                margin: const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 3,
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ==================================================
                                    // Gift Image
                                    // ==================================================

                                    gift.imageUrl.isNotEmpty
                                        ? Image.network(
                                            gift.imageUrl,
                                            height: 160,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (
                                              context,
                                              child,
                                              loadingProgress,
                                            ) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }

                                              return Container(
                                                height: 160,
                                                width: double.infinity,
                                                color: Colors.purple.shade50,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );
                                            },
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Container(
                                                height: 160,
                                                width: double.infinity,
                                                color: Colors.purple.shade100,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.card_giftcard,
                                                    size: 50,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            height: 160,
                                            width: double.infinity,
                                            color: Colors.purple.shade100,
                                            child: const Center(
                                              child: Icon(
                                                Icons.card_giftcard,
                                                size: 50,
                                                color: Colors.deepPurple,
                                              ),
                                            ),
                                          ),

                                    // ==================================================
                                    // Gift Details
                                    // ==================================================

                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ============================================
                                          // Name + Price
                                          // ============================================

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  gift.name,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '\$${gift.estimatedPrice.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(
                                            height: 12,
                                          ),

                                          // ============================================
                                          // AI Reasoning
                                          // ============================================

                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.purple.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.purple.shade200,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.auto_awesome,
                                                      color: Colors.deepPurple,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      'Why AI Chose This:',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.deepPurple,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  gift.reasoning,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          const SizedBox(
                                            height: 12,
                                          ),

                                          // ============================================
                                          // Add To Cart
                                          // ============================================

                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '${gift.name} added to cart!',
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
