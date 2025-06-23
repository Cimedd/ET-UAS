import 'package:belanja/chatList.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget{
  const Chat({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChatPage();
  }

}

class ChatPage extends State<Chat>{

   final List<Map<String, dynamic>> chats = [
      {
        "name": "Alice",
        "lastMessage": "See you tomorrow!",
        "avatarUrl": "https://i.pravatar.cc/150?img=1",
        "isRead": false,
      },
      {
        "name": "Bob",
        "lastMessage": "Thanks for the update",
        "avatarUrl": "https://i.pravatar.cc/150?img=2",
        "isRead": true,
      },
    ];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat["avatarUrl"]),
            ),
            title: Text(
              chat["name"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chat["lastMessage"],
              style: TextStyle(
                color:  Colors.grey ,
                fontWeight:
                     FontWeight.normal,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

}