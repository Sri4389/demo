import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String orderId = args["orderId"];
    final int total = args["total"];

    return Scaffold(
      appBar: AppBar(title: Text("Order Successful")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text("Thank you for your purchase!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text("Order ID: $orderId", style: TextStyle(fontSize: 16)),
              Text("Total Paid: ₹$total", style: TextStyle(fontSize: 16)),
              SizedBox(height: 32),
              ElevatedButton(
                child: Text("Back to Home"),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (_) => false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
