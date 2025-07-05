import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CategoryListPage();
  }
}

class CategoryListPage extends State<CategoryList>{
  int id = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Cat"),
    );
  }
}