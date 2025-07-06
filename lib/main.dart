import 'package:belanja/Class/userPref.dart';
import 'package:belanja/Customer/customerMain.dart';
import 'package:belanja/Seller/sellerMain.dart';
import 'package:belanja/login.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    Widget initialPage;
    if (result == 'seller') {
      initialPage = SellerMain();
    }
    else if(result == 'customer'){
      initialPage = CustomerMain();
    } 
    else {
      initialPage = LoginPage();
    }
    runApp(MainApp(initialPage: initialPage));
  });
}

class MainApp extends StatelessWidget {
  final Widget initialPage;

  const MainApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialPage,
    );
  }
}
