import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';

abstract class SearchDataSourceInterface {
  Future<List<ProductItemEntity>> searchProducts(String query);
}