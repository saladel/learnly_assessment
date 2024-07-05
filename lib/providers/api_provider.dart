import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learnly_assessment/models/product_model.dart';

class ApiProvider with ChangeNotifier {
  final productUrl = 'https://fakestoreapi.com/products';

  List<Product> products = [];

  Future<void> getProducts() async {
    try {
      final apiEndpoint = await http.get(Uri.parse(productUrl));

      if (apiEndpoint.statusCode == 200) {
        final apiResponse = productFromJson(apiEndpoint.body);
        print('PRODUCT API RESPONSE: $apiResponse');

        products.addAll(apiResponse);
        notifyListeners();
      } else {
        print('DEBUG: FAILED TO LOAD PRODUCTS ——> Status code: ${apiEndpoint.statusCode}');
      }
    } catch (e) {
      print('DEBUG: ERROR LOADING PRODUCTS: $e');
    }
  }
}
