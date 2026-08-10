
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_gift_finder/core/model/item/product_item_dto.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/feature/search/domain/repo/search_data_source_interface.dart';

@Injectable(as: SearchDataSourceInterface)
class SearchDataSourceImp implements SearchDataSourceInterface {
  final Dio _dio;

  SearchDataSourceImp(this._dio);

  @override
  Future<List<ProductItemEntity>> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/search',
        queryParameters: {
          'q': query,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];

        return productsJson
            .map(
              (json) => ProductItemDTO.fromJson(
                json as Map<String, dynamic>,
              ).toEntity(),
            )
            .toList();
      } else {
        throw Exception('Failed to fetch search results');
      }
    } on DioException catch (e) {
      throw Exception(
        e.message ?? 'Network error',
      );
    }
  }
}
