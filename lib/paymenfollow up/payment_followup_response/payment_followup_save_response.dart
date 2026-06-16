

import 'dart:convert';

PaymentFollowupSaveResponse paymentFollowupSaveResponseFromJson(String str)=> PaymentFollowupSaveResponse.fromJson(jsonDecode(str));
String paymentFollowupSaveResponseToJson(PaymentFollowupSaveResponse data)=>  jsonEncode(data.toJson());



class PaymentFollowupSaveResponse {
  PaymentFollowupSaveResponse({
      this.success, 
      this.data, 
      this.message, 
      this.status,});

  PaymentFollowupSaveResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }
  bool? success;
  dynamic data;
  String? message;
  num? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    map['status'] = status;
    return map;
  }

}