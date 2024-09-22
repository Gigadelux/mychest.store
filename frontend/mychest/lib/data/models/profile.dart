import 'package:mychest/data/models/creditCard.dart';
import 'package:mychest/data/models/product.dart';

class Profile{
  String email;
  CreditCard creditCard;
  Map<String, List<Product>> chests;
  Profile(this.email, this.creditCard, this.chests);

  factory Profile.empty() => Profile("", CreditCard.empty(), {});
  bool isEmpty() {
    return email.isEmpty && creditCard.isEmpty && chests.isEmpty;
  }
}