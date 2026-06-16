import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Payment Request Data Model
/// Represents a single payment request with all its details
class PaymentRequestModel {
  int? requestId;
  String? requestNo;
  int? partyId;
  String? partyName;
  String? partyType;
  String? requestType;
  int? branchId;
  String? branchName;
  double? amount;
  String? reason;
  String? refDocNo;
  String? status;
  DateTime? requestDate;
  int? approverId;
  String? approverName;
  String? documentPath;
  String? documentName;
  DateTime? approvedDate;
  String? remarks;

  PaymentRequestModel({
    this.requestId,
    this.requestNo,
    this.partyId,
    this.partyName,
    this.partyType,
    this.requestType,
    this.branchId,
    this.branchName,
    this.amount,
    this.reason,
    this.refDocNo,
    this.status,
    this.requestDate,
    this.approverId,
    this.approverName,
    this.documentPath,
    this.documentName,
    this.approvedDate,
    this.remarks,
  });

  /// Create PaymentRequestModel from JSON response
  factory PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestModel(
      requestId: json['ReqId'],
      requestNo: json['RequestNo'],
      partyName: json['PartyName'],
      branchName: json['SiteName'], // SiteName → branchName
      reason: json['Requestfor'], // Requestfor → reason
      approverName: json['RequestBy'], // RequestBy → approverName
      amount: json['Amount'] != null
          ? double.tryParse(json['Amount'].toString())
          : null,
      status: json['Status'],
      requestDate:
          json['RequestDate'] != null ? _parseDate(json['RequestDate']) : null,
      documentName: json['Document'],
      // Additional fields that might come from API
      partyId: json['PartyId'],
      partyType: json['Partytype'] ?? json['PartyType'],
      requestType: json['RequestType'],
      branchId: json['SiteId'] ?? json['BranchId'],
      refDocNo: json['RefDocNo'],
      approverId: json['ApproverId'],
      documentPath: json['DocumentPath'],
      approvedDate: json['ApprovedDate'] != null
          ? _parseDate(json['ApprovedDate'])
          : null,
      remarks: json['Remarks'],
    );
  }

  /// Helper method to parse date from various formats
  static DateTime? _parseDate(dynamic dateValue) {
    if (dateValue == null) return null;

    try {
      final dateStr = dateValue.toString();

      // Try dd-MM-yyyy format first (from API)
      if (dateStr.contains('-') && dateStr.length == 10) {
        return DateFormat('dd-MM-yyyy').parse(dateStr);
      }

      // Try ISO format
      return DateTime.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  /// Convert PaymentRequestModel to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'requestid': requestId,
      'requestno': requestNo,
      'partyid': partyId,
      'partyname': partyName,
      'partytype': partyType,
      'requesttype': requestType,
      'branchid': branchId,
      'branchname': branchName,
      'amount': amount,
      'reason': reason,
      'refdocno': refDocNo,
      'status': status,
      'requestdate': requestDate?.toIso8601String(),
      'approverid': approverId,
      'approvername': approverName,
      'documentpath': documentPath,
      'documentname': documentName,
      'approveddate': approvedDate?.toIso8601String(),
      'remarks': remarks,
    };
  }

  /// Get status color based on status value
  Color getStatusColor() {
    switch (status?.toLowerCase().trim()) {
      case 'approved':
      case 'approve': // ✅
        return const Color(0xFF2196F3);
      case 'finalised':
        return const Color(0xFF9C27B0);
      case 'paid':
        return const Color(0xFF4CAF50);
      case 'rejected':
      case 'reject': // ✅
        return const Color(0xFFF44336);
      case 'pending':
        return const Color(0xFFFF9800);
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon() {
    switch (status?.toLowerCase().trim()) {
      case 'approved':
      case 'approve': // ✅
        return Icons.thumb_up_alt_rounded;
      case 'finalised':
        return Icons.verified_rounded;
      case 'paid':
        return Icons.check_circle_rounded;
      case 'rejected':
      case 'reject': // ✅
        return Icons.cancel_rounded;
      case 'pending':
        return Icons.access_time_rounded;
      default:
        return Icons.help_outline;
    }
  }

  /// Get formatted amount string
  String getFormattedAmount() {
    if (amount == null) return '₹ 0.00';
    return '₹ ${amount!.toStringAsFixed(2)}';
  }

  /// Get formatted request date
  String getFormattedRequestDate() {
    if (requestDate == null) return 'N/A';
    return DateFormat('dd-MM-yyyy').format(requestDate!);
  }

  /// Get formatted approved date
  String getFormattedApprovedDate() {
    if (approvedDate == null) return 'N/A';
    return DateFormat('dd-MM-yyyy').format(approvedDate!);
  }

  /// Check if request can be cancelled (only pending requests)
  bool canBeCancelled() {
    final s = status?.toLowerCase().trim();
    return s == 'pending';  // only pending can be cancelled
  }

  bool canBeEdited() {
    final s = status?.toLowerCase().trim();
    return s == 'pending';  // only pending can be edited
  }

  /// Create a copy of this model with updated fields
  PaymentRequestModel copyWith({
    int? requestId,
    String? requestNo,
    int? partyId,
    String? partyName,
    String? partyType,
    String? requestType,
    int? branchId,
    String? branchName,
    double? amount,
    String? reason,
    String? refDocNo,
    String? status,
    DateTime? requestDate,
    int? approverId,
    String? approverName,
    String? documentPath,
    String? documentName,
    DateTime? approvedDate,
    String? remarks,
  }) {
    return PaymentRequestModel(
      requestId: requestId ?? this.requestId,
      requestNo: requestNo ?? this.requestNo,
      partyId: partyId ?? this.partyId,
      partyName: partyName ?? this.partyName,
      partyType: partyType ?? this.partyType,
      requestType: requestType ?? this.requestType,
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      refDocNo: refDocNo ?? this.refDocNo,
      status: status ?? this.status,
      requestDate: requestDate ?? this.requestDate,
      approverId: approverId ?? this.approverId,
      approverName: approverName ?? this.approverName,
      documentPath: documentPath ?? this.documentPath,
      documentName: documentName ?? this.documentName,
      approvedDate: approvedDate ?? this.approvedDate,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  String toString() {
    return 'PaymentRequestModel(requestId: $requestId, requestNo: $requestNo, '
        'partyName: $partyName, amount: $amount, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentRequestModel && other.requestId == requestId;
  }

  @override
  int get hashCode => requestId.hashCode;
}
