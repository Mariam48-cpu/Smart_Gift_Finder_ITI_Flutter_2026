import 'package:injectable/injectable.dart';

import '../repository/cart_repository.dart';
@injectable
class UpdateCartQuantity {
  final CartRepository repository;

  UpdateCartQuantity(this.repository);

  Future<void> call(
      String productId,
      int quantity,
      ) {
    return repository.updateQuantity(
      productId,
      quantity,
    );
  }
}