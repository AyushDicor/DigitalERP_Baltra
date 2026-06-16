import 'package:flutter/foundation.dart';

class MrnQcListRequest {
  final String fromdate;
  final String todate;
  final int compid;
  final int branchid;
  final int userid;
  final int partyid;
  final int siteid;
  final int jobtypeid;
  final String filtertype; // 'Pendingqc' | 'Qclist'

  MrnQcListRequest({
    required this.fromdate,
    required this.todate,
    required this.compid,
    required this.branchid,
    required this.userid,
    this.partyid = 0,
    this.siteid = 0,
    this.jobtypeid = 0,
    required this.filtertype,
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

class MrnQcListItem {
  final int id;
  final String MrnNo;
  final String billNo;
  final String MrnDate;
  final String partyName;
  final String siteName;
  final String jobType;
  final double totalQty;
  final double totalAmt;
  final String withRateUrl;
  final String withoutRateUrl;

  // ── NEW: QC completed fields ──────────────────────────────────────────
  final String qcNo;
  final String qcDate;
  final double grandTotal;
  final String printUrl;   // ← from "printurl" in Qclist response

  MrnQcListItem({
    required this.id,
    required this.MrnNo,
    required this.billNo,
    required this.MrnDate,
    required this.partyName,
    required this.siteName,
    required this.jobType,
    required this.totalQty,
    required this.totalAmt,
    this.withRateUrl = '',
    this.withoutRateUrl = '',
    this.qcNo = '',
    this.qcDate = '',
    this.grandTotal = 0,
    this.printUrl = '',
  });

  factory MrnQcListItem.fromJson(Map<String, dynamic> json) {
    return MrnQcListItem(
      id: _parseId(json['ID'] ?? json['Id'] ?? json['id'] ?? json['stockid']),
      MrnNo: json['Mrnno']?.toString() ??
          json['MrnNo']?.toString() ??
          json['ReceiptNo']?.toString() ??   // ← Qclist uses ReceiptNo
          json['MRNNo']?.toString() ??
          json['mrnno']?.toString() ??
          '',
      billNo: json['BillNo']?.toString() ?? json['billno']?.toString() ?? '',
      MrnDate: json['Mrndate']?.toString() ?? json['mrndate']?.toString() ?? '',
      partyName: json['PartyName']?.toString() ?? json['partyname']?.toString() ?? '',
      siteName: json['SiteName']?.toString() ?? json['sitename']?.toString() ?? '',
      jobType: json['JobType']?.toString() ?? json['jobtype']?.toString() ?? '',
      totalQty: _parseDouble(json['TotalQty'] ?? json['totalqty']),
      totalAmt: _parseDouble(json['TotalAmt'] ?? json['totalamt']),
      withRateUrl: json['withrateurl']?.toString() ?? '',
      withoutRateUrl: json['withOUTrateurl']?.toString() ?? '',
      // ── NEW ──────────────────────────────────────────────────────────
      qcNo: json['QcNo']?.toString() ?? json['qcno']?.toString() ?? '',
      qcDate: json['QcDate']?.toString() ?? json['qcdate']?.toString() ?? '',
      grandTotal: _parseDouble(json['GrandTotal'] ?? json['grandtotal']),
      printUrl: json['printurl']?.toString() ?? '',
    );
  }

  static int _parseId(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    return int.tryParse(v.toString().split('.')[0]) ?? 0;
  }

  static double _parseDouble(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }
}

class MrnQcListRawRow {
  final int id;
  final Map<String, dynamic> data;
  MrnQcListRawRow({required this.id, required this.data});
}

class MrnQcListResponse {
  final bool? success;
  final int? status;
  final String? message;
  final List<MrnQcListItem> data;
  final List<MrnQcListRawRow> rawRows;
  final List<String> columns;
  final String rawHtml;

  MrnQcListResponse({
    this.success,
    this.status,
    this.message,
    this.data = const [],
    this.rawRows = const [],
    this.columns = const [],
    this.rawHtml = '',
  });

  factory MrnQcListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    List<MrnQcListItem> items = [];
    List<MrnQcListRawRow> rawRows = [];
    List<String> columns = [];
    String html = '';

    if (rawData is List && rawData.isNotEmpty) {
      columns = (rawData.first as Map<String, dynamic>).keys.toList();
      for (final row in rawData) {
        final map = row as Map<String, dynamic>;
        final rawId = map['ID'] ?? map['id'] ?? map['stockid'] ?? 0;
        final int id;
        if (rawId is double) {
          id = rawId.toInt();
        } else if (rawId is int) {
          id = rawId;
        } else {
          id = int.tryParse(rawId.toString().split('.')[0]) ?? 0;
        }
        rawRows.add(MrnQcListRawRow(id: id, data: map));
        items.add(MrnQcListItem.fromJson(map));
      }
    } else if (rawData is String && rawData.isNotEmpty) {
      html = rawData;
      items = _parseHtmlTable(rawData);
    }

    return MrnQcListResponse(
      success: json['success'] ?? false,
      status: json['status'],
      message: json['message'] ?? '',
      data: items,
      rawRows: rawRows,
      columns: columns,
      rawHtml: html,
    );
  }

  static List<MrnQcListItem> _parseHtmlTable(String html) {
    final List<MrnQcListItem> result = [];
    try {
      final tbodyMatch =
      RegExp(r'<tbody>(.*?)</tbody>', dotAll: true).firstMatch(html);
      if (tbodyMatch == null) return result;
      final rowMatches =
      RegExp(r'<tr>(.*?)</tr>', dotAll: true).allMatches(tbodyMatch.group(1)!);
      for (final row in rowMatches) {
        final cells = RegExp(r'<td>(.*?)</td>', dotAll: true)
            .allMatches(row.group(1)!)
            .map((m) => m.group(1)?.trim() ?? '')
            .toList();
        if (cells.length < 9) continue;
        result.add(MrnQcListItem(
          id: int.tryParse(cells[0]) ?? 0,
          MrnNo: cells[1],
          billNo: cells[2],
          MrnDate: cells[3],
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

// ══════════════════════════════════════════════════════════════════════════════
// DETAIL  —  /api/mrnandqcdetail
// ══════════════════════════════════════════════════════════════════════════════

class MrnQcDetailRequest {
  final int compid;
  final int branchid;
  final int documentid;
  final String documentname;

  const MrnQcDetailRequest({
    required this.compid,
    required this.branchid,
    required this.documentid,
    this.documentname = 'mrn',
  });

  Map<String, dynamic> toJson() => {
    'compid': compid,
    'branchid': branchid,
    'documentid': documentid,
    'documentname': documentname,
  };
}

class MrnQcItem {
  final int transid;
  final String itemname;
  final int itemid;
  final double actualqty;
  final double receiveqty;
  final double rejectedqty;
  final double rate;
  final double amount;
  final String description;
  final String reason;

  const MrnQcItem({
    required this.transid,
    required this.itemname,
    required this.itemid,
    required this.actualqty,
    required this.receiveqty,
    required this.rejectedqty,
    required this.rate,
    required this.amount,
    required this.description,
    required this.reason,
  });

  factory MrnQcItem.fromJson(Map<String, dynamic> json) => MrnQcItem(
    transid: json['transid'] ?? 0,
    itemname: json['itemname'] ?? '',
    itemid: json['itemid'] ?? 0,
    actualqty: _pd(json['actualqty']),
    receiveqty: _pd(json['receiveqty']),
    rejectedqty: _pd(json['rejectedqty']),
    rate: _pd(json['rate']),
    amount: _pd(json['amount']),
    description: json['description'] ?? '',
    reason: json['reason'] ?? '',
  );

  // shared safe parser — used by MrnQcDetail.fromJson too
  static double _pd(dynamic v) {
    if (v == null) return 0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  Map<String, dynamic> toJson() => {
    'transid': transid,
    'itemname': itemname,
    'itemid': itemid,
    'actualqty': actualqty,
    'receiveqty': receiveqty,
    'rejectedqty': rejectedqty,
    'rate': rate,
    'amount': amount,
    'description': description,
    'reason': reason,
  };

  MrnQcItem copyWith({
    double? receiveqty,
    double? rejectedqty,
    String? reason,
  }) =>
      MrnQcItem(
        transid: transid,
        itemname: itemname,
        itemid: itemid,
        actualqty: actualqty,
        receiveqty: receiveqty ?? this.receiveqty,
        rejectedqty: rejectedqty ?? this.rejectedqty,
        rate: rate,
        amount: amount,
        description: description,
        reason: reason ?? this.reason,
      );
}

class MrnQcDetail {
  final int qcid;
  final String receiptno;
  final String partyname;
  final int partyid;
  final String qcno;
  final DateTime? qcdate;
  final String checkedby;
  final String reamarks;
  final int stockid;
  final double totalqty;
  final double totalamt;
  final double grandtotal;
  final int compid;
  final int branchid;
  final int userid;
  final String? yearid;
  final DateTime receiptdate;
  final int siteid;
  final int jobtypeid;
  final String billno;
  final int godownid;
  List<MrnQcItem> qcitems; // mutable: patched in-memory per item save

  MrnQcDetail({
    required this.qcid,
    required this.receiptno,
    required this.partyname,
    required this.partyid,
    required this.qcno,
    this.qcdate,
    required this.checkedby,
    required this.reamarks,
    required this.stockid,
    required this.totalqty,
    required this.totalamt,
    required this.grandtotal,
    required this.compid,
    required this.branchid,
    required this.userid,
    this.yearid,
    required this.receiptdate,
    required this.siteid,
    required this.jobtypeid,
    required this.billno,
    required this.godownid,
    required this.qcitems,
  });

  factory MrnQcDetail.fromJson(Map<String, dynamic> json) => MrnQcDetail(
    qcid: json['qcid'] ?? 0,
    receiptno: json['receiptno'] ?? '',
    partyname: json['partyname'] ?? '',
    partyid: json['partyid'] ?? 0,
    qcno: json['qcno'] ?? '',
    qcdate: json['qcdate'] != null
        ? DateTime.tryParse(json['qcdate'].toString())
        : null,
    checkedby: json['checkedby'] ?? '',
    reamarks: json['reamarks'] ?? '',
    stockid: json['stockid'] ?? 0,
    totalqty: MrnQcItem._pd(json['totalqty']),
    totalamt: MrnQcItem._pd(json['totalamt']),
    grandtotal: MrnQcItem._pd(json['grandtotal']),
    compid: json['compid'] ?? 0,
    branchid: json['branchid'] ?? 0,
    userid: json['userid'] ?? 0,
    yearid: json['yearid']?.toString(),
    receiptdate:
    DateTime.tryParse(json['receiptdate']?.toString() ?? '') ??
        DateTime.now(),
    siteid: json['siteid'] ?? 0,
    jobtypeid: json['jobtypeid'] ?? 0,
    billno: json['billno'] ?? '',
    godownid: json['godownid'] ?? 0,
    qcitems: (json['qcitems'] as List? ?? [])
        .map((e) => MrnQcItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

class MrnQcDetailResponse {
  final bool success;
  final MrnQcDetail? data;
  final String? message;
  final int status;

  MrnQcDetailResponse({
    required this.success,
    this.data,
    this.message,
    required this.status,
  });

  factory MrnQcDetailResponse.fromJson(Map<String, dynamic> json) {
    MrnQcDetail? detail;
    if (json['data'] is Map<String, dynamic>) {
      detail = MrnQcDetail.fromJson(json['data'] as Map<String, dynamic>);
    }
    return MrnQcDetailResponse(
      success: json['success'] ?? false,
      data: detail,
      message: json['message'],
      status: json['status'] ?? 0,
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SAVE  —  /api/saveqcentry
// ══════════════════════════════════════════════════════════════════════════════

class SaveQcEntryRequest {
  final int qcid;
  final String receiptno;
  final String partyname;
  final int partyid;
  final String qcno;
  final DateTime qcdate;
  final String checkedby;
  final String reamarks;
  final int stockid;
  final double totalqty;
  final double totalamt;
  final double grandtotal;
  final int compid;
  final int branchid;
  final int userid;
  final String yearid;
  final DateTime receiptdate;
  final int siteid;
  final int jobtypeid;
  final String billno;
  final int godownid;
  final List<MrnQcItem> qcitems;

  const SaveQcEntryRequest({
    required this.qcid,
    required this.receiptno,
    required this.partyname,
    required this.partyid,
    required this.qcno,
    required this.qcdate,
    required this.checkedby,
    required this.reamarks,
    required this.stockid,
    required this.totalqty,
    required this.totalamt,
    required this.grandtotal,
    required this.compid,
    required this.branchid,
    required this.userid,
    required this.yearid,
    required this.receiptdate,
    required this.siteid,
    required this.jobtypeid,
    required this.billno,
    required this.godownid,
    required this.qcitems,
  });

  Map<String, dynamic> toJson() => {
    'qcid': qcid,
    'receiptno': receiptno,
    'partyname': partyname,
    'partyid': partyid,
    'qcno': qcno,
    'qcdate': qcdate.toIso8601String(),
    'checkedby': checkedby,
    'reamarks': reamarks,
    'stockid': stockid,
    'totalqty': totalqty,
    'totalamt': totalamt,
    'grandtotal': grandtotal,
    'compid': compid,
    'branchid': branchid,
    'userid': userid,
    'yearid': yearid,
    'receiptdate': receiptdate.toIso8601String(),
    'siteid': siteid,
    'jobtypeid': jobtypeid,
    'billno': billno,
    'godownid': godownid,
    'qcitems': qcitems.map((e) => e.toJson()).toList(),
  };
}

class SaveQcEntryResponse {
  final bool success;
  final String? message;
  final int status;

  SaveQcEntryResponse({
    required this.success,
    this.message,
    required this.status,
  });

  factory SaveQcEntryResponse.fromJson(Map<String, dynamic> json) =>
      SaveQcEntryResponse(
        success: json['success'] ?? false,
        message: json['message'],
        status: json['status'] ?? 0,
      );
}