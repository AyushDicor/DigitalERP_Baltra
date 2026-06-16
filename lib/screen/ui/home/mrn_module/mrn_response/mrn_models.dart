import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// MRN Models

enum MrnSourceType { purchaseOrder, directPurchase }

enum MrnDocType { invoice, indent, deliveryChallan, inspection, other }

enum MrnAttachmentType { bill, challan }

// ── MRN List ───────────────────────────────────────────────────────────────
class MrnListRequest {
  final String fromdate;
  final String todate;
  final int compid;
  final int branchid;
  final int userid;
  final int partyid;
  final int siteid;
  final int jobtypeid;
  final String filtertype;

  MrnListRequest({
    required this.fromdate,
    required this.todate,
    required this.compid,
    required this.branchid,
    required this.userid,
    this.partyid = 0,
    this.siteid = 0,
    this.jobtypeid = 0,
    this.filtertype = 'mrn',
  });

  Map<String, dynamic> toJson() => {
        'fromdate': fromdate,
        'todate': todate,
        'compid': compid,
        'branchid': branchid,
        'userid': userid,
        'partyid': partyid,
        'siteid': siteid,
        'jobtypeid': jobtypeid,
        'filtertype': filtertype,
      };
}

// class MrnListResponse {
//   final bool? success;
//   final int? status;
//   final String? message;
//   final List<MrnListItem> data;
//
//   MrnListResponse({this.success, this.status, this.message, this.data = const []});
//
//   factory MrnListResponse.fromJson(Map<String, dynamic> json) {
//     final raw = json['data'];
//     final items = raw is String ? _parseHtmlTable(raw) : <MrnListItem>[];
//     return MrnListResponse(
//       success: json['success'],
//       status:  json['status'],
//       message: json['message'],
//       data:    items,
//     );
//   }
//
//   // ── Parse the HTML table string into a list of MrnListItem ─────────────
//   static List<MrnListItem> _parseHtmlTable(String html) {
//     final items = <MrnListItem>[];
//     // Extract all <tr> rows inside <tbody>
//     final tbodyMatch = RegExp(r'<tbody>(.*?)</tbody>', dotAll: true).firstMatch(html);
//     if (tbodyMatch == null) return items;
//
//     final rows = RegExp(r'<tr>(.*?)</tr>', dotAll: true)
//         .allMatches(tbodyMatch.group(1)!)
//         .toList();
//
//     for (final row in rows) {
//       final cells = RegExp(r'<td>(.*?)</td>', dotAll: true)
//           .allMatches(row.group(1)!)
//           .map((m) => m.group(1)!.trim())
//           .toList();
//
//       // Order: ID, Mrnno, BillNo, mrndate, PartyName, SiteName, JobType, TotalQty, TotalAmt
//       if (cells.length >= 9) {
//         items.add(MrnListItem(
//           id:        int.tryParse(cells[0]) ?? 0,
//           mrnNo:     cells[1],
//           billNo:    cells[2],
//           mrnDate:   cells[3],
//           partyName: cells[4],
//           siteName:  cells[5],
//           jobType:   cells[6],
//           totalQty:  double.tryParse(cells[7]) ?? 0,
//           totalAmt:  double.tryParse(cells[8]) ?? 0,
//         ));
//       }
//     }
//     return items;
//   }
// }
//─────────────────────MRN List ───────────────────────────────────────────────

class MrnListRawRow {
  final int id; // always extract ID for tap-to-edit
  final Map<String, dynamic> data; // all columns as-is from API

  MrnListRawRow({required this.id, required this.data});
}

class MrnListResponse {
  final bool? success;
  final int? status;
  final String? message;
  final List<MrnListItem> data; // parsed items (for edit navigation)
  final List<MrnListRawRow> rawRows; // dynamic rows for table display
  final List<String> columns; // column headers in order
  final String rawHtml;

  MrnListResponse({
    this.success,
    this.status,
    this.message,
    this.data = const [],
    this.rawRows = const [],
    this.columns = const [],
    this.rawHtml = '',
  });

  factory MrnListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<MrnListItem> items = [];
    List<MrnListRawRow> rawRows = [];
    List<String> columns = [];
    String html = '';

    if (rawData is List && rawData.isNotEmpty) {
      final firstRow = rawData.first as Map<String, dynamic>;
      columns = firstRow.keys.toList();

      for (final row in rawData) {
        final map = row as Map<String, dynamic>;

        // ✅ Handle double ID (335787.0) correctly
        final rawId = map['ID'] ?? map['id'] ?? map['stockid'] ?? 0;
        final int id;
        if (rawId is double) {
          id = rawId.toInt();
        } else if (rawId is int) {
          id = rawId;
        } else {
          id = int.tryParse(rawId.toString().split('.')[0]) ?? 0;
        }

        rawRows.add(MrnListRawRow(id: id, data: map));
        items.add(MrnListItem.fromJson(map));
      }
    } else if (rawData is String && rawData.isNotEmpty) {
      html = rawData;
      items = MrnListResponse._parseHtmlTable(rawData);
    }

    return MrnListResponse(
      status: json['status'],
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: items,
      rawRows: rawRows,
      columns: columns,
      rawHtml: html,
    );
  }

  static List<MrnListItem> _parseHtmlTable(String html) {
    final List<MrnListItem> result = [];
    try {
      final tbodyMatch =
          RegExp(r'<tbody>(.*?)</tbody>', dotAll: true).firstMatch(html);
      if (tbodyMatch == null) return result;
      final rowMatches = RegExp(r'<tr>(.*?)</tr>', dotAll: true)
          .allMatches(tbodyMatch.group(1)!);
      for (final row in rowMatches) {
        final cells = RegExp(r'<td>(.*?)</td>', dotAll: true)
            .allMatches(row.group(1)!)
            .map((m) => m.group(1)?.trim() ?? '')
            .toList();
        if (cells.length < 9) continue;
        result.add(MrnListItem(
          id: int.tryParse(cells[0]) ?? 0,
          mrnNo: cells[1],
          billNo: cells[2],
          mrnDate: cells[3],
          partyName: cells[4],
          siteName: cells[5],
          jobType: cells[6],
          totalQty: double.tryParse(cells[7]) ?? 0,
          totalAmt: double.tryParse(cells[8]) ?? 0,
        ));
      }
    } catch (_) {}
    return result;
  }
}

class MrnListItem {
  final int id;
  final String mrnNo;
  final String billNo;
  final String mrnDate;
  final String partyName;
  final String siteName;
  final String jobType;
  final double totalQty;
  final double totalAmt;
  final String withRateUrl;
  final String withoutRateUrl;

  MrnListItem({
    required this.id,
    required this.mrnNo,
    required this.billNo,
    required this.mrnDate,
    required this.partyName,
    required this.siteName,
    required this.jobType,
    required this.totalQty,
    required this.totalAmt,
    this.withRateUrl = '',
    this.withoutRateUrl = '',
  });

  // ✅ Add this
  factory MrnListItem.fromJson(Map<String, dynamic> json) {
    return MrnListItem(
      // ✅ ID comes as double (335787.0) — must handle both int and double
      id: _parseId(json['ID'] ?? json['id'] ?? json['stockid']),
      mrnNo: json['Mrnno']?.toString() ?? json['mrnno']?.toString() ?? '',
      billNo: json['BillNo']?.toString() ?? json['billno']?.toString() ?? '',
      mrnDate: json['mrndate']?.toString() ?? '',
      partyName:
          json['PartyName']?.toString() ?? json['partyname']?.toString() ?? '',
      siteName:
          json['SiteName']?.toString() ?? json['sitename']?.toString() ?? '',
      jobType: json['JobType']?.toString() ?? json['jobtype']?.toString() ?? '',
      totalQty: _parseDouble(json['TotalQty'] ?? json['totalqty']),
      totalAmt: _parseDouble(json['TotalAmt'] ?? json['totalamt']),
      withRateUrl: json['withrateurl']?.toString() ?? '',
      withoutRateUrl: json['withOUTrateurl']?.toString() ?? '',
    );
  }

// ✅ Handles int, double (335787.0), and string ("335787")
  static int _parseId(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt(); // ✅ 335787.0 → 335787
    final str = v.toString().split('.')[0]; // ✅ "335787.0" → "335787"
    return int.tryParse(str) ?? 0;
  }

  static double _parseDouble(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }
}

// ── MRN Detail Response ────────────────────────────────────────────────────
class MrnDetailResponse {
  final bool? success;
  final int? status;
  final String? message;
  final MrnDetailData? data;

  MrnDetailResponse({this.success, this.status, this.message, this.data});

  factory MrnDetailResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    MrnDetailData? data;
    if (raw is Map<String, dynamic>) {
      data = MrnDetailData.fromJson(raw);
    } else if (raw is List && raw.isNotEmpty) {
      data = MrnDetailData.fromJson(raw.first as Map<String, dynamic>);
    }
    return MrnDetailResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }
}

class MrnDetailData {
  final int stockid;
  final String type;
  final String pono;
  final int seriesid;
  final String receiptdate;
  final String partyname;
  final int partyid;
  final String billno;
  final String billdate;
  final int godownid;
  final String godownname;
  final String receivedby;
  final String dcno;
  final String dcdate;
  final String lotno;
  final String grnno;
  final String grndate;
  final String gateentryno;
  final String qcstatus;
  final int siteid;
  final String sitename;
  final int paidbyid;
  final String paidby;
  final String paidtype;
  final int jobtypeid;
  final String description;
  final String reason;
  final int customerpoid;
  final String billfile;
  final String dcfile;
  final List<MrnDetailItem> items;
  final List<MrnOtherItem> mrnother;

  MrnDetailData({
    this.stockid = 0,
    this.type = '',
    this.pono = '',
    this.seriesid = 0,
    this.receiptdate = '',
    this.partyname = '',
    this.partyid = 0,
    this.billno = '',
    this.billdate = '',
    this.godownid = 0,
    this.godownname = '',
    this.receivedby = '',
    this.dcno = '',
    this.dcdate = '',
    this.lotno = '',
    this.grnno = '',
    this.grndate = '',
    this.gateentryno = '',
    this.qcstatus = '',
    this.siteid = 0,
    this.sitename = '',
    this.paidbyid = 0,
    this.paidby = '',
    this.paidtype = '',
    this.jobtypeid = 0,
    this.description = '',
    this.reason = '',
    this.customerpoid = 0,
    this.billfile = '',
    this.dcfile = '',
    this.items = const [],
    required this.mrnother,
  });

  factory MrnDetailData.fromJson(Map<String, dynamic> json) {
    // ✅ items come under key 'mrnitems' in the real response
    final rawItems = json['mrnitems'] ?? json['items'] ?? [];
    return MrnDetailData(
      stockid: _i(json['stockid']),
      type: json['type']?.toString() ?? '',
      pono: json['pono']?.toString() ?? '',
      seriesid: _i(json['seriesid']),
      receiptdate: json['receiptdate']?.toString() ?? '',
      partyname: json['partyname']?.toString() ?? '',
      partyid: _i(json['partyid']),
      billno: json['billno']?.toString() ?? '',
      billdate: json['billdate']?.toString() ?? '',
      godownid: _i(json['godownid']),
      godownname: json['godownname']?.toString() ?? '',
      receivedby: json['receivedby']?.toString() ?? '',
      dcno: json['dcno']?.toString() ?? '',
      dcdate: json['dcdate']?.toString() ?? '',
      // ✅ API sends "0" as string for lotno — treat "0" as empty
      lotno: _cleanZero(json['lotno']?.toString()),
      grnno: _cleanZero(json['grnno']?.toString()),
      grndate: json['grndate']?.toString() ?? '',
      gateentryno: json['gateentryNo']?.toString() ?? '',
      qcstatus: json['qcstatus']?.toString() ?? '',
      siteid: _i(json['siteid']),
      sitename: json['sitename']?.toString() ?? '',
      paidbyid: _i(json['paidbyid']),
      paidby: json['paidby']?.toString() ?? '',
      paidtype: json['paidtype']?.toString() ?? '',
      jobtypeid: _i(json['jobtypeid']),
      description: json['description']?.toString() ?? '',
      reason: json['reason']?.toString() ?? '',
      customerpoid: _i(json['customerpoid']),
      billfile: json['billfile']?.toString() ?? '',
      dcfile: json['dcfile']?.toString() ?? '',
      items: rawItems is List
          ? rawItems
              .map((e) => MrnDetailItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      mrnother: (json['mrnother'] as List<dynamic>? ?? [])
          .map((e) => MrnOtherItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // ✅ Treat "0" and "null" string as empty — API sends lotno: "0"
  static String _cleanZero(String? v) {
    if (v == null || v == '0' || v.toLowerCase() == 'null') return '';
    return v;
  }

  static int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}

class MrnDetailItem {
  final int itemid;
  final String itemname;
  final double rate;
  final double quantity;
  final double amount;
  final double gstpercent;
  final double gstamount;
  final double discountpercent;
  final double discountamount;
  final String specification;
  final String make;
  final int makeid;
  final int unitid;
  final String unitname;
  final int godownid;
  final int transid;
  final int uniqueid;
  final String batchno;

  MrnDetailItem({
    this.itemid = 0,
    this.itemname = '',
    this.rate = 0,
    this.quantity = 0,
    this.amount = 0,
    this.gstpercent = 0,
    this.gstamount = 0,
    this.discountpercent = 0,
    this.discountamount = 0,
    this.specification = '',
    this.make = '',
    this.makeid = 0,
    this.unitid = 0,
    this.unitname = 'Nos',
    this.godownid = 0,
    this.transid = 0,
    this.uniqueid = 0,
    this.batchno = '',
  });

  factory MrnDetailItem.fromJson(Map<String, dynamic> json) => MrnDetailItem(
        itemid: _i(json['itemid']),
        itemname: json['itemname']?.toString() ?? '',
        rate: _d(json['rate']),
        quantity: _d(json['quantity']),
        amount: _d(json['amount']),
        gstpercent: _d(json['gstpercent']),
        gstamount: _d(json['gstamount']),
        discountpercent: _d(json['discountpercent']),
        discountamount: _d(json['discountamount']),
        specification: json['specification']?.toString() ?? '',
        make: json['make']?.toString() ?? '',
        makeid: _i(json['makeid']),
        unitid: _i(json['unitid']),
        // ✅ API doesn't return unitname — will fall back to 'Nos'
        unitname: json['unitname']?.toString() ?? 'Nos',
        godownid: _i(json['godownid']),
        transid: _i(json['transid']),
        uniqueid: _i(json['uniqueid']),
        batchno: json['batchno']?.toString() ?? '',
      );

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  static int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}

// ── MRN Dropdown API response ────────────────────────────────────────────────
class MrnDropdownResponse {
  final int? status;
  final bool? success;
  final String? message;
  final List<MrnDropdownOption>? data;

  MrnDropdownResponse({this.status, this.success, this.message, this.data});

  factory MrnDropdownResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) print('🔍 MrnDropdownOption raw json: $json');

    return MrnDropdownResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => MrnDropdownOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// ── Pending PO API — request body ─────────────────────────────────────────────
class GetPendingPoRequest {
  final int compid;
  final int branchid;
  final int userid;
  final int partyid;
  final int siteid;
  final String orderid;
  final int stockid;

  GetPendingPoRequest({
    required this.compid,
    required this.branchid,
    required this.userid,
    this.partyid = 0,
    this.siteid = 0,
    this.orderid = '',
    this.stockid = 0,
  });

  Map<String, dynamic> toJson() => {
        'compid': compid,
        'branchid': branchid,
        'userid': userid,
        'partyid': partyid,
        'siteid': siteid,
        'orderid': orderid,
        'stockid': stockid,
      };

  String toJsonString() => jsonEncode(toJson());
}

// ── Pending PO API — response wrapper ─────────────────────────────────────────
class GetPendingPoResponse {
  final bool? success;
  final List<PendingPoItem>? data;
  final String? message;
  final int? status;

  GetPendingPoResponse({this.success, this.data, this.message, this.status});

  factory GetPendingPoResponse.fromJson(Map<String, dynamic> json) {
    return GetPendingPoResponse(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: json['data'] != null && json['data'] is List
          ? (json['data'] as List)
              .map((v) => PendingPoItem.fromJson(v as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

GetPendingPoResponse getPendingPoResponseFromJson(String str) =>
    GetPendingPoResponse.fromJson(jsonDecode(str));

// ── Single PO row (used in both PO list AND item list) ─────────────────────────
/// When [stockid] == 0  → this is a PO header row
/// When [stockid]  > 0  → this is an item line row (same endpoint, different data)
class PendingPoItem {
  // ── From getpendingpo API (stockid = 0) ───────────────────────────────────
  final int orderid; // e.g. 27658 — pass this as orderid in process call
  final String orderno; // e.g. "GP09/0030/PO/26-27" — display PO number
  final String orderdate; // e.g. "09-05-2026"
  final String partyname; // e.g. "GOLDLINE SECURITY SYSTEMS"
  final int totalqty; // total items ordered
  final double totalamount; // subtotal before GST
  final double grandtotal; // total including GST

  // ── Item line fields — populated when stockid > 0 (process call) ─────────
  // TODO: update these once you get the item API response shape
  final String itemname;
  final String itemcode;
  final String unit;
  final double orderedqty;
  final double receivedqty;
  final double rate;
  final double discountpercent;
  final double gstpercent;
  final int stockid;

  // UI state
  bool isSelected;

  PendingPoItem({
    required this.orderid,
    this.orderno = '',
    this.orderdate = '',
    this.partyname = '',
    this.totalqty = 0,
    this.totalamount = 0,
    this.grandtotal = 0,
    // item fields
    this.itemname = '',
    this.itemcode = '',
    this.unit = 'Nos',
    this.orderedqty = 0,
    this.receivedqty = 0,
    this.rate = 0,
    this.discountpercent = 0,
    this.gstpercent = 18,
    this.stockid = 0,
    this.isSelected = false,
  });

  factory PendingPoItem.fromJson(Map<String, dynamic> json) {
    return PendingPoItem(
      // PO header fields
      orderid: _i(json['orderid']),
      orderno: json['orderno']?.toString() ?? '',
      orderdate: json['orderdate']?.toString() ?? '',
      partyname: json['partyname']?.toString() ?? '',
      totalqty: _i(json['totalqty']),
      totalamount: _d(json['totalamount']),
      grandtotal: _d(json['grandtotal']),
      // Item line fields — covering common naming variants
      itemname: json['itemname']?.toString() ??
          json['item_name']?.toString() ??
          json['name']?.toString() ??
          '',
      itemcode: json['itemcode']?.toString() ??
          json['item_code']?.toString() ??
          json['code']?.toString() ??
          '',
      unit: json['unit']?.toString() ?? json['unitname']?.toString() ?? 'Nos',
      orderedqty: _d(json['orderedqty'] ??
          json['orderqty'] ??
          json['qty'] ??
          json['poqty']),
      receivedqty: _d(json['receivedqty'] ??
          json['recqty'] ??
          json['prevreceivedqty'] ??
          0),
      rate: _d(json['rate'] ?? json['unitrate'] ?? json['price']),
      discountpercent:
          _d(json['discountpercent'] ?? json['discount'] ?? json['disc'] ?? 0),
      gstpercent: _d(json['gstpercent'] ??
          json['gst'] ??
          json['gstrate'] ??
          json['tax'] ??
          18),
      stockid: _i(json['stockid'] ?? json['stock_id'] ?? 0),
    );
  }

  /// Converts an item-response row to [MrnItemLine].
  /// Call this after processSelectedPO() returns item rows.
  MrnItemLine toItemLine({required String poNumber}) {
    return MrnItemLine(
      itemId: itemcode.isNotEmpty ? itemcode : orderid.toString(),
      itemName: itemname,
      itemCode: itemcode,
      unit: unit,
      source: 'PO',
      orderNo: poNumber,
      poQty: orderedqty,
      previouslyReceivedQty: receivedqty,
      rate: rate,
      discountPercent: discountpercent,
      gstPercent: gstpercent,
      receiveNowQty: (orderedqty - receivedqty).clamp(0, double.infinity),
    );
  }

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  static int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}

// ── PO header item (kept for any legacy usage) ─────────────────────────────────
class MrnPOItem {
  final String poNumber;
  final String date;
  final String itemCategory;
  final double amount;
  final String status;
  bool isSelected;

  MrnPOItem({
    required this.poNumber,
    required this.date,
    required this.itemCategory,
    required this.amount,
    required this.status,
    this.isSelected = false,
  });
}

// ── Full item line ─────────────────────────────────────────────────────────────
class MrnItemLine {
  final String itemId;
  final String itemName;
  final String itemCode;
  final String unit;
  final String source;
  final String orderNo;
  final double poQty;
  final double previouslyReceivedQty;
  final double rate;
  final double discountPercent;
  final double discountAmount;
  final double gstPercent;

  // ✅ Add these fields
  final int unitId;
  final int transId;
  final int uniqueId;
  final int makeId;
  final String make;
  final String batchNo;

  double receiveNowQty;
  String? selectedGodownId;
  String remarks;
  bool isExpanded;

  MrnItemLine({
    required this.itemId,
    required this.itemName,
    required this.itemCode,
    required this.unit,
    required this.source,
    this.orderNo = '',
    required this.poQty,
    this.previouslyReceivedQty = 0,
    required this.rate,
    this.discountPercent = 0,
    this.discountAmount = 0,
    this.gstPercent = 18,
    required this.receiveNowQty,
    this.selectedGodownId,
    this.remarks = '',
    this.isExpanded = false,
    // ✅ Add with defaults so existing Direct/PO usages don't break
    this.unitId = 0,
    this.transId = 0,
    this.uniqueId = 0,
    this.makeId = 0,
    this.make = '',
    this.batchNo = '',
  });

  double get maxReceivable =>
      (poQty - previouslyReceivedQty).clamp(0, double.infinity);

  double get _discAmt => source == 'Direct'
      ? discountAmount
      : receiveNowQty * rate * discountPercent / 100;

  double get amount => (receiveNowQty * rate) - _discAmt;
  double get gstAmount => amount * gstPercent / 100;
  double get totalAmount => amount + gstAmount;
  double get lineTotal => totalAmount;
}

// ── Scanned item ───────────────────────────────────────────────────────────────
class MrnScannedItem {
  final String barcode;
  final String itemName;
  final String itemCode;
  final double rate;
  final bool isUnknown;
  double qty;

  MrnScannedItem({
    required this.barcode,
    required this.itemName,
    required this.itemCode,
    required this.rate,
    required this.isUnknown,
    this.qty = 1,
  });
}

// ── Attachment document ────────────────────────────────────────────────────────
class MrnDocument {
  final String id;
  final String fileName;
  final String filePath;
  final String fileType;
  final String fileSize;
  final MrnAttachmentType attachmentType;
  final String source;
  final DateTime uploadedAt;

  MrnDocument({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.attachmentType,
    required this.source,
    required this.uploadedAt,
  });
}

// ── Generic API-driven dropdown option ────────────────────────────────────────
class MrnDropdownOption {
  final String id;
  final String label;

  MrnDropdownOption({required this.id, required this.label});

  factory MrnDropdownOption.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) print('🔍 MrnDropdownOption raw json: $json');
    return MrnDropdownOption(
      id: json['id']?.toString() ?? '',
      label: json['name'] ?? json['label'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MrnDropdownOption && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ── Submit response ────────────────────────────────────────────────────────────
class MrnSubmitResponse {
  final int? status;
  final bool? success; // ✅ add this
  final String? message;
  final String? mrnNumber;

  MrnSubmitResponse({
    this.status,
    this.success, // ✅ add this
    this.message,
    this.mrnNumber,
  });

  factory MrnSubmitResponse.fromJson(Map<String, dynamic> json) {
    return MrnSubmitResponse(
      status: json['status'],
      success: json['success'], // ✅ add this
      message: json['message'],
      mrnNumber: json['mrnno'],
    );
  }
}

// ── Address ────────────────────────────────────────────────────────────────────
class MrnAddress {
  final String label;
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String pincode;

  const MrnAddress({
    required this.label,
    this.line1 = '',
    this.line2 = '',
    this.city = '',
    this.state = '',
    this.pincode = '',
  });

  String get formatted {
    final parts = [line1, line2, city, state, pincode]
        .where((p) => p.isNotEmpty)
        .toList();
    return parts.join(', ');
  }

  bool get isEmpty => formatted.isEmpty;

  factory MrnAddress.fromJson(Map<String, dynamic> json) => MrnAddress(
        label: json['label'] ?? '',
        line1: json['line1'] ?? json['address1'] ?? '',
        line2: json['line2'] ?? json['address2'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        pincode: json['pincode'] ?? json['pin'] ?? '',
      );
}

// ── Process PO request body ────────────────────────────────────────────────
class ProcessPendingPoRequest {
  final int type;
  final int compid;
  final int branchid;
  final int userid;
  final int partyid;
  final int siteid;
  final String orderid;
  final int stockid;

  ProcessPendingPoRequest({
    this.type = 1,
    required this.compid,
    required this.branchid,
    required this.userid,
    this.partyid = 0,
    this.siteid = 0,
    required this.orderid,
    this.stockid = 0,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'compid': compid,
        'branchid': branchid,
        'userid': userid,
        'partyid': partyid,
        'siteid': siteid,
        'orderid': orderid,
        'stockid': stockid,
      };
}

// ── Process PO response item ───────────────────────────────────────────────
class ProcessPoItem {
  final int orderid;
  final String orderno;
  final int itemid;
  final String itemname;
  final double mrp;
  final double rate;
  final double quantity; // ordered qty
  final double amount;
  final double gstpercent;
  final double taxamt;
  final double discountpercent;
  final double discountamount;
  final int unitid;
  final String unitname;
  final String specification;
  final int makeid;
  final String make;
  final int godownid;
  final String godownname;
  final String batchno;
  final int transid;
  final double remqty; // remaining/balance qty — use as maxReceivable
  final double totalamount;
  final int uniqueid;

  ProcessPoItem({
    required this.orderid,
    this.orderno = '',
    required this.itemid,
    this.itemname = '',
    this.mrp = 0,
    this.rate = 0,
    this.quantity = 0,
    this.amount = 0,
    this.gstpercent = 0,
    this.taxamt = 0,
    this.discountpercent = 0,
    this.discountamount = 0,
    this.unitid = 0,
    this.unitname = 'Nos',
    this.specification = '',
    this.makeid = 0,
    this.make = '',
    this.godownid = 0,
    this.godownname = '',
    this.batchno = '',
    this.transid = 0,
    this.remqty = 0,
    this.totalamount = 0,
    this.uniqueid = 0,
  });

  factory ProcessPoItem.fromJson(Map<String, dynamic> json) {
    return ProcessPoItem(
      orderid: _i(json['orderid']),
      orderno: json['orderno']?.toString() ?? '',
      itemid: _i(json['itemid']),
      itemname: json['itemname']?.toString() ?? '',
      mrp: _d(json['mrp']),
      rate: _d(json['rate']),
      quantity: _d(json['quantity']),
      amount: _d(json['amount']),
      gstpercent: _d(json['gstpercent']),
      taxamt: _d(json['taxamt']),
      discountpercent: _d(json['discountpercent']),
      discountamount: _d(json['discountamount']),
      unitid: _i(json['unitid']),
      unitname: json['unitname']?.toString() ?? 'Nos',
      specification: json['specification']?.toString() ?? '',
      makeid: _i(json['makeid']),
      make: json['make']?.toString() ?? '',
      godownid: _i(json['godownid']),
      godownname: json['godownname']?.toString() ?? '',
      batchno: json['batchno']?.toString() ?? '',
      transid: _i(json['transid']),
      remqty: _d(json['remqty']),
      totalamount: _d(json['totalamount']),
      uniqueid: _i(json['uniqueid']),
    );
  }

  // ── Convert to MrnItemLine ─────────────────────────────────────────────
  MrnItemLine toItemLine({required String poNumber}) {
    // poQty = quantity (ordered)
    // previouslyReceivedQty = quantity - remqty (already received)
    // receiveNowQty = remqty (balance left to receive)
    final alreadyReceived = (quantity - remqty).clamp(0.0, double.infinity);
    return MrnItemLine(
      itemId: itemid.toString(),
      itemName: itemname,
      itemCode: itemid.toString(),
      unit: unitname,
      source: 'PO',
      orderNo: poNumber,
      poQty: quantity,
      previouslyReceivedQty: alreadyReceived,
      rate: rate,
      discountPercent: discountpercent,
      gstPercent: gstpercent,
      receiveNowQty: remqty, // default to full balance
      selectedGodownId: godownid > 0 ? godownid.toString() : null,
      remarks: specification,
      unitId: unitid,
      transId: transid,
      uniqueId: uniqueid,
      makeId: makeid,
      make: make,
      batchNo: batchno,
    );
  }

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  static int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}

// ── Process PO response wrapper ────────────────────────────────────────────
class ProcessPendingPoResponse {
  final bool? success;
  final List<ProcessPoItem>? data;
  final String? message;
  final int? status;

  ProcessPendingPoResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  factory ProcessPendingPoResponse.fromJson(Map<String, dynamic> json) {
    return ProcessPendingPoResponse(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: json['data'] != null && json['data'] is List
          ? (json['data'] as List)
              .map((e) => ProcessPoItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

class MrnItemDetailResponse {
  final bool? success;
  final int? status;
  final String? message;
  final MrnItemDetail? data;

  MrnItemDetailResponse({this.success, this.status, this.message, this.data});

  factory MrnItemDetailResponse.fromJson(Map<String, dynamic> json) {
    dynamic raw = json['data'];
    MrnItemDetail? detail;
    if (raw is Map<String, dynamic>) {
      detail = MrnItemDetail.fromJson(raw);
    } else if (raw is List && raw.isNotEmpty) {
      detail = MrnItemDetail.fromJson(raw.first as Map<String, dynamic>);
    }
    return MrnItemDetailResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: detail,
    );
  }
}

class MrnItemDetail {
  final double gstpercent;

  MrnItemDetail({required this.gstpercent});

  factory MrnItemDetail.fromJson(Map<String, dynamic> json) {
    return MrnItemDetail(
      // TODO: confirm exact field name from real API response
      gstpercent: _d(json['gstpercent'] ?? json['gst'] ?? json['taxpercent']),
    );
  }

  static double _d(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }
}

class DependentDetailRequest {
  final String type;
  final int compid;
  final int branchid;
  final int partyid;
  final int siteid;
  final String dependentid; // single id OR comma-separated ids (for PO)

  DependentDetailRequest({
    required this.type,
    required this.compid,
    required this.branchid,
    this.partyid = 0,
    this.siteid = 0,
    required this.dependentid,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'compid': compid,
        'branchid': branchid,
        'partyid': partyid,
        'siteid': siteid,
        'dependentid': dependentid,
      };
}

class DependentDetailResponse {
  final bool? success;
  final int? status;
  final String? message;
  final DependentDetail? data;

  DependentDetailResponse({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory DependentDetailResponse.fromJson(Map<String, dynamic> json) {
    DependentDetail? detail;
    final raw = json['data'];
    if (raw is List && raw.isNotEmpty) {
      detail = DependentDetail.fromJson(raw.first as Map<String, dynamic>);
    } else if (raw is Map<String, dynamic>) {
      detail = DependentDetail.fromJson(raw);
    }
    return DependentDetailResponse(
      success: json['success'],
      status: json['status'],
      message: json['message']?.toString(),
      data: detail,
    );
  }
}

class DependentDetail {
  final int godownid;
  final int jobtypeid;
  final int workorderid;
  final int customerpoid;

  DependentDetail({
    this.godownid = 0,
    this.jobtypeid = 0,
    this.workorderid = 0,
    this.customerpoid = 0,
  });

  factory DependentDetail.fromJson(Map<String, dynamic> json) {
    return DependentDetail(
      godownid: _i(json['godownid']),
      jobtypeid: _i(json['jobtypeid']),
      workorderid: _i(json['workorderid']),
      customerpoid: _i(json['customerpoid']),
    );
  }

  static int _i(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'godownid': godownid,
        'jobtypeid': jobtypeid,
        'workorderid': workorderid,
        'customerpoid': customerpoid,
      };

  bool get hasJobType => jobtypeid > 0;
  bool get hasCustomerPo => customerpoid > 0;
  bool get hasWorkOrder => workorderid > 0;
  bool get hasGodown => godownid > 0;
}

class MrnLedgerAddressRequest {
  final int compid;
  final int partyid;
  final int siteid;

  MrnLedgerAddressRequest({
    required this.compid,
    required this.partyid,
    required this.siteid,
  });

  Map<String, dynamic> toJson() => {
        'compid': compid,
        'partyid': partyid,
        'siteid': siteid,
      };
}

class MrnLedgerAddressResponse {
  final bool? success;
  final int? status;
  final String? message;
  final List<MrnLedgerAddressData> data;

  MrnLedgerAddressResponse({
    this.success,
    this.status,
    this.message,
    this.data = const [],
  });

  factory MrnLedgerAddressResponse.fromJson(Map<String, dynamic> json) {
    return MrnLedgerAddressResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: json['data'] is List
          ? (json['data'] as List)
              .map((e) => MrnLedgerAddressData.fromJson(e))
              .toList()
          : [],
    );
  }
}

class MrnLedgerAddressData {
  final double gstpercent;
  final String fromaddress;
  final String toaddress;

  MrnLedgerAddressData({
    this.gstpercent = 0,
    this.fromaddress = '',
    this.toaddress = '',
  });

  factory MrnLedgerAddressData.fromJson(Map<String, dynamic> json) {
    return MrnLedgerAddressData(
      gstpercent: (json['gstpercent'] ?? 0).toDouble(),
      fromaddress: json['fromaddress']?.toString() ?? '',
      toaddress: json['toaddress']?.toString() ?? '',
    );
  }
}

// ── New model for mrnother rows ─────────────────────────────────────────────
class MrnOtherItem {
  final int accountid;
  final double amount;
  final String nature;
  final double percentage;
  final String dependid;

  const MrnOtherItem({
    required this.accountid,
    required this.amount,
    required this.nature,
    required this.percentage,
    required this.dependid,
  });

  factory MrnOtherItem.fromJson(Map<String, dynamic> json) => MrnOtherItem(
        accountid: (json['accountid'] as num?)?.toInt() ?? 0,
        amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
        nature: (json['nature'] as String?) ?? '+',
        percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
        dependid: (json['dependid'] as String?) ?? '',
      );
}
