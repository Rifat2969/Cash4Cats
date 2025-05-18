import 'package:cash4cats/model/pgm_price.dart';

class PgmPriceAPI {
  final bool? success;
  final String? message;
  final PgmPrice? data;

  PgmPriceAPI({
    this.success,
    this.message,
    this.data,
  });

  factory PgmPriceAPI.fromJson(Map<String, dynamic> json) {
    return PgmPriceAPI(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? PgmPrice.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data!.toJson(),
    };
  }
}
