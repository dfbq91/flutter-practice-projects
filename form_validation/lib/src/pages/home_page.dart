import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/product_model.dart';
import 'package:form_validation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  final productsProvider = new ProductsProvider();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _createProductsList(),
      floatingActionButton: _createButton(context),
    );
  }

  FloatingActionButton _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.teal,
      onPressed: () => Navigator.pushNamed(context, 'product'),
    );
  }

  Widget _createProductsList() {
    return FutureBuilder(
      future: productsProvider.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _createProduct(context, products[index]));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _createProduct(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        productsProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.title} ${product.value}'),
        subtitle: Text(product.id),
        onTap: () {
          Navigator.pushNamed(context, 'product', arguments: product);
        },
      ),
    );
  }
}
