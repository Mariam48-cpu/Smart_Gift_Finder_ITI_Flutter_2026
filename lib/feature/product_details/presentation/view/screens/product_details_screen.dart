import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/routes/app_routes.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../cart/domain/entities/cart_item.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../cart/presentation/screens/cart_screen.dart';
import '../product_details_cubit.dart';
import 'product_images_slider.dart';
import 'product_info_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, this.productId = 1});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(ProductDetailsService(Dio()))
        ..fetchProductDetails(productId),
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
                  _buildBottomBar(context,product),
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
            child: OutlinedButton.icon(
              onPressed: () async {
                final cartCubit = context.read<CartCubit>();
                await cartCubit.addItem(
                  CartItem(
                    id: product['id'].toString(),
                    title: product['title'] ?? '',
                    imageUrl: (product['images'] != null && (product['images'] as List).isNotEmpty)
                        ? product['images'][0]
                        : '',
                    price: (product['price'] ?? 0).toDouble(),
                    quantity: 1,
                  ),
                );

                cartCubit.loadCart();

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: cartCubit,
                        child: const CartScreen(),
                      ),
                    ),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Color(0xFFC2185B)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.add_shopping_cart, color: Color(0xFFC2185B)),
              label: const Text(
                'Add to Cart',
                style: TextStyle(
                    color: Color(0xFFC2185B), fontWeight: FontWeight.bold),
              ),
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
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
