// ─────────────────────────────────────────────────────────────────────────────
// issue_item_list_controller.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:digitalerp/screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../issue_item_filter/issue_item_filter_sheet.dart';
import '../issue_item_response/issue_item_model.dart';

class IssueItemListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  // ── State ──────────────────────────────────────────────────────────────────
  bool isLoadingList = false;
  List<IssueItemListItem> issueItems = [];
  String searchQuery = '';
  IssueItemFilter activeFilter = const IssueItemFilter();

  // ── Date controllers ───────────────────────────────────────────────────────
  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  // ── Filtered list (search only — add MrnGrnFilter here if needed) ──────────
  List<IssueItemListItem> get filteredItems {
    if (searchQuery.trim().isEmpty) return List.from(issueItems);
    final q = searchQuery.toLowerCase();
    return issueItems
        .where((i) =>
            i.issueNo.toLowerCase().contains(q) ||
            i.issueTo.toLowerCase().contains(q) ||
            i.issuedBy.toLowerCase().contains(q) ||
            i.issueType.toLowerCase().contains(q) ||
            i.godown.toLowerCase().contains(q))
        .toList();
  }

  void applyFilter(IssueItemFilter f) {
    activeFilter = f;
    update();
  }

  void resetFilter() {
    activeFilter = const IssueItemFilter();
    update();
  }

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    final today = DateTime.now();
    final from = today.subtract(const Duration(days: 30));
    fromDateCtrl.text = DateFormat('yyyy-MM-dd').format(from);
    toDateCtrl.text = DateFormat('yyyy-MM-dd').format(today);
    fetchIssueItemList();
  }

  @override
  void onClose() {
    fromDateCtrl.dispose();
    toDateCtrl.dispose();
    super.onClose();
  }

  // ── Search ─────────────────────────────────────────────────────────────────
  void onSearch(String q) {
    searchQuery = q;
    update();
  }

  // ── Fetch ──────────────────────────────────────────────────────────────────

  bool _isFetching = false;

  Future<void> fetchIssueItemList() async {
    if (_isFetching) return; // ← guard
    _isFetching = true;
    isLoadingList = true;
    issueItems = [];
    searchQuery = '';
    update();
    try {
      final body = {
        'fromdate': fromDateCtrl.text,
        'todate': toDateCtrl.text,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'siteid': 0, // populate if you have a site filter
        'partyid': 0, // populate if you have a party filter
      };
      final res = await api.getIssueItemList(body);
      if (res.status == 200 || res.success == true) {
        issueItems = res.data;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ShowMessage.showSnackBar(
              'Issue Items', res.message ?? 'Failed to load');
        });
      }
    } catch (e) {
      if (kDebugMode) print('IssueItemList exception: $e');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowMessage.showSnackBar('Error', '$e');
      });
    } finally {
      isLoadingList = false;
      _isFetching = false; // ← release guard
      update();
    }
  }

  // ── Date pickers ───────────────────────────────────────────────────────────
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

  // ── Pull-to-refresh ────────────────────────────────────────────────────────
  Future<void> onRefresh() => fetchIssueItemList();
}
