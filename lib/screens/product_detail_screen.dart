import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:shops/screens/product_overview_Screen.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routename = '/Product-Detail';

  ProductDetailScreen();

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findMyId(productID);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                loadedProduct.imageURL,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$${loadedProduct.price}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '${loadedProduct.description}',
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          )
        ]),
      ),
    );
  }
}
