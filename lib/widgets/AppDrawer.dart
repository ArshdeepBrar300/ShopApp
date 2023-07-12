import 'package:flutter/material.dart';
import 'package:shops/screens/auth_screen.dart';
import '../screens/order_screen.dart';
import '../screens/product_overview_Screen.dart';
import '../screens/userProductScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text("Hello Buddy"),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Shop"),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProductOverviewScreen()));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Orders"),
          onTap: () {
            Navigator.of(context).pushNamed(OrderScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Manage Products"),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text("Logout"),
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AuthScreen()));
          },
        )
      ]),
    );
  }
}
