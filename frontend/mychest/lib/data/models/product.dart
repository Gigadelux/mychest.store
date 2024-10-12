
class Product {
  String id;
  String name;
  String description;
  String image;
  int quantity;
  double price;
  int type;
  String platforms;
  String category;
  Product({
    required this.id,
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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      type: json['type'],
      platforms: json['platforms'],
      category: json['category']
    );
  }
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}