import '../entities/wishlist_item_entity.dart';

abstract class WishlistRepository {
  Future<void> toggleFavorite({
    required String userId,
    required String productId,
    Map<String, dynamic>? productData,
  });
  Stream<List<String>> getFavoriteProductIds(String userId);
  Future<List<WishlistItemEntity>> getWishlistItems({
    required String userId,
    required List<String> productIds,
  });
}
