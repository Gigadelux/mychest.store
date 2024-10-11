import 'dart:convert';
import 'package:http/http.dart' as http;
//TODO complete with body and params
class CreditCardAPI {
  static const String getCreditCardPath = "http://localhost:8100/getFrom";
  static const String setCreditCardPath = "http://localhost:8100/setTo";

  Future<Map<String, dynamic>> getCreditCard() async {
    final response = await http.get(Uri.parse(getCreditCardPath));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Failed to fetch credit card',
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> setCreditCard(String cardNumber) async {
    final response = await http.post(
      Uri.parse(setCreditCardPath),
      body: {'cardNumber': cardNumber},
    );

    if (response.statusCode == 200) {
      return {
        'status': 'success',
        'message': 'Credit card set successfully',
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to set credit card',
        'error': json.decode(response.body)
      };
    }
  }
}
