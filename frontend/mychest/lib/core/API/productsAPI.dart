import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mychest/data/models/product.dart';

class ProductsAPI {
  static const String getFeatured = "http://localhost:8100/products/featured";
  static const String searchProductsByCategory = "http://localhost:8100/products/searchByCategory";
  static const String searchProducts = "http://localhost:8100/products/search";
  static const String mostPopularCategories = "http://localhost:8100/category/mostPopular";

  Future<Map<String, dynamic>> getFeaturedProducts() async {
    final response = await http.get(Uri.parse(getFeatured));
    print("ZIOPERA ${response.body}");
    
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
    print('eccalla $searchProductsByCategory?category=$categoryName');
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

  Future<List<String>> getMostPopularCategories()async{
    List<String> res = [];
    final response = await http.get(Uri.parse("$mostPopularCategories?limit=4"));

    if(response.statusCode == 200){
      List objs = jsonDecode(response.body);
      res = List<String>.generate(objs.length, (index)=>objs[index]['name']);
    }
    print(res);
    return res;
  }
}