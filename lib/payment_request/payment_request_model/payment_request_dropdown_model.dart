// payment_request_model/payment_request_dropdown_model.dart

class PaymentRequestDropdownResponse {
  final bool? success;
  final String? message;
  final int? status;
  final List<PaymentRequestDropdownItem>? data;

  PaymentRequestDropdownResponse({this.success, this.message, this.status, this.data});

  factory PaymentRequestDropdownResponse.fromJson(Map<String, dynamic> json) {
    return PaymentRequestDropdownResponse(
      success: json['success'],
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => PaymentRequestDropdownItem.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}

class PaymentRequestDropdownItem {
  final String? id;      // Keep as String because API returns "47", "48", etc.
  final String? name;

  PaymentRequestDropdownItem({this.id, this.name});
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PaymentRequestDropdownItem && other.id == id;

  @override
  int get hashCode => id.hashCode;

  factory PaymentRequestDropdownItem.fromJson(Map<String, dynamic> json) {
    return PaymentRequestDropdownItem(
      id: (json['id'] ?? json['Id'] ?? '').toString(),
      name: json['name'] ?? json['Name'] ?? '',
    );
  }

  // Helper to convert to int when sending to API
  int get safeId => int.tryParse(id ?? '0') ?? 0;

  String get displayName => name ?? '';
}
