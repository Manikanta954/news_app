import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = '2c7bb3170e1246cd870f66a00a074ac6'; // Replace with your valid API key
const String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

Future<List<dynamic>> fetchNews() async {
  try {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  } catch (e) {
    print('Exception caught: $e');
    throw Exception('Failed to load news');
  }
}
