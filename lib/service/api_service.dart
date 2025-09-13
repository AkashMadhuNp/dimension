import 'dart:convert';
import 'package:dimension_machine_task/model/post_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration timeoutDuration = Duration(seconds: 10);

Future<List<Post>> fetchPosts() async {
  print("🔄 Starting API call to: $baseUrl/posts");
  
  try {
    final response = await http
        .get(
          Uri.parse('$baseUrl/posts'),
          headers: {'Content-Type': 'application/json'},
        )
        .timeout(timeoutDuration);

    print("📡 Response status: ${response.statusCode}");
    print("📦 Response body length: ${response.body.length}");
    
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print("✅ Successfully parsed ${jsonData.length} posts");
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      print("❌ HTTP Error: ${response.statusCode}");
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  } catch (e) {
    print("💥 Exception occurred: $e");
    throw Exception('Network error: $e');
  }
}
}
