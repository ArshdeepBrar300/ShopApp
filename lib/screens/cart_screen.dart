import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shops/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as CI;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(label: Text('\$${cart.totalAmount}')),
                    TextButton(
                        onPressed: () {
                          Provider.of<Orders>(context, listen: false).addOrder(
                              cart.totalAmount, cart.items.values.toList());
                          cart.clear();
                        },
                        child: Text("ORDER NOW!"),
                        style: ButtonStyle()),
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CI.CartItem(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].price,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
