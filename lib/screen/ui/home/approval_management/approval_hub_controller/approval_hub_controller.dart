import 'dart:convert';

import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_detail/approval_details_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../approval_hub_screens/approval_hub_detail.dart';

enum ApprovalItemStatus {
  pending('Pending', 'Pending'),
  onHold('Hold', 'Hold'),
  approve('Approve', 'Approve'),
  reject('Reject', 'Reject'),
  verify('Verify', 'Verify');

  final String label;
  final String apiValue;
  const ApprovalItemStatus(this.label, this.apiValue);
}

/// Approval-side model — separate from ReimbursementLineItem (creation flow).
/// Fields mirror the web UI table columns.
// AFTER
class ApprovalReimbursementItem {
  final int sno;
  final int detailId;
  final int expenseId;
  final int parentId;
  final int ledgerId;
  final int transId;
  final String expenseCategory;
  final String reimbursementType;
  final String description;
  final double requestAmount;
  final String? referenceFileUrl;
  final String? receiptFileUrl;

  double processAmount;
  ApprovalItemStatus status; // ✅ mutable field — was missing

  ApprovalReimbursementItem({
    required this.sno,
    this.detailId = 0,
    this.expenseId = 0,
    this.parentId = 0,
    this.ledgerId = 0,
    this.transId = 0,
    required this.expenseCategory,
    required this.reimbursementType,
    required this.description,
    required this.requestAmount,
    this.referenceFileUrl,
    this.receiptFileUrl,
    double? processAmount,
    this.status = ApprovalItemStatus.pending, // ✅ now valid
  }) : processAmount = processAmount ?? requestAmount;

  factory ApprovalReimbursementItem.fromJson(Map<String, dynamic> json) =>
      ApprovalReimbursementItem(
        sno: (json['SNo'] ?? json['sno'] ?? 0) as int,
        detailId: (json['DetailId'] ?? json['detailId'] ?? 0) as int,
        expenseId: (json['ExpenseId'] ?? json['expenseId'] ?? 0) as int,
        parentId: (json['ParentId'] ?? json['parentId'] ?? 0) as int,
        ledgerId: (json['LedgerId'] ?? json['ledgerId'] ?? 0) as int,
        transId: (json['TransId'] ?? json['transId'] ?? 0) as int,
        expenseCategory: json['ExpenseGroup'] ?? json['expenseCategory'] ?? '',
        reimbursementType:
            json['ExpenseLedger'] ?? json['reimbursementType'] ?? '',
        description: json['Description'] ?? json['description'] ?? '',
        requestAmount: (json['Amount'] as num?)?.toDouble() ??
            (json['requestAmount'] as num?)?.toDouble() ??
            0.0,
        referenceFileUrl: json['ReferenceFile'] ?? json['referenceFileUrl'],
        receiptFileUrl: json['ReceiptFile'] ?? json['receiptFileUrl'],
        // ✅ NO status, isReimbursementL1, isReimbursementL2 here
      );

  /// Serialises to the API's itemslistentry shape.
  Map<String, dynamic> toItemsListEntry() => {
        'DetailId': detailId,
        'SNo': sno,
        'ExpenseId': expenseId,
        'ParentId': parentId,
        'LedgerId': ledgerId,
        'Description': description,
        'Amount': requestAmount,
        'ApprovedAmt': processAmount,
        'Status': status.apiValue, // ✅ now works
        'TransId': transId,
      };
}

//  Category tile model

class ForwardOption {
  final String id;
  final String name;
  const ForwardOption({required this.id, required this.name});
}

class ApprovalCategory {
  final String key, label, emoji;
  final Color color, lightColor;
  int count, overdueCount;

  ApprovalCategory({
    required this.key,
    required this.label,
    required this.emoji,
    required this.color,
    required this.lightColor,
    this.count = 0,
    this.overdueCount = 0,
  });
}

//  Action enum

enum ApprovalAction {
  approve,
  reject,
  hold,
  revert,
  forward,
  comment,
  disapprove
}

extension ApprovalActionX on ApprovalAction {
  String get label {
    switch (this) {
      case ApprovalAction.approve:
        return 'Approved';
      case ApprovalAction.reject:
        return 'Reject'; // ← API value
      case ApprovalAction.hold:
        return 'Hold'; // ← API value
      case ApprovalAction.revert:
        return 'Amendment'; // ← API value (not "Reverted")
      case ApprovalAction.forward:
        return 'Escalate'; // ← API value (not "Forwarded")
      case ApprovalAction.comment:
        return 'Comment';
      case ApprovalAction.disapprove:
        return 'Disapproved';
    }
  }

  String get emoji {
    switch (this) {
      case ApprovalAction.approve:
        return '✓';
      case ApprovalAction.reject:
        return '✕';
      case ApprovalAction.hold:
        return '⏸';
      case ApprovalAction.revert:
        return '↩';
      case ApprovalAction.forward:
        return '→';
      case ApprovalAction.comment:
        return '💬';
      case ApprovalAction.disapprove: return '🚫';
    }
  }

  Color get color {
    switch (this) {
      case ApprovalAction.approve:
        return newGreenColor;
      case ApprovalAction.reject:
        return newRedColor;
      case ApprovalAction.hold:
        return newOrangeColor;
      case ApprovalAction.revert:
        return const Color(0xFF8B5CF6);
      case ApprovalAction.forward:
        return newBlueColor;
      case ApprovalAction.comment:
        return newTextSecondary;
      case ApprovalAction.disapprove: return newRedColor;
    }
  }

  Color get bgColor {
    switch (this) {
      case ApprovalAction.approve:
        return newGreenLightColor;
      case ApprovalAction.reject:
        return newRedLightColor;
      case ApprovalAction.hold:
        return newOrangeLightColor;
      case ApprovalAction.revert:
        return const Color(0xFFEDE9FE);
      case ApprovalAction.forward:
        return newBlueLightColor;
      case ApprovalAction.comment:
        return newSurfaceColor;
      case ApprovalAction.disapprove: return newRedLightColor;
    }
  }

  String get title {
    switch (this) {
      case ApprovalAction.approve:
        return 'Approve';
      case ApprovalAction.reject:
        return 'Reject';
      case ApprovalAction.hold:
        return 'Hold';
      case ApprovalAction.revert:
        return 'Revert';
      case ApprovalAction.forward:
        return 'Forward';
      case ApprovalAction.comment:
        return 'Comment';
      case ApprovalAction.disapprove: return 'Disapprove';
    }
  }
}

//  Controller

class ApprovalHubController extends AppBaseController {
  HomeController get homeController {
    try {
      return Get.find<HomeController>();
    } catch (_) {
      return Get.put(HomeController());
    }
  }

  // Known category styles (seed map — for styling only, NOT for API calls)
  static const Map<String, Map<String, dynamic>> _knownStyles = {
    'Document': {'emoji': '📄', 'color': 0xFF3B82F6, 'light': 0xFFEFF6FF},
    'Payment': {'emoji': '💳', 'color': 0xFF22C55E, 'light': 0xFFF0FDF4},
    'Leave': {'emoji': '🏖', 'color': 0xFFF97316, 'light': 0xFFFFF7ED},
    'PurchaseOrder': {'emoji': '🛒', 'color': 0xFF8B5CF6, 'light': 0xFFEDE9FE},
    'MRN': {'emoji': '📦', 'color': 0xFF0D9488, 'light': 0xFFCCFBF1},
    'GRN': {'emoji': '🚚', 'color': 0xFFEC4899, 'light': 0xFFFCE7F3},
    'SalesOrder': {'emoji': '🧾', 'color': 0xFF0EA5E9, 'light': 0xFFE0F2FE},
    'Expense': {'emoji': '💸', 'color': 0xFFEAB308, 'light': 0xFFFEF9C3},
    'Miscellaneous': {'emoji': '📋', 'color': 0xFF6B7280, 'light': 0xFFF3F4F6},
    'Reimbursement': {'emoji': '🧾', 'color': 0xFF0EA5E9, 'light': 0xFFE0F2FE},
    'Work Order': {'emoji': '🔧', 'color': 0xFF8B5CF6, 'light': 0xFFEDE9FE},
    'Purchase Order': {'emoji': '🛒', 'color': 0xFF8B5CF6, 'light': 0xFFEDE9FE},
    'Estimate': {'emoji': '📋', 'color': 0xFF0D9488, 'light': 0xFFCCFBF1},
    'Payment Request L1': {
      'emoji': '💳',
      'color': 0xFF22C55E,
      'light': 0xFFF0FDF4
    },
    'Payment Request L2': {
      'emoji': '💳',
      'color': 0xFFF97316,
      'light': 0xFFFFF7ED
    },
  };

  static const List<int> _fallbackColors = [
    0xFF06B6D4,
    0xFF8B5CF6,
    0xFFEC4899,
    0xFF14B8A6,
    0xFFF59E0B
  ];
  static const List<int> _fallbackLights = [
    0xFFCFFAFE,
    0xFFEDE9FE,
    0xFFFCE7F3,
    0xFFCCFBF1,
    0xFFFEF3C7
  ];
  static const List<String> _fallbackEmojis = ['📑', '🗂', '📊', '🔖', '📝'];

  // Stats
  int totalPending = 0, totalOnHold = 0, totalThisMonth = 0;

  List<ApprovalCategory> categories = [];


  bool get showDisapprove {
    final type = (currentItem?.approvalTypeCode ??
        currentItem?.approvalType ?? '').toLowerCase();

    final isTargetType = type.contains('work order') ||
        type.contains('workorder') ||
        type.contains('purchase order') ||
        type.contains('purchaseorder') ||
        type.contains('estimate');

    final status = (
        currentDetail?.header?.status ??
            currentItem?.status ??
            ''
    ).toLowerCase();

    // ✅ Already disapproved — don't show the button again
    if (status == 'disapproved' || status == 'disapprove') return false;

    final isVerified = status == 'verify' ||
        status == 'verified' ||
        status == 'approved' ||
        status == 'approve';

    return isTargetType && isVerified;
  }

  bool get showReject {
    final type = (currentItem?.approvalTypeCode ??
        currentItem?.approvalType ?? '').toLowerCase();
    return type.contains('payment') && type.contains('l1');
  }

  ApprovalCategory _buildCat(String key, int fallbackIndex) {
    final style = _knownStyles[key];
    if (style != null) {
      return ApprovalCategory(
        key: key,
        label: _labelFor(key),
        emoji: style['emoji'],
        color: Color(style['color'] as int),
        lightColor: Color(style['light'] as int),
      );
    }
    final i = fallbackIndex % _fallbackColors.length;
    return ApprovalCategory(
      key: key,
      label: _humanize(key),
      emoji: _fallbackEmojis[i % _fallbackEmojis.length],
      color: Color(_fallbackColors[i]),
      lightColor: Color(_fallbackLights[i]),
    );
  }

  String _labelFor(String key) {
    const labels = {
      'Document': 'Documents',
      'Payment': 'Payments',
      'Leave': 'Leave Requests',
      'PurchaseOrder': 'Purchase Orders',
      'MRN': 'MRN',
      'GRN': 'GRN',
      'SalesOrder': 'Sales Orders',
      'Expense': 'Expenses',
      'Miscellaneous': 'Miscellaneous',
    };
    return labels[key] ?? _humanize(key);
  }

  // 'PurchaseReturn' → 'Purchase Return'
  String _humanize(String key) =>
      key.replaceAllMapped(RegExp(r'(?<=[a-z])(?=[A-Z])'), (_) => ' ');

  // List & filter state
  List<ApprovalListData> allApprovals = [];
  String selectedCategory = '';
  String searchQuery = '';
  final TextEditingController searchCtrl = TextEditingController();

  List<ApprovalListData> get filteredApprovals {
    var list = List<ApprovalListData>.from(allApprovals);

    // Category tab filter
    if (selectedCategory.isNotEmpty) {
      list = list
          .where((a) =>
      a.approvalTypeCode == selectedCategory ||
          a.approvalType == selectedCategory)
          .toList();
    }

    // Search filter
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list
          .where(
            (a) =>
                (a.documentNo?.toLowerCase().contains(q) ?? false) ||
                (a.approvalType?.toLowerCase().contains(q) ?? false) ||
                (a.requestedBy?.toLowerCase().contains(q) ?? false) ||
                (a.siteName?.toLowerCase().contains(q) ?? false) ||
                (a.remarks?.toLowerCase().contains(q) ?? false),
          )
          .toList();
    }

    // Status filter
    if (filterStatus.isNotEmpty) {
      list = list.where((a) {
        final s = (a.status ?? '').trim().toLowerCase();
        final f = filterStatus.trim().toLowerCase();
        if (f == 'approved') return s == 'approved' || s == 'approve'; // ✅
        if (f == 'rejected') return s == 'rejected' || s == 'reject'; // ✅
        return s == f;
      }).toList();
    }

    // Date range filter — parse DocumentDate 'dd-MM-yyyy'
    list = list.where((a) {
      if (a.documentDate == null || a.documentDate!.isEmpty) return true;
      try {
        final parts = a.documentDate!.split('-');
        if (parts.length != 3) return true;
        final date = DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
        return !date.isBefore(
                DateTime(filterFrom.year, filterFrom.month, filterFrom.day)) &&
            !date
                .isAfter(DateTime(filterTo.year, filterTo.month, filterTo.day));
      } catch (_) {
        return true;
      }
    }).toList();

    return list;
  }

  // Bulk selection — keyed on documentId (replaces approvalid)
  final Set<int> selectedIds = {};
  bool get hasSelection => selectedIds.isNotEmpty;
  int get selectionCount => selectedIds.length;

  List<ApprovalListData> get selectedItems => allApprovals
      .where((a) => a.documentId != null && selectedIds.contains(a.documentId))
      .toList();

  bool isSelected(ApprovalListData item) =>
      item.documentId != null && selectedIds.contains(item.documentId);

  void toggleSelect(ApprovalListData item) {
    if (item.documentId == null) return;
    if (selectedIds.contains(item.documentId)) {
      selectedIds.remove(item.documentId);
    } else {
      selectedIds.add(item.documentId!);
    }
    update();
  }

  void clearSelection() {
    selectedIds.clear();
    update();
  }

  bool _longPressConsumed = false;

  void onCardLongPress(ApprovalListData item) {
    if (!hasSelection) {
      selectedItems.clear();
    }
    toggleSelect(item);
    update(); // ← CRITICAL — must be called to rebuild _BulkBar and checkboxes
  }

  void onCardTap(ApprovalListData item) {
    if (hasSelection) {
      toggleSelect(item);
      return;
    }

    _prepareDetail(item);
    Get.to(const ApprovalHubDetail());
  }

  //  Detail state

  ApprovalListData? currentItem; // ✅ was accidentally removed
  List<dynamic> currentDetails =
      []; // ✅ kept for backward compat with action screens
  ApprovalDetailData? currentDetail;
  String currentDocUrl = '';
  bool isLoadingDetail = false;

  ApprovalDetailHeader? get detailHeader => currentDetail?.header;
  List<ApprovalChainStep> get approvalChain =>
      currentDetail?.approvalChain ?? [];
  List<RelatedDoc> get relatedDocs => currentDetail?.relatedDocs ?? [];

  // Action state
  ApprovalAction? pickedAction;
  List<StatusListData> statusList = [];
  TextEditingController remarkCtrl = TextEditingController();
  TextEditingController partialCtrl = TextEditingController();
  bool partialApproval = false;
  bool actionSuccess = false;
  String actionResultMsg = '';
  List<ForwardOption> forwardOptions = [];
  ForwardOption? forwardTo;
  List<ApprovalReimbursementItem> approvalReimbursementItems = [];

  // Date range
  final String _from = DateFormat('yyyy-MM-dd').format(DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day));
  final String _to = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void onInit() {
    super.onInit();
    filterFrom = DateTime.now().subtract(const Duration(days: 30));
    filterTo = DateTime.now();
    selectedCategory = ''; // ✅ empty triggers auto-select of first in _loadDashboard
    _loadDashboard();
    _loadForwardOptions();
  }

  @override
  void onClose() {
    try {
      searchCtrl.dispose();
    } catch (_) {}
    try {
      remarkCtrl.dispose();
    } catch (_) {}
    try {
      partialCtrl.dispose();
    } catch (_) {}
    super.onClose();
  }

  Future<void> _loadForwardOptions() async {
    try {
      final res = await api.getExecutiveDropdown({
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
      });
      if (res.status == 200 && res.data != null) {
        forwardOptions = res.data!
            .map((e) => ForwardOption(
                  id: e.executiveId?.toString() ?? '0', // ← capital I
                  name: e.executiveName ?? '', // ← capital N
                ))
            .toList();
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Forward', 'Failed to load executives: $e');
    }
  }

  //  Dashboard

  // In _loadDashboard(), the full finally block should look like this:

  Future<void> _loadDashboard() async {
    setBusy(true);
    try {
      print('📊 Loading dashboard...');
      final allItems = await _fetchAllApprovals();
      print('📊 Fetched ${allItems.length} items');

      final discoveredKeys = allItems
          .map((a) => a.approvalTypeCode ?? a.approvalType)
          .whereType<String>()
          .toSet()
          .toList();

      categories = [];
      for (int i = 0; i < discoveredKeys.length; i++) {
        categories.add(_buildCat(discoveredKeys[i], i));
      }

      categories.add(_buildCat('Miscellaneous', categories.length));

      for (final item in allItems) {
        final cat = categories.firstWhereOrNull((c) =>
        c.key == item.approvalTypeCode || c.key == item.approvalType);
        if (cat != null) {
          cat.count++;
        } else {
          categories.firstWhereOrNull((c) => c.key == 'Miscellaneous')?.count++;
        }
      }

      allApprovals = allItems;

      categories.removeWhere((c) => c.key == 'Miscellaneous' && c.count == 0);

      // ✅ Only auto-select first category if nothing is already selected
      // '' means "show all" (View All button) — don't override it
      // A valid key that no longer exists — fall back to first
      final currentExists = selectedCategory.isEmpty ||
          categories.any((c) => c.key == selectedCategory);
      if (!currentExists && categories.isNotEmpty) {
        selectedCategory = categories.first.key;
      } else if (selectedCategory.isNotEmpty &&
          !categories.any((c) => c.key == selectedCategory) &&
          categories.isNotEmpty) {
        selectedCategory = categories.first.key;
      }

      await Future.wait([getStatusList()]);
      print('📊 Status list loaded: ${statusList.length}');
      _recalcStats();
      print('📊 Stats: pending=$totalPending');
    } catch (e, stack) {
      print('❌ Dashboard error: $e');
      print('❌ Stack: $stack');          // ← add stack trace
      ShowMessage.showSnackBar('Approval Hub', '$e');
    } finally {
      print('📊 Finally block reached');
      setBusy(false);
      update();
    }
  }

  void _recalcStats() {
    // All fetched items are Pending — so totalPending = total count
    totalPending = allApprovals.length;

    // On hold — items with status 'on hold' within fetched data
    // (will be 0 since we fetch only Pending, but keeps it honest)
    totalOnHold = allApprovals
        .where((a) => (a.status ?? '').toLowerCase() == 'on hold')
        .length;

    // This month — pending items whose date falls in current month
    final now = DateTime.now();
    totalThisMonth = allApprovals.where((a) {
      if (a.documentDate == null || a.documentDate!.isEmpty) return false;
      try {
        final parts = a.documentDate!.split('-');
        if (parts.length != 3) return false;
        final date = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
        return date.month == now.month && date.year == now.year;
      } catch (_) {
        return false;
      }
    }).length;

    update();
  }

  Future<void> refreshDashboard() async {
    allApprovals.clear();
    categories.clear();
    // ✅ selectedCategory is intentionally NOT cleared here
    // _loadDashboard() will preserve it if valid, or fall back to first if gone
    await _loadDashboard();
  }

  //  Fetch — single call, no seed keys

  Future<List<ApprovalListData>> _fetchAllApprovals() async {
    try {
      final body = _base()
        ..['approvaltype'] = ''
        ..['statusfilter'] = ''
        ..['fromdate'] = DateFormat('yyyy-MM-dd').format(filterFrom)
        ..['todate'] = DateFormat('yyyy-MM-dd').format(filterTo);

      final res = await api.getApprovalListData(body);

      if ((res.status == 200 || res.success == true) && res.data != null) {
        final seen = <String>{};
        return res.data!.where((a) {
          if (a.documentId == null) return false;
          // ✅ Deduplicate by documentId + approvalTypeCode together
          final key =
              '${a.documentId}_${a.approvalTypeCode ?? a.approvalType ?? ""}';
          return seen.add(key);
        }).toList();
      }
      return [];
    } catch (e) {
      ShowMessage.showSnackBar('Approval Hub', 'Failed to load approvals: $e');
      return [];
    }
  }

  //  Filter

  void selectCategory(String key) {
    selectedCategory = key;
    update();
  }

  void onSearch(String q) {
    searchQuery = q;
    update();
  }

  void clearSearch() {
    searchCtrl.clear();
    searchQuery = '';
    update();
  }

  void loadApprovalReimbursementItems(List<dynamic> apiItems) {
    approvalReimbursementItems =
        apiItems.map((e) => ApprovalReimbursementItem.fromJson(e)).toList();

    for (final item in approvalReimbursementItems) {
      if (isReimbursementL1) {
        item.status = ApprovalItemStatus.verify;
      } else if (isReimbursementL2) {
        item.status = ApprovalItemStatus.approve;
      }
    }
    update();
  }

  //  Detail

  Future<void> openDetail(ApprovalListData item) async {
    currentItem = item;
    currentDetail = null;
    currentDetails = [];
    currentDocUrl = '';
    actionSuccess = false;
    actionResultMsg = '';
    pickedAction = null;
    partialApproval = false;
    remarkCtrl.clear();
    partialCtrl.text = item.amount?.toString() ?? '';
    isLoadingDetail = true;
    update();
    await Future.wait([_fetchDetails(item), _fetchDoc(item)]);
    isLoadingDetail = false;
    update();
  }

  Future<void> _fetchDetails(ApprovalListData item) async {
    try {
      final Map<String, String> body = {
        'approvaltype': item.approvalTypeCode ?? item.approvalType ?? '',
        'documentid': (item.documentId ?? 0).toString(),
        'compid': homeController.currentUserData?.compId.toString() ?? '0',
        'branchid': homeController.currentUserData?.branchId.toString() ?? '0',
        'userid': homeController.currentUserData?.userid.toString() ?? '0',
        'yearid': homeController.currentUserData?.yearId?.toString() ?? '',
      };

      final res = await api.getApprovalDetails(body);

      if ((res.status == 200 || res.success == true) && res.data != null) {
        currentDetail = res.data;

        debugPrint(
            '📦 Raw header approvalId = ${currentDetail?.header?.approvalId}');
        debugPrint('📦 Raw header toJson = ${currentDetail?.header?.toJson()}');

        if ((res.data!.header?.attachFile ?? '').isNotEmpty) {
          currentDocUrl = res.data!.header!.attachFile!;
        }

        // ✅ itemsList is populated from 'itemslist' in fromJson (fix 1 above)
        final rawItems = res.data!.itemsList; // ✅ no longer null
        if (rawItems.isNotEmpty) {
          approvalReimbursementItems = rawItems
              .map((e) => ApprovalReimbursementItem.fromJson(e.toJson()))
              .toList();

          for (final item in approvalReimbursementItems) {
            if (isReimbursementL1) {
              item.status = ApprovalItemStatus.verify;
            } else if (isReimbursementL2) {
              item.status = ApprovalItemStatus.approve;
            }
          }
        } else {
          approvalReimbursementItems = [];
        }
      } // ✅ THIS CLOSING BRACE WAS MISSING — caused a compile error
    } catch (e) {
      ShowMessage.showSnackBar('Detail', '$e');
    }
  }

  Future<void> _fetchDoc(ApprovalListData item) async {
    try {
      final res = await api.getApprovalDocument(
          _base()..[RequestKeys.approvalid] = item.documentId.toString()); // ✅
      if (res.status == 200) currentDocUrl = res.data?.first.url ?? '';
    } catch (_) {}
  }

  //  Action

  void pickAction(ApprovalAction action) {
    pickedAction = action;
    update();
  }

  void setRemark(String text) {
    remarkCtrl.text = text;
    update();
  }

  void togglePartial(bool v) {
    partialApproval = v;

    if (v) {
      // Set default value when enabling partial approval
      partialCtrl.text = (currentItem?.amount ?? 0).toString();
    } else {
      partialCtrl.clear();
    }

    update();
  }

  /// Returns true if current item is Reimbursement L1 (Verification stage)
  bool get isReimbursementL1 {
    final type =
        (currentItem?.approvalTypeCode ?? currentItem?.approvalType ?? '')
            .toLowerCase();
    return type.contains('reimbursement') && type.contains('l1');
  }

  /// Returns true if current item is Reimbursement L2 (Approval stage)
  bool get isReimbursementL2 {
    final type =
        (currentItem?.approvalTypeCode ?? currentItem?.approvalType ?? '')
            .toLowerCase();
    return type.contains('reimbursement') && type.contains('l2');
  }

  /// Returns the allowed per-line statuses based on approval type
  List<ApprovalItemStatus> get allowedItemStatuses {
    if (isReimbursementL1) {
      return [
        ApprovalItemStatus.verify,
        ApprovalItemStatus.pending,
        ApprovalItemStatus.onHold,
        ApprovalItemStatus.reject,
      ];
    } else if (isReimbursementL2) {
      return [
        ApprovalItemStatus.approve,
        ApprovalItemStatus.pending,
        ApprovalItemStatus.onHold,
        ApprovalItemStatus.reject,
      ];
    }
    return ApprovalItemStatus.values.toList();
  }

  Future<void> submitAction() async {
    final isReimbursement =
        currentItem?.approvalType?.toLowerCase().contains('reimbursement') ??
            false;

    if (isReimbursement && pickedAction == null) {
      final allRejected = approvalReimbursementItems
          .every((i) => i.status == ApprovalItemStatus.reject);
      pickedAction =
          allRejected ? ApprovalAction.reject : ApprovalAction.approve;
      update();
    }

    if (pickedAction == null) {
      Get.snackbar('Required', 'Please select an action first');
      return;
    }
    if (remarkCtrl.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Required', 'Please enter a remark');
      return;
    }
    if (currentItem == null) return;

    double? approvedAmountValue;
    if (pickedAction == ApprovalAction.approve && partialApproval) {
      approvedAmountValue = double.tryParse(partialCtrl.text.trim());
      if (approvedAmountValue == null || approvedAmountValue <= 0) {
        ShowMessage.showSnackBar(
            'Invalid Amount', 'Please enter a valid partial amount');
        return;
      }
      if (currentItem!.amount != null &&
          approvedAmountValue > currentItem!.amount!) {
        ShowMessage.showSnackBar('Invalid Amount',
            'Partial amount cannot be greater than requested amount');
        return;
      }
    }

    if (pickedAction == ApprovalAction.forward &&
        (forwardTo == null || forwardTo!.id == '0')) {
      ShowMessage.showSnackBar(
          'Required', 'Please select a person to escalate to');
      return;
    }

    setBusy(true);

    try {
      final String approvedAmountStr = () {
        // Reimbursement — amount is derived from line items, not header
        if (isReimbursement) return '0';

        // All other monetary types — use partial if selected, else full amount
        if (pickedAction == ApprovalAction.approve) {
          if (partialApproval && approvedAmountValue != null) {
            return approvedAmountValue.toString();
          }
          return (currentItem!.amount ?? 0).toString(); // ← full amount
        }

        // Reject / Hold / Revert / Forward / Comment — no amount needed
        return '0';
      }();

      final matchedStatus = statusList.firstWhereOrNull((s) =>
              s.statusname
                  ?.toLowerCase()
                  .contains(pickedAction!.label.toLowerCase()) ??
              false) ??
          StatusListData(
            statusid: _statusIdForAction(pickedAction!),
            statusname: pickedAction!.label,
          );

      final rawApprovalId = currentDetail?.header?.approvalId ?? 0;

      final List<Map<String, dynamic>> itemsListEntry = isReimbursement
          ? approvalReimbursementItems.map((i) => i.toItemsListEntry()).toList()
          : [
        {
          'DetailId': 0,
          'SNo': 0,
          'ExpenseId': 0,
          'ParentId': 0,
          'LedgerId': 0,
          'Description': '',
          'Amount': 0,
          'ApprovedAmt': 0,
          'Status': '',
          'TransId': 0,
        }
      ];

      debugPrint('📤 itemslistentry: ${jsonEncode(itemsListEntry)}');

      // ✅ Derive the correct top-level status string
      final String statusValue = () {
        if (isReimbursement && isReimbursementL1) {
          final allRejected = approvalReimbursementItems
              .every((i) => i.status == ApprovalItemStatus.reject);
          return allRejected ? 'Reject' : 'Verify'; // ← L1 sends 'Verify'
        }
        return pickedAction!.label; // ← L2 and others send normal label
      }();

      final res = await api.updateApprovalStatusApi({
        'userid': homeController.currentUserData?.userid.toString() ?? '',
        'compid': homeController.currentUserData?.compId.toString() ?? '0',
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
        'yearid': homeController.currentUserData?.yearId.toString() ?? '',

        'approvalid':
            (rawApprovalId > 0 ? rawApprovalId : currentItem!.documentId ?? 0)
                .toString(),
        'documentid': (currentItem!.documentId ?? 0).toString(),
        'approvaltype':
            currentItem!.approvalTypeCode ?? currentItem!.approvalType ?? '',

        'statusid': matchedStatus.statusid.toString(),
        'status': statusValue, // ✅ 'Verify' for L1, normal label for L2
        'remarks': remarkCtrl.text.trim(),

        'employeeid': (pickedAction == ApprovalAction.forward
                ? _parseEmployeeId(forwardTo)
                : 0)
            .toString(),

        'approvedamount': approvedAmountStr,

        'itemslistentry': itemsListEntry,
      });

      if (res.status == 200) {
        actionSuccess = true;
        _removeItem(currentItem!);
        _tryRefreshBadge();

        final actionName = isReimbursementL1
            ? 'Verified' // ← better success label for L1
            : (partialApproval ? 'Partially Approved' : pickedAction!.label);
        final docNo = currentItem!.documentNo ?? '';

        Get.snackbar(
          '$actionName ✓',
          'You have $actionName "$docNo" successfully.',
          backgroundColor: pickedAction!.bgColor,
          colorText: pickedAction!.color,
          icon: Text(pickedAction!.emoji, style: const TextStyle(fontSize: 22)),
          duration: const Duration(seconds: 4),
          snackPosition: SnackPosition.TOP,
        );

        Future.delayed(const Duration(milliseconds: 800), () {
          refreshDashboard();
        });
      } else {
        ShowMessage.showSnackBar('Error', res.message?.toString() ?? 'Failed');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Submit', '$e');
      print('Submit Action Error: $e');
    } finally {
      setBusy(false);
      update();
    }
  }

//   Future<void> submitAction() async {
//     if (remarkCtrl.text.trim().isEmpty) {
//       ShowMessage.showSnackBar('Required', 'Please enter a remark');
//       return;
//     }
//     if (pickedAction == null) {
//       ShowMessage.showSnackBar('Required', 'Please select an action first');
//       return;
//     }
//     if (currentItem == null) return;
//
//     // Partial Approval Validation
//     if (pickedAction == ApprovalAction.approve && partialApproval) {
//       final amount = double.tryParse(partialCtrl.text.trim()) ?? 0;
//       if (amount <= 0) {
//         ShowMessage.showSnackBar('Invalid Amount', 'Please enter a valid partial amount');
//         return;
//       }
//       if (currentItem!.amount != null && amount > currentItem!.amount!) {
//         ShowMessage.showSnackBar('Invalid Amount', 'Partial amount cannot be greater than requested amount');
//         return;
//       }
//     }
//
//     // REPLACE the matchedStatus logic with:
//     final matchedStatus = statusList.firstWhereOrNull((s) =>
//     s.statusname?.toLowerCase().contains(
//         pickedAction!.label.toLowerCase()) ??
//         false) ??
//         StatusListData(
//           statusid: _statusIdForAction(pickedAction!), // int is a num, this is fine
//           statusname: pickedAction!.label,
//         );
//
//     // In submitAction(), before setBusy(true):
//     if (pickedAction == ApprovalAction.forward &&
//         (forwardTo == null || forwardTo!.id == '0')) {
//       ShowMessage.showSnackBar('Required', 'Please select a person to escalate to');
//       return;
//     }
//
//     setBusy(true);
//     try {
//       final res = await api.updateApprovalStatusApi({
//         'userid':    homeController.currentUserData?.userid.toString() ?? '',
//         'compid':    homeController.currentUserData?.compId.toString() ?? '0',
//         'branchid':  homeController.currentUserData?.branchId.toString() ?? '',
//         'yearid':    homeController.currentUserData?.yearId.toString() ?? '',
//
//         'approvalid':     (currentDetail?.header?.approvalId ?? currentItem!.documentId ?? 0).toString(),
//         'documentid':     (currentItem!.documentId ?? 0).toString(),
//         'approvaltype': currentItem!.approvalTypeCode ?? currentItem!.approvalType ?? '',
//
//         'statusid':       matchedStatus.statusid.toString(),
//         'status':         pickedAction!.label,
//         'remarks':        remarkCtrl.text.trim(),
//
//         'employeeid':     (pickedAction == ApprovalAction.forward
//             ? _parseEmployeeId(forwardTo)
//             : 0).toString(),
//
//
// // And approvedamount:
//         'approvedamount': (partialApproval &&
//             (currentItem!.approvalTypeCode == 'PaymentL1' ||
//                 currentItem!.approvalTypeCode == 'PaymentL2' ||
//                 currentItem!.approvalType == 'Payment Request L1' ||
//                 currentItem!.approvalType == 'Payment Request L2'))
//             ? (double.tryParse(partialCtrl.text) ?? 0).toString()
//             : '0',
//       });
//
//       if (res.status == 200) {
//         actionSuccess = true;
//         actionResultMsg = partialApproval
//             ? 'Partial Approval done successfully'
//             : '${pickedAction!.label} successfully';
//         _removeItem(currentItem!);
//         _tryRefreshBadge();
//
//         final actionName = partialApproval ? 'Partially Approved' : pickedAction!.label;
//         final docNo = currentItem!.documentNo ?? '';
//
//
//         Get.snackbar(
//           '$actionName ✓',
//           'You have $actionName "$docNo" successfully.',
//           backgroundColor: pickedAction!.bgColor,
//           colorText: pickedAction!.color,
//           icon: Text(pickedAction!.emoji,
//               style: const TextStyle(fontSize: 22)),
//           duration: const Duration(seconds: 3),
//           snackPosition: SnackPosition.TOP,
//           margin: const EdgeInsets.all(12),
//           borderRadius: 12,
//           borderColor: pickedAction!.color,
//           borderWidth: 1,
//         );
//       } else {
//         ShowMessage.showSnackBar('Error', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Submit', '$e');
//     } finally {
//       setBusy(false);
//       update();
//     }
//   }

  //  Bulk action

  Future<void> submitBulkAction(ApprovalAction action, String remark) async {
    final matchedStatus = statusList.firstWhereOrNull((s) =>
            s.statusname?.toLowerCase().contains(action.label.toLowerCase()) ??
            false) ??
        StatusListData(statusid: 0, statusname: action.label);

    setBusy(true);
    int ok = 0;
    final toProcess = List<ApprovalListData>.from(selectedItems);
    for (final item in toProcess) {
      try {
        final res = await api.updateApprovalStatusApi({
          RequestKeys.userId:
              homeController.currentUserData?.userid.toString() ?? '',
          RequestKeys.compId:
              homeController.currentUserData?.compId.toString() ?? '0',
          RequestKeys.branchId:
              homeController.currentUserData?.branchId.toString() ?? '',
          RequestKeys.yearId:
              homeController.currentUserData?.yearId.toString() ?? '',

          'approvalid':
              '0', // not available in bulk — server should use documentid
          'documentid': (item.documentId ?? 0).toString(),
          'approvaltype': item.approvalType ?? '',
          'itemslistentry': null,

          RequestKeys.statusId: matchedStatus.statusid.toString(),
          RequestKeys.status: matchedStatus.statusname.toString(),
          RequestKeys.remarks: remark.isNotEmpty ? remark : action.label,

          'employeeid': '0',
          'approvedamount': '0',
        });
        if (res.status == 200) {
          ok++;
          _removeItem(item);
        }
      } catch (_) {}
    }
    selectedIds.clear();
    _tryRefreshBadge();
    setBusy(false);
    update();
    ShowMessage.showSnackBar('${action.label} Complete',
        '$ok of ${toProcess.length} items processed');
  }

  void _removeItem(ApprovalListData item) {
    if (item.documentId == null) return;

    allApprovals.removeWhere((a) => a.documentId == item.documentId);

    final cat = categories.firstWhereOrNull(
        (c) => c.key == item.approvalTypeCode || c.key == item.approvalType);

    if (cat != null && cat.count > 0) cat.count--;

    _recalcStats();
    update(['list']);
  }

  void _tryRefreshBadge() {
    try {
      Get.put<HomeViewNewController>(HomeViewNewController())
          .getUnApprovalCount();
    } catch (_) {}
  }

  //  Status list

  Future<void> getStatusList() async {
    try {
      final res = await api.getStatusData({
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
      });
      if (res.status == 200) statusList = res.data ?? [];
    } catch (_) {}
    update();
  }

//  Filter state

// Date range — default last 30 days
  late DateTime filterFrom;
  late DateTime filterTo;
  String filterStatus = ''; // '', 'Pending', 'Approved', 'Rejected', 'On Hold'

  bool get isFilterActive {
    final defaultFrom = DateTime.now().subtract(const Duration(days: 30));
    // ✅ Compare by date only, not time — avoids false positives
    return filterStatus.isNotEmpty ||
        filterFrom.year != defaultFrom.year ||
        filterFrom.month != defaultFrom.month ||
        filterFrom.day != defaultFrom.day;
  }

  void applyFilter({
    required DateTime from,
    required DateTime to,
    required String status,
  }) {
    filterFrom = from;
    filterTo = to;
    filterStatus = status;
    refreshDashboard(); // ✅ re-fetch with new date range
  }

  void resetFilter() {
    filterFrom = DateTime.now().subtract(const Duration(days: 30));
    filterTo = DateTime.now();
    filterStatus = '';
    refreshDashboard(); // ✅ re-fetch with default range
  }

  //  Helpers

  // Base params shared by all API calls
  Map<String, String> _base() => {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '0',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.yearId:
            homeController.currentUserData?.yearId.toString() ?? '',
      };

  ApprovalCategory _cat(String? d) => categories.firstWhere(
        (c) => c.key == d,
        orElse: () => ApprovalCategory(
            key: '',
            label: d ?? '',
            emoji: '📋',
            color: newBlueColor,
            lightColor: newBlueLightColor),
      );

  String catEmoji(String? d) => _cat(d).emoji;
  Color catColor(String? d) => _cat(d).color;
  Color catLightColor(String? d) => _cat(d).lightColor;

  int _parseEmployeeId(dynamic selected) {
    if (selected is ForwardOption) {
      return int.tryParse(selected.id) ?? 0;
    }
    return 0;
  }

  Color statusBadgeBg(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'approved':
      case 'approve':
        return newGreenLightColor;
      case 'rejected':
      case 'reject':
        return newRedLightColor;
      case 'disapproved':       // ✅
      case 'disapprove':        // ✅
        return newRedLightColor;
      case 'on hold':
        return newOrangeLightColor;
      case 'reverted':
        return const Color(0xFFEDE9FE);
      default:
        return newOrangeLightColor;
    }
  }

  Color statusBadgeFg(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'approved':
      case 'approve':
        return newGreenColor;
      case 'rejected':
      case 'reject':
        return newRedColor;
      case 'disapproved':       // ✅
      case 'disapprove':        // ✅
        return newRedColor;
      case 'on hold':
        return newOrangeColor;
      case 'reverted':
        return const Color(0xFF7C3AED);
      default:
        return newOrangeColor;
    }
  }

  void _prepareDetail(ApprovalListData item) {
    try {
      remarkCtrl.clear();
    } catch (_) {
      remarkCtrl = TextEditingController();
    }

    // ✅ Single safe reset for partialCtrl
    try {
      partialCtrl.clear();
    } catch (_) {
      partialCtrl = TextEditingController();
    }

    currentItem = item;
    currentDetail = null;
    currentDetails = [];
    currentDocUrl = '';
    actionSuccess = false;
    actionResultMsg = '';
    pickedAction = null;
    partialApproval = false;
    remarkCtrl.clear();
    partialCtrl.text = item.amount?.toString() ?? '';
    isLoadingDetail = true;

    remarkCtrl.text = '';
    partialCtrl.text = item.amount?.toString() ?? '';
    // No update() here
  }

  Future<void> loadDetailData() async {
    if (currentItem == null) return;
    isLoadingDetail = true;
    update();
    await Future.wait([
      _fetchDetails(currentItem!),
      _fetchDoc(currentItem!),
    ]);
    isLoadingDetail = false;
    update(); // ✅ single rebuild after both complete
  }

  int _statusIdForAction(ApprovalAction action) {
    final variations = <String>[];
    switch (action) {
      case ApprovalAction.approve:
        variations.addAll(['approved', 'approve']);
        break;
      case ApprovalAction.reject:
        variations.addAll(['reject']); // ← exact API value
        break;
      case ApprovalAction.hold:
        variations.addAll(['hold']); // ← exact API value
        break;
      case ApprovalAction.revert:
        variations.addAll(['amendment']); // ← exact API value
        break;
      case ApprovalAction.forward:
        variations.addAll(['escalate']); // ← exact API value
        break;
      case ApprovalAction.comment:
        variations.addAll(['comment']);
        break;
      case ApprovalAction.disapprove:
        variations.addAll(['disapproved', 'disapprove']);
        break;
    }
    for (final v in variations) {
      final match = statusList.firstWhereOrNull(
        (s) => s.statusname?.toLowerCase().contains(v) ?? false,
      );
      if (match != null) return (match.statusid ?? 0).toInt();
    }
    return 0;
  }
}
