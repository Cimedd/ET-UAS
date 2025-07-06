import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("role") ?? '';
  return user_id;
}
Future<int> getId() async {
  final prefs = await SharedPreferences.getInstance();
  int user_id = prefs.getInt("user_id") ?? 0;
  return user_id;
}

Future<void> Logout() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('user_id');
  prefs.remove('email');
  prefs.remove('user_name');
  prefs.remove('role');  
}

Future<Map<String, String?>> getUserData() async {
  final prefs = await SharedPreferences.getInstance();

  final int? id = prefs.getInt('user_id');
  final String? email = prefs.getString('email');
  final String? name = prefs.getString('user_name');
  final String? role = prefs.getString('role');
  return {
    'email': email,
    'name': name,
    'role': role,
    'id' : id.toString()
  };
}
