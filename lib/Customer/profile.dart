import 'package:belanja/login.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/userPref.dart' as userPref;
class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return ProfilePage();
  }

}

class ProfilePage extends State<Profile>{

  Map<String,String?> user = {};

  void Logout() async{
    await userPref.Logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, 
    );
  }

  void setData() async{
    final userdata = await userPref.getUserData();
    setState(() {
      user = userdata;
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/300', // Use any image URL or asset
            ),
          ),
          SizedBox(height: 16),
          Text(
            user['name'] ?? "Username",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            user['email'] ?? "Email",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Padding(
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
        ],
      ),
    );
  }
}