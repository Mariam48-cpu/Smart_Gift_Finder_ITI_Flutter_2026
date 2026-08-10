class ProductItemEntity {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final double rating;
  final String imageUrl;

  ProductItemEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.imageUrl,
  });
}