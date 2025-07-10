import 'package:belanja/Class/product.dart';
import 'package:belanja/Customer/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<Home> {
  List<Product> products = [];
  bool isLoading = true;
  String _filterBy = "name";
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filterOptions = ["name", "category"];

  void fetchData() async {
    List<Product> data = await api.GetProductList();
    setState(() {
      products = data;
      isLoading = false;
    });
  }

  void fetchDataFilter() async {
  List<Product> data = await api.GetProductListFiltered(_filterBy,_searchController.text);
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
            items: _filterOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option[0].toUpperCase() + option.substring(1), // Capitalize
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
          Expanded(
            child: productList(), // now it's okay to wrap GridView in Expanded
          ),
        ],
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
                  builder: (context) => ProductDetail(productId: products[index].id),
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
                      products[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ✅ Wrap text in Flexible or just leave it normal
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          products[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Rp ${products[index].price}",
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
  }
}
