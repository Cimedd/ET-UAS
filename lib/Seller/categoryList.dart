import 'package:belanja/Class/product.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;

class CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryListPage();
  }
}

class CategoryListPage extends State<CategoryList> {
  List<Category> categories = [];
  bool isLoading = true;

  void showCategoryDialog(Category? category) {
    TextEditingController _nameController = TextEditingController(
      text: category?.name ?? "",
    );
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(category == null ? "Add Category" : "Edit Category"),
            content: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Category Name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_nameController.text.trim().isNotEmpty) {
                    String result;
                    if (category == null) {
                      result = await api.AddCategory(_nameController.text);
                    } else {
                      result = await api.EditCategory(
                        category.id,
                        _nameController.text,
                      );
                    }

                    if (result == "success") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Saved successfully!")),
                      );
                      fetchData();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed! Please Try Again")),
                      );
                    }
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }

  void deleteCategory(Category category) {
    final result = api.DeleteCategory(category.id);
    if (result == "success") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Deleted successfully!")));
      fetchData();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
    });
    final data = await api.GetCategory();
    setState(() {
      categories = data;
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
      body: CategoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCategoryDialog(null);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget CategoryList() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (categories.isEmpty) {
      return Center(child: Text("No categories found, start adding some"));
    } else {
      return ListView.builder(
        itemCount: categories.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(categories[index].name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => showCategoryDialog(categories[index]),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteCategory(categories[index]),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
