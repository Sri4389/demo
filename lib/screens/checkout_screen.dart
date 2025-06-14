import 'package:flutter/material.dart';
import 'package:myapp/screens/address_screen.dart';


class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Address selectedAddress =
        ModalRoute.of(context)!.settings.arguments as Address;

    // Sample cart data (replace with your real cart model)
    final List<Map<String, dynamic>> cartItems = [
      {"name": "Apples", "qty": 2, "price": 60},
      {"name": "Milk", "qty": 1, "price": 50},
      {"name": "Bread", "qty": 1, "price": 40},
    ];

    final int total = cartItems.fold(
        0, (sum, item) => sum + ((item["qty"] * item["price"]) as int));

    void _placeOrder() {
      // You may add order logic here (API call, Firebase write, etc.)
      Navigator.pushNamed(
        context,
        '/order-success',
        arguments: {
          "orderId": "ORD${DateTime.now().millisecondsSinceEpoch}",
          "total": total,
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Delivery Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text("${selectedAddress.name} - ${selectedAddress.phone}"),
                subtitle: Text(
                    "${selectedAddress.street}, ${selectedAddress.city}, ${selectedAddress.zip}, ${selectedAddress.state}"),
              ),
            ),
            SizedBox(height: 16),
            Text("Order Summary",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...cartItems.map((item) => ListTile(
                  title: Text(item["name"]),
                  subtitle: Text("Qty: ${item["qty"]}"),
                  trailing: Text("₹${item["qty"] * item["price"]}"),
                )),
            Divider(),
            ListTile(
              title: Text("Total", style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text("₹$total", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.check_circle),
              label: Text("Place Order"),
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
