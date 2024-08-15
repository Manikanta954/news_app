import 'dart:convert';
import 'package:http/http.dart' as http;

// Use your provided Currents API key
const String apiKey = 'oqv0U4Ofoi-YGGUnZ_m0KfTVLk7FG4TPXyyUGOSU0TqAfc_T';
const String url = 'https://api.currentsapi.services/v1/latest-news?apiKey=$apiKey';

Future<List<dynamic>> fetchNews() async {
  try {
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['news']; // Adjusted to match the response structure of Currents API
    } else {
      throw Exception('Failed to load news');
    }
  } catch (e) {
    print('Exception caught: $e');
    throw Exception('Failed to load news');
  }
}
