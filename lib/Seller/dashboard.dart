import 'package:belanja/Class/userPref.dart' as userPref;
import 'package:belanja/login.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DashboardPage();
  }

}

class DashboardPage extends State<Dashboard>{
    void Logout() async{
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
      body: Column(children: [ Center(
        child: Text("WELCOME BACK")), Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Logout();
                },
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],) 
      );
  }

}