import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositories {
  final String url = "softdev.bkkz.org";
  // === HANDLE AUTHENTICATION === \\
  Future<bool> login(String username, String password) async {
    final response = await http.post(Uri.parse('http://$url/login'),
        body: jsonEncode({"username": username, "password": password}),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      // Extract JWT token from the response header
      final jwtTokenStart =
          response.headers["set-cookie"]!.indexOf("jwt=") + "jwt=".length;
      final jwtTokenEnd =
          response.headers["set-cookie"]!.indexOf(";", jwtTokenStart);
      final jwtToken =
          response.headers["set-cookie"]!.substring(jwtTokenStart, jwtTokenEnd);
      // Extract JWT expiration from the response header
      final jwtExpiredStart =
          response.headers["set-cookie"]!.indexOf("expires=") +
              "expires=".length;
      final jwtExpiredEnd =
          response.headers["set-cookie"]!.indexOf(";", jwtExpiredStart);
      final jwtExpired = response.headers["set-cookie"]!
          .substring(jwtExpiredStart, jwtExpiredEnd);
      final DateFormat format = DateFormat('EEE, dd MMM yyyy HH:mm:ss zzz');
      final jwtExpiredDate = format.parseUTC(jwtExpired);
      debugPrint(jwtExpired.toString());
      final pref = await SharedPreferences.getInstance();
      await pref.setString("jwt_token", jwtToken);
      await pref.setString("jwt_expired", jwtExpiredDate.toIso8601String());
      debugPrint("Login Success");
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token') ?? '';
  }

  Future<void> logout(int id) async {
    final logouturl = Uri.parse('http://$url/logout/$id');

    // Retrieve the stored JWT
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    debugPrint('Token: $token');

    final response = await http.post(logouturl);

    if (response.statusCode == 200) {
      await prefs.remove('jwt_token');
      await prefs.remove('jwt_expired');
      debugPrint('Logged out successfully.');
    } else {
      debugPrint(response.body);
      debugPrint('Failed to log out');
    }
  }

  Future<void> registerUser(String username, String password, String firstName,
      String lastName) async {
    final registerUrl = Uri.parse('http://$url/user');

    var request = http.MultipartRequest('POST', registerUrl)
      ..fields['Username'] = username
      ..fields['Password'] = password
      ..fields['FirstName'] = firstName
      ..fields['LastName'] = lastName;

    final response = await request.send();

    if (response.statusCode == 200) {
      debugPrint('User registered successfully.');
    } else {
      debugPrint(response.reasonPhrase);
      debugPrint("Failed to register user");
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
      debugPrint(response.body);
      debugPrint("Failed to get user data");
    }
  }

  // === HANDLE ROUTE PROTECTION === \\
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    return token != null;
  }

  // == HANDLE EXPIRED TOKEN == \\
  Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expired = prefs.getString('jwt_expired');
    if (expired != null) {
      final expiredDate = DateTime.parse(expired);
      return expiredDate.isBefore(DateTime.now());
    }
    return true;
  }
}
