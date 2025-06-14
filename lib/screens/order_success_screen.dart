import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String orderId = args['orderId'];
    final double total = (args['total'] as num).toDouble();
    final List<CartItem> items = List<CartItem>.from(args['items']);

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Success"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🎉 Thank you for your order!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Order ID: $orderId"),
            SizedBox(height: 20),
            Text("Ordered Items:", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Image.asset(item.product.image, width: 50),
                    title: Text(item.product.name),
                    subtitle: Text("Qty: ${item.quantity}"),
                    trailing: Text(
                        "₹${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                  );
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text("Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              trailing: Text("₹${total.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              },
              icon: Icon(Icons.home),
              label: Text("Back to Home"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
