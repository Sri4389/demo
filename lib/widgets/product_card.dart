import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/productDetail',
                  arguments: product,
                );
              },
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(product.image, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("₹${product.price.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add to Cart button (not part of the tap area for navigation)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: ElevatedButton(
              onPressed: onAdd,
              child: Text("Add to Cart"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 36),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
