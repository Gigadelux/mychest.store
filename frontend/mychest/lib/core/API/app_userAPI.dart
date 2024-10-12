import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//TODO COMPLETE WITH PARAMETHERS
class AppUserAPI {
  static const String signUp = "http://localhost:8100/users/newUser";
  static const String loginToken = "http://localhost:8080/realms/mychest/protocol/openid-connect/token";
  static const String getMyProfile = "http://localhost:8100/users/getProfile";
  static const String validateTokenUrl = 'http://localhost:8100/users/validateToken';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginToken),
      body: {
        'email': email,
        'password': password,
        'grant_type': 'password',
        'client_id': 'mystore'
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loginToken', jsonResponse['access_token']);

      return {
        'status': 200,
        'message': 'Login successful',
        'token': jsonResponse['access_token']
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to login',
        'error': json.decode(response.body)
      };
    }
  }
  Future<Map<String, dynamic>> getProfile(String email) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('loginToken');
      if (token == null) {
        return {
          'status': 'error',
          'message': 'No token found',
        };
      }
      final uri = Uri.http('localhost:8100', '/users/newUser', {
        'email': email,
      });
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        await prefs.setString('email', jsonResponse['email']);
        return {
          'status': 200,
          'email': jsonResponse['email'],
          'credit_card': jsonResponse['credit_card'],
          'orders': jsonResponse['orders'],
        };
      } else {
        return {
          'status': 'error',
          'message': 'Failed to fetch profile',
          'error': json.decode(response.body),
        };
      }
    } catch (e) {
      return {
        'status': 'error',
        'message': 'An error occurred',
        'error': e.toString(),
      };
    }
  }

  Future<bool> isTokenValid() async {
    // Get the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('loginToken');

    if (token == null || token.isEmpty) {
      return false;
    }

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse(validateTokenUrl),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
