// To parse this JSON data, do
//
//     final partylatLngCheck = partylatLngCheckFromJson(jsonString);

import 'dart:convert';

PartylatLngCheck partylatLngCheckFromJson(String str) => PartylatLngCheck.fromJson(json.decode(str));

String partylatLngCheckToJson(PartylatLngCheck data) => json.encode(data.toJson());

class PartylatLngCheck {
  PartylatLngCheck({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  dynamic data;
  String? message;
  int? status;

  factory PartylatLngCheck.fromJson(Map<String, dynamic> json) => PartylatLngCheck(
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
