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
}
