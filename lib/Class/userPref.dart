import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("role") ?? '';
  return user_id;
}
Future<int> getId() async {
  final prefs = await SharedPreferences.getInstance();
  int user_id = prefs.getInt("id") ?? 0;
  return user_id;
}

Future<void> Logout() async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('user_id');
  prefs.remove('email');
  prefs.remove('name');
  prefs.remove('role');  
}