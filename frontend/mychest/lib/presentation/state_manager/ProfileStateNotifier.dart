import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/core/API/app_userAPI.dart';
import 'package:mychest/data/models/OrderBucket.dart';
import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileNotifier extends StateNotifier<Profile>{
  ProfileNotifier() : super(Profile.empty());
  Future<void> initialize()async{
    final prefs =await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if(token == null) return;
    if(! await AppUserAPI().isTokenValid(token)) return;
    Map<String,dynamic> response = await AppUserAPI().getProfile(token);
    CreditCard? creditCard;
    List<OrderBucket> orderBuckets = [];
    try{
      creditCard = CreditCard.fromJson(response);
      orderBuckets = OrderBucket.fromJsonList(response['orders']);
    }catch(e){}
    Profile p = Profile(token, creditCard ?? CreditCard.empty(),orderBuckets, );
    state = p;
  }
  void destroy(){
    state = Profile.empty();
  }
}