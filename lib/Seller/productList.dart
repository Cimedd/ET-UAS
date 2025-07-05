import 'package:belanja/Customer/productDetail.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListPage();
  }
}

class ProductListPage extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: SearchBar(hintText: "search"),
          ),
          Expanded(child:productList())
        ],
      ),
    );
  }
}

Widget productList() {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: 20,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.9,
    ),
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(productId: index),
            ),
          );
        },
        child: Card(
          elevation: 2,
          color: Colors.teal.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ Use fixed height image, NOT Expanded
             Expanded(
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
              // ✅ Wrap text in Flexible or just leave it normal
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Item Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$19.99',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
