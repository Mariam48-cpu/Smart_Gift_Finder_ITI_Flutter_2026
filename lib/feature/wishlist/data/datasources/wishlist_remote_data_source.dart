import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistRemoteDataSource {
  Future<void> toggleFavorite({
    required String userId,
    required String productId,
    Map<String, dynamic>? productData,
  });
  Stream<List<String>> getFavoriteProductIds(String userId);
  Future<List<WishlistItemModel>> getWishlistItems({
    required String userId,
    required List<String> productIds,
  });
}

@LazySingleton(as: WishlistRemoteDataSource)
class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final FirebaseFirestore _firestore;

  WishlistRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> _favoritesRef(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites');
  }

  @override
  Future<void> toggleFavorite({
    required String userId,
    required String productId,
    Map<String, dynamic>? productData,
  }) async {
    final docRef = _favoritesRef(userId).doc(productId);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'productId': productId,
        'name': productData?['name'],
        'price': productData?['price'],
        'imageUrl': productData?['imageUrl'],
        'rating': productData?['rating'],
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Stream<List<String>> getFavoriteProductIds(String userId) {
    return _favoritesRef(userId).snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  @override
  Future<List<WishlistItemModel>> getWishlistItems({
    required String userId,
    required List<String> productIds,
  }) async {
    if (productIds.isEmpty) return [];

    final targetIdsSet = productIds.toSet();

    final favoritesSnap = await _favoritesRef(userId).get();

    if (favoritesSnap.docs.isEmpty) return [];

    return favoritesSnap.docs
        .where((doc) => targetIdsSet.contains(doc.id))
        .map((doc) => WishlistItemModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}
