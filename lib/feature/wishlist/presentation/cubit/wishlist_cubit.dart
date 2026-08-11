import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import 'wishlist_state.dart';

@injectable
class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository _repository;
  StreamSubscription<List<String>>? _favoritesSubscription;

  Set<String> _currentFavoriteIds = {};
  List<WishlistItemEntity> _currentItems = [];

  WishlistCubit(this._repository) : super(WishlistInitial());

  void initFavoritesStream(String userId) {
    emit(WishlistLoading());
    _favoritesSubscription?.cancel();

    _favoritesSubscription = _repository.getFavoriteProductIds(userId).listen(
      (favoriteIds) async {
        final stringIds = favoriteIds.map((id) => id.toString()).toList();
        _currentFavoriteIds = stringIds.toSet();

        try {
          if (_currentFavoriteIds.isNotEmpty) {
            _currentItems = await _repository
                .getWishlistItems(_currentFavoriteIds.toList());
          } else {
            _currentItems = [];
          }

          emit(WishlistLoaded(
            favoriteIds: Set.from(_currentFavoriteIds),
            items: List.from(_currentItems),
          ));
        } catch (e) {
          emit(WishlistError(e.toString()));
        }
      },
      onError: (error) {
        emit(WishlistError(error.toString()));
      },
    );
  }

  bool isFavorite(String productId) {
    return _currentFavoriteIds.contains(productId);
  }

  Future<void> toggleFavorite({
    required String userId,
    required String productId,
  }) async {
    try {
      await _repository.toggleFavorite(userId: userId, productId: productId);
    } catch (e) {
      initFavoritesStream(userId);
    }
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}