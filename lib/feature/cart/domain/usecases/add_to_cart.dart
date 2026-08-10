import 'package:injectable/injectable.dart';

import '../entities/cart_item.dart';
import '../repository/cart_repository.dart';
@injectable
class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(CartItem item) {
    return repository.addItem(item);
  }
}