import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mychest/main.dart';
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
        'username': email,
        'email': email,
        'password': password,
        'grant_type': 'password',
        'client_id': 'mychest-restapi'
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', jsonResponse['access_token']);
      return {
        'status': 200,
        'message': 'Login successful',
        'token': jsonResponse['access_token']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': response.body,
        'error': response.body
      };
    }
  }
  Future<Map<String, dynamic>> getProfile(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return {
        'status': 404,
        'message': 'No token found',
      };
    }
    final uri = Uri.http('localhost:8100', '/users/getProfile',);
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      await prefs.setString('email', jsonResponse['email']);
      return {
        'status': 200,
        'email':jsonResponse['email'],
        'credit_card':jsonResponse['credit_card'],
        'orders' :jsonResponse['orders']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch profile',
        'error': response.body,
      };
    }
  }

  Future<bool> isTokenValid(String? token) async {
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

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("$signUp?email=$email&password=$password"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': 200,
        'cartId':jsonDecode(response.body)[cartId],
        'message': 'User created successfully',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': response.body,
        'error': response.body,
      };
    }
  }
}
