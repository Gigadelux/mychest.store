class ProductKey {
  String activationKey;
  String productName;
  ProductKey({
    required this.activationKey,
    required this.productName
  });
  factory ProductKey.fromJson(Map<String, dynamic> json) {
    return ProductKey(
      activationKey: json['activationKey'],
      productName: json['productName'],
    );
  }
  static List<ProductKey> fromJsonList(List keys) {
    return keys.map((keyJson) => ProductKey.fromJson(keyJson)).toList();
  }
}