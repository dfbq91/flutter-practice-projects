import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';
import 'package:form_validation/src/models/product_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsBloc = Provider.productsBloc(context);
    productsBloc.getProducts();

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _createProductsList(productsBloc),
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

  Widget _createProductsList(ProductsBloc productsBloc) {
    return StreamBuilder(
        stream: productsBloc.productsStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    _createProduct(context, products[index], productsBloc));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _createProduct(
      BuildContext context, ProductModel product, ProductsBloc productsBloc) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red),
      onDismissed: (direction) {
        // productsProvider.deleteProduct(product.id);
        productsBloc.deleteProduct(product.id);
      },
      child: Card(
        child: Column(
          children: [
            product.photoUrl == null
                ? Image(
                    image: AssetImage('assets/no-image.png'),
                  )
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(product.photoUrl),
                    fit: BoxFit.cover,
                    height: 300.0,
                    width: double.infinity,
                  ),
            ListTile(
              title: Text('${product.title} ${product.value}'),
              subtitle: Text(product.id),
              onTap: () {
                Navigator.pushNamed(context, 'product', arguments: product);
              },
            ),
          ],
        ),
      ),
    );
  }
}
