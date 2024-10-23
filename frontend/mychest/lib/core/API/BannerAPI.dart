import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerAPI {
  static const String getBannerPath = "http://localhost:8100/banner/get";

  Future<Map<String, dynamic>> getBanner() async {
    final response = await http.get(Uri.parse(getBannerPath));

    if (response.statusCode == 200) {
      return {
        'status':response.statusCode,
        'image': json.decode(response.body)['image'],
        'category':json.decode(response.body)['category']['name']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to fetch banner',
        'error': response.body
      };
    }
  }
}
