import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/routes/app_routes.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_state.dart';
import 'package:smart_gift_finder/feature/home/data/datasources/home_data_source_imp.dart';
import 'package:smart_gift_finder/feature/home/data/repo/home_repo_imp.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_categories_use_case.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_productbycategory_use_case.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_products_use_case.dart';
import '../../../../../core/widgets/product_item_card.dart';
import '../../../../cart/domain/entities/cart_item.dart';
import '../../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../cart/presentation/screens/cart_screen.dart';
import '../../view_model/home_cubit.dart';
import '../../view_model/home_state.dart';
import '../widget/category_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final dataSource = HomeDataSourceImp(dio);
    final repo = HomeRepoImp(dataSource);

    return BlocProvider(
      create: (context) => HomeCubit(
        getProductsUseCase: GetProductsUseCase(repo),
        getProductsByCategoryUseCase: GetProductsByCategoryUseCase(repo),
        getCategoriesUseCase: GetCategoriesUseCase(repo),
      )..fetchHomeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  final imageUrl = state is AccountSuccess &&
                          state.account.imageUrl.isNotEmpty
                      ? state.account.imageUrl
                      : null;
                  return CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        imageUrl != null ? NetworkImage(imageUrl) : null,
                    child: imageUrl == null
                        ? const Icon(Icons.person, color: Colors.grey)
                        : null,
                  );
                },
              ),
              const SizedBox(width: 12),
              const Text(
                'Smart Gift Finder',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.search);
                },
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            } else if (state is HomeSuccessState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF3B28CC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF3B28CC).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Find the Perfect Gift',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'AI-curated ideas for everyone.',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.auto_awesome,
                                    size: 16,
                                    color: Color(0xFF3B28CC),
                                  ),
                                  label: const Text(
                                    'Try AI Finder',
                                    style: TextStyle(
                                      color: Color(0xFF3B28CC),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.card_giftcard_rounded,
                            size: 70,
                            color: Colors.white24,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        separatorBuilder: (context, _) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return CategoryItem(
                            title: category,
                            isSelected: category == state.selectedCategory,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.categories,
                                arguments: {
                                  'categorySlug': category,
                                  'categoryName': category,
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending Products',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<HomeCubit>().resetCategory();
                          },
                          child: const Text('See All >'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    state.isProductsLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductItemCard(
                                product: product,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.productDetails,
                                    arguments: {'productId': product.id},
                                  );
                                },
                                onAddToCart: () async {
                                  final product = state.products[index];

                                  final cartCubit = context.read<CartCubit>();

                                  await cartCubit.addItem(
                                    CartItem(
                                      id: product.id.toString(),
                                      title: product.title,
                                      imageUrl: product.imageUrl,
                                      price: product.price.toDouble(),
                                      quantity: 1,
                                    ),
                                  );

                                  if (!context.mounted) return;
                                },
                              );
                            },
                          ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
