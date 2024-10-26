import 'dart:convert';
import 'package:http/http.dart' as http;
class OrderAPI {
  static const String payOrder = "http://localhost:8100/orders/pay";
  static const String getOrdersPath = "http://localhost:8100/orders/getOrders";

  Future<Map<String, dynamic>> pay(String postalCode, int cartId, String token) async {
    final response = await http.post(
      Uri.parse("$payOrder?postalCode=$postalCode&id=$cartId"),
      headers: {
        "Authorization": "Bearer $token"
      }
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'newCartID': json.decode(response.body)['newCartID'],
        'message': 'Order paid successfully',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to pay for the order ${response.body}',
      };
    }
  }

  Future<Map<String, dynamic>> getOrders(String token) async {
    final response = await http.get(
      Uri.parse(getOrdersPath),
      headers: {
        "Authorization": "Bearer $token"
      }
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'orders': json.decode(response.body)
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch orders ${response.body}'
      };
    }
  }
}
