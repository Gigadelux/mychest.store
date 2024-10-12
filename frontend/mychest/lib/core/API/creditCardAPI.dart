import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//TODO complete with body and params
class CreditCardAPI {
  static const String getCreditCardPath = "http://localhost:8100/creditCard/getFrom";
  static const String setCreditCardPath = "http://localhost:8100/creditCard/setTo";

  Future<Map<String, dynamic>> getCreditCard(String email) async {
    final response = await http.get(Uri.parse('$getCreditCardPath?email=$email'));
    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'credit_card':json.decode(response.body),
        'message': 'Credit card get successfully',
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to fetch credit card',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }

  Future<Map<String, dynamic>> setCreditCard(String cardNumber,String passCode,String expireTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    final response = await http.post(
      Uri.parse('$setCreditCardPath?email=$email'),
      body: {
        'card_number': cardNumber,
        'pass_code':passCode,
        'expire_time':expireTime
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': response.statusCode,
        'credit_card':json.decode(response.body),
        'message': 'Credit card set successfully',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to set credit card',
        'description': json.decode(response.body)['message'],
        'error': json.decode(response.body)
      };
    }
  }
}
