import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'title': product.title,
      'price': product.price,
      'quantity': quantity,
      'imageUrl': product.thumbnail,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product(
        id: map['productId'] != null ? map['productId'] as int : 0,
        title: map['title'],
        price: map['price'],
        description: '',
        category: '',
        discountPercentage: 0.0,
        rating: 0.0,
        stock: 0,
        tags: [],
        brand: '',
        sku: '',
        weight: 0.0,
        dimensions: {},
        warrantyInformation: '',
        shippingInformation: '',
        availabilityStatus: '',
        reviews: [],
        returnPolicy: '',
        minimumOrderQuantity: 0,
        meta: {},
        images: [],
        thumbnail: map['imageUrl'] ?? '',
      ),
      quantity: map['quantity'],
    );
  }
}
