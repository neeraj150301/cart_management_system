import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/product_model.dart';
import '../repository/product_repository.dart';


final productProvider = FutureProvider<List<Product>>((ref) async {
  final productRepository = ProductRepository();
  return await productRepository.fetchProducts();
});
