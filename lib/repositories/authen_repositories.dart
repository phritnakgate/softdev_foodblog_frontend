import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositories {
  final String url = "softdev.bkkz.org";

  // === HANDLE AUTHENTICATION === \\
  Future<bool> login(String username, String password) async {
    Map<String, dynamic> userData = {};
    final response = await http.post(Uri.parse('http://$url/login'),
        body: jsonEncode({"username": username, "password": password}),
        headers: {
          "Content-Type": "application/json",
        });
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
      final userId = JWT
          .verify(jwtToken, SecretKey(dotenv.env['ACCESS_SECRET_KEY']!))
          .payload['user_id'];
      getUserData(userId);
      await pref.setInt("user_id", userId);

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

    final response = await http.post(logouturl, headers: {
      "Cookie": "jwt=$token",
    });

    if (response.statusCode == 200) {
      clearUserData();
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
  Future<Map<String, dynamic>> getUserData(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response =
        await http.get(Uri.parse('http://$url/user/$id'), headers: {
      "Cookie": "jwt=$token",
    });
    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      await prefs.setString('user_data', jsonEncode(userData));
      debugPrint('User data: ${userData.runtimeType} $userData');
      return userData;
    } else {
      debugPrint(response.body);
      debugPrint("Failed to get user data");
      return {};
    }
  }

  // === HANDLE ROUTE PROTECTION === \\
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    //debugPrint('Token: $token');
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

  // == CLEAR ALL USER DATA == \\
  void clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('jwt_expired');
    await prefs.remove('user_id');
    await prefs.remove('user_data');
  }
}
