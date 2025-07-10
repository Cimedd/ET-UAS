import 'package:belanja/Class/api.dart' as api;
import 'package:belanja/Class/chat.dart';
import 'package:belanja/chatList.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<StatefulWidget> createState() {
    return ChatPage();
  }
}

class ChatPage extends State<Chat> {
  List<Chats> chats = [];
  bool isLoading = true;

  void fetchData() async {
    List<Chats> data = await api.fetchChatList();
    setState(() {
      chats = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListChat());
  }

  Widget ListChat() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (chats.isEmpty) {
      return Center(child: Text("Start a conversation with seller"));
    } else {
      return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            title: Text(
              chat.otherUserName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chat.lastMessage.toString(),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatList(id: chat.otherUserId, name: chat.otherUserName,),
                ),
              );
            },
          );
        },
      );
    }
  }
}
