import '../../domain/entities/wishlist_item_entity.dart';

abstract class WishlistState {
  const WishlistState();
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final Set<String> favoriteIds;
  final List<WishlistItemEntity> items;

  const WishlistLoaded({
    required this.favoriteIds,
    required this.items,
  });
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);
}
