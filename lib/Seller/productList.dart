import 'package:belanja/Class/product.dart';
import 'package:belanja/Customer/productDetail.dart';
import 'package:belanja/Seller/productAdd.dart';
import 'package:belanja/Seller/productEdit.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListPage();
  }
}

class ProductListPage extends State<ProductList> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: SearchBar(hintText: "search"),
          ),
          Expanded(child: productList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAdd()),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
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
          clipBehavior:
              Clip.hardEdge, // Ensures the image respects the card's rounded corners
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The image takes up the available space
              Expanded(
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Item Name (takes up available space in the row)
                    const Flexible(
                      child: Text(
                        'Item Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 3,),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Edit Product',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductEdit(id: 1,),
                          ),
                        );
                      },
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
