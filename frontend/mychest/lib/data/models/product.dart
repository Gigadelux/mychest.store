
class Product {
  String name;
  String description;
  String image;
  int quantity;
  double price;
  int type;
  String platforms;
  String category;
  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.type,
    required this.platforms,
    required this.category
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      type: json['type'],
      platforms: json['platforms'],
      category: json['category']['name']
    );
  }
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}