import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/core/API/app_userAPI.dart';
import 'package:mychest/core/API/cartAPI.dart';
import 'package:mychest/core/API/orderProductAPI.dart';
import 'package:mychest/data/models/Cart.dart';
import 'package:mychest/data/responseFormat/ObjectRequest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cartstatenotifier extends StateNotifier<ObjectRequest<Cart>>{
  Cartstatenotifier():super(ObjectRequest(object: Cart.empty()));

  initialize()async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(!await AppUserAPI().isTokenValid(token)){
      state = ObjectRequest(object: Cart.empty(),statusCode: 401, errorMessage: 'Error in your account');
      return;
    }
    Map res = await CartAPI().getCart(token!);
    int status = res['status'];
    Cart cart = Cart.empty();
    if(status==200) {
      cart = Cart.fromJson(res['cart']);
    }
    state = ObjectRequest(object: cart,statusCode: status, errorMessage: res['message']);
    print(state);
  }

  addItem(String productName, int quantity)async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(!await AppUserAPI().isTokenValid(token)){
      state = ObjectRequest(object: Cart.empty(),statusCode: 401, errorMessage: 'Error in your account');
      return;
    }
    Map res = await CartAPI().addItemToCart(productName, quantity, token!);
    int status = res['status'];
    Cart cart = Cart.empty();
    if(status==200) {
      cart = Cart.fromJson(res['cart']);
    }
    state = ObjectRequest(object: cart,statusCode: status, errorMessage: res['message']);
  }

  removeItem(String productName, int quantity)async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(!await AppUserAPI().isTokenValid(token)){
      state = ObjectRequest(object: Cart.empty(),statusCode: 401, errorMessage: 'Error in your account');
      return;
    }
    Map res = await CartAPI().removeItemFromCart(productName, token!);
    int status = res['status'];
    Cart cart = Cart.empty();
    if(status==200) {
      cart = Cart.fromJson(res['cart']);
    }
    state = ObjectRequest(object: cart,statusCode: status, errorMessage: res['message']);
  }

  pay(String postalCode)async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? cartId = prefs.getInt('cartId');
    if(!await AppUserAPI().isTokenValid(token) || cartId == null){
      state = ObjectRequest(object: state.getObject, statusCode: 401, errorMessage: 'Error in your account');
      return;
    }
    Map res = await OrderAPI().pay(postalCode, cartId, token!);
    int status = res['status'];
    Cart? cart;
    if(status==200) {
      cart = Cart.empty();
    }
    state = ObjectRequest(object: cart??state.getObject,statusCode: status, errorMessage: res['message']);
  }

  flush()async{
    state = ObjectRequest(object: Cart.empty());
  }
}