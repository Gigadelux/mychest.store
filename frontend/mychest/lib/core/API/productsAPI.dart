import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductsAPI {
  static const String getFeatured = "http://localhost:8100/products/featured";
  static const String searchProductsByCategory = "http://localhost:8100/searchByCategory";
  static const String searchProducts = "http://localhost:8100/products/search";

  Future<Map<String, dynamic>> getFeaturedProducts() async {
    final response = await http.get(Uri.parse(getFeatured));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'featuredProducts': json.decode(response.body)
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch featured products',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> searchProductsByCategoryName(String categoryName) async {
    final response = await http.get(Uri.parse('$searchProductsByCategory?category=$categoryName'));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'products': json.decode(response.body)
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to search products by category',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> searchProductsByName(String productName) async {
    final response = await http.get(Uri.parse('$searchProducts?name=$productName'));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'products': json.decode(response.body)
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to search products',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }
}