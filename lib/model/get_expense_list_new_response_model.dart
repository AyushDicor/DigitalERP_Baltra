// lib/model/get_expense_list_new_response_model.dart
//
// API: POST /api/GetExpenseListNew
// Note: Swagger example shows "data": {} but real response is "data": [...]
// The fromJson handles both cases safely.

class GetExpenseListNewResponseModel {
  bool?         success;
  List<ExpenseData>? data;
  String?       message;
  int?          status;

  GetExpenseListNewResponseModel({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory GetExpenseListNewResponseModel.fromJson(Map<String, dynamic> json) {
    List<ExpenseData> parsed = [];

    // ✅ data can be a List (real) or Map/null (swagger example / empty)
    final raw = json['data'];
    if (raw is List) {
      for (final v in raw) {
        if (v is Map<String, dynamic>) {
          parsed.add(ExpenseData.fromJson(v));
        }
      }
    }
    // If raw is Map or null → parsed stays empty — no crash

    return GetExpenseListNewResponseModel(
      success : json['success'] as bool?,
      data    : parsed,
      message : json['message'] as String?,
      status  : json['status']  as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data'    : data?.map((v) => v.toJson()).toList(),
    'message' : message,
    'status'  : status,
  };
}

class ExpenseData {
  int?    expenseId;
  String? expenseNo;
  String? expenseDate;      // "dd-MM-yyyy"
  String? site;
  String? expenseDescription;
  num?    amount;
  num?    approvedAmt;
  num?    verifiedAmt;
  num?    balanceAmt;
  String? approvalStatus;   // "Pending" | "Approved" | "Rejected"
  int?    eFlag;
  String? reason;
  String? employeeName;
  String? entryFlag;        // "Direct" etc.
  int?    stockId;

  ExpenseData({
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

  factory ExpenseData.fromJson(Map<String, dynamic> json) => ExpenseData(
    expenseId          : _parseInt(json['ExpenseId']),
    expenseNo          : json['ExpenseNo']          as String?,
    expenseDate        : json['ExpenseDate']        as String?,
    site               : json['Site']               as String?,
    expenseDescription : json['ExpenseDescription'] as String?,
    amount             : _parseNum(json['Amount']),
    approvedAmt        : _parseNum(json['ApprovedAmt']),
    verifiedAmt        : _parseNum(json['VerifiedAmt']),
    balanceAmt         : _parseNum(json['BalanceAmt']),
    approvalStatus     : json['ApprovalStatus']     as String?,
    eFlag              : _parseInt(json['EFlag']),
    reason             : json['Reason']             as String?,
    employeeName       : json['EmployeeName']       as String?,
    entryFlag          : json['EntryFlag']          as String?,
    stockId            : _parseInt(json['StockId']),
  );

  Map<String, dynamic> toJson() => {
    'ExpenseId'         : expenseId,
    'ExpenseNo'         : expenseNo,
    'ExpenseDate'       : expenseDate,
    'Site'              : site,
    'ExpenseDescription': expenseDescription,
    'Amount'            : amount,
    'ApprovedAmt'       : approvedAmt,
    'VerifiedAmt'       : verifiedAmt,
    'BalanceAmt'        : balanceAmt,
    'ApprovalStatus'    : approvalStatus,
    'EFlag'             : eFlag,
    'Reason'            : reason,
    'EmployeeName'      : employeeName,
    'EntryFlag'         : entryFlag,
    'StockId'           : stockId,
  };

  //  safe parsers (API sometimes returns int, sometimes String) 
  static int? _parseInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    return int.tryParse(v.toString());
  }

  static num? _parseNum(dynamic v) {
    if (v == null) return null;
    if (v is num) return v;
    return num.tryParse(v.toString());
  }
}