import 'package:belanja/Class/api.dart' as api;
import 'package:belanja/Class/order.dart';
import 'package:flutter/material.dart';

class Ordersdetail extends StatefulWidget {
  final int id;

  const Ordersdetail({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    return OrdersDetailPage();
  }
}

class OrdersDetailPage extends State<Ordersdetail> {
  OrderDetail? order;
  bool isLoading = true;

  void fetchData() async {
    final data = await api.getOrderDetail(widget.id);
    setState(() {
      order = data;
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
    return Scaffold(
      appBar: AppBar(title: Text("Order Detail"),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Order ID: ${order?.order.id ?? ''}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            SizedBox(height: 4),
            Text("Date: ${order?.order.time ?? ''}"),
            SizedBox(height: 4),
            Text("Address: ${order?.order.address ?? ''}"),
            SizedBox(height: 4),
            Text(
              "Total Price: Rp ${order?.order.total ?? 0}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: order?.items.length ?? 0,
                itemBuilder: (context, index) {
                  final item = order?.items[index];
                  final int quantity = item?.quantity ?? 0;
                  final int price = item?.product.price ?? 0;
                  final int subtotal = quantity * price;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        item?.product.image != null
                            ? Image.network(
                              item?.product.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs9gUXKwt2KErC_jWWlkZkGabxpeGchT-fyw&s",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                            : Icon(Icons.image, size: 50),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.product.name ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Quantity: $quantity"),
                              Text("Subtotal: Rp $subtotal"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
