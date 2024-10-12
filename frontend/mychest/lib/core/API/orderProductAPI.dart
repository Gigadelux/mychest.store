import 'dart:convert';
import 'package:http/http.dart' as http;
//TODO add params and body
class OrderAPI {
  static const String payOrder = "http://localhost:8100/orders/pay";
  static const String getOrdersPath = "http://localhost:8100/orders/getOrders";

  Future<Map<String, dynamic>> pay(int orderId) async {
    final response = await http.post(
      Uri.parse(payOrder),
      body: {'orderId': orderId.toString()},
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'order': json.decode(response.body),
        'message': 'Order paid successfully',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to pay for the order ${json.decode(response.body)['message']}',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> getOrders() async {
    final response = await http.get(Uri.parse(getOrdersPath));

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'orders': json.decode(response.body)
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch orders',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }
}
