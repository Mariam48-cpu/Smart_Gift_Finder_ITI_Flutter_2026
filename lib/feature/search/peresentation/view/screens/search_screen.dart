import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:smart_gift_finder/core/widgets/custom_text_field.dart';
import 'package:smart_gift_finder/core/widgets/product_item_card.dart';
import 'package:smart_gift_finder/feature/search/peresentation/view_model/search_cubit.dart';
import 'package:smart_gift_finder/feature/search/peresentation/view_model/search_states.dart';

// استورد ملف الـ DI الخاص بك (مثل: import 'package:smart_gift_finder/core/di/di.dart';)
// أو استخدم الـ instance المباشر لـ GetIt:
final getIt = GetIt.instance;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => getIt<SearchCubit>(),
      child: const SearchBody(),
    );
  }
}

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Gifts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            CustomTextField(
              controller: _searchController,
              hintText: 'Search gifts...',
              prefixIcon: const Icon(Icons.search),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                context.read<SearchCubit>().onSearchChanged(value);
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Search Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E2C),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocConsumer<SearchCubit, SearchStates>(
                listener: (context, state) {
                  if (state is SearchErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is SearchSuccessState) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Text(
                          'No gifts found.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];

                        return ProductItemCard(
                          product: product,
                          onTap: () {
                            // TODO: Navigate to product details
                          },
                          onAddToCart: () {
                            // TODO: Add product to cart
                          },
                        );
                      },
                    );
                  }

                  if (state is SearchErrorState) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }

                  // Default / Initial State
                  return const Center(
                    child: Text(
                      'Search for gifts you love 🎁',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}