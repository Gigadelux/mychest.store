import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//TODO complete with body and request params
class CartAPI {
  static const String addCart = "http://localhost:8100/cart/add";
  static const String addToCart = "http://localhost:8100/cart/addItem";
  static const String removeItem = "http://localhost:8100/cart/removeItem";

  Future<Map<String, dynamic>> createCart() async {
    final response = await http.post(Uri.parse(addCart));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cartId', jsonResponse['cartId']);

      return {
        'status': 'success',
        'cartId': jsonResponse['cartId']
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to create cart',
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> addItemToCart(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? cartId = prefs.getInt('cartId');

    final response = await http.post(
      Uri.parse(addToCart),
      body: {
        'cartId': cartId.toString(),
        'productId': productId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'message': 'Item added to cart',
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to add item to cart',
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> removeItemFromCart(int productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? cartId = prefs.getInt('cartId');

    final response = await http.post(
      Uri.parse(removeItem),
      body: {
        'cartId': cartId.toString(),
        'productId': productId.toString(),
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'message': 'Item removed from cart',
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to remove item from cart',
        'error': json.decode(response.body)
      };
    }
  }
}