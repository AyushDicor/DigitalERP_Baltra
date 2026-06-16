// To parse this JSON data, do
//
//     final partyDropdownListResponse = partyDropdownListResponseFromJson(jsonString);

import 'dart:convert';

PartyDropdownListResponse partyDropdownListResponseFromJson(String str) =>
    PartyDropdownListResponse.fromJson(json.decode(str));

String partyDropdownListResponseToJson(PartyDropdownListResponse data) =>
    json.encode(data.toJson());

class PartyDropdownListResponse {
  PartyDropdownListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  bool? success;
  List<PartyDropdownData>? data;
  String? message;
  int? status;

  factory PartyDropdownListResponse.fromJson(Map<String, dynamic> json) =>
      PartyDropdownListResponse(
        success: json['success'],
        data: json['data'] == null
            ? null
            : List<PartyDropdownData>.from(json['data'].map((x) => PartyDropdownData.fromJson(x))),
        message: json['message'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': List<dynamic>.from(data!.map((x) => x.toJson())),
        'message': message,
        'status': status,
      };
}

class PartyDropdownData {
  PartyDropdownData({
    this.partyid,
    this.partyname,
  });

  int? partyid;
  String? partyname;

  factory PartyDropdownData.fromJson(Map<String, dynamic> json) => PartyDropdownData(
        partyid: json['partyid'],
        partyname: json['partyname'],
      );

  Map<String, dynamic> toJson() => {
        'partyid': partyid,
        'partyname': partyname,
      };

  @override
  String toString() {
    return 'PartyDropdownData{partyid: $partyid, partyname: $partyname}';
  }
}
