import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mychest/core/API/app_userAPI.dart';
import 'package:mychest/core/API/creditCardAPI.dart';
import 'package:mychest/data/models/OrderBucket.dart';
import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/presentation/widgets/universal/SimpleAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileNotifier extends StateNotifier<Profile>{
  ProfileNotifier() : super(Profile.empty());

  Future<void> initialize()async{
    final prefs =await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token == null) return;
    if(! await AppUserAPI().isTokenValid(token)) {
      prefs.clear();
      return;
    }
    Map<String,dynamic> response = await AppUserAPI().getProfile(token);
    if(response['status']!=200){ throw Exception(" ${response['status']} ${response['message']}");}
    CreditCard? creditCard;
    List<OrderBucket> orderBuckets = [];
    try{
      creditCard = CreditCard.fromJson(response['credit_card']);
      orderBuckets = OrderBucket.fromJsonList(response['orders']);
    }catch(e){
      print("ZIOPERONI PEPPEROPOLI $e");
    }
    Profile p = Profile(response['email'], creditCard ?? CreditCard.empty(),orderBuckets);
    state = p;
  }

  setCreditCard(BuildContext context, String cardNumber,String passCode,String expireTime)async{
    Map res = await CreditCardAPI().setCreditCard(cardNumber, passCode, expireTime);
    if(res['status']==200){
      Profile p = Profile(state.email, CreditCard(cardNumber: cardNumber, passCode: passCode, expireTime: expireTime), state.orderBuckets);
      state = p;
      showSimpleAlert(context, "Credit card set🥳");
    }
    else{
      Fluttertoast.showToast(msg: "failed to set");
    }
    print(res);
  }

  Future<void> destroy()async{
    state = Profile.empty();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
  
}