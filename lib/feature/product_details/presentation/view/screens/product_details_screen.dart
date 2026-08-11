import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../cart/domain/entities/cart_item.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../cart/presentation/cubit/cart_state.dart';
import '../../../../wishlist/presentation/screens/widgets/favorite_button.dart';
import '../product_details_cubit.dart';
import 'product_images_slider.dart';
import 'product_info_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, this.productId = 1});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _awaitingAdd = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(ProductDetailsService(Dio()))
        ..fetchProductDetails(widget.productId),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          title: const Text(
            'Product Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is! ProductDetailsSuccess) {
                  return const SizedBox.shrink();
                }

                final product = state.product;
                final userId =
                    FirebaseAuth.instance.currentUser?.uid ?? 'test_user_id';

                return FavoriteButton(
                  productId: product['id'].toString(),
                  userId: userId,
                  productData: {
                    'name': product['title'] ?? '',
                    'price': product['price'] ?? 0,
                    'imageUrl': (product['images'] != null &&
                            (product['images'] as List).isNotEmpty)
                        ? product['images'][0]
                        : '',
                    'rating': product['rating'] ?? 0,
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product link copied!')),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is ProductDetailsSuccess) {
              final product = state.product;
              final List<dynamic> rawImages = product['images'] ?? [];
              final List<String> images =
                  rawImages.map((e) => e.toString()).toSet().toList();

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProductImagesSlider(images: images),
                          ProductInfoSection(
                            title: product['title'] ?? '',
                            description: product['description'] ?? '',
                            price: product['price'] ?? 0,
                            discountPercentage:
                                product['discountPercentage'] ?? 0,
                            rating: product['rating'] ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomBar(context, product),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, dynamic product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                if (!_awaitingAdd) return;
                if (state is CartSuccess) {
                  _awaitingAdd = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Added to cart successfully!'),
                    ),
                  );
                } else if (state is CartError) {
                  _awaitingAdd = false;
                }
              },
              builder: (context, state) {
                return OutlinedButton.icon(
                  onPressed: () async {
                    _awaitingAdd = true;
                    final cartCubit = context.read<CartCubit>();
                    await cartCubit.addItem(
                      CartItem(
                        id: product['id'].toString(),
                        title: product['title'] ?? '',
                        imageUrl: (product['images'] != null &&
                                (product['images'] as List).isNotEmpty)
                            ? product['images'][0]
                            : '',
                        price: (product['price'] ?? 0).toDouble(),
                        quantity: 1,
                      ),
                    );

                    cartCubit.loadCart();

                    // if (context.mounted) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => BlocProvider.value(
                    //         value: cartCubit,
                    //         child: const CartScreen(),
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: Color(0xFFC2185B)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.add_shopping_cart,
                      color: Color(0xFFC2185B)),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(
                        color: Color(0xFFC2185B), fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.checkout);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4D39E9),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'Buy Now',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
