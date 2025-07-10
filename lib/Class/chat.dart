class ChatMessage {
  int id;
  int chatId;
  int senderId;
  String text;
  String sentAt;

  ChatMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.sentAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      chatId: json['Chat_id'],
      senderId: json['sender_id'],
      text: json['text'],
      sentAt: json['sent_at'],
    );
  }
}


class Chats {
  int chatId;
  int otherUserId;
  String otherUserName;
  String? lastMessage;

  Chats({
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
    this.lastMessage,
  });

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
      chatId: json['chat_id'],
      otherUserId: json['other_user_id'],
      otherUserName: json['other_user_name'],
      lastMessage: json['last_message'] ?? "",
    );
  }
}