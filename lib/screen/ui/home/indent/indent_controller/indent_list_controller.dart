// ─────────────────────────────────────────────────────────────────────────────
// indent_list_controller.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:digitalerp/screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../indent_response/indent_model.dart';
import '../indent_filter/indent_filter_sheet.dart';

class IndentListController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  static final _apiFmt = DateFormat('yyyy-MM-dd');

  // ── Filter ─────────────────────────────────────────────────────────────────
  IndentFilter activeFilter = const IndentFilter();
  bool get hasActiveFilter => activeFilter.isActive;

  // ── State ──────────────────────────────────────────────────────────────────
  bool isLoadingList = false;
  List<IndentListItem> indentItems = [];

  List<IndentListItem> get filteredItems {
    final searched = searchQuery.trim().isEmpty
        ? List<IndentListItem>.from(indentItems)
        : indentItems
        .where((i) =>
    i.indentNo.toLowerCase().contains(searchQuery.toLowerCase()) ||
        i.requestBy.toLowerCase().contains(searchQuery.toLowerCase()) ||
        i.siteName.toLowerCase().contains(searchQuery.toLowerCase()) ||
        i.department
            .toLowerCase()
            .contains(searchQuery.toLowerCase()) ||
        i.jobType.toLowerCase().contains(searchQuery.toLowerCase()) ||
        i.status.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return activeFilter.apply(searched);
  }

  String searchQuery = '';

  // ── API date-window controllers (used for fetching from API) ───────────────
  final TextEditingController fromDateCtrl = TextEditingController();
  final TextEditingController toDateCtrl = TextEditingController();

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _isFetching = false;
    final today = DateTime.now();
    final from = today.subtract(const Duration(days: 30));
    fromDateCtrl.text = _apiFmt.format(from);
    toDateCtrl.text = _apiFmt.format(today);
    fetchIndentList();
  }

  @override
  void onClose() {
    fromDateCtrl.dispose();
    toDateCtrl.dispose();
    super.onClose();
  }

  // ── Filter helpers ─────────────────────────────────────────────────────────
  void applyFilter(IndentFilter f) {
    activeFilter = f;
    update(['indentList']);
  }

  void resetFilter() {
    activeFilter = const IndentFilter();
    update(['indentList']);
  }

  void onSearch(String q) {
    searchQuery = q;
    update(['indentList']);
  }

  /// Called by IndentFilterSheet when the user picks a date range that may be
  /// outside the already-loaded API window. We widen the API window and
  /// re-fetch so the filter can work on the full data set.
  Future<void> fetchForDateRange(DateTime from, DateTime to) async {
    final newFrom = _apiFmt.format(from);
    final newTo = _apiFmt.format(to);

    // Only re-fetch if the requested window is wider than what we have.
    final currentFrom = DateTime.tryParse(fromDateCtrl.text);
    final currentTo = DateTime.tryParse(toDateCtrl.text);
    final needsWider = currentFrom == null ||
        currentTo == null ||
        from.isBefore(currentFrom) ||
        to.isAfter(currentTo);

    if (needsWider) {
      fromDateCtrl.text = newFrom;
      toDateCtrl.text = newTo;
      await fetchIndentList();
    }
  }

  // ── Fetch ──────────────────────────────────────────────────────────────────
  bool _isFetching = false;

  Future<void> fetchIndentList() async {
    if (_isFetching) return;
    _isFetching = true;
    isLoadingList = true;
    indentItems = [];
    searchQuery = '';

    try {
      final body = {
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'fromdate': fromDateCtrl.text,
        'todate': toDateCtrl.text,
        'siteid': 0,
      };

      final res = await api.getIndentList(body);
      if (res.success == true || res.status == 200) {
        indentItems = res.data;
      } else {
        ShowMessage.showSnackBar(
            'Indent List', res.message ?? 'Failed to load');
      }
    } catch (e) {
      if (kDebugMode) print('IndentList exception: $e');
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isLoadingList = false;
      _isFetching = false;
      update(['indentList']);
    }
  }

  // ── Date pickers (toolbar) ─────────────────────────────────────────────────
  Future<void> pickFromDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.tryParse(fromDateCtrl.text) ?? DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      fromDateCtrl.text = _apiFmt.format(picked);
      update(['indentList']);
    }
  }

  Future<void> pickToDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.tryParse(toDateCtrl.text) ?? DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      toDateCtrl.text = _apiFmt.format(picked);
      update(['indentList']);
    }
  }

  // ── Pull-to-refresh ────────────────────────────────────────────────────────
  Future<void> refresh() => fetchIndentList();
}
