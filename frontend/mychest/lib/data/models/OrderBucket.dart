import 'package:mychest/data/models/ProductKey.dart';

class OrderBucket {
  List<ProductKey> keys;
  String createdAt; //timeStamp
  OrderBucket({
    required this.keys,
    required this.createdAt,
  });
static List<OrderBucket> fromJsonList(List<dynamic> jsonList) {
  return jsonList.map((json) {
    return OrderBucket(
      keys: ProductKey.fromJsonList(json['keys']),
      createdAt: json['createdAt'],
    );
  }).toList();
}
}