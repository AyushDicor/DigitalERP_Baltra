// ─────────────────────────────────────────────────────────────────────────────
// issue_item_entry_controller.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'dart:convert';

import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:digitalerp/screen/base/base_controller.dart';
import '../../home_controller.dart';
import '../issue_item_response/issue_item_model.dart';
import '../issue_item_screens/issue_item_list_screen.dart';
import 'issue_item_list_controller.dart';

enum IssueItemSource { direct, fromIndent }

class IssueItemEntryController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 0;
  final PageController pageController = PageController();

  // ── Source ─────────────────────────────────────────────────────────────────
  IssueItemSource selectedSource = IssueItemSource.direct;

  // ── Header dropdowns ───────────────────────────────────────────────────────
  List<IssueItemDropdownOption> issueTypeList    = [];
  List<IssueItemDropdownOption> issueToList      = [];
  List<IssueItemDropdownOption> godownList       = [];
  List<IssueItemDropdownOption> itemIssueTypeList = [];
  List<IssueItemDropdownOption> itemList         = [];
  List<IssueItemDropdownOption> unitList         = [];
  IssueItemDropdownOption? selectedIssueType;
  IssueItemDropdownOption? selectedIssueTo;
  IssueItemDropdownOption? selectedGodown;
  IssueItemDropdownOption? selectedItemIssueType;

  bool isLoadingIssueType     = false;
  bool isLoadingIssueTo       = false;
  bool isLoadingGodown        = false;
  bool isLoadingItemIssueType = false;
  bool isLoadingItems         = false;
  bool isLoadingUnits         = false;

  // ── Header text fields ─────────────────────────────────────────────────────
  final TextEditingController issueDateCtrl = TextEditingController();
  final TextEditingController billNoCtrl    = TextEditingController();
  final TextEditingController remarksCtrl   = TextEditingController();
  String issueNo    = '';
  String issuedBy   = '';

  // ── Indent list (for "From Indent" source) ─────────────────────────────────
  List<PendingIndent> pendingIndentList = [];
  bool isLoadingIndents = false;
  PendingIndent? selectedIndent;

  // ── Item lines ─────────────────────────────────────────────────────────────
  List<IssueItemLine> itemLines = [];

  // ── Edit mode ──────────────────────────────────────────────────────────────
  bool isEditMode  = false;
  int? editIssueId;

  // ── Review ─────────────────────────────────────────────────────────────────
  final TextEditingController reviewRemarksCtrl = TextEditingController();

  // ── Financials ─────────────────────────────────────────────────────────────
  double get totalQty    => itemLines.fold(0, (s, i) => s + i.qty);
  double get totalAmount => itemLines.fold(0, (s, i) => s + i.amount);
  double get grandTotal  => totalAmount;

  // ── Init / Dispose ─────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    issueDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    issueNo   = _generateIssueNo();
    issuedBy  = homeController.currentUserData?.name ?? 'User';

    final args = Get.arguments;
    if (args is IssueItemListItem) {
      isEditMode   = true;
      editIssueId  = args.id;

      _fetchAllDropdowns().then((_) => _prefillFromListItem(args));
    } else {
      _fetchAllDropdowns();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    issueDateCtrl.dispose();
    billNoCtrl.dispose();
    remarksCtrl.dispose();
    reviewRemarksCtrl.dispose();
    super.onClose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────
  void goToStep(int step) {
    if (step < 0 || step > 2) return;
    currentStep = step;
    pageController.animateToPage(step,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (step == 1 && selectedSource == IssueItemSource.fromIndent) {
      fetchPendingIndents();
    }
    update();
  }

  void nextStep() => goToStep(currentStep + 1);
  void prevStep() => goToStep(currentStep - 1);

  // ── Source ─────────────────────────────────────────────────────────────────
  void setSource(IssueItemSource src) {
    selectedSource = src;
    itemLines.clear();
    pendingIndentList.clear();
    selectedIndent = null;
    if (src == IssueItemSource.fromIndent) fetchPendingIndents();
    update();
  }

  // ── Setters ────────────────────────────────────────────────────────────────
  void setIssueType(IssueItemDropdownOption? v) {
    selectedIssueType = v;
    update();
  }

  void setIssueTo(IssueItemDropdownOption? v) {
    selectedIssueTo = v;
    update();
  }

  void setGodown(IssueItemDropdownOption? v) {
    selectedGodown = v;
    update();
  }

  void setItemIssueType(IssueItemDropdownOption? v) {
    selectedItemIssueType = v;
    update();
  }

  // ── Fetch all dropdowns ────────────────────────────────────────────────────
  Future<void> _fetchAllDropdowns() async {
    await Future.wait([
      _fetchIssueTypes(),
      _fetchIssueTo(),
      _fetchGodowns(),
      _fetchItemIssueTypes(),
      _fetchItems(),
      _fetchUnits(),
    ]);
  }

  Map<String, dynamic> _dropBody(String type) => {
    'type':     type,
    'compid':   homeController.currentUserData?.compId   ?? 0,
    'branchid': homeController.currentUserData?.branchId ?? 0,
    'userid':   homeController.currentUserData?.userid   ?? 0,
  };

  Future<void> _fetchIssueTypes() async {
    isLoadingIssueType = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('IssueTo'));                    // adjust 'type' value to match your API
      if (res.status == 200 || res.success == true) {
        issueTypeList = res.data;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Issue Type', '$e');
    } finally {
      isLoadingIssueType = false; update();
    }
  }

  Future<void> _fetchIssueTo() async {
    isLoadingIssueTo = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('party'));                    // adjust type string
      if (res.status == 200 || res.success == true) {
        issueToList = res.data;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Issue To', '$e');
    } finally {
      isLoadingIssueTo = false; update();
    }
  }

  Future<void> _fetchGodowns() async {
    isLoadingGodown = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('Godown'));
      if (res.status == 200 || res.success == true) {
        godownList = res.data;
        if (godownList.isNotEmpty && selectedGodown == null) {
          selectedGodown = godownList.first;
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Godown', '$e');
    } finally {
      isLoadingGodown = false; update();
    }
  }

  Future<void> _fetchItemIssueTypes() async {
    isLoadingItemIssueType = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('itemissuetype'));              // adjust type string
      if (res.status == 200 || res.success == true) {
        itemIssueTypeList = res.data;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Item Issue Type', '$e');
    } finally {
      isLoadingItemIssueType = false; update();
    }
  }

  Future<void> _fetchItems() async {
    isLoadingItems = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('Item'));
      if (res.status == 200 || res.success == true) {
        itemList = res.data;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Items', '$e');
    } finally {
      isLoadingItems = false; update();
    }
  }

  Future<void> _fetchUnits() async {
    isLoadingUnits = true; update();
    try {
      final res = await api.getIssueItemDropdownList(
          _dropBody('Unit'));
      if (res.status == 200 || res.success == true) {
        unitList = res.data;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Units', '$e');
    } finally {
      isLoadingUnits = false; update();
    }
  }

  // ── Fetch pending indents (From Indent source) ─────────────────────────────
  Future<void> fetchPendingIndents() async {
    isLoadingIndents = true;
    pendingIndentList = [];
    selectedIndent = null;
    update();
    try {
      final res = await api.getPendingIndents({
        'userid':   homeController.currentUserData?.userid   ?? 0,
        'compid':   homeController.currentUserData?.compId   ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
      });
      if (res.status == 200 || res.success == true) {
        pendingIndentList = res.data;
      } else {
        ShowMessage.showSnackBar('Indent List', res.message ?? 'No pending indents');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Indent List', '$e');
    } finally {
      isLoadingIndents = false;
      update();
    }
  }

  // ── Select indent → load its items ────────────────────────────────────────
  void selectIndent(PendingIndent indent) {
    selectedIndent = indent;
    update();
    _loadIndentItems(indent.id);
  }


  Future<void> _loadIndentItems(int indentId) async {
    setBusy(true);
    itemLines.clear();
    update();
    try {
      final res = await api.getIndentItemsForIssue({
        'indentid': indentId,
        'compid':   homeController.currentUserData?.compId   ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
      });
      if (res.status == 200 || res.success == true) {
        itemLines = res.data
            .map((i) => IssueItemLine(
          itemId:   i.itemId,
          itemName: i.itemName,
          unitId:   i.unitId,
          unitName: i.unitName,
          qty:      i.quantity,
          rate:     i.rate,
        ))
            .toList();
      } else {
        ShowMessage.showSnackBar('Indent Items', res.message ?? 'Could not load items');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Indent Items', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  // ── Direct item operations ─────────────────────────────────────────────────
  void addDirectItem({
    required int itemId,
    required String itemName,
    required int unitId,
    required String unitName,
    required double qty,
    required double rate,
  }) {
    itemLines.add(IssueItemLine(
      itemId:   itemId,
      itemName: itemName,
      unitId:   unitId,
      unitName: unitName,
      qty:      qty,
      rate:     rate,
    ));
    update();
  }

  void updateItemQty(IssueItemLine item, double qty) {
    item.qty = qty < 0 ? 0 : qty;
    update();
  }

  void increaseQty(IssueItemLine item) {
    item.qty++;
    update();
  }

  void decreaseQty(IssueItemLine item) {
    if (item.qty > 0) { item.qty--; update(); }
  }

  void removeItem(IssueItemLine item) {
    itemLines.remove(item);
    update();
  }

  // ── Edit prefill ───────────────────────────────────────────────────────────
  void _prefillFromListItem(IssueItemListItem item) {
    billNoCtrl.text = item.billNo;
    remarksCtrl.text = item.remarks;
    try {
      final dt = DateTime.tryParse(item.issueDate) ??
          DateFormat('dd-MM-yyyy').tryParseStrict(item.issueDate);
      if (dt != null) {
        issueDateCtrl.text = DateFormat('dd/MM/yyyy').format(dt);
      }
    } catch (_) {}
    update();
    _fetchIssueDetail(item.id);
  }

  Future<void> _fetchIssueDetail(int issueId) async {
    setBusy(true);
    try {
      final res = await api.getIssueItemFullDetail({
        'stockid':  issueId,   // ← key is 'stockid' not 'issueid'
        'compid':   homeController.currentUserData?.compId   ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
      });
      if ((res.status == 200 || res.success == true) && res.data != null) {
        _applyDetail(res.data!);
      } else {
        ShowMessage.showSnackBar('Detail', res.message ?? 'Could not load issue details');
      }
    } catch (e) {
      if (kDebugMode) print('❌ IssueItem detail error: $e');
    } finally {
      setBusy(false);
    }
  }

  void _applyDetail(IssueItemDetailData d) {
    billNoCtrl.text   = d.billNo;
    remarksCtrl.text  = d.remarks;
    issuedBy          = d.issuedBy;

    try {
      final dt = DateTime.tryParse(d.issueDate);
      if (dt != null) issueDateCtrl.text = DateFormat('dd/MM/yyyy').format(dt);
    } catch (_) {}

    if (d.issueToId > 0) {
      selectedIssueTo = issueToList.firstWhereOrNull(
              (o) => o.id == d.issueToId.toString()) ??
          IssueItemDropdownOption(
              id: d.issueToId.toString(), label: d.issueTo);
    }
    if (d.godownId > 0) {
      selectedGodown = godownList.firstWhereOrNull(
              (o) => o.id == d.godownId.toString()) ??
          IssueItemDropdownOption(
              id: d.godownId.toString(), label: d.godown);
    }

    itemLines = d.items
        .map((i) => IssueItemLine(
      itemId:   i.itemId,
      itemName: i.itemName,
      unitId:   0,
      unitName: '',
      qty:      i.qty,
      rate:     i.rate,
      transId:  i.transId,
    ))
        .toList();
    update();
  }

  // ── Date picker ────────────────────────────────────────────────────────────
  Future<void> pickIssueDate(BuildContext ctx) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      issueDateCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
      update();
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────
  Future<void> submitIssueItem() async {
    if (selectedIssueTo == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Issue To');
      return;
    }
    if (selectedGodown == null) {
      ShowMessage.showSnackBar('Validation', 'Please select a Godown');
      return;
    }
    if (itemLines.isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please add at least one item');
      return;
    }
    if (itemLines.any((i) => i.qty <= 0)) {
      ShowMessage.showSnackBar('Validation', 'All items must have qty > 0');
      return;
    }

    setBusy(true);
    try {
      DateTime _parseDate(String d) {
        try { return DateFormat('dd/MM/yyyy').parse(d); }
        catch (_) { return DateTime.now(); }
      }

      final items = itemLines.map((i) => {
        'itemid':        i.itemId,
        'itemname':      i.itemName,
        'unitid':        i.unitId,
        'unit':          i.unitName,       // API uses 'unit' not 'unitname'
        'quantity':      i.qty,            // API uses 'quantity' not 'qty'
        'rate':          i.rate,
        'amount':        i.amount,
        'specification': '',               // required by API, send empty if unused
      }).toList();

      final body = {
        'stockid':         isEditMode ? (editIssueId ?? 0) : 0,
        'entryissuetype':  selectedIssueType?.label ?? '',
        'issueno':         issueNo,
        'issuedate':       _parseDate(issueDateCtrl.text).toIso8601String(),
        'issuetoid':       int.tryParse(selectedIssueTo?.id ?? '0') ?? 0,
        'issuename':       selectedIssueTo?.label ?? '',   // API uses 'issuename'
        'issuedby':        issuedBy,
        'indentid':        selectedSource == IssueItemSource.fromIndent
            ? (selectedIndent?.id ?? 0)
            : 0,
        'billno':          billNoCtrl.text.trim(),
        'jobtypeid':       int.tryParse(selectedIssueType?.id ?? '0') ?? 0,
        'siteid':          0,              // populate if you have a site dropdown
        'godownid':        int.tryParse(selectedGodown?.id ?? '0') ?? 0,
        'itemissuetypeid': int.tryParse(selectedItemIssueType?.id ?? '0') ?? 0,
        'itemissuetype':   selectedItemIssueType?.label ?? '',
        'remarks':         remarksCtrl.text.trim(),
        'totalamount':     totalAmount,
        'totalquantity':   totalQty,       // API uses 'totalquantity'
        'grandtotal':      grandTotal,
        'compid':          homeController.currentUserData?.compId   ?? 0,
        'branchid':        homeController.currentUserData?.branchId ?? 0,
        'userid':          homeController.currentUserData?.userid   ?? 0,
        'yearid':          homeController.currentUserData?.yearId?.toString() ?? '',
        'issueitems':      items,
      };

      final res = await api.saveIssueItem(body);
      if (res.status == 200 || res.success == true) {
        ShowMessage.showSnackBar(
            'Success', res.message ?? 'Issue Item saved successfully');
        if (Get.isRegistered<IssueItemListController>()) {
          Get.find<IssueItemListController>().fetchIssueItemList();
        }
        Get.off(() => const IssueItemListScreen());
      } else {
        ShowMessage.showSnackBar(
            'Error', res.message ?? 'Failed to save Issue Item');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  String _generateIssueNo() {
    final year = DateTime.now().year;
    final seq =
    (DateTime.now().millisecondsSinceEpoch % 9000 + 1000).toString();
    return 'ISS-$year-$seq';
  }
  // String _generateIssueNo() {
  //   return DateTime.now().millisecondsSinceEpoch.toString();
  // }
}

// ── Mutable item line used inside the controller ───────────────────────────
class IssueItemLine {
  final int    itemId;
  final String itemName;
  final int    unitId;
  final String unitName;
  double qty;
  final double rate;
  final int    transId;

  IssueItemLine({
    required this.itemId,
    required this.itemName,
    required this.unitId,
    required this.unitName,
    required this.qty,
    required this.rate,
    this.transId = 0,
  });

  double get amount => qty * rate;
}