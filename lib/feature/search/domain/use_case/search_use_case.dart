import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/feature/search/domain/repo/search_repo_interface.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepoInterface _searchRepo;

  SearchProductsUseCase(this._searchRepo);

  Future<List<ProductItemEntity>> invoke(String query) =>
      _searchRepo.searchProducts(query);
}