import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:form_validation/src/providers/products_provider.dart';
import 'package:form_validation/src/models/product_model.dart';

class ProductsBloc {
  // Initialize streams
  final _productsController = new BehaviorSubject<List<ProductModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  // Initialize provider. We need it to access REST product methods.
  final productsProvider = new ProductsProvider();

  // Now, we need to listen both streams: products stream and loading stream
  Stream<List<ProductModel>> get productsStream => _productsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  // We get products and add them to products stream
  void getProducts() async {
    final products = await productsProvider.getProducts();
    print('Los productos $products');
    _productsController.sink.add(products);
  }

  // We need to notify when a product is being created, we do it through the loading stream.
  void createProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await productsProvider.createProduct(product);
    _loadingController.sink.add(false);
  }

  // We need to notify when a photo is being uploaded, we do it through the loading stream.
  Future<String> uploadImage(File file) async {
    _loadingController.sink.add(true);
    final String photoUrl = await productsProvider.uploadImage(file);
    _loadingController.sink.add(false);
    return photoUrl;
  }

  // We need to notify when a product is being edited, we do it through the loading stream.
  void editProduct(ProductModel product) async {
    _loadingController.sink.add(true);
    await productsProvider.editProduct(product);
    _loadingController.sink.add(false);
  }

  // Flutter disappears element through "Dismissible", hence we does not need loading stream
  void deleteProduct(String id) async {
    await productsProvider.deleteProduct(id);
  }

  dispose() {
    _productsController?.close();
    _loadingController?.close();
  }
}
