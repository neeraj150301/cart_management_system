import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductRepository {
  final String apiUrl = 'https://dummyjson.com/products';

  
  
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['products'];
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
