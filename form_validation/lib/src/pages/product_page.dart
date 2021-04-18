import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validation/src/models/product_model.dart';
import 'package:form_validation/src/providers/products_provider.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSaving = false;
  ProductModel product = new ProductModel();
  final productProvider = new ProductsProvider();
  PickedFile photo;

  @override
  Widget build(BuildContext context) {
    final ProductModel productData = ModalRoute.of(context).settings.arguments;

    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Productos'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.photo_size_select_actual,
            ),
            onPressed: () => _selectOrTakePhoto(ImageSource.gallery),
          ),
          IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () => _selectOrTakePhoto(ImageSource.camera)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _showPhoto(),
                _createProductName(),
                _createProductPrice(),
                _createAvailable(),
                _createSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createProductName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => product.title = value,
      validator: (value) =>
          value.length < 3 ? 'Ingrese el nombre del producto' : null,
    );
  }

  Widget _createProductPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => product.value = double.parse(value),
      validator: (value) {
        if (utils.isNumber(value)) {
          return null;
        } else {
          return 'Debes ingresar números.';
        }
      },
    );
  }

  Widget _createSubmitButton() {
    return RaisedButton.icon(
      label: Text('Guardar'),
      icon: Icon(
        Icons.save,
        color: Colors.white,
      ),
      color: Colors.teal,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: _isSaving ? null : _submit,
    );
  }

  void _submit() {
    bool isValidForm = formKey.currentState.validate();

    if (!isValidForm) return;

    formKey.currentState.save();
    setState(() {
      _isSaving = true;
    });

    if (product.id == null) {
      productProvider.createProduct(product);
    } else {
      productProvider.editProduct(product);
    }

    showSnackBar('El registro ha sido actualizado');
    Navigator.pop(context);
  }

  void showSnackBar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      activeColor: Colors.teal,
      title: Text('Disponible'),
      onChanged: (value) {
        setState(() {
          product.available = value;
        });
      },
    );
  }

  Widget _showPhoto() {
    if (product.photoUrl != null) {
      // implement product photo
      return Container();
    } else {
      return Image(
        image: AssetImage(photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  void _selectOrTakePhoto(ImageSource source) async {
    final imagePicker = new ImagePicker();

    photo = await imagePicker.getImage(
      source: source,
    );

    if (photo != null) {
      // clean
    }
    setState(() {});
  }
}
