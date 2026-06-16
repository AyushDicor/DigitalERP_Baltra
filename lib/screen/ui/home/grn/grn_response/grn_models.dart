import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

// Grn Models

enum GrnSourceType { grn }

enum GrnDocType { invoice, indent, deliveryChallan, inspection, other }

enum GrnAttachmentType { bill, challan }

// ── Grn List ───────────────────────────────────────────────────────────────
class GrnListRequest {
  final String fromdate;
  final String todate;
  final int compid;
  final int branchid;
  final int userid;
  final int partyid;
  final int siteid;
  final int jobtypeid;
  final String filtertype;

  GrnListRequest({
    required this.fromdate,
    required this.todate,
    required this.compid,
    required this.branchid,
    required this.userid,
    this.partyid = 0,
    this.siteid = 0,
    this.jobtypeid = 0,
    this.filtertype = 'grn',
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

// class GrnListResponse {
//   final bool? success;
//   final int? status;
//   final String? message;
//   final List<GrnListItem> data;
//
//   GrnListResponse({this.success, this.status, this.message, this.data = const []});
//
//   factory GrnListResponse.fromJson(Map<String, dynamic> json) {
//     final raw = json['data'];
//     final items = raw is String ? _parseHtmlTable(raw) : <GrnListItem>[];
//     return GrnListResponse(
//       success: json['success'],
//       status:  json['status'],
//       message: json['message'],
//       data:    items,
//     );
//   }
//
//   // ── Parse the HTML table string into a list of GrnListItem ─────────────
//   static List<GrnListItem> _parseHtmlTable(String html) {
//     final items = <GrnListItem>[];
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
//       // Order: ID, Grnno, BillNo, Grndate, PartyName, SiteName, JobType, TotalQty, TotalAmt
//       if (cells.length >= 9) {
//         items.add(GrnListItem(
//           id:        int.tryParse(cells[0]) ?? 0,
//           GrnNo:     cells[1],
//           billNo:    cells[2],
//           GrnDate:   cells[3],
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
//─────────────────────Grn List ───────────────────────────────────────────────

class GrnListRawRow {
  final int id; // always extract ID for tap-to-edit
  final Map<String, dynamic> data; // all columns as-is from API

  GrnListRawRow({required this.id, required this.data});
}

class GrnListResponse {
  final bool? success;
  final int? status;
  final String? message;
  final List<GrnListItem> data; // parsed items (for edit navigation)
  final List<GrnListRawRow> rawRows; // dynamic rows for table display
  final List<String> columns; // column headers in order
  final String rawHtml;

  GrnListResponse({
    this.success,
    this.status,
    this.message,
    this.data = const [],
    this.rawRows = const [],
    this.columns = const [],
    this.rawHtml = '',
  });

  factory GrnListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<GrnListItem> items = [];
    List<GrnListRawRow> rawRows = [];
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

        rawRows.add(GrnListRawRow(id: id, data: map));
        items.add(GrnListItem.fromJson(map));
      }
    } else if (rawData is String && rawData.isNotEmpty) {
      html = rawData;
      items = GrnListResponse._parseHtmlTable(rawData);
    }

    return GrnListResponse(
      status: json['status'],
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: items,
      rawRows: rawRows,
      columns: columns,
      rawHtml: html,
    );
  }

  static List<GrnListItem> _parseHtmlTable(String html) {
    final List<GrnListItem> result = [];
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
        result.add(GrnListItem(
          id: int.tryParse(cells[0]) ?? 0,
          GrnNo: cells[1],
          billNo: cells[2],
          GrnDate: cells[3],
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

class GrnListItem {
  final int id;
  final String GrnNo;
  final String billNo;
  final String GrnDate;
  final String partyName;
  final String siteName;
  final String jobType;
  final double totalQty;
  final double totalAmt;
  final String withRateUrl;
  final String withoutRateUrl;

  GrnListItem({
    required this.id,
    required this.GrnNo,
    required this.billNo,
    required this.GrnDate,
    required this.partyName,
    required this.siteName,
    required this.jobType,
    required this.totalQty,
    required this.totalAmt,
    this.withRateUrl = '',
    this.withoutRateUrl = '',
  });

  // ✅ Add this
  factory GrnListItem.fromJson(Map<String, dynamic> json) {
    // ✅ DEBUG — print all keys to find the correct GRN No field name
    if (kDebugMode) print('📋 GrnListItem raw keys: ${json.keys.toList()}');
    if (kDebugMode) print('📋 GrnListItem raw data: $json');

    return GrnListItem(
      id: _parseId(json['ID'] ?? json['id'] ?? json['stockid']),
      GrnNo: json['Grnno']?.toString() ??
          json['grnno']?.toString() ??
          json['GrnNo']?.toString() ??
          json['GrnNo']?.toString() ??
          json['grnno']?.toString() ??
          json['Grnno']?.toString() ??
          json['GRNNo']?.toString() ??
          '',
      billNo: json['BillNo']?.toString() ?? json['billno']?.toString() ?? '',
      GrnDate: json['Grndate']?.toString() ?? json['grndate']?.toString() ?? '',
      partyName: json['PartyName']?.toString() ?? json['partyname']?.toString() ?? '',
      siteName: json['SiteName']?.toString() ?? json['sitename']?.toString() ?? '',
      jobType: (json['JobType']?.toString() ?? json['jobtype']?.toString() ?? '') == 'null'
          ? ''
          : (json['JobType']?.toString() ?? json['jobtype']?.toString() ?? ''),
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

// ── Grn Detail Response ────────────────────────────────────────────────────
class GrnDetailResponse {
  final bool? success;
  final int? status;
  final String? message;
  final GrnDetailData? data;

  GrnDetailResponse({this.success, this.status, this.message, this.data});

  factory GrnDetailResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    GrnDetailData? data;
    if (raw is Map<String, dynamic>) {
      data = GrnDetailData.fromJson(raw);
    } else if (raw is List && raw.isNotEmpty) {
      data = GrnDetailData.fromJson(raw.first as Map<String, dynamic>);
    }
    return GrnDetailResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }
}

class GrnDetailData {
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
  final List<GrnDetailItem> items;
  final String fromaddress;
  final String toaddress;
  final List<GrnOtherItem> grnother;

  GrnDetailData({
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
    this.fromaddress = '',
    this.toaddress = '',
    required this.grnother,
  });

  factory GrnDetailData.fromJson(Map<String, dynamic> json) {

    final rawItems = json['mrnitems'] ?? json['items'] ?? [];
    return GrnDetailData(
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
      fromaddress: json['fromaddress']?.toString() ?? '',
      toaddress: json['toaddress']?.toString() ?? '',
      items: rawItems is List
          ? rawItems
          .map((e) => GrnDetailItem.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      grnother: (json['mrnother'] as List<dynamic>? ?? [])
          .map((e) => GrnOtherItem.fromJson(e as Map<String, dynamic>))
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

class GrnDetailItem {
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

  GrnDetailItem({
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

  factory GrnDetailItem.fromJson(Map<String, dynamic> json) => GrnDetailItem(
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
// ── Grn Dropdown API response ────────────────────────────────────────────────
class GrnDropdownResponse {
  final int? status;
  final bool? success;
  final String? message;
  final List<GrnDropdownOption>? data;

  GrnDropdownResponse({this.status, this.success, this.message, this.data});

  factory GrnDropdownResponse.fromJson(Map<String, dynamic> json) {
    return GrnDropdownResponse(
      status: json['status'],
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => GrnDropdownOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GrnDocument {
  final String id;
  final String fileName;
  final String filePath;
  final String fileType;
  final String fileSize;
  final GrnAttachmentType attachmentType;
  final String source;
  final DateTime uploadedAt;

  GrnDocument({
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
class GrnDropdownOption {
  final String id;
  final String label;

  GrnDropdownOption({required this.id, required this.label});

  factory GrnDropdownOption.fromJson(Map<String, dynamic> json) {
    return GrnDropdownOption(
      id: json['id']?.toString() ?? '',
      label: json['name'] ?? json['label'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      other is GrnDropdownOption && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ── Submit response ────────────────────────────────────────────────────────────
class GrnSubmitResponse {
  final int? status;
  final bool? success; // ✅ add this
  final String? message;
  final String? GrnNumber;

  GrnSubmitResponse({
    this.status,
    this.success, // ✅ add this
    this.message,
    this.GrnNumber,
  });

  factory GrnSubmitResponse.fromJson(Map<String, dynamic> json) {
    return GrnSubmitResponse(
      status: json['status'],
      success: json['success'], // ✅ add this
      message: json['message'],
      GrnNumber: json['Grnno'],
    );
  }
}

// ── Address ────────────────────────────────────────────────────────────────────
class GrnAddress {
  final String label;
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String pincode;

  const GrnAddress({
    required this.label,
    this.line1 = '',
    this.line2 = '',
    this.city = '',
    this.state = '',
    this.pincode = '',
  });

  String get formatted {
    // ✅ If only line1 is set (single-line API address), just return it
    if (line2.isEmpty && city.isEmpty && state.isEmpty && pincode.isEmpty) {
      return line1;
    }
    final parts = [line1, line2, city, state, pincode]
        .where((p) => p.isNotEmpty)
        .toList();
    return parts.join(', ');
  }

  bool get isEmpty => line1.isEmpty && city.isEmpty;
}

class GrnItemDetailResponse {
  final bool? success;
  final int? status;
  final String? message;
  final GrnItemDetail? data;

  GrnItemDetailResponse({this.success, this.status, this.message, this.data});

  factory GrnItemDetailResponse.fromJson(Map<String, dynamic> json) {
    dynamic raw = json['data'];
    GrnItemDetail? detail;
    if (raw is Map<String, dynamic>) {
      detail = GrnItemDetail.fromJson(raw);
    } else if (raw is List && raw.isNotEmpty) {
      detail = GrnItemDetail.fromJson(raw.first as Map<String, dynamic>);
    }
    return GrnItemDetailResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: detail,
    );
  }
}

class GrnItemDetail {
  final double gstpercent;

  GrnItemDetail({required this.gstpercent});

  factory GrnItemDetail.fromJson(Map<String, dynamic> json) {
    return GrnItemDetail(
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


class GrnItemLine {
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

  GrnItemLine({
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
class LedgerAddressRequest {
  final int compid;
  final int partyid;
  final int siteid;

  LedgerAddressRequest({
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
class LedgerAddressResponse {
  final bool? success;
  final int? status;
  final String? message;
  final List<LedgerAddressData> data;

  LedgerAddressResponse({
    this.success,
    this.status,
    this.message,
    this.data = const [],
  });

  factory LedgerAddressResponse.fromJson(Map<String, dynamic> json) {
    return LedgerAddressResponse(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: json['data'] is List
          ? (json['data'] as List)
          .map((e) => LedgerAddressData.fromJson(e))
          .toList()
          : [],
    );
  }
}

class LedgerAddressData {
  final double gstpercent;
  final String fromaddress;
  final String toaddress;

  LedgerAddressData({
    this.gstpercent = 0,
    this.fromaddress = '',
    this.toaddress = '',
  });

  factory LedgerAddressData.fromJson(Map<String, dynamic> json) {
    return LedgerAddressData(
      gstpercent: (json['gstpercent'] ?? 0).toDouble(),
      fromaddress: json['fromaddress']?.toString() ?? '',
      toaddress: json['toaddress']?.toString() ?? '',
    );
  }
}
// ── New model for mrnother rows ─────────────────────────────────────────────
class GrnOtherItem {
  final int accountid;
  final double amount;
  final String nature;
  final double percentage;
  final String dependid;

  const GrnOtherItem({
    required this.accountid,
    required this.amount,
    required this.nature,
    required this.percentage,
    required this.dependid,
  });

  factory GrnOtherItem.fromJson(Map<String, dynamic> json) => GrnOtherItem(
    accountid: (json['accountid'] as num?)?.toInt() ?? 0,
    amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    nature: (json['nature'] as String?) ?? '+',
    percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    dependid: (json['dependid'] as String?) ?? '',
  );
}
