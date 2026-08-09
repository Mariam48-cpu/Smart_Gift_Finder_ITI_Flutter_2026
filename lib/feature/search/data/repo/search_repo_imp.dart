import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/feature/search/domain/repo/search_data_source_interface.dart';

@Injectable(as: SearchDataSourceInterface)
class SearchRepoImp implements SearchDataSourceInterface {
  final SearchDataSourceInterface _searchDataSource;

  SearchRepoImp(this._searchDataSource);

  @override
  Future<List<ProductItemEntity>> searchProducts(String query) =>
      _searchDataSource.searchProducts(query);
}