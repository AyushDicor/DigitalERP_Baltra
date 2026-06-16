// To parse this JSON data, do
//
//     final getreimbursementResponseModel = getreimbursementResponseModelFromJson(jsonString);

import 'dart:convert';

GetreimbursementResponseModel getreimbursementResponseModelFromJson(
        String str) =>
    GetreimbursementResponseModel.fromJson(json.decode(str));

String getreimbursementResponseModelToJson(
        GetreimbursementResponseModel data) =>
    json.encode(data.toJson());

class GetreimbursementResponseModel {
  bool? success;
  List<GetReimbursementData>? data;
  String? message;
  int? status;

  GetreimbursementResponseModel(
      {this.success, this.data, this.message, this.status});

  factory GetreimbursementResponseModel.fromJson(Map<String, dynamic> json) =>
      GetreimbursementResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<GetReimbursementData>.from(
                json["data"]!.map((x) => GetReimbursementData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class GetReimbursementData {
  int? expenseId;
  String? expenseNo;
  String? expenseDate;
  String? site;
  String? expenseDescription;
  num? amount;
  num? approvedAmt;
  num? verifiedAmt;
  num? balanceAmt;
  String? approvalStatus;
  int? eFlag;
  String? reason;
  String? employeeName;
  String? entryFlag;
  int? stockId;

  GetReimbursementData({
    this.expenseId,
    this.expenseNo,
    this.expenseDate,
    this.site,
    this.expenseDescription,
    this.amount,
    this.approvedAmt,
    this.verifiedAmt,
    this.balanceAmt,
    this.approvalStatus,
    this.eFlag,
    this.reason,
    this.employeeName,
    this.entryFlag,
    this.stockId,
  });

    GetReimbursementData.fromJson(Map<String, dynamic> json) {
    expenseId = json['ExpenseId'];
    expenseNo = json['ExpenseNo'];
    expenseDate = json['ExpenseDate'];
    site = json['Site'];
    expenseDescription = json['ExpenseDescription'];
    amount = json['Amount'];
    approvedAmt = json['ApprovedAmt'];
    verifiedAmt = json['VerifiedAmt'];
    balanceAmt = json['BalanceAmt'];
    approvalStatus = json['ApprovalStatus'];
    eFlag = json['EFlag'];
    reason = json['Reason'];
    employeeName = json['EmployeeName'];
    entryFlag = json['EntryFlag'];
    stockId = json['StockId'];
  }

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExpenseId'] = expenseId;
    data['ExpenseNo'] = expenseNo;
    data['ExpenseDate'] = expenseDate;
    data['Site'] = site;
    data['ExpenseDescription'] = expenseDescription;
    data['Amount'] = amount;
    data['ApprovedAmt'] = approvedAmt;
    data['VerifiedAmt'] = verifiedAmt;
    data['BalanceAmt'] = balanceAmt;
    data['ApprovalStatus'] = approvalStatus;
    data['EFlag'] = eFlag;
    data['Reason'] = reason;
    data['EmployeeName'] = employeeName;
    data['EntryFlag'] = entryFlag;
    data['StockId'] = stockId;
    return data;
      }
}
// TODO Implement this library.
