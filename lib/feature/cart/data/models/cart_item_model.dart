import 'package:smart_gift_finder/feature/cart/domain/entities/cart_item.dart';

class CartItemModel extends CartItem{
  CartItemModel({required super.id, required super.title, required super.imageUrl, required super.price, required super.quantity});
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['product_id'].toString(),
      title: json['title'],
      imageUrl: json['image_url'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'title': title,
      'image_url': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

}