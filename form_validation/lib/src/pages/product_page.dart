import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:form_validation/src/models/product_model.dart';
import 'package:form_validation/src/utils/utils.dart' as utils;

// import 'package:flutter/services.dart';
// import 'package:form_validation/src/providers/products_provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // final productProvider = new ProductsProvider();
  ProductsBloc productsBloc;
  ProductModel product = new ProductModel();
  bool _isSaving = false;
  File photo;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productsBloc(context);
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
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      label: Text('Guardar'),
      icon: Icon(
        Icons.save,
        color: Colors.white,
      ),
      // color: Colors.teal,
      // textColor: Colors.white,
      onPressed: _isSaving ? null : _submit,
    );
  }

  void _submit() async {
    bool isValidForm = formKey.currentState.validate();

    if (!isValidForm) return;

    formKey.currentState.save();
    setState(() {
      _isSaving = true;
    });

    if (photo != null) {
      // product.photoUrl = await productProvider.uploadImage(photo);
      product.photoUrl = await productsBloc.uploadImage(photo);
    }

    if (product.id == null) {
      // productProvider.createProduct(product);
      productsBloc.createProduct(product);
    } else {
      // productProvider.editProduct(product);
      productsBloc.editProduct(product);
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
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(product.photoUrl),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (photo != null) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  void _selectOrTakePhoto(ImageSource source) async {
    final imagePicker = new ImagePicker();

    final pickedImage = await imagePicker.getImage(
      source: source,
    );

    photo = File(pickedImage.path);

    if (photo != null) {
      product.photoUrl = null;
    }
    setState(() {});
  }
}
