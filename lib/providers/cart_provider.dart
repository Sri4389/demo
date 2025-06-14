import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  void updateQuantity(Product product, int qty) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1 && qty > 0) {
      _items[index].quantity = qty;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
  }
}
