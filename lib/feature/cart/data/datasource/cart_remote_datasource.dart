import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../models/cart_item_model.dart';
@injectable
class CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRemoteDataSource({
    required this.firestore,
    required this.auth,
  });

  String get userId => auth.currentUser!.uid;

  Future<List<CartItemModel>> getCart() async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();

    return snapshot.docs
        .map((doc) => CartItemModel.fromJson(doc.data()))
        .toList();
  }
  Future<void> addItem(CartItemModel item) async {
    final cartRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(item.id);

    final doc = await cartRef.get();

    if (doc.exists) {
      final currentQuantity = doc.data()?['quantity'] ?? 0;

      await cartRef.update({
        'quantity': currentQuantity + 1,
      });
    } else {
      await cartRef.set(item.toJson());
    }
  }

  Future<void> updateQuantity(
      String productId,
      int quantity,
      ) async {
    final cartRef = firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    if (quantity <= 0) {
      await cartRef.delete();
      return;
    }

    await cartRef.update({
      'quantity': quantity,
    });
  }
  Future<void> removeItem(String productId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }
}