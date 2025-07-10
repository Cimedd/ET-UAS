import 'dart:async';

import 'package:belanja/Class/api.dart' as api;
import 'package:belanja/Class/chat.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/dateUtils.dart' as dateUtils;

class ChatList extends StatefulWidget {
  final int id;
  final String name;

  const ChatList({super.key, required this.id, required this.name});
  @override
  State<StatefulWidget> createState() {
    return ChatListPage();
  }
}

class ChatListPage extends State<ChatList> {
  TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> chats = [];
  int chatID = 0;
  bool isLoading = true;

  Timer? _timer;
  void fetchData() async {
    List<ChatMessage> data = await api.fetchChatMessages(chatID);
    setState(() {
      chats = data;
      isLoading = false;
    });
  }

  void fetchChat() async {
    final data = await api.startChat(widget.id);
    setState(() {
      chatID = data;
      fetchData();
    });
  }

  void sendChat() async {
    final result = await api.sendChat(chatID, "text");
    if (result == "success") {
      fetchData();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Edit successful!")));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChat();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData(); 
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }


  void sendMessage(String text) async {
    final result = await api.sendChat(chatID, text);
    if (result == "success") {
      _messageController.clear();
      fetchData();
      isLoading = false;
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(
            child:
                chats.isEmpty
                    ? Center(child: Text("No Chat Found"))
                    : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(12),
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        final chat = chats[index];
                        final isMe = chat.senderId == widget.id;
                        final currentDate =
                            DateTime.parse(chat.sentAt).toLocal();
                        final previousDate =
                            index > 0
                                ? DateTime.parse(
                                  chats[index - 1].sentAt,
                                ).toLocal()
                                : null;

                        bool showDateSeparator = false;
                        if (previousDate == null ||
                            currentDate.day != previousDate.day ||
                            currentDate.month != previousDate.month ||
                            currentDate.year != previousDate.year) {
                          showDateSeparator = true;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (showDateSeparator)
                              Center(
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    dateUtils.formatDate(currentDate),
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                              ),
                            Align(
                              alignment:
                                  isMe
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isMe
                                          ? Colors.blueAccent
                                          : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      chat.text,
                                      style: TextStyle(
                                        color:
                                            isMe
                                                ? Colors.white
                                                : Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      dateUtils.formatTime(currentDate),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color:
                                            isMe
                                                ? Colors.white70
                                                : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
          ),

          // --- Input field & send button ---
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if(isLoading){
                      return;
                    }
                    if (_messageController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Edit successful!")),
                      );
                      Navigator.pop(context);
                    } else if (_messageController.text.length > 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Edit successful!")),
                      );
                      Navigator.pop(context);
                    } else {
                      sendMessage(_messageController.text.trim());
                      isLoading = true;
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
