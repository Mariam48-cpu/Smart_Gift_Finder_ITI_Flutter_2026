// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smart_gift_finder/feature/ai_finder/domain/entities/ai_gift_request_entity.dart';
// import 'package:smart_gift_finder/feature/ai_finder/domain/usecases/get_ai_gift_recommendations_usecase.dart';
// import 'package:smart_gift_finder/feature/ai_finder/presentation/cubit/ai_gift_cubit.dart';
// import 'package:smart_gift_finder/feature/ai_finder/presentation/cubit/ai_gift_state.dart';

// class AIFinderPage extends StatelessWidget {
//   const AIFinderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           AIGiftCubit(context.read<GetAIGiftRecommendationsUseCase>()),
//       child: const AIFinderView(),
//     );
//   }
// }

// class AIFinderView extends StatefulWidget {
//   const AIFinderView({super.key});

//   @override
//   State<AIFinderView> createState() => _AIFinderViewState();
// }

// class _AIFinderViewState extends State<AIFinderView> {
//   final _promptController = TextEditingController();

//   void _submitRequest(BuildContext context) {
//     // تجهيز الـ Request بناء على الإدخال لـ Gemini
//     final request = AIGiftRequestEntity(
//       recipientAge: 22,
//       occasion: 'Graduation',
//       profession: 'Software Engineer',
//       interests: ['Reading', 'Coffee', 'Tech'],
//       budgetLimit: 150.0,
//     );

//     context.read<AIGiftCubit>().getRecommendations(request);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Icon(Icons.auto_awesome, color: Colors.deepPurple),
//             SizedBox(width: 8),
//             Text('GiftAI',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.deepPurple)),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: BlocBuilder<AIGiftCubit, AIGiftState>(
//               builder: (context, state) {
//                 if (state is AIGiftLoading) {
//                   return const Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(color: Colors.deepPurple),
//                         SizedBox(height: 12),
//                         Text('Searching for perfect gifts...'),
//                       ],
//                     ),
//                   );
//                 } else if (state is AIGiftError) {
//                   return Center(
//                     child: Text('Error: ${state.message}',
//                         style: const TextStyle(color: Colors.red)),
//                   );
//                 } else if (state is AIGiftSuccess) {
//                   return ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: state.gifts.length,
//                     itemBuilder: (context, index) {
//                       final gift = state.gifts[index];
//                       return Container(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.deepPurple.shade700,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               gift.name,
//                               style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               gift.reasoning,
//                               style: const TextStyle(
//                                   color: Colors.white70, fontSize: 14),
//                             ),
//                             const SizedBox(height: 12),
//                             Text(
//                               'Estimated Price: \$${gift.estimatedPrice}',
//                               style: const TextStyle(
//                                   color: Colors.greenAccent,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 }

//                 // Initial State View
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),
//                       const Text(
//                         'How can I help you find the perfect gift today?',
//                         style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepPurple),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         'Describe the person or occasion, and I\'ll generate personalized ideas.',
//                         style: TextStyle(color: Colors.grey),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Bottom Input Section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _promptController,
//                     decoration: InputDecoration(
//                       hintText: 'Describe your perfect gift...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 14),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 FloatingActionButton(
//                   backgroundColor: Colors.deepPurple,
//                   onPressed: () => _submitRequest(context),
//                   child: const Icon(Icons.auto_awesome, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
