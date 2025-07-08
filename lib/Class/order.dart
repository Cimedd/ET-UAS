class Orders {
  int id;
  String time;
  int total;
  String address;
  int custId;

  Orders({
    required this.id,
    required this.time,
    required this.total,
    required this.address,
    required this.custId,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      time: json['created_at'],
      total: json['total_price'],
      address: json['address'],
      custId: json['customer_id'],
    );
  }
}
class OrderDetail {}