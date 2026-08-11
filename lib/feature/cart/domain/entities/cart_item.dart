class CartItem {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  const CartItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  double get itemTotal => price * quantity;
}