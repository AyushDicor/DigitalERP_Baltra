// lib/model/reimbursement_dropdown_response_model.dart

import 'dart:convert';

ReimbursementDropdownResponseModel reimbursementDropdownResponseModelFromJson(
    String str) =>
    ReimbursementDropdownResponseModel.fromJson(json.decode(str));

class ReimbursementDropdownResponseModel {
  bool? success;
  List<ReimbursementDropdownItem>? data;
  String? message;
  int? status;

  ReimbursementDropdownResponseModel(
      {this.success, this.data, this.message, this.status});

  factory ReimbursementDropdownResponseModel.fromJson(
      Map<String, dynamic> json) =>
      ReimbursementDropdownResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ReimbursementDropdownItem>.from(
            json["data"]!.map((x) => ReimbursementDropdownItem.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );
}

class ReimbursementDropdownItem {
  int? id;
  String? name;

  ReimbursementDropdownItem({this.id, this.name});

  /// The API returns different key names per type:
  ///   SeriesType   → { "SeriesId": 2,  "SeriesName": "EXP" }
  ///   Site         → { "SiteId": 1,    "SiteName": "Main Site" }
  ///   Employee     → { "EmpId": 101,   "EmpName": "John Doe" }
  ///   ExpenseGroup → { "GroupId": 5,   "GroupName": "Travel" }
  ///   ExpenseLedger→ { "LedgerId": 14, "LedgerName": "Milk" }
  /// We normalise them all to id / name here.
  factory ReimbursementDropdownItem.fromJson(Map<String, dynamic> json) {
    // Try every known id-key in priority order
    final id = json["SeriesId"] ??
        json["SiteId"] ??
        json["EmpId"] ??
        json["executiveid"] ??
        json["GroupId"] ??
        json["LedgerId"] ??
        json["id"] ??
        json["Id"];

    // Try every known name-key
    final name = json["SeriesName"] ??
        json["SiteName"] ??
        json["EmpName"] ??
        json["executivename"] ??
        json["GroupName"] ??
        json["LedgerName"] ??
        json["name"] ??
        json["Name"];

    return ReimbursementDropdownItem(
      id: id is int ? id : int.tryParse(id?.toString() ?? ''),
      name: name?.toString(),
    );
  }

  @override
  String toString() => name ?? '';
}