import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/data/models/product.dart';

class Profile{
  String email;
  CreditCard creditCard;
  Profile(this.email, this.creditCard);

  factory Profile.empty() => Profile("", CreditCard.empty());
  bool isEmpty() {
    return email.isEmpty && creditCard.isEmpty;
  }
}