import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OrderPage();
  }
}

class OrderPage extends State<Order> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#ORD1234",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text("123 Main Street, Surabaya"),
                  SizedBox(height: 4),
                  Text(
                    "Date: 2025-06-10",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Total: Rp 1.500.000",
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
            );
          },
        ),
      ),
    );
  }
}
