class Product {
  int id;
  int sellerId;
  String name;
  String description;
  int price;
  int stock;
  String image;
  List<Category>? category;

  Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sellerId: json['seller_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
       category: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}

class Category{
  int id;
  String name;
  int sellerId;

  Category({required this.id, required this.name, required this.sellerId});
  factory Category.fromJson(Map<String, dynamic> json){
    return Category(id: json['id'], name:json['name'], sellerId:json['seller_id']);
  }
}

