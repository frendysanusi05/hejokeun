import 'package:flutter/material.dart';
import 'package:hejokeun/model/cart_item.dart';
import 'package:hejokeun/model/penukaran.dart';
import 'package:collection/collection.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Penukaran penukaran, double quantity) {
    var existingCartItem = _cartItems
        .firstWhereOrNull((item) => item.penukaran.name == penukaran.name);

    if (existingCartItem == null) {
      _cartItems.add(CartItem(penukaran: penukaran, quantity: quantity));
    } else {
      if (quantity == 0) {
        _cartItems.removeWhere((item) => item.penukaran.name == penukaran.name);
      } else {
        existingCartItem.quantity = quantity;
      }
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getTotalItem() {
    return _cartItems.length;
  }

  int getTotalPoints() {
    int total = 0;
    for (var item in _cartItems) {
      total += item.penukaran.point! * item.quantity ~/ 0.1;
    }
    return total;
  }

  double getTotalQuantity() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.quantity;
    }
    return total;
  }

  double getItemQuantity(String name) {
    var existingCartItem =
        _cartItems.firstWhereOrNull((item) => item.penukaran.name == name);

    if (existingCartItem == null) {
      return 0;
    } else {
      return existingCartItem.quantity;
    }
  }
}
