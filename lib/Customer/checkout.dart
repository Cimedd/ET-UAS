import 'package:belanja/Class/db.dart';
import 'package:belanja/Customer/customerMain.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CheckoutPage();
  }
}

class CheckoutPage extends State<Checkout> {
  List<Map<String, dynamic>> carts = [];
  final dbHelper = DatabaseHelper.instance;
  final _addressController = TextEditingController();

  void addOrder() async {
    final result = await api.addOrder(calculateTotal(), _addressController.text);
    if (result == "success") {
      await dbHelper.emptyCart();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CustomerMain()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void fetchData() async {
    final data = await dbHelper.viewCart();
    setState(() {
      carts = data ?? [];
    });
  }

  int calculateTotal() {
    int total = 0;
    for (var item in carts) {
      total +=
          ((item['price'] as num).toInt() * (item['quantity'] as num).toInt());
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: carts.length,
                itemBuilder: (context, index) {
                  final item = carts[index];
                  final int quantity = item['quantity'];
                  final int price = item['price'];
                  final int subtotal = quantity * price;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        item['image'] != ""
                            ? Image.network(
                              item['image'],
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
                                item['name'],
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
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: "Delivery Address",
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp ${calculateTotal()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_addressController.text.isNotEmpty) {
                    addOrder();
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Fill the address!")));
                  }
                },
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
