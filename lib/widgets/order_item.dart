import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';
import 'dart:math';
import '../providers/orders.dart' as orderData;

class OrderItem extends StatefulWidget {
  final orderData.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd MM yyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon:
                  _expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: min(widget.order.items.length * 20.0 + 10, 100),
              child: ListView.builder(
                itemBuilder: (ctx, ind) {
                  return Row(
                    children: [
                      Text(
                        '${widget.order.items[ind].title}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.order.items[ind].quantity}x \$${widget.order.items[ind].price}',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      )
                    ],
                  );
                },
                itemCount: widget.order.items.length,
              ),
            ),
        ],
      ),
    );
  }
}

