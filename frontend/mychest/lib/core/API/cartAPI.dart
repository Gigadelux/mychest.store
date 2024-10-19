import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//TODO complete with body and request params
class CartAPI {
  static const String addCart = "http://localhost:8100/cart/add";
  static const String addToCart = "http://localhost:8100/cart/addItem";
  static const String removeItem = "http://localhost:8100/cart/removeItem";

  Future<Map<String, dynamic>> createCart(String token) async {
    final uri = Uri.parse(addCart);
    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('cartId', jsonResponse['cartId']);

      return {
        'status': response.statusCode,
        'cartId': jsonResponse['cartId']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to create cart',
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> addItemToCart(String productName, int quantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? cartId = prefs.getInt('cartId');
    String? email = prefs.getString('email');
    final response = await http.post(
      Uri.parse(addToCart),
      body: {
        'cartId': cartId,
        'email': email,
        'productName':productName,
        'quantity':quantity
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'cart': json.decode(response.body),
        'message': 'Item added to cart',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to add item to cart',
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> removeItemFromCart(String productName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? cartId = prefs.getInt('cartId');
    String? email = prefs.getString('email');
    final response = await http.post(
      Uri.parse(removeItem),
      body: {
        'cartId': cartId,
        'email':email,
        'productName': productName,
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'cart': json.decode(response.body),
        'message': 'Item removed from cart',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to remove item from cart',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }
}