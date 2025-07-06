import 'package:belanja/Class/db.dart';
import 'package:belanja/Customer/checkout.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CartPage();
  }
}

class CartPage extends State<Cart> {
  List<Map<String, dynamic>> carts = [];
  final dbHelper = DatabaseHelper.instance;

  void fetchData() async {
    final data = await dbHelper.viewCart();
    setState(() {
      carts = data ?? [];
    });
  }

  void addQuantity(id, quantity) async {
    dbHelper.addQuantity(id, quantity);
    fetchData();
  }

  void remove(id) {
    dbHelper.removeItem(id);
    fetchData();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: [
          Expanded(child: CartList()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Checkout()),
                  );
                },
                child: Text("Go to Checkout"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CartList() {
    if (carts.isEmpty) {
      return Center(
        child: Text("Cart is Empty, Start browsing and add items to your cart"),
      );
    } else {
      return ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  leading:
                      carts[index]['image'] != ""
                          ? Image.network(
                            carts[index]['image'],
                            width: 50,
                            height: 50,
                          )
                          : Icon(Icons.image),
                  title: Text(carts[index]['name']),
                  subtitle: Text("Rp ${carts[index]['price']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Keep the row compact
                          children: [
                            InkWell(
                              onTap:
                                  () => (addQuantity(carts[index]['id'], -1)),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                bottomLeft: Radius.circular(25.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 6.0,
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                  right: BorderSide(
                                    color: Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  '${carts[index]['quantity']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => (addQuantity(carts[index]['id'], 1)),

                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 6.0,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          remove(carts[index]['id']);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 1,),
              ],
            ),
          );
        },
      );
    }
  }
}
