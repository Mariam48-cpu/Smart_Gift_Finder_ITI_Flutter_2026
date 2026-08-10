import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import '../datasources/home_data_source_interface.dart';
import '../../domain/repo/home_repo_interface.dart';

class HomeRepoImp implements HomeRepoInterface {
  final HomeDataSourceInterface dataSource;

  HomeRepoImp(this.dataSource);

  @override
  Future<List<ProductItemEntity>> getProducts() async {
    final dtos = await dataSource.getProducts();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<ProductItemEntity>> getProductsByCategory(String category) async {
    final dtos = await dataSource.getProductsByCategory(category);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    return await dataSource.getCategories();
  }
}