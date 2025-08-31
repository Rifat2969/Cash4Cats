import 'dart:convert';

import 'package:cash4cats/model/pgm_price_api.dart';
import 'package:cash4cats/utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../utils/api_helper.dart';

class PgmPriceRepository {
  final ApiUrl apiUrl = ApiUrl();

  Future<PgmPriceAPI?> fetchPgmPrices() async {
    var endPoint = apiUrl.publicPgmPrices;
    try {
      var apiResponse = await http.get(
        Uri.parse(endPoint),
        headers: await ApiHelper.getHeaders(),
      );

      if (apiResponse.statusCode == 200) {
        return PgmPriceAPI.fromJson(json.decode(apiResponse.body));
      } else {
        print("fetchPgmPrices failed with status: ${apiResponse.statusCode}");
      }
    } catch (e) {
      print("Error fetching PGM Prices: $e");
    }
    return null;
  }
}
