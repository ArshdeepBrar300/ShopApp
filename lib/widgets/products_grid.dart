import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  var _showFavourites;
  ProductsGrid(this._showFavourites);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =
        _showFavourites ? productData.favorites : productData.items;
    print('i');
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          child: ProductItem(), value: products[i]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
