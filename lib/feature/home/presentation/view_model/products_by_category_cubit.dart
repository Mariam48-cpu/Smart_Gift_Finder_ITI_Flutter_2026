import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_productbycategory_use_case.dart';
import 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  ProductsByCategoryCubit(this._getProductsByCategory)
      : super(ProductsByCategoryLoading());

  final GetProductsByCategoryUseCase _getProductsByCategory;

  List<ProductItemEntity> _allProducts = const [];

  Future<void> load(String categorySlug) async {
    emit(ProductsByCategoryLoading());
    try {
      _allProducts = await _getProductsByCategory(categorySlug);

      if (_allProducts.isEmpty) {
        emit(
          ProductsByCategorySuccess(
            products: [],
            minPrice: 0,
            maxPrice: 0,
            currentMin: 0,
            currentMax: 0,
          ),
        );
        return;
      }

      final minPrice = _allProducts
          .map((product) => product.price)
          .reduce((a, b) => a < b ? a : b);
      final maxPrice = _allProducts
          .map((product) => product.price)
          .reduce((a, b) => a > b ? a : b);

      emit(
        ProductsByCategorySuccess(
          products: _allProducts,
          minPrice: minPrice,
          maxPrice: maxPrice,
          currentMin: minPrice,
          currentMax: maxPrice,
        ),
      );
    } catch (e) {
      emit(ProductsByCategoryError(e.toString()));
    }
  }

  void applyBudget(double minPrice, double maxPrice) {
    if (state is! ProductsByCategorySuccess) return;
    final current = state as ProductsByCategorySuccess;

    final filtered = _allProducts
        .where(
          (product) => product.price >= minPrice && product.price <= maxPrice,
        )
        .toList();

    emit(
      ProductsByCategorySuccess(
        products: filtered,
        minPrice: current.minPrice,
        maxPrice: current.maxPrice,
        currentMin: minPrice,
        currentMax: maxPrice,
      ),
    );
  }

  void resetBudget() {
    if (state is! ProductsByCategorySuccess) return;
    final current = state as ProductsByCategorySuccess;

    emit(
      ProductsByCategorySuccess(
        products: _allProducts,
        minPrice: current.minPrice,
        maxPrice: current.maxPrice,
        currentMin: current.minPrice,
        currentMax: current.maxPrice,
      ),
    );
  }
}
