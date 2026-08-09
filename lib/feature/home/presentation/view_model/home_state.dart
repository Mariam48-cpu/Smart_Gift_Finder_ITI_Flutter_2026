import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductItemEntity> products;
  final List<String> categories;
  final String selectedCategory;
  final bool isProductsLoading;

  HomeSuccessState({
    required this.products,
    required this.categories,
    required this.selectedCategory,
    this.isProductsLoading = false,
  });
}

class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState(this.message);
}