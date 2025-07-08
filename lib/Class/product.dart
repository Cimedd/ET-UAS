class Product {
  int id;
  int sellerId;
  String sellerName;
  String name;
  String description;
  int price;
  int stock;
  String image;
  List<Category>? category;
  bool isWishlisted;

  Product({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.category,
    required this.isWishlisted
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sellerId: json['seller_id'],
      sellerName: json['seller_name'] ?? "",
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
      category: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
      isWishlisted: json['wishlist'] ?? false
    );
  }
}

class Category{
  int id;
  String name;
  int sellerId;

  Category({required this.id, required this.name, required this.sellerId});
  factory Category.fromJson(Map<String, dynamic> json){
    return Category(id: json['id'] ?? 0, name:json['name'] ?? "", sellerId:json['seller_id'] ?? 0);
  }
}

