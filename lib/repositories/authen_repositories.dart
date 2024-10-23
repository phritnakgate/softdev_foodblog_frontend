import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositories {
  final String url = "softdev.bkkz.org";
  // === HANDLE AUTHENTICATION === \\
  Future<void> login(String username, String password) async {
    final response = await http.post(Uri.parse('http://$url/login'),
        body: jsonEncode({"username": username, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body["token"];
      final pref = await SharedPreferences.getInstance();
      await pref.setString("jwt_token", token);
      debugPrint("Login Success");
    } else {
      throw Exception("Failed to login");
    }
  }

  Future<void> logout(int id) async {
    final url = Uri.parse('http://127.0.0.1:8080/logout/$id');

    // Retrieve the stored JWT
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('jwt_token'); // Clear the JWT token from local storage
      debugPrint('Logged out successfully.');
    } else {
      throw Exception('Failed to log out');
    }
  }

  Future<void> registerUser(String username, String password, String firstName, String lastName, File pictureFile) async {
  final url = Uri.parse('http://127.0.0.1:8080/user');

  var request = http.MultipartRequest('POST', url)
    ..fields['Username'] = username
    ..fields['Password'] = password
    ..fields['FirstName'] = firstName
    ..fields['LastName'] = lastName
    ..files.add(await http.MultipartFile.fromPath('PictureProfile', pictureFile.path));

  final response = await request.send();

  if (response.statusCode == 200) {
    debugPrint('User registered successfully.');
  } else {
    throw Exception('Failed to register user');
  }
}

  // === HANDLE USER DATA === \\
  Future<void> getUserData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response = await http.get(Uri.parse('http://$url/user/$id'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      debugPrint('User data: $userData');
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  // === HANDLE ROUTE PROTECTION === \\
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }
}
