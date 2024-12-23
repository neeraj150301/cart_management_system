import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'database_helper.dart';

class ProductRepository {
  final String apiUrl = 'https://dummyjson.com/products';

    final dbHelper = DatabaseHelper.instance;

  Future<List<Product>> fetchProducts() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      print("Fetching products from API...");
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['products'];
        final products =
            data.map<Product>((item) => Product.fromJson(item)).toList();

        await dbHelper.insertProducts(products);

        return products;
      } else {
        throw Exception('Failed to load products from API');
      }
    } else {
       print("Fetching products from local database...");
      final products = await dbHelper.fetchAllProducts();
      if (products.isNotEmpty) {
        return products;
      } else {
        throw Exception('No products available offline');
      }
    }
  }
}
