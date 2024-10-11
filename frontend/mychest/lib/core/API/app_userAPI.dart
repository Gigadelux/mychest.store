import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//TODO COMPLETE WITH PARAMETHERS
class AppUserAPI {
  static const String signUp = "http://localhost:8100/users/newUser";
  static const String loginToken = "http://localhost:8080/realms/mychest/protocol/openid-connect/token";
  static const String getMyProfile = "http://localhost:8100/users/getProfile";

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginToken),
      body: {
        'username': username,
        'password': password,
        'grant_type': 'password',
        'client_id': 'mystore',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loginToken', jsonResponse['access_token']);

      return {
        'status': 'success',
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('loginToken');

    final response = await http.get(
      Uri.parse(getMyProfile),
      params: {
        'email': email,
      },
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      await prefs.setString('email', jsonResponse['email']);
      return {
        'status': 'success',
        'email': jsonResponse['email'],
        'credit_card': jsonResponse['credit_card'],
        'orders': jsonResponse['orders']
      };
    } else {
      return {
        'status': 'error',
        'message': 'Failed to fetch profile',
        'error': json.decode(response.body)
      };
    }
  }
}
