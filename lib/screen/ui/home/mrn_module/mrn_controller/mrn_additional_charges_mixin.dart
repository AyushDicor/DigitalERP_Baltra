// ── Mrn_additional_charges_mixin.dart ────────────────────────────────────────
// Drop this mixin onto MrnController to add full Additional Charges logic.
//
// USAGE — in Mrn_controller.dart:
//   class MrnController extends AppBaseController
//       with MrnAdditionalChargesMixin {
//
// Then call `_fetchAllDropdowns()` to include `fetchChargeHeads()`.

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../../../utils/show_message.dart';

// ignore: depend_on_referenced_packages
import 'package:digitalerp/utils/app_constant_new.dart';

import '../../grn/grn_response/additional_charge_model.dart';
import '../mrn_response/mrn_models.dart';



mixin MrnAdditionalChargesMixin on GetxController {
  // ── State ──────────────────────────────────────────────────────────────────
  List<AdditionalChargeHead> chargeHeadList = [];
  bool isLoadingChargeHeads = false;

  List<AdditionalCharge> additionalCharges = [];

  // ── Derived totals ─────────────────────────────────────────────────────────
  double additionalChargesTotal = 0.0; // net (+/-)
  double additionalChargesGross = 0.0; // sum of + rows
  double additionalChargesDeduct = 0.0; // sum of − rows

  // ── Host controller must provide these ────────────────────────────────────
  double get subtotal;
  double get grandTotal;

  // ── Fetch charge heads ─────────────────────────────────────────────────────
  /// Calls the 'Otherdetail' dropdown API and maps results into
  /// [chargeHeadList].  The mixin delegates to the host controller's
  /// `fetchTax()` because the host owns the `api` reference.
  ///
  /// Override or extend in the host if needed.
  Future<void> fetchChargeHeads() => fetchTax();

  // This must be implemented in the host (MrnController).
  // It calls api.getMrnDropdownList(_MrnDropdownBody('Otherdetail')) and
  // populates [chargeHeadList].
  Future<void> fetchTax();

  // ── TODO(backend): fetch exact percentage for a head ──────────────────────
  /// Once your backend provides an endpoint like:
  ///   POST /getchargeheaddetail  { headid, compid, branchid }
  ///   → { percent: 18.0 }
  ///
  /// Uncomment and implement:
  // Future<double?> _fetchPercentForHead(String headId) async {
  //   try {
  //     final res = await api.getChargeHeadDetail({
  //       'headid'  : int.tryParse(headId) ?? 0,
  //       'compid'  : homeController.currentUserData?.compId ?? 0,
  //       'branchid': homeController.currentUserData?.branchId ?? 0,
  //     });
  //     if ((res.status == 200 || res.success == true) && res.data != null) {
  //       return res.data!['percent'] as double?;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) print('⚠️ fetchPercentForHead error: $e');
  //   }
  //   return null;
  // }

  // ── CRUD ───────────────────────────────────────────────────────────────────
  void addAdditionalCharge() {
    additionalCharges.add(
      AdditionalCharge(
        localId: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    );
    _recalculateCharges();
    update();
  }

  void updateAdditionalCharge(AdditionalCharge updated) {
    final idx =
    additionalCharges.indexWhere((c) => c.localId == updated.localId);
    if (idx != -1) {
      additionalCharges[idx] = updated;
      _recalculateCharges();
      update();
    }
  }
  // Add alongside the other public methods
  void resetAdditionalCharges() {
    additionalCharges.clear();
    _recalculateCharges(); // called from within the mixin — valid ✅
  }

  void prefillAdditionalChargesFromOther(List<MrnOtherItem> others) {
    additionalCharges.clear();

    for (final o in others) {
      // ── Match head by accountid ──────────────────────────────────────────
      final head = chargeHeadList.firstWhereOrNull(
            (h) => h.id == o.accountid.toString(),
      );

      if (kDebugMode) {
        print('🔍 Prefill: accountid=${o.accountid} → head=${head?.label ?? "NOT FOUND"} | dependid="${o.dependid}"');
      }

      final nature = (o.nature == '+' || o.nature.toLowerCase() == 'plus')
          ? ChargeNature.plus
          : ChargeNature.less;

      final calcType = o.percentage > 0
          ? ChargeCalcType.percentage
          : ChargeCalcType.fixed;

      final value = calcType == ChargeCalcType.percentage
          ? o.percentage
          : o.amount;

      // ── Resolve dependsOn by matching accountid of ALREADY-ADDED charges ─
      // dependid from API is the accountid of the charge this row depends on.
      // We need to find the localId of that already-added charge.
      String? dependsOnLocalId;
      String? dependsOnLabel;

      if (o.dependid.isNotEmpty && o.dependid != '0') {
        // Find the previously added charge whose head.id == dependid
        final depCharge = additionalCharges.firstWhereOrNull(
              (c) => c.head?.id == o.dependid,
        );
        if (depCharge != null) {
          dependsOnLocalId = depCharge.localId;
          dependsOnLabel = depCharge.head?.label ?? 'Previous charge';
        } else {
          // Head not found in already-added list (shouldn't happen if API order is correct)
          // Store the accountid as a fallback label
          dependsOnLocalId = null;
          dependsOnLabel = null;
          if (kDebugMode) {
            print('⚠️  dependid="${o.dependid}" not found in already-added charges');
          }
        }
      }

      final localId = '${DateTime.now().millisecondsSinceEpoch}_${additionalCharges.length}';

      additionalCharges.add(
        AdditionalCharge(
          localId: localId,
          head: head,
          nature: nature,
          calcType: calcType,
          value: value,
          dependsOnLocalId: dependsOnLocalId,
          dependsOnLabel: dependsOnLabel,
          dependsOnAccountId: (o.dependid.isNotEmpty && o.dependid != '0')
              ? o.dependid
              : null,
        ),
      );
    }

    _recalculateCharges();
    update();
  }



  void removeAdditionalCharge(String localId) {
    additionalCharges.removeWhere((c) => c.localId == localId);
    // Clear dangling dependencies pointing to the deleted charge.
    for (final c in additionalCharges) {
      if (c.dependsOnLocalId == localId) {
        c.dependsOnLocalId = null;
        c.dependsOnLabel = null;
      }
    }
    _recalculateCharges();
    update();
  }

  // ── Prefill from edit detail API ───────────────────────────────────────────
  /// TODO(backend): call this from `_applyMrnDetail` once the edit API
  /// returns an `additionalcharges` (or similar) list.
  ///
  /// Example call inside _applyMrnDetail:
  ///   if (d.additionalCharges.isNotEmpty) {
  ///     prefillAdditionalCharges(d.additionalCharges);
  ///   }
  ///
  /// [jsonList] shape — list of maps, each matching
  /// AdditionalCharge.fromEditJson's expected format:
  /// [
  ///   { "headid":5, "headname":"Freight", "taxpercent":0,
  ///     "nature":"+", "calctype":"fixed", "value":200.0,
  ///     "amount":200.0, "dependsid":"0" },
  ///   ...
  /// ]
  void prefillAdditionalCharges(List<Map<String, dynamic>> jsonList) {
    additionalCharges.clear();
    for (final json in jsonList) {
      final charge = AdditionalCharge.fromEditJson(
        json,
        headList: chargeHeadList,
        alreadyAdded: List.unmodifiable(additionalCharges),
      );
      additionalCharges.add(charge);
    }
    _recalculateCharges();
    update();
  }

  // ── Recalculation engine ───────────────────────────────────────────────────
  /// Processes all charges in order, resolving bases and populating
  /// `calculatedAmount` on every row.
  ///
  /// PERCENTAGE mode
  ///   dependsOnLocalId == null  →  base = item subtotal
  ///   dependsOnLocalId != null  →  base = abs(that charge's signed amount)
  ///   calculatedAmount = (value / 100) * base
  ///
  /// FIXED mode
  ///   dependsOnLocalId == null  →  calculatedAmount = value
  ///   dependsOnLocalId != null  →  calculatedAmount = value + base
  ///                                 (fixed amount stacked on top of dependency)
  void _recalculateCharges() {
    // localId → signed amount (positive for +, negative for −)
    final Map<String, double> resolved = {};
    final baseAmount = subtotal;

    for (final charge in additionalCharges) {
      double base = baseAmount;

      if (charge.dependsOnLocalId != null &&
          resolved.containsKey(charge.dependsOnLocalId)) {
        base = resolved[charge.dependsOnLocalId]!.abs();
      }

      if (charge.calcType == ChargeCalcType.percentage) {
        // Percentage of base
        charge.calculatedAmount = (charge.value / 100.0) * base;
      } else {
        // Fixed — if depends on something, stack on top; otherwise standalone

          charge.calculatedAmount = charge.value;
      }

      // Store signed for dependency resolution of subsequent rows
      final signedAmt = charge.nature == ChargeNature.plus
          ? charge.calculatedAmount
          : -charge.calculatedAmount;
      resolved[charge.localId] = signedAmt;
    }

    // Aggregate totals
    additionalChargesGross = additionalCharges
        .where((c) => c.nature == ChargeNature.plus)
        .fold(0.0, (s, c) => s + c.calculatedAmount);

    additionalChargesDeduct = additionalCharges
        .where((c) => c.nature == ChargeNature.less)
        .fold(0.0, (s, c) => s + c.calculatedAmount);

    additionalChargesTotal = additionalChargesGross - additionalChargesDeduct;
  }

  // ── Extended grand total ───────────────────────────────────────────────────
  double get grandTotalWithCharges => grandTotal + additionalChargesTotal;

  // ── Submit payload ─────────────────────────────────────────────────────────
  /// Returns an empty list (all zeroed) when no charges were added,
  /// matching the requirement that optional charges default to 0.
  List<Map<String, dynamic>> get additionalChargesPayload =>
      additionalCharges.isEmpty
          ? []
          : additionalCharges.map((c) => c.toApiJson()).toList();
}