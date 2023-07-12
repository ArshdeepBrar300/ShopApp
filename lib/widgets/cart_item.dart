import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final String prodID;
  final int quantity;
  final String title;

  CartItem(this.id, this.price, this.prodID, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
      ),
      onDismissed: (direction) {
        final cart =
            Provider.of<Cart>(context, listen: false).removeItem(prodID);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to remove this item from cart?'),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text('No')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: Text('Yes')),
                ],
              );
            });
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
                    padding: EdgeInsets.all(5),
                    child: FittedBox(child: Text('\$$price')))),
            title: Text(title),
            subtitle: Text('Total : \$${(price * quantity)}'),
            trailing: Text('$quantity X'),
          ),
        ),
      ),
    );
  }
}
