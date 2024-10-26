import 'package:mychest/data/models/ProductKey.dart';

class OrderBucket {
  List<ProductKey> keys;
  String createdAt; //timeStamp
  OrderBucket({
    required this.keys,
    required this.createdAt,
  });
static List<OrderBucket> fromJsonList(List<dynamic> jsonList) {
  print("ORDERBUCKET ERROR ${jsonList[0]['keys'].runtimeType}");
  return jsonList.map((json) {
    List createdAt = json['createdAt'];
    DateTime dt = DateTime(createdAt[0], createdAt[1],createdAt[2], createdAt[3], createdAt[4]);
    return OrderBucket(
      keys: ProductKey.fromJsonList(json['keys']),
      createdAt: dt.toIso8601String(),
    );
  }).toList();
}
}
