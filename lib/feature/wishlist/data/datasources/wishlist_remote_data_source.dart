import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/wishlist_item_model.dart';

abstract class WishlistRemoteDataSource {
  Future<void> toggleFavorite(
      {required String userId, required String productId});
  Stream<List<String>> getFavoriteProductIds(String userId);
  Future<List<WishlistItemModel>> getWishlistItems(List<String> productIds);
}

@LazySingleton(as: WishlistRemoteDataSource)
class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final FirebaseFirestore _firestore;

  WishlistRemoteDataSourceImpl(this._firestore);

  @override
  Future<void> toggleFavorite(
      {required String userId, required String productId}) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId);

    final doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Stream<List<String>> getFavoriteProductIds(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  @override
  Future<List<WishlistItemModel>> getWishlistItems(
      List<String> productIds) async {
    if (productIds.isEmpty) return [];

    final allProductsSnap = await _firestore.collection('products').get();

    if (allProductsSnap.docs.isEmpty) return [];

    final targetIdsSet = productIds.map((id) => id.trim()).toSet();

    List<WishlistItemModel> items = [];

    for (var doc in allProductsSnap.docs) {
      final docId = doc.id.trim();
      final data = doc.data();

      final String? fieldId = data['id']?.toString().trim();
      final String? fieldProductId = data['productId']?.toString().trim();

      bool matches = targetIdsSet.contains(docId) ||
          (fieldId != null && targetIdsSet.contains(fieldId)) ||
          (fieldProductId != null && targetIdsSet.contains(fieldProductId));

      if (matches) {
        items.add(WishlistItemModel.fromJson(data, doc.id));
      }
    }

    return items;
  }
}
