// To parse this JSON data, do
//
//     final paymentEntrySubmitResponse = paymentEntrySubmitResponseFromJson(jsonString);

import 'dart:convert';

PaymentEntrySubmitResponse paymentEntrySubmitResponseFromJson(String str) => PaymentEntrySubmitResponse.fromJson(json.decode(str));

String paymentEntrySubmitResponseToJson(PaymentEntrySubmitResponse data) => json.encode(data.toJson());

class PaymentEntrySubmitResponse {
  PaymentEntrySubmitResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory PaymentEntrySubmitResponse.fromJson(Map<String, dynamic> json) => PaymentEntrySubmitResponse(
    success: json["success"],
    data: json["data"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
    "status": status,
  };
}
