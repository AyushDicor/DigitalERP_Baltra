// ─────────────────────────────────────────────────────────────────────────────
// issue_item_models.dart
// ─────────────────────────────────────────────────────────────────────────────

// ── List item (one row returned by GetIssueItemList) ──────────────────────────
class IssueItemListItem {
  final int id;
  final String issueNo;
  final String issueDate;
  final String issueType;
  final String issueTo;
  final String issuedBy;
  final String godown;
  final String itemIssueType;
  final String billNo;
  final String remarks;
  final double totalQty;
  final double totalAmount;
  final double grandTotal;
  final String status;

  const IssueItemListItem({
    required this.id,
    required this.issueNo,
    required this.issueDate,
    required this.issueType,
    required this.issueTo,
    required this.issuedBy,
    required this.godown,
    required this.itemIssueType,
    required this.billNo,
    required this.remarks,
    required this.totalQty,
    required this.totalAmount,
    required this.grandTotal,
    required this.status,
  });

  factory IssueItemListItem.fromJson(Map<String, dynamic> j) =>
      IssueItemListItem(
        id:            int.tryParse(j['id']?.toString() ?? '0') ?? 0,
        issueNo:       (j['issueno']       ?? j['IssueNo']       ?? '').toString(),
        issueDate:     (j['issuedate']     ?? j['IssueDate']     ?? '').toString(),
        issueType:     (j['issuetype']     ?? j['IssueType']     ?? '').toString(),
        issueTo:       (j['issueto']       ?? j['IssueTo']       ?? '').toString(),
        issuedBy:      (j['issuedby']      ?? j['IssuedBy']      ?? '').toString(),
        godown:        (j['godown']        ?? j['Godown']        ?? '').toString(),
        itemIssueType: (j['itemissuetype'] ?? j['ItemIssueType'] ?? '').toString(),
        billNo:        (j['billno']        ?? j['BillNo']        ?? '').toString(),
        remarks:       (j['remarks']       ?? j['Remarks']       ?? '').toString(),
        totalQty:      double.tryParse(j['totalqty']?.toString()    ?? '0') ?? 0,
        totalAmount:   double.tryParse(j['totalamount']?.toString() ?? '0') ?? 0,
        grandTotal:    double.tryParse(j['grandtotal']?.toString()  ?? '0') ?? 0,
        status:        (j['status'] ?? j['Status'] ?? 'Draft').toString(),
      );
}

// ── Detail item line ──────────────────────────────────────────────────────────
class IssueDetailItem {
  final int itemId;
  final String itemName;
  final double qty;
  final double rate;
  final double amount;
  final int transId;

  const IssueDetailItem({
    required this.itemId,
    required this.itemName,
    required this.qty,
    required this.rate,
    required this.amount,
    required this.transId,
  });

  factory IssueDetailItem.fromJson(Map<String, dynamic> j) => IssueDetailItem(
    itemId:   int.tryParse(j['itemid']?.toString()  ?? '0') ?? 0,
    itemName: (j['itemname'] ?? j['ItemName']       ?? '').toString(),
    qty:      double.tryParse(j['qty']?.toString()    ?? '0') ?? 0,
    rate:     double.tryParse(j['rate']?.toString()   ?? '0') ?? 0,
    amount:   double.tryParse(j['amount']?.toString() ?? '0') ?? 0,
    transId:  int.tryParse(j['transid']?.toString() ?? '0') ?? 0,
  );
}

// ── Detail header returned by GetIssueItemDetail ──────────────────────────────
class IssueItemDetailData {
  final int issueId;
  final String issueNo;
  final String issueDate;
  final String issueType;
  final int issueToId;
  final String issueTo;
  final String issuedBy;
  final int godownId;
  final String godown;
  final String itemIssueType;
  final String billNo;
  final String remarks;
  final int compId;
  final int branchId;
  final double totalQty;
  final double totalAmount;
  final double grandTotal;
  final List<IssueDetailItem> items;

  const IssueItemDetailData({
    required this.issueId,
    required this.issueNo,
    required this.issueDate,
    required this.issueType,
    required this.issueToId,
    required this.issueTo,
    required this.issuedBy,
    required this.godownId,
    required this.godown,
    required this.itemIssueType,
    required this.billNo,
    required this.remarks,
    required this.compId,
    required this.branchId,
    required this.totalQty,
    required this.totalAmount,
    required this.grandTotal,
    required this.items,
  });

  factory IssueItemDetailData.fromJson(Map<String, dynamic> j) {
    final rawItems = j['items'] ?? j['Items'] ?? [];
    return IssueItemDetailData(
      issueId:       int.tryParse(j['issueid']?.toString()    ?? '0') ?? 0,
      issueNo:       (j['issueno']       ?? '').toString(),
      issueDate:     (j['issuedate']     ?? '').toString(),
      issueType:     (j['issuetype']     ?? '').toString(),
      issueToId:     int.tryParse(j['issuetoid']?.toString()  ?? '0') ?? 0,
      issueTo:       (j['issueto']       ?? '').toString(),
      issuedBy:      (j['issuedby']      ?? '').toString(),
      godownId:      int.tryParse(j['godownid']?.toString()   ?? '0') ?? 0,
      godown:        (j['godown']        ?? '').toString(),
      itemIssueType: (j['itemissuetype'] ?? '').toString(),
      billNo:        (j['billno']        ?? '').toString(),
      remarks:       (j['remarks']       ?? '').toString(),
      compId:        int.tryParse(j['compid']?.toString()     ?? '0') ?? 0,
      branchId:      int.tryParse(j['branchid']?.toString()   ?? '0') ?? 0,
      totalQty:      double.tryParse(j['totalqty']?.toString()    ?? '0') ?? 0,
      totalAmount:   double.tryParse(j['totalamount']?.toString() ?? '0') ?? 0,
      grandTotal:    double.tryParse(j['grandtotal']?.toString()  ?? '0') ?? 0,
      items: (rawItems as List)
          .map((e) => IssueDetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// ── Response wrappers ─────────────────────────────────────────────────────────
class IssueItemListResponse {
  final int status;
  final bool? success;
  final String? message;
  final List<IssueItemListItem> data;

  IssueItemListResponse({
    required this.status,
    this.success,
    this.message,
    this.data = const [],
  });

  factory IssueItemListResponse.fromJson(Map<String, dynamic> j) =>
      IssueItemListResponse(
        status:  int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: (j['data'] as List? ?? [])
            .map((e) => IssueItemListItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class IssueItemDetailResponse {
  final int status;
  final bool? success;
  final String? message;
  final IssueItemDetailData? data;

  IssueItemDetailResponse({
    required this.status,
    this.success,
    this.message,
    this.data,
  });

  factory IssueItemDetailResponse.fromJson(Map<String, dynamic> j) =>
      IssueItemDetailResponse(
        status:  int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: j['data'] != null
            ? IssueItemDetailData.fromJson(j['data'] as Map<String, dynamic>)
            : null,
      );
}

class IssueItemSubmitResponse {
  final int status;
  final bool? success;
  final String? message;

  IssueItemSubmitResponse({
    required this.status,
    this.success,
    this.message,
  });

  factory IssueItemSubmitResponse.fromJson(Map<String, dynamic> j) =>
      IssueItemSubmitResponse(
        status:  int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
      );
}

class IssueItemDropdownOption {
  final String id;
  final String label;

  const IssueItemDropdownOption({required this.id, required this.label});

  factory IssueItemDropdownOption.fromJson(Map<String, dynamic> j) =>
      IssueItemDropdownOption(
        id:    (j['id']    ?? j['Id']    ?? '').toString(),
        label: (j['label'] ?? j['Label'] ?? j['name'] ?? j['Name'] ?? '').toString(),
      );
}

class IssueItemDropdownResponse {
  final int status;
  final bool? success;
  final String? message;
  final List<IssueItemDropdownOption> data;

  IssueItemDropdownResponse({
    required this.status,
    this.success,
    this.message,
    this.data = const [],
  });

  factory IssueItemDropdownResponse.fromJson(Map<String, dynamic> j) =>
      IssueItemDropdownResponse(
        status:  int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: (j['data'] as List? ?? [])
            .map((e) =>
            IssueItemDropdownOption.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
// ── Pending Indent ─────────────────────────────────────────────────────────

class PendingIndent {
  final int    id;
  final String indentNo;

  PendingIndent({required this.id, required this.indentNo});

  factory PendingIndent.fromJson(Map<String, dynamic> j) => PendingIndent(
    id:       j['indentid'] as int,
    indentNo: j['indentno']?.toString() ?? '',
  );
}

class PendingIndentResponse {
  final bool   success;
  final int    status;
  final String? message;
  final List<PendingIndent> data;

  PendingIndentResponse({
    this.success = false,
    this.status  = 0,
    this.message,
    this.data    = const [],
  });

  factory PendingIndentResponse.fromJson(Map<String, dynamic> j) =>
      PendingIndentResponse(
        success: j['success'] as bool?  ?? false,
        status:  j['status']  as int?   ?? 0,
        message: j['message'] as String?,
        data: j['data'] is List
            ? (j['data'] as List)
            .map((e) => PendingIndent.fromJson(e as Map<String, dynamic>))
            .toList()
            : [],
      );
}

// ── Issue Item Full Detail ─────────────────────────────────────────────────
// Reuse your existing IssueItemDetailResponse — just add a new API method
// that posts to 'itemissuefulldetail' with { stockid, compid, branchid }
class _IndentStub {
  final int    id;
  final String indentNo;
  const _IndentStub({required this.id, required this.indentNo});
}
// ── Indent Item Detail (for loading items from a selected indent) ───────────

class IndentItemForIssue {
  final int    itemId;
  final String itemName;
  final int    unitId;
  final String unitName;
  final double quantity;
  final double rate;
  final double amount;
  final String specification;

  IndentItemForIssue({
    required this.itemId,
    required this.itemName,
    required this.unitId,
    required this.unitName,
    required this.quantity,
    required this.rate,
    required this.amount,
    required this.specification,
  });

  factory IndentItemForIssue.fromJson(Map<String, dynamic> j) =>
      IndentItemForIssue(
        itemId:        j['itemid']        as int,
        itemName:      j['itemname']      as String? ?? '',
        unitId:        j['unitid']        as int,
        unitName:      j['unit']          as String? ?? '',
        quantity:      (j['quantity']     as num).toDouble(),
        rate:          (j['rate']         as num).toDouble(),
        amount:        (j['amount']       as num).toDouble(),
        specification: j['specification'] as String? ?? '',
      );
}

class IndentItemForIssueResponse {
  final bool   success;
  final int    status;
  final String? message;
  final List<IndentItemForIssue> data;

  IndentItemForIssueResponse({
    this.success = false,
    this.status  = 0,
    this.message,
    this.data    = const [],
  });

  factory IndentItemForIssueResponse.fromJson(Map<String, dynamic> j) =>
      IndentItemForIssueResponse(
        success: j['success'] as bool?   ?? false,
        status:  j['status']  as int?    ?? 0,
        message: j['message'] as String?,
        data: j['data'] is List
            ? (j['data'] as List)
            .map((e) => IndentItemForIssue.fromJson(e as Map<String, dynamic>))
            .toList()
            : [],
      );
}