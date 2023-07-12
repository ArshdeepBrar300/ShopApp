import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/editProductScreen";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var editProduct =
      Product(id: 'null', title: '', description: '', price: 0, imageURL: '');
  final _form = GlobalKey<FormState>();
  final _pricefocusNode = FocusNode();
  final _descriptionfocusNode = FocusNode();
  final _imagefocusNode = FocusNode();
  final _imageurlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _imagefocusNode.addListener(_updateimageurl);
    super.initState();
  }

  void _updateimageurl() {
    if (!_imagefocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pricefocusNode.dispose();
    _imagefocusNode.removeListener(_updateimageurl);
    _descriptionfocusNode.dispose();
    _imagefocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('title'),
                  ),
                  onSaved: (newValue) {
                    editProduct = Product(
                        id: editProduct.id,
                        title: newValue!,
                        description: editProduct.description,
                        price: editProduct.price,
                        imageURL: editProduct.imageURL);
                  },
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_pricefocusNode),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Price'),
                  ),
                  onSaved: (newValue) {
                    editProduct = Product(
                        id: editProduct.id,
                        title: editProduct.title,
                        description: editProduct.description,
                        price: double.parse(newValue!),
                        imageURL: editProduct.imageURL);
                  },
                  focusNode: _pricefocusNode,
                  onFieldSubmitted: (value) => FocusScope.of(context)
                      .requestFocus(_descriptionfocusNode),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                  maxLines: 3,
                  onSaved: (newValue) {
                    editProduct = Product(
                        id: editProduct.id,
                        title: editProduct.title,
                        description: newValue!,
                        price: editProduct.price,
                        imageURL: editProduct.imageURL);
                  },
                  focusNode: _descriptionfocusNode,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: _imageurlController.text.length > 0
                          ? FittedBox(
                              child: Image.network(_imageurlController.text),
                              fit: BoxFit.cover,
                            )
                          : Text("Enter an url"),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('image url'),
                        ),
                        controller: _imageurlController,
                        focusNode: _imagefocusNode,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) => _saveForm(),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
