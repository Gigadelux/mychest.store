import 'package:mychest/data/models/product.dart';

class CartItem {
  Product product;
  int quantity;
  CartItem({
    required this.product,
    required this.quantity,
  });
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}