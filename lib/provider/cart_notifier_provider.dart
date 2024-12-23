import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cart_item_model.dart';
import '../model/product_model.dart';
import '../repository/database_helper.dart';

class CartNotifier extends StateNotifier<Map<String, CartItem>> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  CartNotifier() : super({}) {
    _loadCartFromDatabase();
  }

  void _loadCartFromDatabase() async {
    final cartItems = await dbHelper.getCartItems();
    final Map<String, CartItem> cartMap = {};

    for (var cartItem in cartItems) {
      cartMap[cartItem.product.id.toString()] = cartItem;
    }

    state = cartMap;
  }

  void addToCart(Product product) async {
    final cartItem = CartItem(product: product);

    state = {
      ...state,
      product.id.toString(): state[product.id.toString()] != null
          ? CartItem(
              product: product,
              quantity: state[product.id.toString()]!.quantity + 1,
            )
          : cartItem,
    };
    await dbHelper.addProductToCart(cartItem);
  }

  void updateQuantity(String productId, int quantity) async {
    if (state.containsKey(productId)) {
      if (quantity > 0) {
        state = {
          ...state,
          productId:
              CartItem(product: state[productId]!.product, quantity: quantity),
        };
        await dbHelper.updateProductQuantity(productId, quantity);
      } else {
        
        removeFromCart(productId);
      }
    }
  }

  void removeFromCart(String productId) async {
    state = {
      ...state..remove(productId),
    };
    await dbHelper.removeProductFromCart(productId);
  }

  int get totalItems =>
      state.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      state.values.fold(0, (sum, item) => sum + item.totalPrice);
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, CartItem>>(
  (ref) => CartNotifier(),
);
