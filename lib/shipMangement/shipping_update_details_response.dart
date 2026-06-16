

 import 'dart:convert';

ShippingUpdateDetailsResponse shippingUpdateDetailsResponseFromJson(String str) => ShippingUpdateDetailsResponse.fromJson(json.decode(str));
String shippingUpdateDetailsResponseToJson(ShippingUpdateDetailsResponse data) => json.encode(data.toJson());

class ShippingUpdateDetailsResponse {
  bool? success;
  Null? data;
  String? message;
  int? status;

  ShippingUpdateDetailsResponse(
      {this.success, this.data, this.message, this.status});

  ShippingUpdateDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
