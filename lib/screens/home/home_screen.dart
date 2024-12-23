import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/cart_notifier_provider.dart';
import '../../provider/product_provider.dart';
import '../../widgets/product_card.dart';
import '../cart/cart_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productAsyncValue = ref.watch(productProvider);
// final cartNotifier = ref.watch(cartProvider.notifier);
    final totalItems = ref.watch(cartProvider).values.fold<int>(
          0,
          (previousValue, cartItem) => previousValue + cartItem.quantity,
        );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Products List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          badges.Badge(
            badgeContent: Text(
              totalItems.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: productAsyncValue.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}
