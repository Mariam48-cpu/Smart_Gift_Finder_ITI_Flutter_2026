import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import '../repo/home_repo_interface.dart';

class GetProductsUseCase {
  final HomeRepoInterface repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductItemEntity>> call() async {
    return await repository.getProducts();
  }
}


