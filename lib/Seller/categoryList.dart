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
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    if (category == null) {
                      api.AddCategory(_nameController);
                    } else {
                      api.EditCategory(_nameController, category.id);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
    );
  }

  void deleteCategory(Category category) {
    api.DeleteCategory(category.id);
    setState(() {});
  }

  void fetchData() async {
    final data = await api.GetCategory();
    setState(() {
      categories = data;
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          // final category = categories[index];
          return ListTile(
            title: Text("category.name"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed:
                      () => showCategoryDialog(
                        Category(id: 1, name: "asd", sellerId: 1),
                      ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed:
                      () => deleteCategory(
                        Category(id: 1, name: "", sellerId: 1),
                      ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCategoryDialog(null);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
