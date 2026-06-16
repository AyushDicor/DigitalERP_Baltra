import 'dart:convert';

ApprovalsListResponse approvalListResponseFromJson(String str) =>
    ApprovalsListResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String approvalListResponseToJson(ApprovalsListResponse data) =>
    json.encode(data.toJson());

//  Response wrapper 

class ApprovalsListResponse {
  final bool?   success;
  final num?    status;
  final String? message;
  final List<ApprovalListData>? data;
  final CardConfig? cardConfig;

  const ApprovalsListResponse({
    this.success,
    this.status,
    this.message,
    this.data,
    this.cardConfig,
  });

  factory ApprovalsListResponse.fromJson(Map<String, dynamic> json) {
    return ApprovalsListResponse(
      success:    json['success']  as bool?,
      status:     json['status']   as num?,
      message:    json['message']  as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ApprovalListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Use CardConfig.fromJson if backend sends config, else null
      cardConfig: json['card_config'] != null
          ? CardConfig.fromJson(json['card_config'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success':     success,
    'status':      status,
    'message':     message,
    'data':        data?.map((e) => e.toJson()).toList(),
    'card_config': cardConfig?.toJson(),
  };
}

//  Row data 

class ApprovalListData {
  final String? approvalType;
  final int?    documentId;
  final String? documentNo;
  final String? documentDate;
  final String? dueDate;
  final String? status;
  final num?    quantity;
  final num?    amount;
  final String? requestedBy;
  final String? siteName;
  final String? remarks;
  final String? subType;
  final int?    navigateId;
  final String? approvalTypeCode;
  final String? partyName;
  String? get documentname => approvalType;
  /// was: documentno → now: documentNo
  String? get documentno => documentNo;
  /// was: approvalid → now: documentId
  int? get approvalid => documentId;
  /// was: totalamount → now: amount as String
  String? get totalamount => amount?.toString();
  /// was: partyname → maps to requestedBy (closest equivalent)
  String? get partyname => requestedBy;
  /// was: clintname → maps to siteName (closest equivalent)
  String? get clintname => siteName;
  /// was: lastremark → maps to remarks
  String? get lastremark => remarks;
  /// was: execuname — no direct equivalent, return null gracefully
  String? get execuname => null;

  const ApprovalListData({
    this.approvalType,
    this.documentId,
    this.documentNo,
    this.documentDate,
    this.dueDate,
    this.status,
    this.quantity,
    this.amount,
    this.requestedBy,
    this.siteName,
    this.remarks,
    this.subType,
    this.navigateId,
    this.approvalTypeCode,
    this.partyName,


  });

  factory ApprovalListData.fromJson(Map<String, dynamic> json) =>
      ApprovalListData(
        approvalType: json['ApprovalType'] as String?,
        documentId:   json['DocumentId']   as int?,
        documentNo:   json['DocumentNo']   as String?,
        documentDate: json['DocumentDate'] as String?,
        dueDate:      json['DueDate']      as String?,
        status:       json['Status']       as String?,
        quantity:     json['Quantity']     as num?,
        amount:       json['Amount']       as num?,
        requestedBy:  json['RequestedBy']  as String?,
        siteName:     json['SiteName']     as String?,
        remarks:      json['Remarks']      as String?,
        subType:      json['SubType']      as String?,
        navigateId:   json['NavigateId']   as int?,
        approvalTypeCode: json['ApprovalTypeCode'] as String?,
        partyName: json['PartyName'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'ApprovalType': approvalType,
    'DocumentId':   documentId,
    'DocumentNo':   documentNo,
    'DocumentDate': documentDate,
    'DueDate':      dueDate,
    'Status':       status,
    'Quantity':     quantity,
    'Amount':       amount,
    'RequestedBy':  requestedBy,
    'SiteName':     siteName,
    'Remarks':      remarks,
    'SubType':      subType,
    'NavigateId':   navigateId,
    'ApprovalTypeCode': approvalTypeCode,
    'PartyName': partyName,
  };

  /// Used by CardConfig/FieldConfig to render dynamic card fields.
  /// Keys here must match FieldConfig.key values exactly.
  Map<String, String> toDisplayMap() => {
    'approvalType': approvalType ?? '',
    'documentNo':   documentNo   ?? '',
    'documentDate': documentDate ?? '',
    'dueDate':      dueDate      ?? '',
    'status':       status       ?? '',
    'quantity':     quantity?.toString() ?? '',
    'amount':       amount?.toString()   ?? '',
    'requestedBy':  requestedBy  ?? '',
    'siteName':     siteName     ?? '',
    'remarks':      remarks      ?? '',
    'subType':      subType      ?? '',
    'partyName': partyName ?? '',
  };
}

//  Card config 

class CardConfig {
  final List<FieldConfig> headerFields;
  final List<FieldConfig> mainFields;
  final List<FieldConfig> expandedFields;
  final bool showPdf;
  final bool showStatus;
  final bool showDate;

  const CardConfig({
    this.headerFields    = const [],
    this.mainFields      = const [],
    this.expandedFields  = const [],
    this.showPdf         = true,
    this.showStatus      = true,
    this.showDate        = true,
  });

  factory CardConfig.fromJson(Map<String, dynamic> json) => CardConfig(
    headerFields:   _parseFields(json['header_fields']),
    mainFields:     _parseFields(json['main_fields']),
    expandedFields: _parseFields(json['expanded_fields']),
    showPdf:    json['show_pdf']    as bool? ?? true,
    showStatus: json['show_status'] as bool? ?? true,
    showDate:   json['show_date']   as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'header_fields':   headerFields.map((e)   => e.toJson()).toList(),
    'main_fields':     mainFields.map((e)     => e.toJson()).toList(),
    'expanded_fields': expandedFields.map((e) => e.toJson()).toList(),
    'show_pdf':    showPdf,
    'show_status': showStatus,
    'show_date':   showDate,
  };

  /// Fallback when backend sends no card_config.
  /// Keys must match ApprovalListData.toDisplayMap() keys.
  factory CardConfig.defaultConfig() => const CardConfig(
    headerFields: [
      FieldConfig(key: 'documentNo', label: 'Doc No.'),
    ],
    mainFields: [
      FieldConfig(key: 'requestedBy', label: 'Requested By'),
      FieldConfig(key: 'amount',      label: 'Amount'),
    ],
    expandedFields: [
      FieldConfig(key: 'approvalType', label: 'Type'),
      FieldConfig(key: 'siteName',     label: 'Site'),
      FieldConfig(key: 'remarks',      label: 'Remarks'),
    ],
    showPdf:    true,
    showStatus: true,
    showDate:   true,
  );

  static List<FieldConfig> _parseFields(dynamic raw) {
    if (raw == null) return [];
    return (raw as List<dynamic>)
        .map((e) => FieldConfig.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

//  Field config 

class FieldConfig {
  final String key;     // must match a key in ApprovalListData.toDisplayMap()
  final String label;
  final bool   visible;

  const FieldConfig({
    required this.key,
    required this.label,
    this.visible = true,
  });

  factory FieldConfig.fromJson(Map<String, dynamic> json) => FieldConfig(
    key:     json['key']     as String,
    label:   json['label']   as String,
    visible: json['visible'] as bool? ?? true,
  );

  Map<String, dynamic> toJson() => {
    'key':     key,
    'label':   label,
    'visible': visible,
  };
}