import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

sealed class ProductsByCategoryState {}

final class ProductsByCategoryLoading extends ProductsByCategoryState {}

final class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductItemEntity> products;
  final double minPrice;
  final double maxPrice;
  final double currentMin;
  final double currentMax;

  ProductsByCategorySuccess({
    required this.products,
    required this.minPrice,
    required this.maxPrice,
    required this.currentMin,
    required this.currentMax,
  });
}

final class ProductsByCategoryError extends ProductsByCategoryState {
  final String message;

  ProductsByCategoryError(this.message);
}
