import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/core/API/app_userAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenNotifier extends StateNotifier<String?>{
  TokenNotifier() : super(null);
  Future<void> initialize()async{
    final prefs =await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(!await AppUserAPI().isTokenValid(token)) return;
    state = token;
  }
  Future<void> setToken(String? token) async {
    if(token == null) return;
    if(!await AppUserAPI().isTokenValid(token)) return;
    saveToken(token);
    state = token;
  }
  Future<void> saveToken(String? token) async {
    if(token == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
  void destroy(){
    state = null;
  }
}