class IndentDropdownOption {
  final String id;
  final String label;

  const IndentDropdownOption({required this.id, required this.label});

  factory IndentDropdownOption.fromJson(Map<String, dynamic> j) =>
      IndentDropdownOption(
        id: (j['id'] ?? j['Id'] ?? '').toString(),
        label: (j['label'] ?? j['Label'] ?? j['name'] ?? j['Name'] ?? '')
            .toString(),
      );

  Map<String, dynamic> toJson() => {'id': id, 'label': label};

  @override
  bool operator ==(Object other) =>
      other is IndentDropdownOption && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ── Indent list item (returned by list API) ───────────────────────────────────
class IndentListItem {
  final int id;
  final String indentNo;
  final String indentDate;
  final String dueDate;
  final String requestBy;
  final String siteName;
  final String department;
  final String jobType;
  final String priority;
  final String status;
  final String approvalStatus;
  final String orderNo;
  final int totalItems;
  final double approveQty;
  final double poQty;
  final double balQty;
  final String printUrl;

  const IndentListItem({
    required this.id,
    required this.indentNo,
    required this.indentDate,
    required this.dueDate,
    required this.requestBy,
    required this.siteName,
    required this.department,
    required this.jobType,
    required this.priority,
    required this.status,
    required this.approvalStatus,
    required this.orderNo,
    required this.totalItems,
    required this.approveQty,
    required this.poQty,
    required this.balQty,
    required this.printUrl,
  });

  factory IndentListItem.fromJson(Map<String, dynamic> j) => IndentListItem(
    id: int.tryParse(j['IndentId']?.toString() ?? '0') ?? 0,
    indentNo: '#${j['IndentNo'] ?? ''}',
    indentDate: (j['IndentDate'] ?? '').toString(),
    dueDate: (j['DueDate'] ?? '').toString(),
    requestBy: (j['CreatedBy'] ?? '').toString(),
    siteName: (j['Site'] ?? '').toString(),
    department: (j['Godown'] ?? '').toString(),
    jobType: (j['JobType'] ?? '').toString(),
    priority: (j['Priority'] ?? '').toString(),
    status: (j['IndentStatus'] ?? 'Draft').toString(),
    approvalStatus: (j['ApprovalStatus'] ?? '').toString(),
    orderNo: (j['OrderNo'] ?? '').toString(),
    totalItems: (j['IndentQty'] as num? ?? 0).toInt(),
    approveQty: (j['ApproveQty'] as num? ?? 0).toDouble(),
    poQty: (j['PoQty'] as num? ?? 0).toDouble(),
    balQty: (j['BalQty'] as num? ?? 0).toDouble(),
    printUrl: (j['printurl'] ?? '').toString(),
  );
}

// ── Indent item line (one row in the items table) ─────────────────────────────
class IndentItemLine {
  final String itemId;
  String itemName;
  String itemCode;
  String unit;
  String unitId;
  double prQty; // PR (previous) qty from system
  double indentQty; // qty the user is requesting
  double delQty; // delivered qty (read-only from system)
  double rate;
  double stockAtSite;
  String itemDescription;
  String remarks;
  int transId; // for edit mode round-trip

  IndentItemLine({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.unit,
    this.unitId = '',
    this.prQty = 0,
    this.indentQty = 1,
    this.delQty = 0,
    this.rate = 0,
    this.stockAtSite = 0,
    this.itemDescription = '',
    this.remarks = '',
    this.transId = 0,
  });

  double get amount => indentQty * rate;
}

// ── Detail data returned by the edit/detail API ───────────────────────────────
class IndentDetailData {
  final int indentid;
  final String indentno;
  final String indentdate;
  final String requestby;
  final int siteid;
  final String sitename;
  final int departmentid;
  final String department;
  final int jobtypeid;
  final String jobtype;
  final String priority;
  final String remarks;
  final String siteIncharge;
  final int godownid;
  final String godownname;
  final int workorderid;
  final String workorderno;
  final int compid;
  final int branchid;
  final List<IndentDetailItem> items;
  final String requireddate;
  final int priortyid;
  final String boqNo;
  final String indentType;

  const IndentDetailData({
    required this.indentid,
    required this.indentno,
    required this.indentdate,
    required this.requestby,
    required this.siteid,
    required this.sitename,
    required this.departmentid,
    required this.department,
    required this.jobtypeid,
    required this.jobtype,
    required this.priority,
    required this.remarks,
    required this.siteIncharge,
    required this.godownid,
    required this.godownname,
    required this.workorderid,
    required this.workorderno,
    required this.compid,
    required this.branchid,
    required this.items,
    required this.requireddate,
    required this.priortyid,
    required this.boqNo,
    required this.indentType,
  });

  factory IndentDetailData.fromJson(Map<String, dynamic> j) {
    final rawItems = j['indentitems'] ?? j['items'] ?? j['Items'] ?? [];
    final parsedItems = (rawItems as List)
        .map((e) => IndentDetailItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return IndentDetailData(
      indentid:     int.tryParse(j['indentid']?.toString() ?? '0') ?? 0,
      indentno:     (j['indentno'] ?? '').toString(),
      indentdate:   (j['indentdate'] ?? '').toString(),
      requireddate: (j['requireddate'] ?? '').toString(),
      requestby:    (j['receivedby'] ?? j['requestby'] ?? '').toString(),
      siteid:       int.tryParse(j['siteid']?.toString() ?? '0') ?? 0,
      sitename:     (j['sitename'] ?? '').toString(),
      departmentid: int.tryParse(j['departmentid']?.toString() ?? '0') ?? 0,
      department:   (j['department'] ?? '').toString(),
      jobtypeid:    int.tryParse(j['jobtypeid']?.toString() ?? '0') ?? 0,
      jobtype:      (j['jobtype'] ?? '').toString(),
      indentType:   (j['indenttype'] ?? '').toString(),
      priority:     (j['indenttype'] ?? j['priority'] ?? '').toString(),
      remarks:      (j['remarks'] ?? '').toString(),
      siteIncharge: (j['siteincharge'] ?? '').toString(),
      godownid:     int.tryParse(j['godownid']?.toString() ?? '0') ?? 0,
      godownname:   (j['godownname'] ?? '').toString(),
      workorderid:  int.tryParse(j['orderid']?.toString() ?? '0') ?? 0,
      workorderno:  (j['BOQNo'] ?? j['workorderno'] ?? '').toString(),
      compid:       int.tryParse(j['companyid']?.toString() ?? j['compid']?.toString() ?? '0') ?? 0,
      branchid:     int.tryParse(j['reuesttoid']?.toString() ?? j['branchid']?.toString() ?? '0') ?? 0,
      items:        parsedItems,
      priortyid:    int.tryParse(j['priortyid']?.toString() ?? '0') ?? 0,
      boqNo:        (j['BOQNo'] ?? '').toString(),
    );
  }
}

class IndentDetailItem {
  final int itemid;
  final String itemname;
  final int unitid;
  final String unitname;
  final double prqty;
  final double indentqty;
  final double delqty;
  final double rate;
  final double stockatsite;
  final String itemdescription;
  final int transid;

  const IndentDetailItem({
    required this.itemid,
    required this.itemname,
    required this.unitid,
    required this.unitname,
    required this.prqty,
    required this.indentqty,
    required this.delqty,
    required this.rate,
    required this.stockatsite,
    required this.itemdescription,
    required this.transid,
  });

  factory IndentDetailItem.fromJson(Map<String, dynamic> j) => IndentDetailItem(
    itemid: int.tryParse(j['itemid']?.toString() ?? '0') ?? 0,
    itemname: (j['ItemName'] ?? j['itemname'] ?? '')
        .toString(), // ← capital ItemName
    unitid: int.tryParse(j['unitid']?.toString() ?? '0') ?? 0,
    unitname: (j['unitname'] ?? '').toString(),
    prqty: double.tryParse(j['bomqty']?.toString() ?? '0') ?? 0, // ← bomqty
    indentqty: double.tryParse(j['quantity']?.toString() ?? '0') ??
        0, // ← quantity
    delqty:
    double.tryParse(j['deliveredQtyamount']?.toString() ?? '0') ?? 0,
    rate: double.tryParse(j['rate']?.toString() ?? '0') ?? 0,
    stockatsite: double.tryParse(j['stockquantity']?.toString() ?? '0') ??
        0, // ← stockquantity
    itemdescription:
    (j['remarks'] ?? j['lineitem'] ?? '').toString(), // ← remarks
    transid: int.tryParse(j['autoid']?.toString() ?? '0') ?? 0, // ← autoid
  );
}

// ── Generic API response wrapper ──────────────────────────────────────────────
class IndentApiResponse<T> {
  final int? status;
  final bool? success;
  final String? message;
  final T? data;

  const IndentApiResponse({
    this.status,
    this.success,
    this.message,
    this.data,
  });
}
// ── Indent Response Models (add to your models file) ─────────────────────────

class IndentDropdownResponse {
  final int status;
  final bool? success;
  final String? message;
  final List<IndentDropdownOption> data;

  IndentDropdownResponse({
    required this.status,
    this.success,
    this.message,
    this.data = const [],
  });

  factory IndentDropdownResponse.fromJson(Map<String, dynamic> j) =>
      IndentDropdownResponse(
        status: int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: (j['data'] as List? ?? [])
            .map(
                (e) => IndentDropdownOption.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class IndentListResponse {
  final int status;
  final bool? success;
  final String? message;
  final List<IndentListItem> data;

  IndentListResponse({
    required this.status,
    this.success,
    this.message,
    this.data = const [],
  });

  factory IndentListResponse.fromJson(Map<String, dynamic> j) =>
      IndentListResponse(
        status: int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: (j['data'] as List? ?? [])
            .map((e) => IndentListItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class IndentDetailResponse {
  final int status;
  final bool? success;
  final String? message;
  final IndentDetailData? data;

  IndentDetailResponse({
    required this.status,
    this.success,
    this.message,
    this.data,
  });

  factory IndentDetailResponse.fromJson(Map<String, dynamic> j) =>
      IndentDetailResponse(
        status: int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        data: j['data'] != null
            ? IndentDetailData.fromJson(j['data'] as Map<String, dynamic>)
            : null,
      );
}

class IndentSubmitResponse {
  final int status;
  final bool? success;
  final String? message;

  IndentSubmitResponse({
    required this.status,
    this.success,
    this.message,
  });

  factory IndentSubmitResponse.fromJson(Map<String, dynamic> j) =>
      IndentSubmitResponse(
        status: int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
      );
}

class IndentItemStockResponse {
  final int status;
  final bool? success;
  final String? message;
  final double? stock;

  IndentItemStockResponse({
    required this.status,
    this.success,
    this.message,
    this.stock,
  });

  factory IndentItemStockResponse.fromJson(Map<String, dynamic> j) =>
      IndentItemStockResponse(
        status: int.tryParse(j['status']?.toString() ?? '200') ?? 200,
        success: j['success'] as bool?,
        message: j['message']?.toString(),
        stock: double.tryParse(j['data']?.toString() ?? '0'),
      );
}
