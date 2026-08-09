import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/get_cart.dart';
import '../../domain/usecases/remove_from_cart.dart';
import '../../domain/usecases/update_cart_quantity.dart';
import 'cart_state.dart';
@injectable
class CartCubit extends Cubit<CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final UpdateCartQuantity updateCartQuantity;
  final RemoveFromCart removeFromCart;

  CartCubit({
    required this.getCart,
    required this.addToCart,
    required this.updateCartQuantity,
    required this.removeFromCart,
  }) : super(const CartInitial());

  Future<void> loadCart() async {
    emit(const CartLoading());

    try {
      final items = await getCart();

      emit(_buildLoadedState(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(CartItem item) async {
    try {
      await addToCart(item);

      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      await updateCartQuantity(productId, quantity);

      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(String productId) async {
    try {
      await removeFromCart(productId);

      await loadCart();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  CartSuccess _buildLoadedState(List<CartItem> items) {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.itemTotal);

    const discount = 0.0;

    final total = subtotal - discount;

    return CartSuccess(
      items: items,
      subtotal: subtotal,
      discount: discount,
      total: total,
    );
  }
}
