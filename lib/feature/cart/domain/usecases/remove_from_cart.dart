import 'package:injectable/injectable.dart';

import '../repository/cart_repository.dart';
@injectable
class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(String productId) {
    return repository.removeItem(productId);
  }
}