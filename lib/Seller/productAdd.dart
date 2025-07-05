import 'package:flutter/material.dart';

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
                    // Call your API or logic here
                    print("Product Name: ${_nameController.text}");
                    print("Description: ${_descController.text}");
                    print("Price: ${_priceController.text}");
                    print("Stock: ${_stockController.text}");
                    print("Image URL: ${_imageController.text}");
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