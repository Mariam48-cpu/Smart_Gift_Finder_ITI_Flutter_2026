import 'package:injectable/injectable.dart';

import '../../domain/entities/cart_item.dart';
import '../../domain/repository/cart_repository.dart';
import '../datasource/cart_remote_datasource.dart';
import '../models/cart_item_model.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CartItem>> getCart() {
    return remoteDataSource.getCart();
  }

  @override
  Future<void> addItem(CartItem item) {
    final model = CartItemModel(
      id: item.id,
      title: item.title,
      imageUrl: item.imageUrl,
      price: item.price,
      quantity: item.quantity,
    );

    return remoteDataSource.addItem(model);
  }

  @override
  Future<void> updateQuantity(
      String productId,
      int quantity,
      ) {
    return remoteDataSource.updateQuantity(
      productId,
      quantity,
    );
  }

  @override
  Future<void> removeItem(String productId) {
    return remoteDataSource.removeItem(productId);
  }
}