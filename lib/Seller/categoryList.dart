import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CategoryListPage();
  }

}

class CategoryListPage extends State<CategoryList>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Cat"),
    );
  }

}