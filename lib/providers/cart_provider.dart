import 'package:flutter/material.dart';
import 'package:learnly_assessment/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addProductToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeProductFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  int get cartItemCount => _cartItems.length;
}
