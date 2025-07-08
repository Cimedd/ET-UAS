import 'dart:convert';

import 'package:belanja/Class/db.dart';
import 'package:belanja/Class/order.dart';
import 'package:belanja/Class/product.dart';
import 'package:belanja/Class/review.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belanja/Class/userPref.dart' as userPref;

//Login
Future<String> Login(email, password) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/login.php"),
    body: {'email': email, 'password': password},
  );
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

Future<String> Register(name, email, password, role) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/register.php"),
    body: {'name': name, 'email': email, 'password': password, 'role': role},
  );
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
Future<List<Product>> GetProductList() async {
  final response = await http.get(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productlist.php"),
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

Future<String> AddProduct(Product prod) async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productadd.php"),
    body: {
      'name': prod.name,
      'desc': prod.description,
      'stock': prod.stock.toString(),
      'price': prod.price.toString(),
      'image': prod.image,
      'id': id.toString(),
    },
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> DeleteProduct(id) async{
   final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productdelete.php"),
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> EditProduct(Product prod) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productedit.php"),
    body: {
      'name': prod.name,
      'desc': prod.description,
      'stock': prod.stock.toString(),
      'price': prod.price.toString(),
      'image': prod.image,
      'id': prod.id.toString(),
    },
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<List<Product>> GetProductAdmin() async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productadminlist.php"),
    body: {'id': id.toString()},
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

Future<Product> GetProductDetail(id) async {
  final cid = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/productdetail.php"),
    body: {'id': id.toString(), 'cid' : cid.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return Product.fromJson(json['product']);
    } else {
      throw Exception('API result not success ${json['message']}');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//review
Future<List<Review>> getReview(id) async{
    final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/reviewlist.php"),
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Review.fromJson(e)).toList();
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> addReview(text,rating, pid) async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/reviewadd.php"),
    body: {'cid': id.toString(),'pid' : pid.toString(), 'text' : text, 'rating' : rating.toString() },
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//category
Future<String> AddCategory(name) async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categoryadd.php"),
    body: {'name': name, 'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> DeleteCategory(id) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categorydelete.php"),
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<String> EditCategory(id, name) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categoryedit.php"),
    body: {'name': name, 'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<List<Category>> GetCategory() async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/categorylist.php"),
    body: {'id': id.toString()},
  );
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//wishlist
Future<List<Product>> GetWishlist() async {
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/wishlistget.php"),
    body: {'id': id.toString()},
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

Future<String> wishlistItem(pid) async{
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/wishlistadd.php"),
    body: {'cid': id.toString(), 'pid':pid.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return json['message'];
    } else {
      return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//order
Future<String> addOrder(total, address) async{
  final id = await userPref.getId();

  final dbHelper = DatabaseHelper.instance;
   
  final cartItems = await dbHelper.viewCart() ?? [];

  List<Map<String, dynamic>> orderList = cartItems.map((item) {
    return {
      "quantity": item["quantity"],
      "product_id": item["product_id"],
    };
  }).toList();

  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/orderadd.php"),
    body: {'id': id.toString(),'total': total.toString(),
      'address': address,
      'orders': jsonEncode(orderList),},
  );
  
  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return "success";
    } else {
      throw Exception('Failed to read API ${json['message']}');
      //return "error";
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<List<Orders>> getOrderHistory() async{
  final id = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/orderlist.php"),
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      final List<dynamic> jsonList = json['data'];
      return jsonList.map((e) => Orders.fromJson(e)).toList();
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

Future<OrderDetail> getOrderDetail(id) async{
    final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/orderlist.php"),
    body: {'id': id.toString()},
  );

  if (response.statusCode == 200) {
    Map json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return OrderDetail.fromJson(json['data']);
    } else {
      throw Exception('API result not success');
    }
  } else {
    throw Exception('Failed to read API');
  }
}

//chat
Future<List<dynamic>> fetchChatList() async {
  final userId = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/chatlist.php"),
    body: {'user_id': userId.toString()},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      // Kembalikan list data percakapan
      return json['data'];
    } else {
      // Jika gagal atau tidak ada data, kembalikan list kosong
      return [];
    }
  } else {
    throw Exception('Failed to load chat list');
  }
}

Future<List<dynamic>> fetchChatMessages(int chatId) async {
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/chatmessages.php"),
    body: {'chat_id': chatId.toString()},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return json['data'];
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load messages');
  }
}

Future<String> sendChat(int chatId, String text) async {
  final senderId = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/sendchat.php"),
    body: {
      'chat_id': chatId.toString(),
      'sender_id': senderId.toString(),
      'text': text,
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return json['result'];
  } else {
    throw Exception('Failed to send message');
  }
}

Future<int> startChat(int sellerId) async {
  final customerId = await userPref.getId();
  final response = await http.post(
    Uri.parse("https://ubaya.xyz/flutter/160422007/uas/startchat.php"),
    body: {
      'customer_id': customerId.toString(),
      'seller_id': sellerId.toString(),
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    if (json['result'] == 'success') {
      return json['chat_id'];
    } else {
      throw Exception('Failed to start chat: ${json['message']}');
    }
  } else {
    throw Exception('Failed to communicate with server');
  }
}

