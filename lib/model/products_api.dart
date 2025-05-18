import 'products_data.dart';

class ProductsApi {
  ProductsApi({
    this.success,
    this.message,
    this.data,
  });

  ProductsApi.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductsData.fromJson(v));
      });
    }
  }
  bool? success;
  String? message;
  List<ProductsData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
