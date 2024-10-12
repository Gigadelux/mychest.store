import 'package:mychest/data/models/OrderBucket.dart';
import 'package:mychest/data/models/creditCard.dart';

class Profile{
  String email;
  CreditCard creditCard;
  List<OrderBucket> orderBuckets;
  Profile(this.email, this.creditCard, this.orderBuckets);

  factory Profile.empty() => Profile("", CreditCard.empty(), []);
  bool isEmpty() {
    return email.isEmpty && creditCard.isEmpty;
  }
}