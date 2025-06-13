import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Tomato', image: 'assets/onboarding1.png', price: 20, category: 'Vegetables'),
    Product(id: '2', name: 'Milk', image: 'assets/onboarding1.png', price: 40, category: 'Dairy'),
    Product(id: '3', name: 'Apple', image: 'assets/onboarding1.png', price: 90, category: 'Fruits'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screenova"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search groceries...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onAdd: () {
                    Navigator.pushNamed(
                      context,
                      '/productDetail',
                      arguments: products[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
