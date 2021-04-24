import 'dart:convert';
import 'dart:io';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:form_validation/src/models/product_model.dart';
import 'package:form_validation/src/user_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _rootUrl = 'flutter-projects-2e557-default-rtdb.firebaseio.com';
  final _userPreferences = new UserPreferences();

  Future<bool> createProduct(ProductModel product) async {
    final Uri url =
        Uri.https(_rootUrl, 'products.json', {'auth': _userPreferences.token});
    await http.post(url, body: productModelToJson(product));
    return true;
  }

  Future<bool> editProduct(ProductModel product) async {
    final Uri url =
        Uri.https(_rootUrl, 'products.json', {'auth': _userPreferences.token});
    await http.put(url, body: productModelToJson(product));
    return true;
  }

  Future<List<ProductModel>> getProducts() async {
    final Uri url =
        Uri.https(_rootUrl, 'products.json', {'auth': _userPreferences.token});
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> products = [];

    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    decodedData.forEach((productId, productData) {
      final productTemp = ProductModel.fromJson(productData);
      productTemp.id = productId;
      products.add(productTemp);
    });

    return products;
  }

  Future<int> deleteProduct(String id) async {
    final Uri url =
        Uri.https(_rootUrl, 'products.json', {'auth': _userPreferences.token});
    final response = await http.delete(url);
    print(response);
    return 1;
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dkjzlyysu/image/upload?upload_preset=wjeyhhmw');
    final mimeType = mime(image.path).split('/');
    print(mimeType);

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Something was wrong :(');
      print(response.body);
      return null;
    }

    final responseData = json.decode(response.body);
    print(responseData);
    return responseData['secure_url'];
  }
}
