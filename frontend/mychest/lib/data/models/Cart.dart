import 'package:mychest/data/models/CartItem.dart';

class Cart {
  List<CartItem> cartItems;
  Cart({
    required this.cartItems
  });
  factory Cart.empty() => Cart(cartItems: []);
  factory Cart.fromJson(Map<String, dynamic> json) {
    var cartItemsFromJson = json['cartItem'] as List;
    List<CartItem> cartItemsList = cartItemsFromJson.map((item) => CartItem.fromJson(item)).toList();
    return Cart(cartItems: cartItemsList);
  }
  @override
  String toString() {
    return 'Cart(cartItems: $cartItems)';
  }
}