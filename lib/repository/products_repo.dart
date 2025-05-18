import 'dart:convert';

import 'package:cash4cats/model/products_api.dart';
import 'package:cash4cats/utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../utils/api_helper.dart';

class ProductsRepository {
  final ApiUrl apiUrl = ApiUrl();

  Future<ProductsApi?> fetchProducts({required int categoryId, required int page}) async {
    var endPoint = apiUrl.categoryProducts(categoryId, page);
    try {
      var apiResponse = await http.get(
        Uri.parse(endPoint),
        headers: ApiHelper.getHeaders(),
      );

      if (apiResponse.statusCode == 200) {
        return ProductsApi.fromJson(json.decode(apiResponse.body));
      } else {
        print("fetchProducts failed with status: ${apiResponse.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    return null;
  }
}
