import 'package:flutter/material.dart';

class ChatList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChatListPage();
  }

}

class ChatListPage extends State<ChatList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NAME "),
      ),
      body: Text("data"),
    );
  }

}