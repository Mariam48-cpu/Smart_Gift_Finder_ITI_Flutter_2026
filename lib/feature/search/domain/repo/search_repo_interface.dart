 import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

abstract class SearchRepoInterface {

  Future<List<ProductItemEntity>> searchProducts(String query);
}