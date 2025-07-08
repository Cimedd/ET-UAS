import 'package:belanja/Class/db.dart';
import 'package:belanja/Class/product.dart';
import 'package:belanja/Customer/cart.dart';
import 'package:belanja/Customer/shopDetail.dart';
import 'package:flutter/material.dart';
import 'package:belanja/Class/api.dart' as api;
import 'package:belanja/Class/userPref.dart' as userPref;

class ProductDetail extends StatefulWidget {
  final int productId;

  const ProductDetail({super.key, required this.productId});
  @override
  State<StatefulWidget> createState() {
    return ProductdetailPage();
  }
}

class ProductdetailPage extends State<ProductDetail> {
  final dbHelper = DatabaseHelper.instance;
  Product? item;
  bool isLoading = false;
  bool isWishlisted = false;
  String message = '';
  String role = 'customer';

  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void showAddReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom:
                  MediaQuery.of(
                    context,
                  ).viewInsets.bottom, // ⬅️ Handles keyboard
            ),

            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Leave a Review",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _reviewController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Write your review...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _ratingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Rating (1-5)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {
                      if (_quantityController.text.isNotEmpty) {
                        setState(() {});
                        _reviewController.clear();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void showAddProduct() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Enter Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    int? qty = int.tryParse(_quantityController.text);
                    if (qty == null || qty < 1) {
                      setState(() {
                        message = "Minimum quantity is 1";
                      });
                      return;
                    }
                    if (qty > (item?.stock ?? 0)) {
                      setState(() {
                        message = "Only ${item?.stock ?? 0} in stocks";
                      });
                      return;
                    }
                    addToCart(int.parse(_quantityController.text));
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void fetchData() async {
    final prod = await api.GetProductDetail(widget.productId);
    final prefRole = await userPref.checkUser();
    setState(() {
      item = prod;
      isLoading = false;
      role = prefRole;
    });
  }

  void wishlist() async {}

  void addToCart(quantity) async {
    Map<String, dynamic> addItem = {
      "product_id": item?.id,
      "name": item?.name,
      "image": item?.image,
      "price": item?.price,
      "quantity": quantity,
      "stock": item?.stock,
    };
    dbHelper.addCart(addItem);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Cart()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail ${widget.productId}"),
        actions: [
           if (role == "customer") 
           IconButton(
            icon: Icon(
              Icons.favorite_border,
            ), 
            onPressed: () {
              wishlist();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(child: ItemView()),
    );
  }

  Widget ItemView() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(item?.image ?? "", fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Text(
              item?.name ?? "",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShopDetail(shopId: item?.sellerId ?? 1),
                  ),
                );
              },
              child: Text(
                item?.sellerName ?? "Visit Shop",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text("Price: ${item?.price ?? 0}", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            Text("Stock: ${item?.stock ?? 0}", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children:
                  item?.category
                      ?.where((cat) => cat.name != null && cat.name!.isNotEmpty)
                      .map((category) => Chip(label: Text(category.name)))
                      .toList() ??
                  [],
            ),
            const SizedBox(height: 6),
            Text(
              item?.description ?? "No Description",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            role == "customer"
                ? SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showAddProduct();
                    },
                    child: const Text("Add to Cart"),
                  ),
                )
                : const SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: showAddReview,
                    child: const Text(
                      "Add Review +",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("name"),
                      Row(
                        children: [
                          Text("review['rating']" ?? '4'),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lorem ipsum dolor"),
                      const SizedBox(height: 4),
                      Text(
                        "review['date']" ?? '2025-06-13',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
