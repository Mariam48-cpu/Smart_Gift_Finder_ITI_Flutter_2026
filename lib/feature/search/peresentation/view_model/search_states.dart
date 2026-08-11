
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<ProductItemEntity> products;
  SearchSuccessState(this.products);
}

class SearchErrorState extends SearchStates {
  final String message;
  SearchErrorState(this.message);
}