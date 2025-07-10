import 'package:belanja/Class/api.dart' as api;
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
  String _filterBy = "name";
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filterOptions = ["name", "category"];

  void fetchData() async {
    List<Product> data = await api.GetProductAdmin(0);
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  void fetchDataFilter() async {
  List<Product> data = await api.GetProducAdmintListFiltered(_filterBy,_searchController.text, 0);
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: _searchController,
                    hintText: "Search by $_filterBy",
                    onChanged: (query) {
                      fetchDataFilter();
                      setState(() {
                        isLoading = true;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _filterBy,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _filterBy = value;
                      });
                    }
                  },
                  items:
                      _filterOptions.map((option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(
                            option[0].toUpperCase() +
                                option.substring(1), // Capitalize
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ),
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

  Widget productList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (products.isEmpty) {
      return Center(child: Text("Empty Product"));
    } else {
      return GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
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
                  builder:
                      (context) => ProductDetail(productId: products[index].id),
                ),
              );
            },
            child: Card(
              elevation: 2,
              color: Colors.teal.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      products[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            products[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit Product',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        ProductEdit(id: products[index].id),
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
  }
}
