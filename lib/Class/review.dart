class Review {
  int id;
  String text;
  int rating;
  String time;
  String sender;

  Review({required this.id, required this.text, required this.rating, required this.time, required this.sender});
  factory Review.fromJson(Map<String, dynamic> json){
    return Review(id: json['id'], 
    text:json['text'] ??"",
    rating: json['rating'] ?? 0,
    time: json['created_at'] ?? "",
    sender: json['name']??"");
  }
}