
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Login
Future<String> Login(email, password) async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422007/login.php"),
        body: {'email': email, 'user_password': password});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("user_id", json['id']);
        prefs.setString("user_name", json['user_name']);
        prefs.setString("email", json['email']);
        prefs.setString("role", json['role']);
        return json['role'];
      } else {
        return "Failed to Login";
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

Future<String> Register(name , email, password, role) async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422007/login.php"),
        body: {'name' : name,'email': email, 'password': password, 'role' : role});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        return "success";
      } else {
        return "Failed to Login";
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

//product
Future<String> GetProductList() async{

  final response = await http.get(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/porductlist.php")
  );
  
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return response.body;
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

void AddProduct(){

}

void DeleteProduct(){

}

void EditProduct(){

}

void GetProductAdmin(id){

}

void GetProductDetail(id){

}



//category
void AddCategory(){

}

void DeleteCategory(){

}

void EditCategory(){

}

void GetCategory(){

}

