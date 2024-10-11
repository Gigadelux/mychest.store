import 'dart:convert';
import 'package:http/http.dart' as http;

class BannerAPI {
  static const String getBannerPath = "http://localhost:8100/banner/get";

  Future<Map<String, dynamic>> getBanner() async {
    final response = await http.get(Uri.parse(getBannerPath));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Failed to fetch banner',
        'error': json.decode(response.body)
      };
    }
  }
}
