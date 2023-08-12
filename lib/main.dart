import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shops/providers/auth.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/userProductScreen.dart';
import './screens/editProductScreen.dart';
import './providers/cart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/order_screen.dart';
import './providers/orders.dart';
import 'package:shops/screens/product_overview_Screen.dart';
import './screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

@override
class MyApp extends StatelessWidget {
  bool isLoggedIn = false;
  static const String keyLogin = "login";

  @override
  void initState() async {
    var sharedPref = await SharedPreferences.getInstance();
    isLoggedIn = sharedPref.getBool(keyLogin) as bool;
    print(isLoggedIn);
    print("------------");
  }

  void where() async {}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(
          create: (ctx) => Products(),

          // ignore: missing_return
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(create: (ctx) => Orders(_auth.currentUser!.uid))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          hintColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: isLoggedIn ? ProductOverviewScreen() : AuthScreen(),
        routes: {
          ProductDetailScreen.routename: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
