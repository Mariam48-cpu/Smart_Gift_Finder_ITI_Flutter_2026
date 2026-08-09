import 'product_item_entity.dart';

class ProductItemDTO {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final double rating;
  final String thumbnail;

  ProductItemDTO({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.thumbnail,
  });

  factory ProductItemDTO.fromJson(Map<String, dynamic> json) {
    return ProductItemDTO(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  ProductItemEntity toEntity() {
    return ProductItemEntity(
      id: id,
      title: title,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      imageUrl: thumbnail,
    );
  }
}