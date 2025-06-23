import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

void getUser(){
  
}