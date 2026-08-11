import '../entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<void> toggleFavorite(
      {required String userId, required String productId});
  Stream<List<String>> getFavoriteProductIds(String userId);
  Future<List<WishlistItemEntity>> getWishlistItems(List<String> productIds);
}
