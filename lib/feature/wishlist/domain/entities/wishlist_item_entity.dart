class WishlistItemEntity {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final String? aiExplanation;

  const WishlistItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.rating,
    this.aiExplanation,
  });
}
