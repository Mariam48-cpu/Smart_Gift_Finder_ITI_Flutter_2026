import '../../domain/entities/wishlist_item_entity.dart';

class WishlistItemModel extends WishlistItemEntity {
  const WishlistItemModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.rating,
    super.aiExplanation,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json, String docId) {
    return WishlistItemModel(
      id: docId,
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? json['image'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      aiExplanation:
          json['aiExplanation'] as String? ?? json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'aiExplanation': aiExplanation,
    };
  }
}
