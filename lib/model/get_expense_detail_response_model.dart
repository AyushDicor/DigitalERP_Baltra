// // To parse this JSON data, do
// //
// //     final reimburseMentOnClickResponseModel = reimburseMentOnClickResponseModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ReimburseMentOnClickResponseModel reimburseMentOnClickResponseModelFromJson(String str) =>
//     ReimburseMentOnClickResponseModel.fromJson(json.decode(str));
//
// String reimburseMentOnClickResponseModelToJson(ReimburseMentOnClickResponseModel data) =>
//     json.encode(data.toJson());
//
// class ReimburseMentOnClickResponseModel {
//   bool? success;
//   List<ReimbursementDetailList>? data;
//   String? message;
//   int? status;
//
//   ReimburseMentOnClickResponseModel({this.success, this.data, this.message, this.status});
//
//   factory ReimburseMentOnClickResponseModel.fromJson(Map<String, dynamic> json) =>
//       ReimburseMentOnClickResponseModel(
//         success: json["success"],
//         data: json["data"] == null
//             ? []
//             : List<ReimbursementDetailList>.from(
//           json["data"]!.map((x) => ReimbursementDetailList.fromJson(x)),
//         ),
//         message: json["message"],
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     "message": message,
//     "status": status,
//   };
// }
//
// class ReimbursementDetailList {
//   int? expenseId;
//   int? reimbursementid;
//   String? reimbursementType;
//   String? expenseDate;
//   String? expenseDescription;
//   String? amount;
//   String? currency;
//   List<String>? supportingDocs;
//   String? additionalNotes;
//   String? entryDate;
//
//   ReimbursementDetailList({
//     this.expenseId,
//     this.reimbursementid,
//     this.reimbursementType,
//     this.expenseDate,
//     this.expenseDescription,
//     this.amount,
//     this.currency,
//     this.supportingDocs,
//     this.additionalNotes,
//     this.entryDate,
//   });
//
//   factory ReimbursementDetailList.fromJson(Map<String, dynamic> json) => ReimbursementDetailList(
//     expenseId: json["ExpenseId"],
//     reimbursementid: json["Reimbursementid"],
//     reimbursementType: json["ReimbursementType"],
//     expenseDate: json["ExpenseDate"],
//     expenseDescription: json["ExpenseDescription"],
//     amount: json["Amount"],
//     currency: json["Currency"],
//     supportingDocs: json["SupportingDocs"] == null
//         ? []
//         : List<String>.from(json["SupportingDocs"]!.map((x) => x)),
//     additionalNotes: json["AdditionalNotes"],
//     entryDate: json["EntryDate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ExpenseId": expenseId,
//     "Reimbursementid": reimbursementid,
//     "ReimbursementType": reimbursementType,
//     "ExpenseDate": expenseDate,
//     "ExpenseDescription": expenseDescription,
//     "Amount": amount,
//     "Currency": currency,
//     "SupportingDocs": supportingDocs == null ? [] : List<dynamic>.from(supportingDocs!.map((x) => x)),
//     "AdditionalNotes": additionalNotes,
//     "EntryDate": entryDate,
//   };
// }
// // TODO Implement this library.

// get_expense_detail_response_model.dart

import 'dart:convert';

GetExpenseDetailResponseModel getExpenseDetailResponseModelFromJson(
        String str) =>
    GetExpenseDetailResponseModel.fromJson(json.decode(str));

String getExpenseDetailResponseModelToJson(
        GetExpenseDetailResponseModel data) =>
    json.encode(data.toJson());

class GetExpenseDetailResponseModel {
  bool? success;
  GetExpenseDetailData? data;
  String? message;
  int? status;

  GetExpenseDetailResponseModel({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetExpenseDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      GetExpenseDetailResponseModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : GetExpenseDetailData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class GetExpenseDetailData {
  GetExpenseHeader? header;
  List<GetExpenseItem> items;

  GetExpenseDetailData({
    this.header,
    this.items = const [],
  });

  factory GetExpenseDetailData.fromJson(Map<String, dynamic> json) =>
      GetExpenseDetailData(
        header: json["header"] == null
            ? null
            : GetExpenseHeader.fromJson(json["header"]),
        items: json["items"] == null
            ? []
            : List<GetExpenseItem>.from(
                json["items"]!.map((x) => GetExpenseItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "header": header?.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class GetExpenseHeader {
  int? expenseId;
  String? expenseNo;
  String? expenseDate;
  String? entryDate;
  String? requestedBy;
  int? reqId;
  String? siteName;
  int? siteId;
  double? totalAmount;
  double? approvedAmt;
  double? verifiedAmt;
  double? paidAmt;
  double? balanceAmt;
  String? approvalStatus;
  int? eFlag;
  int? vFlag;
  String? eFlagLabel;
  int? isEditable;
  String? expenseDescription;
  String? additionalNotes;
  String? reason;
  String? verifyReason;
  String? supportingDocs;
  int? hasSupportingDocs;
  String? approvedByName;
  String? verifiedByName;
  int? seriesId;
  String? entryFrom;
  String? yearId;

  GetExpenseHeader({
    this.expenseId,
    this.expenseNo,
    this.expenseDate,
    this.entryDate,
    this.requestedBy,
    this.reqId,
    this.siteName,
    this.siteId,
    this.totalAmount,
    this.approvedAmt,
    this.verifiedAmt,
    this.paidAmt,
    this.balanceAmt,
    this.approvalStatus,
    this.eFlag,
    this.vFlag,
    this.eFlagLabel,
    this.isEditable,
    this.expenseDescription,
    this.additionalNotes,
    this.reason,
    this.verifyReason,
    this.supportingDocs,
    this.hasSupportingDocs,
    this.approvedByName,
    this.verifiedByName,
    this.seriesId,
    this.entryFrom,
    this.yearId,
  });

  factory GetExpenseHeader.fromJson(Map<String, dynamic> json) =>
      GetExpenseHeader(
        expenseId: json["ExpenseId"],
        expenseNo: json["ExpenseNo"],
        expenseDate: json["ExpenseDate"],
        entryDate: json["EntryDate"],
        requestedBy: json["RequestedBy"],
        reqId: json["ReqId"],
        siteName: json["SiteName"],
        siteId: json["SiteId"],
        totalAmount: json["TotalAmount"]?.toDouble(),
        approvedAmt: json["ApprovedAmt"]?.toDouble(),
        verifiedAmt: json["VerifiedAmt"]?.toDouble(),
        paidAmt: json["PaidAmt"]?.toDouble(),
        balanceAmt: json["BalanceAmt"]?.toDouble(),
        approvalStatus: json["ApprovalStatus"],
        eFlag: json["EFlag"],
        vFlag: json["VFlag"],
        eFlagLabel: json["EFlagLabel"],
        isEditable: json["IsEditable"],
        expenseDescription: json["ExpenseDescription"],
        additionalNotes: json["AdditionalNotes"],
        reason: json["Reason"],
        verifyReason: json["VerifyReason"],
        supportingDocs: json["SupportingDocs"],
        hasSupportingDocs: json["HasSupportingDocs"],
        approvedByName: json["ApprovedByName"],
        verifiedByName: json["VerifiedByName"],
        seriesId: json["SeriesId"],
        entryFrom: json["EntryFrom"],
        yearId: json["YearId"],
      );

  Map<String, dynamic> toJson() => {
        "ExpenseId": expenseId,
        "ExpenseNo": expenseNo,
        "ExpenseDate": expenseDate,
        "EntryDate": entryDate,
        "RequestedBy": requestedBy,
        "ReqId": reqId,
        "SiteName": siteName,
        "SiteId": siteId,
        "TotalAmount": totalAmount,
        "ApprovedAmt": approvedAmt,
        "VerifiedAmt": verifiedAmt,
        "PaidAmt": paidAmt,
        "BalanceAmt": balanceAmt,
        "ApprovalStatus": approvalStatus,
        "EFlag": eFlag,
        "VFlag": vFlag,
        "EFlagLabel": eFlagLabel,
        "IsEditable": isEditable,
        "ExpenseDescription": expenseDescription,
        "AdditionalNotes": additionalNotes,
        "Reason": reason,
        "VerifyReason": verifyReason,
        "SupportingDocs": supportingDocs,
        "HasSupportingDocs": hasSupportingDocs,
        "ApprovedByName": approvedByName,
        "VerifiedByName": verifiedByName,
        "SeriesId": seriesId,
        "EntryFrom": entryFrom,
        "YearId": yearId,
      };
}

class GetExpenseItem {
  int? detailId;
  int? sNo;
  int? expenseId;
  String? expenseGroup;
  int? parentId;
  String? expenseLedger;
  final int? expenseLedgerId;
  int? ledgerId;
  String? description;
  double? amount;
  double? approvedAmt;
  double? verifiedAmt;
  String? status;
  int? isLineEditable;
  String? referenceFile;
  String? receiptFile;
  int? hasReferenceFile;
  int? hasReceiptFile;
  int? transId;
  String? entryDate;

  GetExpenseItem({
    this.detailId,
    this.sNo,
    this.expenseId,
    this.expenseGroup,
    this.parentId,
    this.expenseLedger,
    this.expenseLedgerId,
    this.ledgerId,
    this.description,
    this.amount,
    this.approvedAmt,
    this.verifiedAmt,
    this.status,
    this.isLineEditable,
    this.referenceFile,
    this.receiptFile,
    this.hasReferenceFile,
    this.hasReceiptFile,
    this.transId,
    this.entryDate,
  });

  factory GetExpenseItem.fromJson(Map<String, dynamic> json) => GetExpenseItem(
        detailId: json["DetailId"],
        sNo: json["SNo"],
        expenseId: json["ExpenseId"],
        expenseGroup: json["ExpenseGroup"],
        parentId: json["ParentId"],
        expenseLedger: json["ExpenseLedger"],
        expenseLedgerId:  json["ExpenseLedgerId"]  ?? json["expenseledgerid"] ?? 0,
        ledgerId: json["LedgerId"],
        description: json["Description"],
        amount: json["Amount"]?.toDouble(),
        approvedAmt: json["ApprovedAmt"]?.toDouble(),
        verifiedAmt: json["VerifiedAmt"]?.toDouble(),
        status: json["Status"],
        isLineEditable: json["IsLineEditable"],
        referenceFile: json["ReferenceFile"],
        receiptFile: json["ReceiptFile"],
        hasReferenceFile: json["HasReferenceFile"],
        hasReceiptFile: json["HasReceiptFile"],
        transId: json["TransId"],
        entryDate: json["EntryDate"],
      );

  Map<String, dynamic> toJson() => {
        "DetailId": detailId,
        "SNo": sNo,
        "ExpenseId": expenseId,
        "ExpenseGroup": expenseGroup,
        "ParentId": parentId,
        "ExpenseLedger": expenseLedger,
        "LedgerId": ledgerId,
        "Description": description,
        "Amount": amount,
        "ApprovedAmt": approvedAmt,
        "VerifiedAmt": verifiedAmt,
        "Status": status,
        "IsLineEditable": isLineEditable,
        "ReferenceFile": referenceFile,
        "ReceiptFile": receiptFile,
        "HasReferenceFile": hasReferenceFile,
        "HasReceiptFile": hasReceiptFile,
        "TransId": transId,
        "EntryDate": entryDate,
      };
}
