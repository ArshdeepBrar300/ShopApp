import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/AppDrawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        drawer: AppDrawer(),
        body: orderData.orders.length != 0
            ? ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (ctx, index) {
                  return OrderItem(orderData.orders[index]);
                },
              )
            : Center(
                child: Text("No Orders yet!"),
              ));
  }
}
