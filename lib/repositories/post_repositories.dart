import 'dart:convert';

import 'package:http/http.dart' as http;

class PostRepositories {
  final String url = "softdev.bkkz.org";
  // === HANDLE RECIPE === \\
  Future<List<dynamic>> getAllPosts() async {
    final response = await http.get(Uri.parse('http://$url/post'));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getPostById(int id) async {
    final response = await http.get(Uri.parse('http://$url/post/$id'));
    return jsonDecode(response.body);
  }

  // === RECIPE FILTERING === \\
  Future<List<dynamic>> getPostByTitle(String title) async {
    final response =
        await http.get(Uri.parse('http://$url/posts/search?title=$title'));
    return jsonDecode(response.body);
  }
  Future<List<dynamic>> getPostByTag(String title) async {
    final response =
        await http.get(Uri.parse('http://$url/posts/search?title=$title'));
    return jsonDecode(response.body);
  }
  Future<List<dynamic>> getPostByPrice(String priceMin, String priceMax) async {
    final response =
        await http.get(Uri.parse('http://$url/posts/filter/price?min_price=$priceMin&max_price=$priceMax'));
    return jsonDecode(response.body);
  }
}
