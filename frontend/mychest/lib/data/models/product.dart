
class Product {
  String id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  int productType;
  List<String> avaiblePlatforms;
  String? activationKey;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.productType,
    required this.avaiblePlatforms,
    this.activationKey
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productType: json['productType'],
      avaiblePlatforms: List<String>.from(json['avaiblePlatforms']),
      activationKey: json['activationKey'],
    );
  }
}