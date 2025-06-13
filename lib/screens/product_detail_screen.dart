import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  void incrementQty() {
    setState(() {
      quantity++;
    });
  }

  void decrementQty() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.asset(product.image, height: 220, fit: BoxFit.contain),
          SizedBox(height: 16),
          Text(product.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(product.category, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          SizedBox(height: 12),
          Text("₹${product.price.toStringAsFixed(2)}", style: TextStyle(fontSize: 22, color: Colors.green)),
          SizedBox(height: 20),
          Row(
            children: [
              Text("Quantity:", style: TextStyle(fontSize: 18)),
              SizedBox(width: 20),
              IconButton(onPressed: decrementQty, icon: Icon(Icons.remove_circle_outline)),
              Text('$quantity', style: TextStyle(fontSize: 18)),
              IconButton(onPressed: incrementQty, icon: Icon(Icons.add_circle_outline)),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Description",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Fresh and organic ${product.name} directly from farm to your doorstep. Packed with nutrition and delivered with care.",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // TODO: Add to cart logic
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.green,
            ),
            child: Text("Add to Cart", style: TextStyle(fontSize: 18)),
          )
        ],
      ),
    );
  }
}
