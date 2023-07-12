import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import './auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shops/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.items, this.dateTime);
}

class Orders with ChangeNotifier {
  late String userId;
  Orders(this.userId);
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(double amount, List<CartItem> items) async {
    await FirebaseFirestore.instance.collection('Orders').add({
      '$userId': {
        'amount': amount,
        'dateTime': DateTime.now().toIso8601String(),
        'products': items.map((item) => {
              'id': item.id,
              'price': item.price,
              'quantity': item.quantity,
              'title': item.title,
            })
      }
    });

    _orders.insert(
        0,
        OrderItem(
          DateTime.now().toString(),
          amount,
          items,
          DateTime.now(),
        ));
    notifyListeners();
  }
}
