import 'dart:convert';

import 'package:cash4cats/model/category_api.dart';
import 'package:cash4cats/utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../utils/api_helper.dart';

class CategoryRepository {
  final ApiUrl apiUrl = ApiUrl();

  Future<CategoryApi?> fetchCategories() async {
    var endPoint = apiUrl.categories;
    try {
      final response = await http.get(
        Uri.parse(endPoint),
        headers: ApiHelper.getHeaders(),
      );
      if (response.statusCode == 200) {
        return CategoryApi.fromJson(json.decode(response.body));
      }
    } catch (e) {}
    return null;
  }
}
