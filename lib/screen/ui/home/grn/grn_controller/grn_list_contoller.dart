import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../grn_filter/grn_filter_sheet.dart';
import '../grn_response/grn_models.dart';

class GrnListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  MrnGrnFilter activeFilter = const MrnGrnFilter();

  String htmlData = '';
  bool isLoadingList = false;
  List<GrnListItem> GrnItems = [];
  List<GrnListRawRow> rawRows = []; // ✅ add this
  List<String> columns = [];

  List<GrnListItem> get filteredItems => activeFilter.applyMrn(
    GrnItems,
    partyName: (e) => e.partyName,
    siteName: (e) => e.siteName,
    jobType: (e) => e.jobType,
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
    fetchGrnList();
  }

  @override
  void onClose() {
    fromDateCtrl.dispose();
    toDateCtrl.dispose();
    super.onClose();
  }
  void applyFilter(MrnGrnFilter f) { activeFilter = f; update(); }
  void resetFilter() { activeFilter = const MrnGrnFilter(); update(); }

  Future<void> fetchGrnList() async {
    isLoadingList = true;
    GrnItems = [];
    htmlData = '';
    rawRows = []; // ✅ reset
    columns = []; // ✅ reset
    update();
    try {
      final request = GrnListRequest(
        fromdate: fromDateCtrl.text,
        todate: toDateCtrl.text,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        filtertype: 'grn',
      );
      final res = await api.getGrnList(request);
      if (res.status == 200 || res.success == true) {
        GrnItems = res.data;
        htmlData = res.rawHtml;
        rawRows = res.rawRows; // ✅ assign
        columns = res.columns; // ✅ assign

        if (kDebugMode && res.rawRows.isNotEmpty) {
          print('📋 GRN List columns: ${res.columns}');
          print('📋 First row raw data: ${res.rawRows.first.data}');
        }
      } else {
        ShowMessage.showSnackBar('Grn List', res.message ?? 'Failed to load');
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
