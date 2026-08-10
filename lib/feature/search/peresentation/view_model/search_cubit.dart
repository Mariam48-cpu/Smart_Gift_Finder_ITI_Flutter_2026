
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:smart_gift_finder/feature/search/domain/use_case/search_use_case.dart';

import 'search_states.dart';

@injectable
class SearchCubit extends Cubit<SearchStates> {
  final SearchProductsUseCase _searchProductsUseCase;

  Timer? _debounceTimer;

  SearchCubit(this._searchProductsUseCase)
      : super(SearchInitialState());

  void onSearchChanged(String query) {
    // Cancel the previous timer
    _debounceTimer?.cancel();

    // If search field is empty, reset the screen
    if (query.trim().isEmpty) {
      emit(SearchInitialState());
      return;
    }

    // Wait 500ms after the user stops typing
    _debounceTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        searchProducts(query.trim());
      },
    );
  }

  Future<void> searchProducts(String query) async {
    emit(SearchLoadingState());
    try {
      final results = await _searchProductsUseCase.invoke(query);
      emit(SearchSuccessState(results));
    } catch (error) {
   
      emit(SearchErrorState(error.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
