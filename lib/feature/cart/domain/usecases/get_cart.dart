import 'package:injectable/injectable.dart';

import '../entities/cart_item.dart';
import '../repository/cart_repository.dart';
@injectable
class GetCart {
  final CartRepository repository;

  GetCart(this.repository);

  Future<List<CartItem>> call() {
    return repository.getCart();
  }
}