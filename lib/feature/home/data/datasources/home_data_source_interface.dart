import 'package:smart_gift_finder/core/model/item/product_item_dto.dart';
abstract class HomeDataSourceInterface {
  Future<List<ProductItemDTO>> getProducts();
  Future<List<ProductItemDTO>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}