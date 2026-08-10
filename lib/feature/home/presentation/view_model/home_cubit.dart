import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_case/get_categories_use_case.dart';
import '../../domain/use_case/get_productbycategory_use_case.dart';
import '../../domain/use_case/get_products_use_case.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit({
    required this.getProductsUseCase,
    required this.getProductsByCategoryUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitialState());

  void fetchHomeData() async {
    emit(HomeLoadingState());
    try {
      final products = await getProductsUseCase();
      final categories = await getCategoriesUseCase();
      emit(
        HomeSuccessState(
          products: products,
          categories: categories,
          selectedCategory: '',
        ),
      );
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  void selectCategory(String category) async {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      if (currentState.selectedCategory == category) return;

      emit(
        HomeSuccessState(
          products: currentState.products,
          categories: currentState.categories,
          selectedCategory: category,
          isProductsLoading: true,
        ),
      );

      try {
        final filteredProducts = await getProductsByCategoryUseCase(category);
        emit(
          HomeSuccessState(
            products: filteredProducts,
            categories: currentState.categories,
            selectedCategory: category,
            isProductsLoading: false,
          ),
        );
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    }
  }

  void resetCategory() async {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      if (currentState.selectedCategory.isEmpty) return;

      emit(
        HomeSuccessState(
          products: currentState.products,
          categories: currentState.categories,
          selectedCategory: '',
          isProductsLoading: true,
        ),
      );

      try {
        final allProducts = await getProductsUseCase();
        emit(
          HomeSuccessState(
            products: allProducts,
            categories: currentState.categories,
            selectedCategory: '',
            isProductsLoading: false,
          ),
        );
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    }
  }
}
