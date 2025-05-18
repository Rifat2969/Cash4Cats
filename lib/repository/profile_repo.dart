import 'dart:convert';

import 'package:cash4cats/model/profile_api.dart';
import 'package:cash4cats/utils/api_url.dart';
import 'package:http/http.dart' as http;

import '../utils/api_helper.dart';

class ProfileRepository {
  final ApiUrl apiUrl = ApiUrl();

  Future<ProfileApi?> fetchProfile() async {
    var endPoint = apiUrl.getProfile;
    try {
      var apiResponse = await http.get(
        Uri.parse(endPoint),
        headers: ApiHelper.getHeaders(),
      );

      if (apiResponse.statusCode == 200) {
        return ProfileApi.fromJson(json.decode(apiResponse.body));
      } else {
        print("fetchProfile failed with status: ${apiResponse.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
    return null;
  }
}
