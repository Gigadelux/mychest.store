import 'package:mychest/data/models/CartItem.dart';

class Cart {
  List<CartItem> cartItems;
  Cart({
    required this.cartItems
  });
  factory Cart.empty() => Cart(cartItems: []);
}