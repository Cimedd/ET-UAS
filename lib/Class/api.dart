
import 'dart:convert';

import 'package:belanja/Class/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belanja/Class/userPref.dart' as userPref;

//Login
Future<String> Login(email, password) async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422007/uas/login.php"),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt("user_id", json['user']['id']);
        prefs.setString("user_name", json['user']['name']);
        prefs.setString("email", json['user']['email']);
        prefs.setString("role", json['user']['role']);
        return json['user']['role'];
      } else {
        return "Failed to Login";
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

Future<String> Register(name , email, password, role) async {
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422007/uas/register.php"),
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
Future<List<Product>> GetProductList() async{
  final response = await http.get(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productlist.php")
  );
  
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> AddProduct(name, description, stock, image, price) async{
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productadd.php")
  );
  
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return "";
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

void DeleteProduct(){

}

void EditProduct(){

}

void GetProductAdmin(id){

}

Future<Product> GetProductDetail(id) async{
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/wishlistget.php"),
     body: {'id' : id.toString()});

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return Product.fromJson(json['product']);
    } 
    else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//category
Future<String> AddCategory(name) async{
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categoryadd.php"),
     body: {'name' : name, 'seller_id' : id});

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } 
    else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> DeleteCategory(id) async{
  final response = await http.post(
  Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categorydelete.php"),
     body: {'id' : id});

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } 
    else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  } 
}

Future<String> EditCategory(id, name) async{
  final response = await http.post(
  Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categoryedit.php"),
     body: {'name' : name, 'id' : id});

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } 
    else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<List<Category>> GetCategory() async{
  final id = await userPref.getId();
  final response = await http.post(
  Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categorylist.php"),
     body: { 'id' : id});
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Category.fromJson(e)).toList();
    } else{
       throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }

}

//wishlist
Future<List<Product>> GetWishlist() async{
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/wishlistget.php"),
     body: {'id' : id.toString()});

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Product.fromJson(e)).toList();
    } 
    else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

