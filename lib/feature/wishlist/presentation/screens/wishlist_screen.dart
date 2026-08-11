import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/item/product_item_entity.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/product_item_card.dart';
import '../../../cart/domain/entities/cart_item.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../cubit/wishlist_cubit.dart';
import '../cubit/wishlist_state.dart';

class WishlistScreen extends StatefulWidget {
  final String userId;

  const WishlistScreen({
    super.key,
    required this.userId,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().initFavoritesStream(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Saved Gifts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6C5CE7),
              ),
            );
          }

          if (state is WishlistError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No saved gifts yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];

                return ProductItemCard(
                  product: ProductItemEntity(
                    id: int.tryParse(item.id) ?? 0,
                    title: item.name,
                    price: item.price,
                    discountPercentage: 0,
                    rating: item.rating,
                    imageUrl: item.imageUrl,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.productDetails,
                      arguments: {'productId': int.tryParse(item.id) ?? 1},
                    );
                  },
                  onAddToCart: () async {
                    final cartCubit = context.read<CartCubit>();

                    await cartCubit.addItem(
                      CartItem(
                        id: item.id,
                        title: item.name,
                        imageUrl: item.imageUrl,
                        price: item.price,
                        quantity: 1,
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
