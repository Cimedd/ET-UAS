import 'package:belanja/Class/userPref.dart' as userPref;
import 'package:belanja/Seller/categoryList.dart';
import 'package:belanja/Seller/dashboard.dart';
import 'package:belanja/Seller/productList.dart';
import 'package:belanja/chat.dart';
import 'package:belanja/login.dart';
import 'package:flutter/material.dart';

class SellerMain extends StatefulWidget {
  const SellerMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return Seller();
  }
}

class Seller extends State<SellerMain> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Dashboard(),
    ProductList(),
    CategoryList(),
    Chat(),
  ];

  final List<String> _drawerTitles = [
    'Dashboard',
    'Product',
    'Category',
    'Chat',
  ];

  void Logout() async {
    await userPref.Logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_drawerTitles[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Logout();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _drawerTitles.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.arrow_right),
              title: Text(_drawerTitles[index]),
              selected: index == _currentIndex,
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                Navigator.pop(context); // Close the drawer
              },
            );
          },
        ),
      ),
      body: _screens[_currentIndex],
    );
  }
}
