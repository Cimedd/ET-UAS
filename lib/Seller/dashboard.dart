import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DashboardPage();
  }

}

class DashboardPage extends State<Dashboard>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("WELCOME BACK"),
      ),
    );
  }

}