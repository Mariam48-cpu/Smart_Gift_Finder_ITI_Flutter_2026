import 'package:injectable/injectable.dart';
import '../../domain/entities/wishlist_item_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_data_source.dart';

@LazySingleton(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource _remoteDataSource;

  WishlistRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> toggleFavorite({
    required String userId,
    required String productId,
  }) async {
    return await _remoteDataSource.toggleFavorite(
      userId: userId,
      productId: productId,
    );
  }

  @override
  Stream<List<String>> getFavoriteProductIds(String userId) {
    return _remoteDataSource.getFavoriteProductIds(userId);
  }

  @override
  Future<List<WishlistItemEntity>> getWishlistItems(
      List<String> productIds) async {
    return await _remoteDataSource.getWishlistItems(productIds);
  }
}
