import 'dart:convert';

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final Map<String, double> dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Map<String, dynamic>> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Map<String, String> meta;
  final List<String> images;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: json['price'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      rating: json['rating'],
      stock: json['stock'],
      tags: List<String>.from(json['tags']),
      brand: json['brand'] ?? 'Unknown',
      sku: json['sku'],
      weight: json['weight'].toDouble(),
      dimensions: {
        'width': json['dimensions']['width'].toDouble(),
        'height': json['dimensions']['height'].toDouble(),
        'depth': json['dimensions']['depth'].toDouble(),
      },
      warrantyInformation: json['warrantyInformation'],
      shippingInformation: json['shippingInformation'],
      availabilityStatus: json['availabilityStatus'],
      reviews: List<Map<String, dynamic>>.from(json['reviews']),
      returnPolicy: json['returnPolicy'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      meta: Map<String, String>.from(json['meta']),
      images: List<String>.from(json['images']),
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags.join(','),
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': jsonEncode(dimensions),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': jsonEncode(reviews),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': jsonEncode(meta),
      'images': images.join(','),
      'thumbnail': thumbnail,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      discountPercentage: map['discountPercentage'],
      rating: map['rating'],
      stock: map['stock'],
      tags: map['tags'].split(','),
      brand: map['brand'] ?? 'unknown',
      sku: map['sku'],
      weight: map['weight'],
      dimensions: {},
      warrantyInformation: map['warrantyInformation'],
      shippingInformation: map['shippingInformation'],
      reviews: [], 
      availabilityStatus: map['availabilityStatus'],
      returnPolicy: map['returnPolicy'],
      minimumOrderQuantity: map['minimumOrderQuantity'],
      meta: {}, 
      images: map['images'].split(','),
      thumbnail: map['thumbnail'],
    );
  }
}
