import 'package:belanja/Customer/home.dart';
import 'package:belanja/Customer/orders.dart';
import 'package:belanja/Customer/profile.dart';
import 'package:belanja/Customer/wishlist.dart';
import 'package:belanja/chat.dart';
import 'package:belanja/chatList.dart';
import 'package:flutter/material.dart';

class CustomerMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Customer();
  }
}

class Customer extends State<CustomerMain> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Home(),
    Order(),
    Wishlist(),
    Chat(),
    Profile(),
  ];
  final List<String> _title = ['Home', 'Order', 'Wishlist', 'Chat', 'Profile'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex]),
        backgroundColor: Colors.teal,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.library_books_outlined),
          ),
          BottomNavigationBarItem(
            label: "Wishlist",
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(label: "Chat", icon: Icon(Icons.chat)),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
