import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/AppDrawer.dart';
import '../widgets/userProductItem.dart';
import '../providers/products.dart';

class UserProductScreen extends StatelessWidget {
  @override
  static const routeName = "/userProductScreen";
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: (_, i) {
            return UserProductItem(
              title: productData.items[i].title,
              imageurl: productData.items[i].imageURL,
            );
          },
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
