import 'package:flutter/material.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductListPage();
  }

}

class ProductListPage extends State<ProductList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Product"),
    );
  }

}