import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../mrn_filter/mrn_filter_sheet.dart';
import '../mrn_response/mrn_models.dart';

class MrnListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();
  MrnGrnFilter activeFilter = const MrnGrnFilter();

  String htmlData = '';
  bool isLoadingList = false;
  List<MrnListItem> mrnItems = [];
  List<MrnListRawRow> rawRows = []; // ✅ add this
  List<String> columns = [];
  List<MrnListItem> get filteredItems => activeFilter.applyMrn(
    mrnItems,
    partyName: (e) => e.partyName,
    siteName: (e) => e.siteName,
    jobType: (e) => e.jobType,        // make sure jobType is String (not String?)
    totalAmt: (e) => e.totalAmt,
  );
  bool get hasActiveFilter => activeFilter.isActive;

  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    final from = today.subtract(const Duration(days: 30));
    fromDateCtrl.text = DateFormat('yyyy-MM-dd').format(from); // ✅ 30 days back
    toDateCtrl.text = DateFormat('yyyy-MM-dd').format(today);
    fetchMrnList();
  }

  @override
  void onClose() {
    fromDateCtrl.dispose();
    toDateCtrl.dispose();
    super.onClose();
  }

  void applyFilter(MrnGrnFilter f) {
    activeFilter = f;
    update();
  }

  void resetFilter() {
    activeFilter = const MrnGrnFilter();
    update();
  }

  Future<void> fetchMrnList() async {
    isLoadingList = true;
    mrnItems = [];
    activeFilter = const MrnGrnFilter();
    htmlData = '';
    rawRows = []; // ✅ reset
    columns = []; // ✅ reset
    update();
    try {
      final req = MrnListRequest(
        fromdate: fromDateCtrl.text,
        todate: toDateCtrl.text,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        jobtypeid: 0,   // ← wire up when filter exists
        filtertype: 'mrn',
      );
      final res = await api.getMrnList(req);
      if (res.status == 200 || res.success == true) {
        mrnItems = res.data;
        htmlData = res.rawHtml;
        rawRows = res.rawRows; // ✅ assign
        columns = res.columns; // ✅ assign
      } else {
        ShowMessage.showSnackBar('MRN List', res.message ?? 'Failed to load');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isLoadingList = false;
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
    }
  }
}
