import 'dart:convert';
import 'package:http/http.dart' as http;

class Aiassistant {
  final String reccomendPath = "http://localhost:8100/aiAssistant/reccomendProducts";
  final String refreshPath = "http://localhost:8100/aiAssistant/newReccomendation";

  Future<Map> reccomend()async{
    final response = await http.get(Uri.parse(reccomendPath));
    print(response.body);
    if (response.statusCode == 200) {
      return {
        'status':response.statusCode,
        'botMessage': jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to generate text',
        'error': response.body
      };
    }
  }
  
  Future<Map> refreshReccomend(String oldRes)async{
    final response = await http.get(Uri.parse("$refreshPath?dislikedText=$oldRes"));
    print(response.body);
    if (response.statusCode == 200) {
      return {
        'status':response.statusCode,
        'botMessage': jsonDecode(response.body)['candidates'][0]['content']['parts'][0]['text']
      };
    } else {
      return {
        'status': response.statusCode,
        'message': 'Failed to generate text',
        'error': response.body
      };
    }
  }
}