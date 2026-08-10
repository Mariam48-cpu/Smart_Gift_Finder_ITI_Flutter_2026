import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCart();

  Future<void> addItem(CartItem item);

  Future<void> updateQuantity(
      String productId,
      int quantity,
      );

  Future<void> removeItem(String productId);
}