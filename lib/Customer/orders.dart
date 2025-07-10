import 'package:belanja/Class/api.dart' as api;
import 'package:belanja/Class/order.dart';
import 'package:belanja/Customer/ordersDetail.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderPage();
  }
}

class OrderPage extends State<Order> {
  List<Orders> orders = [];
  bool isLoading = true;

  void fetchData() async {
    List<Orders> data = await api.getOrderHistory();
    setState(() {
      orders = data;
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
    return Scaffold(body: orderItem());
  }

  Widget orderItem() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (orders.isEmpty) {
      return Center(child: Text("Empty Product"));
    } else {
      return Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ordersdetail(id: orders[index].id),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${orders[index].id}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(orders[index].address),
                    SizedBox(height: 4),
                    Text(
                      "Date: ${orders[index].time}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Total: Rp ${orders[index].total}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 6),
                    Divider(thickness: 2, color: Colors.grey[400]),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
