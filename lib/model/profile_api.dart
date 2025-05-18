import 'package:cash4cats/model/profile.dart';

class ProfileApi {
  ProfileApi({
    this.success,
    this.message,
    this.data,
  });

  ProfileApi.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  ProfileData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
