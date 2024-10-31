import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softdev_foodblog_frontend/repositories/authen_repositories.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response = await http.get(Uri.parse('http://$url/postu'), headers: {
      "Cookie": "jwt=$token",
    });
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

  Future<void> deletePost(int id) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response = await http.delete(Uri.parse('http://$url/post/$id'), headers: {
      "Cookie": "jwt=$token",
    });
    debugPrint(response.body);
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

  // === HANDLE BOOKMARK === \\
  Future<List<dynamic>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response =
        await http.get(Uri.parse('http://$url/bookmark'), headers: {
      "Cookie": "jwt=$token",
    });
    return jsonDecode(response.body);
  }

  Future<void> bookmark(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final userId = prefs.getInt('user_id');

    // Retrieve and filter bookmarks for the current user
    List<dynamic> bookmarks = await getBookmarks();
    List<dynamic> userBookmarks =
        bookmarks.where((bookmark) => bookmark['UserID'] == userId).toList();

    // Check if the current user has already bookmarked this post
    bool isBookmarked =
        userBookmarks.any((bookmark) => bookmark['PostID'] == id);
    debugPrint('User bookmarks: $userBookmarks');

    if (isBookmarked) {
      // If bookmarked, proceed to unbookmark
      var request =
          http.MultipartRequest("DELETE", Uri.parse('http://$url/bookmark'))
            ..fields['postid'] = id.toString()
            ..headers['Cookie'] = 'jwt=$token';
      final response = await request.send();
      if (response.statusCode == 200) {
        final userId = prefs.getInt('user_id');
        AuthenticationRepositories().getUserData(userId!);
        debugPrint('Unbookmarked successfully');
      } else {
        debugPrint('Failed to unbookmark');
      }
    } else {
      // If not bookmarked, proceed to bookmark
      var request =
          http.MultipartRequest("POST", Uri.parse('http://$url/bookmark'))
            ..fields['postid'] = id.toString()
            ..headers['Cookie'] = 'jwt=$token';
      final response = await request.send();
      if (response.statusCode == 200) {
        final userId = prefs.getInt('user_id');
        AuthenticationRepositories().getUserData(userId!);
        debugPrint('Bookmarked successfully');
      } else {
        debugPrint('Failed to bookmark');
      }
    }
  }

  Future<bool> isBookmarked(int postId) async {
    final bookmarks = await getBookmarks();
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    List<dynamic> userBookmarks =
        bookmarks.where((bookmark) => bookmark['UserID'] == userId).toList();
    return userBookmarks.any((bookmark) => bookmark['PostID'] == postId);
  }

  // === HANDLE LIKES === \\
  Future<List<dynamic>> getLikes() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response = await http.get(Uri.parse('http://$url/like'), headers: {
      "Cookie": "jwt=$token",
    });
    return jsonDecode(response.body);
  }

  Future<void> likes(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final userId = prefs.getInt('user_id');

    // Retrieve and filter bookmarks for the current user
    List<dynamic> likes = await getLikes();
    List<dynamic> userLikes =
        likes.where((like) => like['UserID'] == userId).toList();

    // Check if the current user has already bookmarked this post
    bool isBookmarked = userLikes.any((like) => like['PostID'] == id);
    debugPrint('User bookmarks: $userLikes');

    if (isBookmarked) {
      // If bookmarked, proceed to unbookmark
      var request =
          http.MultipartRequest("DELETE", Uri.parse('http://$url/like'))
            ..fields['postid'] = id.toString()
            ..headers['Cookie'] = 'jwt=$token';
      final response = await request.send();
      if (response.statusCode == 200) {
        final userId = prefs.getInt('user_id');
        AuthenticationRepositories().getUserData(userId!);
        debugPrint('UnLiked successfully');
      } else {
        debugPrint('Failed to unlike');
      }
    } else {
      // If not bookmarked, proceed to bookmark
      var request = http.MultipartRequest("POST", Uri.parse('http://$url/like'))
        ..fields['postid'] = id.toString()
        ..headers['Cookie'] = 'jwt=$token';
      final response = await request.send();
      if (response.statusCode == 200) {
        final userId = prefs.getInt('user_id');
        AuthenticationRepositories().getUserData(userId!);
        debugPrint('Liked successfully');
      } else {
        debugPrint('Failed to like');
      }
    }
  }

  Future<bool> isLiked(int postId) async {
    final likes = await getLikes();
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    List<dynamic> userBookmarks =
        likes.where((like) => like['UserID'] == userId).toList();
    return userBookmarks.any((like) => like['PostID'] == postId);
  }
}
