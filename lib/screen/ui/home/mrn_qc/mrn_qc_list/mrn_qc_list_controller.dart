import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../mrn_qc_filter/mrn_qc_filter_sheet.dart';
import '../mrn_qc_model/mrn_qc_models.dart';

enum MrnQcTab { pending, completed }

class MrnQcListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  // ── Tab state ──────────────────────────────────────────────────────────────
  MrnQcTab activeTab = MrnQcTab.pending;
  MrnQcFilter activeFilter = const MrnQcFilter();


  // ── Separate lists per tab ─────────────────────────────────────────────────
  List<MrnQcListItem> pendingItems = [];
  List<MrnQcListItem> completedItems = [];

  // ── Active list (used by UI) ───────────────────────────────────────────────
  List<MrnQcListItem> get activeItems =>
      activeTab == MrnQcTab.pending ? pendingItems : completedItems;

  //Filter Sheet
  List<MrnQcListItem> get filteredItems =>
      activeFilter.apply(activeItems, activeTab == MrnQcTab.completed);

  // ── Loading states per tab ─────────────────────────────────────────────────
  bool isLoadingPending = false;
  bool isLoadingCompleted = false;
  bool get isLoadingList =>
      activeTab == MrnQcTab.pending ? isLoadingPending : isLoadingCompleted;
  bool get hasActiveFilter => activeFilter.isActive;

  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    final from = today.subtract(const Duration(days: 30));
    fromDateCtrl.text = DateFormat('yyyy-MM-dd').format(from);
    toDateCtrl.text = DateFormat('yyyy-MM-dd').format(today);
    fetchMrnQcList(); // fetch active tab on init

  }

  @override
  void onClose() {
    fromDateCtrl.dispose();
    toDateCtrl.dispose();
    super.onClose();
  }

  // ── Switch tab → fresh API call ────────────────────────────────────────────
  void switchTab(MrnQcTab tab) {
    activeTab = tab;
    activeFilter = const MrnQcFilter(); // ← reset on tab switch
    update();
    fetchMrnQcList();
  }

  //Filter Functions
  void applyFilter(MrnQcFilter f) {
    activeFilter = f;
    update();
  }

  void resetFilter() {
    activeFilter = const MrnQcFilter();
    update();
  }


  // ── Fetch for current active tab ───────────────────────────────────────────
  Future<void> fetchMrnQcList() async {
    final isPending = activeTab == MrnQcTab.pending;

    if (isPending) {
      isLoadingPending = true;
      pendingItems = [];
    } else {
      isLoadingCompleted = true;
      completedItems = [];
    }
    update();

    try {
      final req = MrnQcListRequest(
        fromdate: fromDateCtrl.text,
        todate: toDateCtrl.text,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        filtertype: isPending ? 'Pendingqc' : 'Qclist', // ← API filter values
      );

      final res = await api.getMrnQcList(req);

      if (res.status == 200 || res.success == true) {
        if (isPending) {
          pendingItems = res.data;
        } else {
          completedItems = res.data;
        }
      } else {
        ShowMessage.showSnackBar(
            isPending ? 'Pending QC' : 'QC List',
            res.message ?? 'Failed to load');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      if (isPending) {
        isLoadingPending = false;
      } else {
        isLoadingCompleted = false;
      }
      update();
    }
  }

  Future<void> pickFromDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.tryParse(fromDateCtrl.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      fromDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
      fetchMrnQcList(); // re-fetch with new date
    }
  }

  Future<void> pickToDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.tryParse(toDateCtrl.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      toDateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      update();
      fetchMrnQcList(); // re-fetch with new date
    }
  }
}