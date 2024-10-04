import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/data/models/profile.dart';

class ProfileRepo{
  Future<Profile> initializeUser()async{
    //ONLY FOR DEMO PURPOSES
    return Profile("mirco.delux@gmail.com", CreditCard(postalCode: "", cardNumber: "3495804958023", passCode: "343", expireTime: DateTime.now().toIso8601String()));
  }
}