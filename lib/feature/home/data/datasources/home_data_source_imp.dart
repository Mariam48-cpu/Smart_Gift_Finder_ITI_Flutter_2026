import 'package:dio/dio.dart';
import 'package:smart_gift_finder/core/model/item/product_item_dto.dart';
import 'home_data_source_interface.dart';

class HomeDataSourceImp implements HomeDataSourceInterface {
  final Dio dio;

  HomeDataSourceImp(this.dio);

  @override
  Future<List<ProductItemDTO>> getProducts() async {
    final response = await dio.get('https://dummyjson.com/products');
    final List data = response.data['products'];
    return data.map((json) => ProductItemDTO.fromJson(json)).toList();
  }

  @override
  Future<List<ProductItemDTO>> getProductsByCategory(String category) async {
    final response = await dio.get(
      'https://dummyjson.com/products/category/$category',
    );
    final List data = response.data['products'];
    return data.map((json) => ProductItemDTO.fromJson(json)).toList();
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await dio.get(
      'https://dummyjson.com/products/category-list',
    );
    final List data = response.data;
    return data.map((e) => e.toString()).toList();
  }
}
