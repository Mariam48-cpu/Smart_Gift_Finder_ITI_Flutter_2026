import '../../domain/entities/cart_item.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartSuccess extends CartState {
  final List<CartItem> items;
  final double subtotal;
  final double discount;
  final double total;

  const CartSuccess({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
  });
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}