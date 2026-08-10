import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import '../repo/home_repo_interface.dart';
class GetProductsByCategoryUseCase {
  final HomeRepoInterface repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<List<ProductItemEntity>> call(String category) async {
    return await repository.getProductsByCategory(category);
  }
}