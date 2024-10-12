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
    String? email = prefs.getString('email');
    if(email == null) return;
    Map<String,dynamic> response = await AppUserAPI().getProfile(email);
    CreditCard? creditCard;
    List<OrderBucket> orderBuckets = [];
    try{
      creditCard = CreditCard.fromJson(response);
      orderBuckets = OrderBucket.fromJsonList(response['orders']);
    }catch(e){}
    Profile p = Profile(email, creditCard ?? CreditCard.empty(),orderBuckets);
    state = p;
  }
}