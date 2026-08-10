import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/core/routes/app_routes.dart';
import 'package:smart_gift_finder/core/widgets/product_item_card.dart';
import 'package:smart_gift_finder/feature/home/data/datasources/home_data_source_imp.dart';
import 'package:smart_gift_finder/feature/home/data/repo/home_repo_imp.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_productbycategory_use_case.dart';
import 'package:smart_gift_finder/feature/home/presentation/view_model/products_by_category_cubit.dart';
import 'package:smart_gift_finder/feature/home/presentation/view_model/products_by_category_state.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String categorySlug;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(
          HomeRepoImp(HomeDataSourceImp(Dio())),
        ),
      )..load(categorySlug),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
          builder: (context, state) {
            if (state is ProductsByCategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductsByCategoryError) {
              return Center(child: Text(state.message));
            }

            if (state is ProductsByCategorySuccess) {
              return Column(
                children: [
                  _BudgetFilterBar(
                    state: state,
                    onBudgetChanged: (min, max) =>
                        context.read<ProductsByCategoryCubit>().applyBudget(
                              min,
                              max,
                            ),
                    onReset: () =>
                        context.read<ProductsByCategoryCubit>().resetBudget(),
                  ),
                  Expanded(
                    child: state.products.isEmpty
                        ? const Center(
                            child: Text('No gifts match your budget'),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.65,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductItemCard(
                                product: product,
                                onTap: () => _openProductDetails(
                                  context,
                                  product,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _openProductDetails(
    BuildContext context,
    ProductItemEntity product,
  ) {
    Navigator.pushNamed(
      context,
      Routes.productDetails,
      arguments: {'productId': product.id},
    );
  }
}

class _BudgetFilterBar extends StatelessWidget {
  final ProductsByCategorySuccess state;
  final void Function(double min, double max) onBudgetChanged;
  final VoidCallback onReset;

  const _BudgetFilterBar({
    required this.state,
    required this.onBudgetChanged,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final hasRange = state.minPrice != state.maxPrice;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        border: const Border(
          bottom: BorderSide(color: Color(0x4DCCC3D8)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Budget',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF151C27),
                ),
              ),
              TextButton(
                onPressed: onReset,
                child: const Text('Reset'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${state.currentMin.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF630ED4),
                ),
              ),
              Text(
                '\$${state.currentMax.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF630ED4),
                ),
              ),
            ],
          ),
          if (hasRange)
            RangeSlider(
              min: state.minPrice,
              max: state.maxPrice,
              values: RangeValues(state.currentMin, state.currentMax),
              divisions: 50,
              labels: RangeLabels(
                '\$${state.currentMin.round()}',
                '\$${state.currentMax.round()}',
              ),
              activeColor: const Color(0xFF630ED4),
              inactiveColor: const Color(0xFFCCC3D8),
              onChanged: (values) {
                onBudgetChanged(values.start, values.end);
              },
            ),
          Text(
            '${state.products.length} gifts in range',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7B7487),
            ),
          ),
        ],
      ),
    );
  }
}
