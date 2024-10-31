import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<dynamic>> getPostByUser() async {
    final response = await http.get(Uri.parse('http://$url/postu'));
    return jsonDecode(response.body);
  }

  Future<bool> createPost(Map<String, dynamic> post) async {
    // Retrieve the stored JWT
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    var request = http.MultipartRequest('POST', Uri.parse('http://$url/post'))
      ..fields['title'] = post['title']
      ..fields['detail'] = post['detail']
      ..fields['recipe'] = post['recipe']
      ..fields['timetocook'] = post['timetocook']
      ..fields['category'] = post['category']
      ..fields['image'] = post['image']
      ..fields['ingredient'] = jsonEncode(post['ingredient'])
      ..fields['quantity'] = jsonEncode(post['quantity'])
      ..headers['Cookie'] = 'jwt=$token';

    final response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('Post created successfully.');
      return true;
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint('Failed to create post');
      return false;
    }
  }

  // === RECIPE FILTERING === \\
  Future<List<dynamic>> filterPost(String? title, String? category,
      String? priceMin, String? priceMax) async {
    final uri = Uri.http(url, '/posts/search', {
      if (title != null) 'title': title,
      if (category != null) 'type': category,
      if (priceMin != null) 'min_price': priceMin,
      if (priceMax != null) 'max_price': priceMax
    });
    debugPrint(uri.toString());
    final response = await http.get(uri);
    return jsonDecode(response.body);
  }

  // === HANDLE INGREDIENTS === \\
  Future<List<dynamic>> getAllIngredients() async {
    final response = await http.get(Uri.parse('http://$url/ingredient'));
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getIngredientById(int id) async {
    final response = await http.get(Uri.parse('http://$url/ingredient/$id'));
    debugPrint(response.body);
    return jsonDecode(response.body);
  }
}
