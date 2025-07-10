import 'package:belanja/Class/product.dart';
import 'package:belanja/Seller/sellerMain.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;
import 'package:http/http.dart';

class ProductEdit extends StatefulWidget {
  final int id;

  const ProductEdit({super.key, required this.id});
  @override
  State<StatefulWidget> createState() {
    return ProductEditPage();
  }
}

class ProductEditPage extends State<ProductEdit> {
  Product? product;
  List<Category> categories = [];
  bool isLoading = true;
  int? selectedId;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _imageController = TextEditingController();

  void fetchData() async {
    final data = await api.GetProductDetail(widget.id);
    setState(() {
      isLoading = false;
      product = data;
      _nameController.text = product?.name ?? "";
      _descController.text = product?.description ?? "";
      _priceController.text = product?.price.toString() ?? '';
      _stockController.text = product?.stock.toString() ?? '';
      _imageController.text = product?.image ?? "";
    });
  }

  void fetchCategory() async {
    final data = await api.GetCategory();
    setState(() {
      categories = data;
    });
  }

  void addProductCat(cid) async {
    final result = await api.AddProductCategory(cid, product?.id);
    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Add successful!")));
      fetchData();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void deleteProductCat(cid) async {
    final result = await api.DeleteProductCategories(cid, product?.id);
    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Delete successful!")));
      fetchData();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void showCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        int? tempSelected = 0; 
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Category'),
              content: Container(
                width: double.maxFinite,
                constraints: BoxConstraints(maxHeight: 300),
                child: ListView(
                  shrinkWrap: true,
                  children:
                      categories.map((category) {
                        return RadioListTile<int>(
                          title: Text(category.name),
                          value: category.id,
                          groupValue: tempSelected,
                          onChanged: (int? value) {
                            setState(() {
                              tempSelected = value;
                            });
                          },
                        );
                      }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (tempSelected != null) {
                      selectedId = tempSelected; 
                      addProductCat(selectedId!); 
                    }
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void Save(Product prod) async {
    final result = await api.EditProduct(prod);
    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Edit successful!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void Delete(id) async {
    final result = await api.DeleteProduct(id);
    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Delete successful!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Delete(product?.id);
            },
          ),
        ],
      ),
      body: EditForm(),
    );
  }

  Widget EditForm() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Enter product name"
                            : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: "Description"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Enter description"
                            : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? "Enter price" : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value == null || value.isEmpty ? "Enter stock" : null,
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "Image URL"),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Enter image URL"
                            : null,
              ),
              const SizedBox(height: 20),
              Text("Categories"),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ...(product?.category
                          ?.where(
                            (cat) => cat.name != null && cat.name!.isNotEmpty,
                          )
                          .map(
                            (category) => Chip(
                              label: Text(category.name),
                              onDeleted: () {
                                setState(() {
                                  deleteProductCat(category.id);
                                });
                              },
                            ),
                          )
                          .toList() ??
                      []),

                  // Add Category Chip at the end
                  ActionChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 16),
                        SizedBox(width: 4),
                        Text("Add Category"),
                      ],
                    ),
                    onPressed: () {
                      showCategoryDialog();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    product?.name = _nameController.text;
                    product?.image = _imageController.text;
                    product?.stock = int.parse(_stockController.text);
                    ;
                    product?.price = int.parse(_priceController.text);
                    ;
                    product?.description = _descController.text;
                    Save(product!);
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      );
    }
  }
}
