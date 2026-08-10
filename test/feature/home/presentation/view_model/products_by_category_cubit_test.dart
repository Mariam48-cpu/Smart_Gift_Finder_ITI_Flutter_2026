import 'package:flutter_test/flutter_test.dart';
import 'package:smart_gift_finder/core/model/item/product_item_entity.dart';
import 'package:smart_gift_finder/feature/home/domain/repo/home_repo_interface.dart';
import 'package:smart_gift_finder/feature/home/domain/use_case/get_productbycategory_use_case.dart';
import 'package:smart_gift_finder/feature/home/presentation/view_model/products_by_category_cubit.dart';
import 'package:smart_gift_finder/feature/home/presentation/view_model/products_by_category_state.dart';

class _FakeHomeRepo implements HomeRepoInterface {
  final Object? error;
  final List<ProductItemEntity> products;

  _FakeHomeRepo({this.products = const [], this.error});

  @override
  Future<List<ProductItemEntity>> getProducts() async => products;

  @override
  Future<List<ProductItemEntity>> getProductsByCategory(String category) async {
    if (error != null) throw error!;
    return products;
  }

  @override
  Future<List<String>> getCategories() async => const [];
}

ProductItemEntity _product(int id, double price) => ProductItemEntity(
      id: id,
      title: 'Gift $id',
      price: price,
      discountPercentage: 0,
      rating: 4.5,
      imageUrl: '',
    );

void main() {
  group('ProductsByCategoryCubit', () {
    test('load computes min/max price range and shows all products', () async {
      final cubit = ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(
          _FakeHomeRepo(
            products: [_product(1, 10.5), _product(2, 25.75), _product(3, 8.0)],
          ),
        ),
      );

      await cubit.load('beauty');

      final state = cubit.state;
      expect(state, isA<ProductsByCategorySuccess>());
      final success = state as ProductsByCategorySuccess;
      expect(success.products, hasLength(3));
      expect(success.minPrice, 8.0);
      expect(success.maxPrice, 25.75);
      expect(success.currentMin, 8.0);
      expect(success.currentMax, 25.75);
    });

    test('applyBudget filters products within the selected range', () async {
      final cubit = ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(
          _FakeHomeRepo(
            products: [_product(1, 10.0), _product(2, 30.0), _product(3, 50.0)],
          ),
        ),
      );

      await cubit.load('electronics');
      cubit.applyBudget(10.0, 30.0);

      final success = cubit.state as ProductsByCategorySuccess;
      expect(success.products, hasLength(2));
      expect(success.products.map((p) => p.id), containsAll([1, 2]));
      expect(success.currentMin, 10.0);
      expect(success.currentMax, 30.0);
    });

    test('resetBudget restores the full product list', () async {
      final cubit = ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(
          _FakeHomeRepo(
            products: [_product(1, 10.0), _product(2, 30.0), _product(3, 50.0)],
          ),
        ),
      );

      await cubit.load('electronics');
      cubit.applyBudget(10.0, 30.0);
      expect((cubit.state as ProductsByCategorySuccess).products, hasLength(2));

      cubit.resetBudget();

      final success = cubit.state as ProductsByCategorySuccess;
      expect(success.products, hasLength(3));
      expect(success.currentMin, success.minPrice);
      expect(success.currentMax, success.maxPrice);
    });

    test('load with an empty category emits an empty success state', () async {
      final cubit = ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(_FakeHomeRepo()),
      );

      await cubit.load('empty');

      final success = cubit.state as ProductsByCategorySuccess;
      expect(success.products, isEmpty);
      expect(success.minPrice, 0);
      expect(success.maxPrice, 0);
    });

    test('load with a failing repository emits an error state', () async {
      final cubit = ProductsByCategoryCubit(
        GetProductsByCategoryUseCase(
          _FakeHomeRepo(error: Exception('network down')),
        ),
      );

      await cubit.load('fragile');

      expect(cubit.state, isA<ProductsByCategoryError>());
    });
  });
}
