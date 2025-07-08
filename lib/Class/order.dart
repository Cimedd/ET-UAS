import 'package:belanja/Class/product.dart';
import 'package:belanja/Customer/orders.dart';

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
class OrderDetail {
  Orders order;
  List<OrderItem> items;
  OrderDetail({required this.order, required this.items});
  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
    order: Orders.fromJson(json['order']),
    items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList()
  ); 
}


class OrderItem {
  int quantity;
  Product product;

  OrderItem({required this.quantity, required this.product});

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    quantity: json['quantity'],
    product: Product.fromJson(json['product']),
  );
}