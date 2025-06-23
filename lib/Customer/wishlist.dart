import 'package:belanja/Customer/productDetail.dart';
import 'package:flutter/material.dart';

class Wishlist extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WishlistPage();
  }

}

class WishlistPage extends State<Wishlist>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: SearchBar(hintText: "search"),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => ProductDetail(productId: index)));
                  },
                  child: Card(
                    elevation: 2,
                    color: Colors.teal.shade100,
                    child: Center(
                      child: Text(
                        "Item $index",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}