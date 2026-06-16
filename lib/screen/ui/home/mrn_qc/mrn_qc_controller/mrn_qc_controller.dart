import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../mrn_qc_model/mrn_qc_models.dart';

/// Per-item editable state
class QcItemState {
  final TextEditingController receivedCtrl;
  final TextEditingController reasonCtrl;
  double receivedQty;
  int rejectedQty;
  bool isSaved;

  QcItemState({
    required double initialReceived,
    required int actualQty,
    String initialReason = '',
  })  : receivedQty = initialReceived,
        rejectedQty = actualQty - initialReceived.toInt(),
        isSaved = false,
        receivedCtrl =
        TextEditingController(text: initialReceived.toInt().toString()),
        reasonCtrl = TextEditingController(text: initialReason);

  void dispose() {
    receivedCtrl.dispose();
    reasonCtrl.dispose();
  }
}

class MrnQcScreenController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  // ── State ──────────────────────────────────────────────────────────────────
  MrnQcDetail? detail;
  bool isQcLoading = false;  // renamed: AppBaseController already has RxBool isLoading
  bool isQcSaving = false;   // renamed: keep naming consistent
  bool get isCompleted => documentName == 'qc';

  // The MrnQcListItem passed as argument
  MrnQcListItem? listItem;

  // Editable fields
  final TextEditingController remarksCtrl = TextEditingController();
  final TextEditingController checkedByCtrl = TextEditingController();

  DateTime qcDate = DateTime.now();
  String get qcDateDisplay => DateFormat('dd MMM yyyy').format(qcDate);
  // Use whichever field UserData exposes — fullname, name, or userName
  String get checkedBy =>
      checkedByCtrl.text.isNotEmpty
          ? checkedByCtrl.text
          : homeController.currentUserData?.name ?? 'Unknown';

  // Per-item states: index → QcItemState
  final Map<int, QcItemState> itemStates = {};

  // Which item is expanded for editing (-1 = none)
  int expandedItemIndex = -1;
  String documentName = 'mrn';

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    listItem = args?['item'] as MrnQcListItem?;
    documentName = args?['docname'] as String? ?? 'mrn';
    loadDetail();
  }

  @override
  void onClose() {
    remarksCtrl.dispose();
    checkedByCtrl.dispose();  // ← ADD
    for (final s in itemStates.values) {
      s.dispose();
    }
    super.onClose();
  }

  // ── Load QC Detail from API ────────────────────────────────────────────────
  Future<void> loadDetail() async {
    if (listItem == null) return;
    isQcLoading = true;
    update();

    try {
      final req = MrnQcDetailRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        documentid: listItem!.id,
        documentname: documentName,
      );

      final res = await api.getMrnQcDetail(req);

      if (res.status == 200 || res.success == true) {
        detail = res.data;
        _initItemStates();
        if (detail!.qcdate != null) {
          qcDate = detail!.qcdate!;
        }
        if (detail!.reamarks.isNotEmpty) {
          remarksCtrl.text = detail!.reamarks;
        }
        // ── NEW: prefill checkedBy ──────────────────────────────────────────
        checkedByCtrl.text = detail!.checkedby.isNotEmpty
            ? detail!.checkedby
            : homeController.currentUserData?.name ?? '';
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to load');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isQcLoading = false;
      update();
    }
  }

  void _initItemStates() {
    itemStates.clear();
    final items = detail?.qcitems ?? [];
    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      itemStates[i] = QcItemState(
        initialReceived: item.receiveqty,
        actualQty: item.actualqty.toInt(),
        initialReason: item.reason,
      );
    }
  }

  // ── Toggle item expand ─────────────────────────────────────────────────────
  void toggleItemExpand(int idx) {
    expandedItemIndex = expandedItemIndex == idx ? -1 : idx;
    update();
  }

  // ── Handle received qty change → auto-calc rejected ───────────────────────
  void onReceivedQtyChanged(int idx, String val) {
    final item = detail!.qcitems[idx];
    final received = double.tryParse(val) ?? 0;
    final clamped = received.clamp(0.0, item.actualqty) as double;
    final state = itemStates[idx]!;
    state.receivedQty = clamped;
    state.rejectedQty = item.actualqty.toInt() - clamped.toInt();
    update();
  }

  // ── Save a single item row ─────────────────────────────────────────────────
  void saveItem(int idx) {
    final state = itemStates[idx]!;
    final item = detail!.qcitems[idx];

    // Validate
    final received = double.tryParse(state.receivedCtrl.text) ?? 0;
    if (received > item.actualqty) {
      ShowMessage.showSnackBar(
          'Invalid', 'Received qty cannot exceed actual qty (${item.actualqty.toInt()})');
      return;
    }
    if (state.rejectedQty > 0 && state.reasonCtrl.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
          'Reason Required', 'Please enter a reason for rejected items');
      return;
    }

    // Update in-memory item
    detail!.qcitems[idx] = item.copyWith(
      receiveqty: received,
      rejectedqty: state.rejectedQty.toDouble(),
      reason: state.reasonCtrl.text.trim(),
    );

    state.receivedQty = received;
    state.isSaved = true;
    expandedItemIndex = -1; // collapse
    update();

    ShowMessage.showSnackBar('Updated', '${item.itemname} updated successfully');
  }

  // ── Pick QC Date ───────────────────────────────────────────────────────────
  Future<void> pickQcDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: qcDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      qcDate = picked;
      update();
    }
  }

  // ── Submit full QC entry ───────────────────────────────────────────────────
  Future<void> submitQc() async {
    if (detail == null) return;

    isQcSaving = true;
    update();

    try {
      final req = SaveQcEntryRequest(
        qcid: detail!.qcid,
        receiptno: detail!.receiptno,
        partyname: detail!.partyname,
        partyid: detail!.partyid,
        qcno: detail!.qcno,
        qcdate: qcDate,
        checkedby: checkedByCtrl.text.trim().isNotEmpty
            ? checkedByCtrl.text.trim()
            : checkedBy,
        reamarks: remarksCtrl.text.trim(),
        stockid: detail!.stockid,
        totalqty: detail!.totalqty,
        totalamt: detail!.totalamt,
        grandtotal: detail!.grandtotal,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        yearid: homeController.currentUserData?.yearId ?? '',
        receiptdate: detail!.receiptdate,
        siteid: detail!.siteid,
        jobtypeid: detail!.jobtypeid,
        billno: detail!.billno,
        godownid: detail!.godownid,
        qcitems: detail!.qcitems,
      );

      final res = await api.saveQcEntry(req);

      if (res.status == 200 || res.success == true) {
        ShowMessage.showSnackBar('Success', 'QC Entry saved successfully');

        Get.offNamed('/mrnQcList'); // replaces current route with the list
      }else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to save');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isQcSaving = false;
      update();
    }
  }
}