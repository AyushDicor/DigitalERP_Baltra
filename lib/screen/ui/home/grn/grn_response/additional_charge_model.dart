// ── grn_controller/additional_charge_model.dart ───────────────────────────────

import 'package:flutter_alice/core/alice_core.dart';

enum ChargeNature { plus, less }
enum ChargeCalcType { fixed, percentage }

// ─────────────────────────────────────────────────────────────────────────────
// Charge head fetched from Otherdetail API.
//
// taxPercent > 0  →  percentage is LOCKED (read-only). calcType is forced to
//                    ChargeCalcType.percentage and the value field is locked.
// taxPercent == 0 →  user freely picks calcType and types the value.
// ─────────────────────────────────────────────────────────────────────────────
class AdditionalChargeHead {
  final String id;
  final String accountId;
  final String label;
  final double taxPercent;

  const AdditionalChargeHead({
    required this.id,
    this.accountId = '',
    required this.label,
    this.taxPercent = 0,
  });

  factory AdditionalChargeHead.fromJson(Map<String, dynamic> json) =>
      AdditionalChargeHead(
        id: json['acoountid']?.toString() ?? json['id']?.toString() ?? '',
        label: json['headname']?.toString() ?? json['label']?.toString() ?? '',
        // TODO(backend): confirm the exact key — 'taxpercent', 'percent', etc.
        taxPercent: double.tryParse(
          json['taxpercent']?.toString() ??
              json['tax_percent']?.toString() ??
              json['percent']?.toString() ??
              '0',
        ) ??
            0,
      );

  Map<String, dynamic> toJson() => {
    'accountid': id,
    'headname': label,
    'taxpercent': taxPercent,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AdditionalChargeHead && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// ─────────────────────────────────────────────────────────────────────────────
// One additional charge row.
//
// Calculation rules
// ─────────────────
// PERCENTAGE mode
//   dependsOnLocalId == null  →  base = item subtotal
//   dependsOnLocalId != null  →  base = that charge's calculatedAmount
//   calculatedAmount = (value / 100) * base
//
// FIXED mode
//   dependsOnLocalId == null  →  calculatedAmount = value
//   dependsOnLocalId != null  →  calculatedAmount = value + base
//                                 where base = dependsOn.calculatedAmount
//
// nature == plus   →  row is an addition
// nature == less   →  row is a deduction
// ─────────────────────────────────────────────────────────────────────────────
class AdditionalCharge {
  final String localId;

  AdditionalChargeHead? head;
  ChargeNature nature;

  /// fixed      → value is a ₹ amount typed by the user (locked when
  ///              dependsOnLocalId is set — amount auto = value + base).
  /// percentage → value is a % figure; amount auto-computed.
  ///              LOCKED when head.taxPercent > 0.
  ChargeCalcType calcType;

  /// The raw number the user (or API) supplied.
  double value;

  /// If set:
  ///   percentage → percent applied to this charge's calculatedAmount
  ///   fixed      → fixed value is ADDED ON TOP of this charge's amount
  String? dependsOnLocalId;
  String? dependsOnLabel;
  String? dependsOnAccountId;

  /// Filled in by the recalculation engine — never set directly.
  double calculatedAmount = 0.0;

  AdditionalCharge({
    required this.localId,
    this.head,
    this.nature = ChargeNature.plus,
    this.calcType = ChargeCalcType.fixed,
    this.value = 0.0,
    this.calculatedAmount = 0.0,
    this.dependsOnLocalId,
    this.dependsOnLabel,
    this.dependsOnAccountId,
  });

  // ── Lock helpers ────────────────────────────────────────────────────────────

  /// True when the API supplied a fixed taxPercent → percent field is
  /// read-only and calcType is forced to percentage.
  bool get isPercentLocked =>
      head != null &&
          head!.taxPercent > 0 &&
          calcType == ChargeCalcType.percentage;

  /// True when the amount is auto-derived (not freely typed).
  /// Percentage rows are always auto-computed.
  /// Fixed rows are auto-computed only when dependsOnLocalId is set
  /// (calculatedAmount = value + dependsOn.amount).
  bool get isAmountAutoComputed => calcType == ChargeCalcType.percentage;

  // ── Copy ───────────────────────────────────────────────────────────────────
  AdditionalCharge copyWith({
    AdditionalChargeHead? head,
    ChargeNature? nature,
    ChargeCalcType? calcType,
    double? value,
    String? dependsOnLocalId,
    String? dependsOnLabel,
    String? dependsOnAccountId,
  }) =>
      AdditionalCharge(
        localId: localId,
        head: head ?? this.head,
        nature: nature ?? this.nature,
        calcType: calcType ?? this.calcType,
        value: value ?? this.value,
        dependsOnLocalId: dependsOnLocalId ?? this.dependsOnLocalId,
        dependsOnLabel: dependsOnLabel ?? this.dependsOnLabel,
        dependsOnAccountId : dependsOnAccountId ?? this.dependsOnAccountId,
      );

  // ── API serialisation ──────────────────────────────────────────────────────
  /// Used in the GRN submit payload.
  /// TODO(backend): confirm field names with backend team.
  Map<String, dynamic> toApiJson() => {
    'accountid': int.tryParse(head?.id ?? '0') ?? 0,
    'amount': calculatedAmount,
    'nature': nature == ChargeNature.plus ? '+' : '-',
    'percentage': calcType == ChargeCalcType.percentage ? value : 0.0,
    'dependid'   : dependsOnAccountId ?? '0',
  };

  // ── Prefill from edit detail API ────────────────────────────────────────────
  /// TODO(backend): call this once the detail API returns additional charges.
  /// Expected JSON shape per charge row:
  /// {
  ///   "headid"    : 5,
  ///   "headname"  : "Freight",
  ///   "taxpercent": 0,
  ///   "nature"    : "+",           // "+" or "-"
  ///   "calctype"  : "fixed",       // "fixed" or "percentage"
  ///   "value"     : 200.0,
  ///   "amount"    : 200.0,
  ///   "dependsid" : "0"            // "0" means no dependency
  /// }
  factory AdditionalCharge.fromEditJson(
      Map<String, dynamic> json, {
        required List<AdditionalChargeHead> headList,
        required List<AdditionalCharge> alreadyAdded,
      }) {
    final headId = json['accountid']?.toString() ?? '';
    final head = headList.  firstWhereOrNull((h) => h.id == headId);

    final natureStr = json['nature']?.toString() ?? '+';
    final calcTypeStr = json['calctype']?.toString() ?? 'fixed';
    final dependsIdStr = json['dependsid']?.toString() ?? '0';

    // Resolve dependsOnLabel from already-added charges
    final depCharge = dependsIdStr != '0'
        ? alreadyAdded.firstWhereOrNull((c) => c.localId == dependsIdStr)
        : null;

    final charge = AdditionalCharge(
      localId: DateTime.now().microsecondsSinceEpoch.toString(),
      head: head ??
          AdditionalChargeHead(
            id: headId,
            label: json['headname']?.toString() ?? '',
            taxPercent: double.tryParse(
                json['taxpercent']?.toString() ?? '0') ??
                0,
          ),
      nature: natureStr == '+' ? ChargeNature.plus : ChargeNature.less,
      calcType:
      calcTypeStr == 'percentage' ? ChargeCalcType.percentage : ChargeCalcType.fixed,
      value: double.tryParse(json['value']?.toString() ?? '0') ?? 0,
      dependsOnLocalId: dependsIdStr != '0' ? dependsIdStr : null,
      dependsOnLabel: depCharge?.head?.label,
    );

    return charge;
  }
}