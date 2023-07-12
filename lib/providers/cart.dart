import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final double price;
  final String id;
  final int quantity;

  CartItem(
      {required this.title,
      required this.price,
      required this.id,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double amount = 0.0;
    _items.forEach((key, cartItem) {
      amount += cartItem.price * cartItem.quantity;
    });
    return amount;
  }

  void removeItem(String prodID) {
    _items.remove(prodID);
    notifyListeners();
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (existingItem) => CartItem(
              title: existingItem.title,
              price: existingItem.price,
              id: existingItem.id,
              quantity: existingItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
              title: title,
              price: price,
              id: DateTime.now().toString(),
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(String prodId) {
    if (!_items.containsKey(prodId)) return;
    if (_items[prodId]!.quantity > 1) {
      _items.update(
          prodId,
          (previousItem) => CartItem(
              title: previousItem.title,
              price: previousItem.price,
              id: previousItem.id,
              quantity: previousItem.quantity - 1));
    } else {
      _items.remove(prodId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
