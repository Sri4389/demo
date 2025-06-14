import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item_model.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final List<CartItem> selectedItems = cartProvider.selectedItems;

    if (selectedItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Checkout")),
        body: Center(child: Text("No items selected for checkout.")),
      );
    }

    final total = cartProvider.totalSelectedPrice;

    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ...selectedItems.map((item) => Card(
                  child: ListTile(
                    leading: Image.asset(item.product.image, width: 50, fit: BoxFit.cover),
                    title: Text(item.product.name),
                    subtitle: Text("Qty: ${item.quantity}"),
                    trailing: Text("₹${item.product.price * item.quantity}"),
                  ),
                )),
            Divider(),
            ListTile(
              title: Text("Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              trailing: Text("₹${total.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final orderId = "ORD${DateTime.now().millisecondsSinceEpoch}";
                Navigator.pushNamed(
                  context,
                  '/order-success',
                  arguments: {
                    "orderId": orderId,
                    "total": total,
                    "items": selectedItems,
                  },
                );
              },
              child: Text("Place Order"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
