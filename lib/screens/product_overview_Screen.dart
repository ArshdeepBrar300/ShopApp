import 'dart:async';

import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/widgets/products_grid.dart';
import '../providers/cart.dart';
import 'package:flutter/material.dart';
import './cart_screen.dart';
import '../widgets/AppDrawer.dart';
import 'auth_screen.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => ProductOverviewScreenState();
}

class ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    //var isLoggedIn=
    var _showFavorites = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Only Favourites"),
                value: 0,
              ),
              PopupMenuItem(child: Text("Show All"), value: 1)
            ],
            onSelected: (value) {
              setState(() {
                if (value == 0) {
                  _showFavorites = true;
                } else
                  _showFavorites = false;
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return Badgee(
                child: ch,
                value: cart.itemCount.toString(),
                color: Colors.black,
              );
            },
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: new ProductsGrid(_showFavorites),
    );
  }
}
