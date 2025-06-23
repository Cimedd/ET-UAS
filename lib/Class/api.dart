
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> Login(id, password) async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422007/login.php"),
        body: {'user_id': id, 'user_password': password});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", id);
        prefs.setString("user_name", json['user_name']);
        prefs.setString("role", json['role']);
        return json['role'];
      } else {
        return "Failed to Login";
      }
    } else {
      throw Exception('Failed to read API');
    }
  }