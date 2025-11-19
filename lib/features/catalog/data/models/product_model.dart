import '../../domain/entities/product.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final ProductRating? rating;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
      rating: json['rating'] != null
          ? ProductRating(
              rate: (json['rating']['rate'] as num?)?.toDouble() ?? 0.0,
              count: json['rating']['count'] as int? ?? 0,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      if (rating != null)
        'rating': {
          'rate': rating!.rate,
          'count': rating!.count,
        },
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: product.rating,
    );
  }
}

