import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

abstract class HomeRepoInterface {
  Future<List<ProductItemEntity>> getProducts();
  Future<List<ProductItemEntity>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}
