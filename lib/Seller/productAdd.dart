import 'package:belanja/Class/product.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddPage();
  }

}

class ProductAddPage extends State<ProductAdd>{
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _imageController = TextEditingController();

  void addProducct(Product prod) async{
    final result = await api.AddProduct(prod);
    if(result == "success"){
       ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Add successful!")));
      Navigator.pop(context);
    } 
    else{
       ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter product name" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter description" : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter price" : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter stock" : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "Image URL"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter image URL" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Product prod = Product(id: 0, sellerId:0 , name: _nameController.text, 
                    description: _descController.text, price: int.parse(_priceController.text),
                     stock:int.parse( _stockController.text), image: _imageController.text, category: []);
                     addProducct(prod);
                  }
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}