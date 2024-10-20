import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mychest/data/models/product.dart';

class ProductsAPI {
  static const String getFeatured = "http://localhost:8100/products/featured";
  static const String searchProductsByCategory = "http://localhost:8100/searchByCategory";
  static const String searchProducts = "http://localhost:8100/products/search";

  Future<Map<String, dynamic>> getFeaturedProducts() async {
    final response = await http.get(Uri.parse(getFeatured));
    print("ZIOPERA ${response.statusCode}");

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'featuredProducts': Product.fromJsonList(json.decode(response.body)),
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch featured products',
        'error': response.body
      };
    }
  }

  Future<Map<String, dynamic>> searchProductsByCategoryName(String categoryName) async {
    final response = await http.get(Uri.parse('$searchProductsByCategory?category=$categoryName'));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'products': Product.fromJsonList(json.decode(response.body)),
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to search products by category',
        'error': response.body
      };
    }
  }

  Future<Map<String, dynamic>> searchProductsByName(String productName) async {
    final response = await http.get(Uri.parse('$searchProducts?name=$productName'));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'products': Product.fromJsonList(json.decode(response.body)),
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to search products',
        'error': response.body
      };
    }
  }
}