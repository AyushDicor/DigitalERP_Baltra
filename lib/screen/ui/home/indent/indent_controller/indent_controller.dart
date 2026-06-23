import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import '../../home_controller.dart';
import '../indent_response/indent_model.dart';
import '../indent_screens/indent_list_screen.dart';
import 'indent_list_controller.dart';

class IndentController extends AppBaseController {
  final HomeController _home = Get.find<HomeController>();

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 0;
  final PageController pageController = PageController();

  // ── Edit mode ──────────────────────────────────────────────────────────────
  bool isEditMode = false;
  int? editIndentId;
  bool get isSubmitting => _submitting;

  // =========================================================================
  // STEP 0 — HEADER
  // =========================================================================

  // Indent No / Date
  String indentNumber = '';
  final TextEditingController indentDisplayNoCtrl = TextEditingController();
  final TextEditingController indentDateCtrl = TextEditingController();
  final TextEditingController requiredDateCtrl = TextEditingController();
  final TextEditingController boqNoCtrl = TextEditingController();
  String get loggedInUserName => _home.currentUserData?.name ?? '';
  // Request By (pre-filled with logged-in user)
  final TextEditingController requestByCtrl = TextEditingController();

  // Indent Type  (Purchase / Stock Issue / Stock Transfer)
  List<IndentDropdownOption> indentTypeList = [];
  IndentDropdownOption? selectedIndentType;
  bool isLoadingIndentType = false;

// Company
  List<IndentDropdownOption> companyList = [];
  IndentDropdownOption? selectedCompany;
  bool isLoadingCompany = false;

// Branch (Request To Site)
  List<IndentDropdownOption> branchList = [];
  IndentDropdownOption? selectedBranch;
  bool isLoadingBranch = false;

// Priority (now from API)
  List<IndentDropdownOption> priorityList = [];
  IndentDropdownOption? selectedPriorityOption;
  bool isLoadingPriority = false;

// Customer Order (BOQ No — now a dropdown)
  List<IndentDropdownOption> customerOrderList = [];
  IndentDropdownOption? selectedCustomerOrder;
  bool isLoadingCustomerOrder = false;

  // Department
  List<IndentDropdownOption> departmentList = [];
  IndentDropdownOption? selectedDepartment;
  bool isLoadingDepartment = false;

  // Job Type
  List<IndentDropdownOption> jobTypeList = [];
  IndentDropdownOption? selectedJobType;
  bool isLoadingJobType = false;

  // Priority  (static)
  final List<String> priorityOptions = ['Low', 'Medium', 'High'];
  String selectedPriority = 'Medium';

  // Site
  List<IndentDropdownOption> siteList = [];
  IndentDropdownOption? selectedSite;
  bool isLoadingSite = false;

  // Godown  (site-dependent)
  List<IndentDropdownOption> godownList = [];
  IndentDropdownOption? selectedGodown;
  bool isLoadingGodown = false;

  // Approver Name
  List<IndentDropdownOption> approverList = [];
  IndentDropdownOption? selectedApprover;
  bool isLoadingApprover = false;

  // Work Order  (site-dependent)
  List<IndentDropdownOption> workOrderList = [];
  IndentDropdownOption? selectedWorkOrder;
  bool isLoadingWorkOrder = false;

  // Site Incharge / Remarks
  final TextEditingController siteInchargeCtrl = TextEditingController();
  final TextEditingController remarksCtrl = TextEditingController();

  // =========================================================================
  // STEP 1 — ITEMS
  // =========================================================================
  List<IndentItemLine> itemLines = [];

  List<IndentDropdownOption> itemList = [];
  bool isLoadingItems = false;

  List<IndentDropdownOption> unitList = [];
  bool isLoadingUnits = false;

  // =========================================================================
  // STEP 2 — REVIEW
  // =========================================================================
  final TextEditingController reviewRemarksCtrl = TextEditingController();

  // ── Financials ─────────────────────────────────────────────────────────────
  double get totalQty => itemLines.fold(0, (s, i) => s + i.indentQty);
  double get totalAmount => itemLines.fold(0, (s, i) => s + i.amount);

  // =========================================================================
  // LIFECYCLE
  // =========================================================================
  @override
  void onInit() {
    super.onInit();
    final now = DateTime.now();
    indentDateCtrl.text = DateFormat('dd/MM/yyyy').format(now);
    requiredDateCtrl.text = DateFormat('dd/MM/yyyy').format(now);
    indentNumber = _generateIndentNumber();
    indentDisplayNoCtrl.text = indentNumber;
    _setLoggedInUser();

    final args = Get.arguments;
    if (args is IndentListItem) {
      isEditMode = true;
      editIndentId = args.id;
      // ← prefill basic fields from list item immediately
      _prefillBasicFromListItem(args);
      // ← wait for dropdowns, THEN fetch and apply full detail
      _fetchAllDropdownsThenDetail(args.id);
    } else {
      _fetchAllDropdowns();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    indentDisplayNoCtrl.dispose();
    indentDateCtrl.dispose();
    requiredDateCtrl.dispose();
    boqNoCtrl.dispose();
    requestByCtrl.dispose();
    siteInchargeCtrl.dispose();
    remarksCtrl.dispose();
    reviewRemarksCtrl.dispose();
    super.onClose();
  }

  @override
  void setBusy(bool value) {
    isBusy = value;
    update(); // ← use ids, not bare update()
  }

  // =========================================================================
  // NAVIGATION
  // =========================================================================
  void goToStep(int step) {
    if (step < 0 || step > 2) return;
    currentStep = step;
    pageController.animateToPage(step,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
    ;
  }

  void nextStep() => goToStep(currentStep + 1);
  void prevStep() => goToStep(currentStep - 1);

  // =========================================================================
  // SETTERS
  // =========================================================================
  void setIndentType(IndentDropdownOption? v) {
    selectedIndentType = v;
    update();
    ;
  }

  void setDepartment(IndentDropdownOption? v) {
    selectedDepartment = v;
    update();
    ;
  }

  void setJobType(IndentDropdownOption? v) {
    selectedJobType = v;
    update();
    ;
  }

  void setGodown(IndentDropdownOption? v) {
    selectedGodown = v;
    update();
    ;
  }

  void setPriority(String v) {
    selectedPriority = v;
    update();
    ;
  }

  void setWorkOrder(IndentDropdownOption? v) {
    selectedWorkOrder = v;
    update();
    ;
  }

  void setApprover(IndentDropdownOption? v) {
    selectedApprover = v;
    update();
    ;
  }

  void setSite(IndentDropdownOption? v) {
    selectedSite = v;
    selectedGodown = null;
    godownList.clear();
    selectedWorkOrder = null;
    workOrderList.clear();
    if (v != null) {
      final sid = int.tryParse(v.id) ?? 0;
      fetchGodowns(siteId: sid);
      fetchWorkOrders(siteId: sid);
    }
    update();
    ;
  }

  // ── Item line mutations ────────────────────────────────────────────────────
  void setIndentQty(IndentItemLine item, double qty) {
    item.indentQty = qty < 0 ? 0 : qty;
    update();
    ;
  }

  void increaseQty(IndentItemLine item) {
    item.indentQty++;
    update();
    ;
  }

  void decreaseQty(IndentItemLine item) {
    if (item.indentQty > 1) {
      item.indentQty--;
      update();
      ;
    }
  }

  void setItemDescription(IndentItemLine item, String val) {
    item.itemDescription = val;
    update();
    ;
  }

  void setCompany(IndentDropdownOption? v) {
    selectedCompany = v;
    update();
  }

  void setBranch(IndentDropdownOption? v) {
    selectedBranch = v;
    update();
  }

  void setPriorityOption(IndentDropdownOption? v) {
    selectedPriorityOption = v;
    if (v != null) selectedPriority = v.label; // ← keep the String in sync
    update();
  }

  void setCustomerOrder(IndentDropdownOption? v) {
    selectedCustomerOrder = v;
    update();
  }

  void removeItem(IndentItemLine item) {
    itemLines.remove(item);
    update();
    ;
  }

  void updateItemRate(IndentItemLine item, double rate) {
    item.rate = rate;
    update();
    ;
  }

  void addItem({
    required String itemId,
    required String itemName,
    required String itemCode,
    required String unit,
    required String unitId,
    required double indentQty,
    required double rate,
    required double stockAtSite,
    required String itemDescription,
  }) {
    if (itemLines.any((i) => i.itemId == itemId)) {
      ShowMessage.showSnackBar('Duplicate', 'Item "$itemName" already added');
      return;
    }
    itemLines.add(IndentItemLine(
      itemId: itemId,
      itemName: itemName,
      itemCode: itemCode,
      unit: unit,
      unitId: unitId,
      indentQty: indentQty,
      rate: rate,
      stockAtSite: stockAtSite,
      itemDescription: itemDescription,
    ));
    update();
    ;
  }

  // ── Date pickers ───────────────────────────────────────────────────────────
  Future<void> pickIndentDate(BuildContext ctx) =>
      _pickDate(ctx, indentDateCtrl);
  Future<void> pickRequiredDate(BuildContext ctx) =>
      _pickDate(ctx, requiredDateCtrl);

  Future<void> _pickDate(BuildContext ctx, TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (c, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF1976D2)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text = DateFormat('dd/MM/yyyy').format(picked);
      update();
      ;
    }
  }

  // =========================================================================
  // SUBMIT
  // =========================================================================
  bool _submitting = false;

  Future<void> submitIndent() async {
    if (selectedSite == null) {
      ShowMessage.showSnackBar('Validation', 'Please select a site');
      return;
    }
    if (itemLines.isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please add at least one item');
      return;
    }
    if (itemLines.any((i) => i.indentQty <= 0)) {
      ShowMessage.showSnackBar('Validation', 'All items must have qty > 0');
      return;
    }

    _submitting = true;
    update();

    setBusy(true);
    try {
      DateTime _parseDate(String d) {
        try {
          return DateFormat('dd/MM/yyyy').parse(d);
        } catch (_) {
          return DateTime.now();
        }
      }

      final items = itemLines
          .map((i) => {
                'seqNo': 0,
                'itemid': int.tryParse(i.itemId) ?? 0,
                'unitid': int.tryParse(i.unitId) ?? 0,
                'quantity': i.indentQty, // ← was 'indentqty'
                'stockquantity': i.stockAtSite, // ← was 'stockatsite'
                'rate': i.rate,
                'amount': i.amount,
                'priorityid': 0,
                'remarks': i.remarks,
                'DueDate': '',
                'linenumber': '',
                'lineitem': i.itemDescription,
                'lineid': 0,
                'boqQty': 0,
                'deliveredQtyamount': i.delQty,
                'autoid': i.transId,
                'bomqty': 0,
              })
          .toList();

      final body = {
        'indentid': isEditMode ? (editIndentId ?? 0) : 0,
        'seriesid': 0,
        'indentno': indentNumber,
        'indentdate': _parseDate(indentDateCtrl.text).toIso8601String(),
        'requireddate': _parseDate(requiredDateCtrl.text)
            .toIso8601String(), // ← was 'duedate'
        'receivedby': requestByCtrl.text.trim(), // ← was 'requestby'
        'orderid': int.tryParse(selectedWorkOrder?.id ?? '0') ??
            0, // ← was 'workorderid'
        'departmentid': int.tryParse(selectedDepartment?.id ?? '0') ?? 0,
        'jobtypeid': int.tryParse(selectedJobType?.id ?? '0') ?? 0,
        'siteid': int.tryParse(selectedSite?.id ?? '0') ?? 0,
        'empid': _home.currentUserData?.userid ?? 0,
        'godownid': int.tryParse(selectedGodown?.id ?? '0') ?? 0,
        'siteincharge': siteInchargeCtrl.text.trim(),
        'Approver': selectedApprover?.label ?? '', // ← capital A
        'ApproverId':
            int.tryParse(selectedApprover?.id ?? '0') ?? 0, // ← capital A+I
        'Agent': '',
        'entrystatus': 'Final', // ← always Final
        'remarks': remarksCtrl.text.trim(),
        'totalamount': totalAmount,
        'totalquantity': totalQty,
        'compid': _home.currentUserData?.compId ?? 0,
        'branchid': _home.currentUserData?.branchId ?? 0,
        'userid': _home.currentUserData?.userid ?? 0,
        'yearid': _currentYearId(),
        'grandtotal': totalAmount,
        'indentitems': items,
        'companyid': int.tryParse(selectedCompany?.id ?? '0') ?? 0,
        'reuesttoid': int.tryParse(selectedBranch?.id ?? '0') ?? 0,
        'priortyid': int.tryParse(selectedPriorityOption?.id ?? '0') ?? 0,
        'indenttype': selectedIndentType?.label ?? '',
// BOQ from dropdown:
        'BOQNo': selectedCustomerOrder?.label ?? boqNoCtrl.text.trim(),
      };

      if (kDebugMode) {
        print('📦 INDENT SUBMIT PAYLOAD');
        print(const JsonEncoder.withIndent('  ').convert(body));
      }

      // Returns IndentSubmitResponse  { status, success, message }
      final res = await api.saveIndent(body);
      if (res.success == true || res.status == 200) {
        ShowMessage.showSnackBar('Success', res.message ?? 'Indent saved');
        if (Get.isRegistered<IndentListController>()) {
          Get.find<IndentListController>().fetchIndentList();
        }
        Get.off(() => const IndentListScreen());
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      _submitting = false;
      update();
      ;
    }
  }

  // =========================================================================
  // EDIT PREFILL
  // =========================================================================
  void _prefillFromListItem(IndentListItem item) {
    indentNumber = item.indentNo;
    indentDisplayNoCtrl.text = item.indentNo;
    requestByCtrl.text = item.requestBy;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item.indentDate);
      indentDateCtrl.text = DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {}
    update();
    ;
    _fetchIndentDetail(item.id);
  }

  Future<void> _fetchIndentDetail(int indentId) async {
    setBusy(true);
    try {
      final body = {
        'indentid': indentId,
        'compid': _home.currentUserData?.compId ?? 0,
        'branchid': _home.currentUserData?.branchId ?? 0,
      };
      // Returns IndentDetailResponse  { status, success, message, data: IndentDetailData? }
      final res = await api.getIndentDetail(body);
      if ((res.success == true || res.status == 200) && res.data != null) {
        await _applyDetail(res.data!);
      } else {
        ShowMessage.showSnackBar(
            'Detail', res.message ?? 'Could not load indent details');
      }
    } catch (e) {
      if (kDebugMode) print('❌ Indent detail error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> _applyDetail(IndentDetailData d) async {
    indentNumber = d.indentno;
    indentDisplayNoCtrl.text = d.indentno;

    requestByCtrl.text = d.requestby;
    siteInchargeCtrl.text = d.siteIncharge;
    remarksCtrl.text = d.remarks;
    boqNoCtrl.text = d.workorderno;

    // Priority comes as string from detail, use it directly if non-empty
    if (d.priority.isNotEmpty) {
      selectedPriority = d.priority;
    }

    _setDateCtrl(indentDateCtrl, d.indentdate);
    _setDateCtrl(requiredDateCtrl, d.requireddate);

    if (d.siteid > 0) {
      selectedSite =
          siteList.firstWhereOrNull((s) => s.id == d.siteid.toString()) ??
              IndentDropdownOption(id: d.siteid.toString(), label: d.sitename);
      // Godown and WorkOrder already loaded via _fetchAllDropdownsThenDetail
      // but re-fetch to be safe since they're site-dependent
      fetchGodowns(siteId: d.siteid);
      fetchWorkOrders(siteId: d.siteid);
    }
    // Company
    if (companyList.isNotEmpty) {
      selectedCompany =
          companyList.firstWhereOrNull((c) => c.id == d.compid.toString()) ??
              companyList.first;
    }

// Branch — reuesttoid is the branch id
    selectedBranch = branchList.firstWhereOrNull((b) =>
            b.id == d.workorderid.toString()) // workorderid maps to reuesttoid
        ??
        branchList.firstWhereOrNull(
            (b) => b.id == _home.currentUserData?.branchId.toString());

// Priority by ID (priortyid)
// Add priortyid to IndentDetailData first (see step 6)
    if (d.indentType.isNotEmpty) {
      selectedIndentType = indentTypeList.firstWhereOrNull(
            (t) => t.label.toLowerCase() == d.indentType.toLowerCase(),
          ) ??
          IndentDropdownOption(id: '0', label: d.indentType);
    }

    if (d.priortyid > 0) {
      selectedPriorityOption =
          priorityList.firstWhereOrNull((p) => p.id == d.priortyid.toString());
      if (selectedPriorityOption != null) {
        selectedPriority = selectedPriorityOption!.label; // ← ADD
      }
    }

// Customer Order / BOQ
    if (d.boqNo.isNotEmpty) {
      selectedCustomerOrder = customerOrderList
              .firstWhereOrNull((o) => o.label == d.boqNo || o.id == d.boqNo) ??
          IndentDropdownOption(id: d.boqNo, label: d.boqNo);
      boqNoCtrl.text = d.boqNo; // keep text ctrl in sync
    }

    if (d.siteid > 0) {
      selectedSite =
          siteList.firstWhereOrNull((s) => s.id == d.siteid.toString()) ??
              IndentDropdownOption(id: d.siteid.toString(), label: d.sitename);

      // ← await these so we can set selection AFTER list loads
      await fetchGodowns(siteId: d.siteid);
      await fetchWorkOrders(siteId: d.siteid);

      // Set godown AFTER list is loaded
      if (d.godownid > 0) {
        selectedGodown =
            godownList.firstWhereOrNull((g) => g.id == d.godownid.toString()) ??
                IndentDropdownOption(
                    id: d.godownid.toString(), label: d.godownname);
      }

      // Set work order AFTER list is loaded (may be empty if API returns 500)
      if (d.workorderid > 0 && workOrderList.isNotEmpty) {
        selectedWorkOrder = workOrderList
                .firstWhereOrNull((w) => w.id == d.workorderid.toString()) ??
            IndentDropdownOption(
                id: d.workorderid.toString(), label: d.workorderno);
      } else if (d.workorderid > 0) {
        // API returned no workorders but we have an ID — set it directly
        selectedWorkOrder = IndentDropdownOption(
            id: d.workorderid.toString(), label: d.workorderno);
      }
    }

    if (d.departmentid > 0) {
      selectedDepartment = departmentList
              .firstWhereOrNull((dep) => dep.id == d.departmentid.toString()) ??
          IndentDropdownOption(
              id: d.departmentid.toString(), label: d.department);
    }

    if (d.jobtypeid > 0) {
      selectedJobType = jobTypeList
              .firstWhereOrNull((j) => j.id == d.jobtypeid.toString()) ??
          IndentDropdownOption(id: d.jobtypeid.toString(), label: d.jobtype);
    }

    itemLines = d.items
        .map((i) => IndentItemLine(
              itemId: i.itemid.toString(),
              itemName: i.itemname,
              itemCode: i.itemid.toString(),
              unit: i.unitname,
              unitId: i.unitid.toString(),
              prQty: i.prqty,
              indentQty: i.indentqty,
              delQty: i.delqty,
              rate: i.rate,
              stockAtSite: i.stockatsite,
              itemDescription: i.itemdescription,
              transId: i.transid,
            ))
        .toList();

    if (kDebugMode) print('📦 Detail applied — items: ${itemLines.length}');
    update();
    ;
  }

  // =========================================================================
  // DROPDOWN FETCHERS — all POST /api/indentandissuedropdown
  // Returns IndentDropdownResponse  { status, success, message, data: List<IndentDropdownOption> }
  // IndentDropdownOption.fromJson maps { "id": ..., "name": ... }
  // =========================================================================
  Map<String, dynamic> _ddBody(String type,
          {int siteId = 0, int partyId = 0}) =>
      {
        'type': type,
        'compid': _home.currentUserData?.compId ?? 0,
        'branchid': _home.currentUserData?.branchId ?? 0,
        'userid': _home.currentUserData?.userid ?? 0,
        'siteid': siteId,
        'partyid': partyId,
        'dependentid': siteId,
      };

  bool isInitialLoading = false;

  // Replace _fetchAllDropdowns:
  Future<void> _fetchAllDropdowns() async {
    isInitialLoading = true;
    update();

    try {
      await Future.wait([
        fetchIndentTypes(),
        fetchSites(),
        fetchDepartments(),
        fetchJobTypes(),
        fetchApprovers(),
        fetchItems(),
        fetchUnits(),
        fetchCompanies(),
        fetchBranches(),
        fetchPriorities(),
        fetchCustomerOrders(),
      ]).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          if (kDebugMode) print('⚠️ Dropdown fetch timed out');
          return [];
        },
      );

      if (kDebugMode) {
        print('✅ IndentTypes: ${indentTypeList.length}');
        print('✅ Sites: ${siteList.length}');
        print('✅ Departments: ${departmentList.length}');
        print('✅ JobTypes: ${jobTypeList.length}');
        print('✅ Approvers: ${approverList.length}');
        print('✅ Items: ${itemList.length}');
        print('✅ Units: ${unitList.length}');
        print('✅ Companies: ${companyList.length}');
        print('✅ Branches: ${branchList.length}');
        print('✅ Priorities: ${priorityList.length}');
        print('✅ CustomerOrders: ${customerOrderList.length}');
      }
    } catch (e) {
      if (kDebugMode) print('❌ _fetchAllDropdowns error: $e');
    } finally {
      isInitialLoading = false;
      update();
    }
  }

  Future<void> fetchSites() async {
    isLoadingSite = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('Site'));
      if (res.success == true || res.status == 200) siteList = res.data;
    } catch (e) {
      _postSnack('Site', e);
    } finally {
      isLoadingSite = false;
      update();
    }
  }

  Future<void> fetchDepartments() async {
    isLoadingDepartment = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('department'));
      if (res.success == true || res.status == 200) departmentList = res.data;
    } catch (e) {
      _postSnack('Department', e);
    } finally {
      isLoadingDepartment = false;
      update();
    }
  }

  Future<void> fetchJobTypes() async {
    isLoadingJobType = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('Jobtype'));
      if (res.success == true || res.status == 200) jobTypeList = res.data;
    } catch (e) {
      _postSnack('Job Type', e);
    } finally {
      isLoadingJobType = false;
      update();
    }
  }

  Future<void> fetchApprovers() async {
    isLoadingApprover = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('ApproverName'));
      if (res.success == true || res.status == 200) approverList = res.data;
    } catch (e) {
      _postSnack('Approver', e);
    } finally {
      isLoadingApprover = false;
      update();
    }
  }

  Future<void> fetchItems() async {
    isLoadingItems = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('Item'));
      if (res.success == true || res.status == 200) itemList = res.data;
    } catch (e) {
      _postSnack('Items', e);
    } finally {
      isLoadingItems = false;
      update();
    }
  }

  Future<void> fetchUnits() async {
    isLoadingUnits = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('Unit'));
      if (res.success == true || res.status == 200) unitList = res.data;
    } catch (e) {
      _postSnack('Units', e);
    } finally {
      isLoadingUnits = false;
      update();
    }
  }

  Future<void> fetchCompanies() async {
    isLoadingCompany = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('company'));
      if (res.success == true || res.status == 200) {
        companyList = res.data;
        final cid = _home.currentUserData?.compId.toString();
        if (cid != null) {
          selectedCompany = companyList.firstWhereOrNull((c) => c.id == cid) ??
              (companyList.isNotEmpty ? companyList.first : null);
        }
      }
    } catch (e) {
      _postSnack('Company', e);
    } finally {
      isLoadingCompany = false;
      update();
    }
  }

  Future<void> fetchBranches() async {
    isLoadingBranch = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('branch'));
      if (res.success == true || res.status == 200) {
        branchList = res.data;
        final bid = _home.currentUserData?.branchId.toString();
        if (bid != null) {
          selectedBranch = branchList.firstWhereOrNull((b) => b.id == bid) ??
              (branchList.isNotEmpty ? branchList.first : null);
        }
      }
    } catch (e) {
      _postSnack('Branch', e);
    } finally {
      isLoadingBranch = false;
      update();
    }
  }

  Future<void> fetchPriorities() async {
    isLoadingPriority = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('Priority'));
      if ((res.success == true || res.status == 200) && res.data.isNotEmpty) {
        priorityList = res.data;
      } else {
        priorityList = [
          const IndentDropdownOption(id: '1', label: 'Low'),
          const IndentDropdownOption(id: '2', label: 'Medium'),
          const IndentDropdownOption(id: '3', label: 'High'),
          const IndentDropdownOption(id: '4', label: 'Urgent'),
        ];
      }
    } catch (e) {
      priorityList = [
        const IndentDropdownOption(id: '1', label: 'Low'),
        const IndentDropdownOption(id: '2', label: 'Medium'),
        const IndentDropdownOption(id: '3', label: 'High'),
        const IndentDropdownOption(id: '4', label: 'Urgent'),
      ];
    } finally {
      isLoadingPriority = false;
      update();
    }
  }

  Future<void> fetchCustomerOrders() async {
    isLoadingCustomerOrder = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('customerorder'));
      if (res.success == true || res.status == 200) {
        customerOrderList = res.data;
      }
    } catch (e) {
      _postSnack('Customer Order', e);
    } finally {
      isLoadingCustomerOrder = false;
      update();
    }
  }

  Future<void> fetchIndentTypes() async {
    isLoadingIndentType = true;
    update();
    try {
      final res = await api.getIndentDropdownList(_ddBody('IndentType'));
      if (res.success == true || res.status == 200) {
        indentTypeList = res.data;
      }
      if (indentTypeList.isEmpty) {
        indentTypeList = [
          const IndentDropdownOption(id: '1', label: 'Purchase'),
          const IndentDropdownOption(id: '2', label: 'Stock Issue'),
          const IndentDropdownOption(id: '3', label: 'Stock Transfer'),
        ];
      }
    } catch (e) {
      indentTypeList = [
        const IndentDropdownOption(id: '1', label: 'Purchase'),
        const IndentDropdownOption(id: '2', label: 'Stock Issue'),
        const IndentDropdownOption(id: '3', label: 'Stock Transfer'),
      ];
    } finally {
      isLoadingIndentType = false;
      update();
    }
  }

  Future<void> fetchGodowns({int siteId = 0}) async {
    isLoadingGodown = true;
    selectedGodown = null; // ← clear previous selection
    update();
    try {
      final res =
          await api.getIndentDropdownList(_ddBody('Godown', siteId: siteId));
      if (res.success == true || res.status == 200) {
        godownList = res.data;
        if (godownList.length == 1) {
          // ← auto-select if only one result
          selectedGodown = godownList.first;
        }
      }
    } catch (e) {
      _postSnack('Godown', e);
    } finally {
      isLoadingGodown = false;
      update();
    }
  }

  Future<void> fetchWorkOrders({int siteId = 0}) async {
    isLoadingWorkOrder = true;
    update();
    try {
      final res =
          await api.getIndentDropdownList(_ddBody('workorder', siteId: siteId));
      if (res.success == true || res.status == 200) workOrderList = res.data;
    } catch (e) {
      _postSnack('Work Order', e);
    } finally {
      isLoadingWorkOrder = false;
      update();
    }
  }

  // Returns IndentItemStockResponse  { status, success, message, stock: double? }
  Future<double?> fetchStockAtSite(int itemId) async {
    final siteId = int.tryParse(selectedSite?.id ?? '0') ?? 0;
    try {
      final res = await api.getIndentItemStock(
        itemId: itemId,
        siteId: siteId,
        compId: _home.currentUserData?.compId ?? 0,
        branchId: _home.currentUserData?.branchId ?? 0,
      );
      if (res.success == true || res.status == 200) return res.stock;
      return null;
    } catch (e) {
      if (kDebugMode) print('fetchStockAtSite error: $e');
      return null;
    }
  }

  // =========================================================================
  // HELPERS
  // =========================================================================
  void _setLoggedInUser() {
    requestByCtrl.text = _home.currentUserData?.name ?? '';
  }

  String _generateIndentNumber() {
    final year = DateTime.now().year;
    final seq =
        (DateTime.now().millisecondsSinceEpoch % 9000 + 1000).toString();
    return 'IND-$year-$seq';
  }

  void _setDateCtrl(TextEditingController ctrl, String raw) {
    if (raw.isEmpty) return;
    try {
      DateTime? dt = DateTime.tryParse(raw);
      dt ??= DateFormat('dd-MM-yyyy').tryParseStrict(raw);
      dt ??= DateFormat('dd/MM/yyyy').tryParseStrict(raw);
      if (dt != null) ctrl.text = DateFormat('dd/MM/yyyy').format(dt);
    } catch (_) {}
  }

  void _postSnack(String title, Object e) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowMessage.showSnackBar(title, '$e');
    });
  }

  String _currentYearId() {
    final now = DateTime.now();
    final startYear = now.month >= 4 ? now.year : now.year - 1;
    return '$startYear-${(startYear + 1).toString().substring(2)}';
    // e.g. "2026-27"
  }

  // Called immediately — fills text fields from list item data
  void _prefillBasicFromListItem(IndentListItem item) {
    final cleanNo = item.indentNo.startsWith('#')
        ? item.indentNo.substring(1)
        : item.indentNo;
    indentNumber = cleanNo;
    indentDisplayNoCtrl.text = cleanNo;
    requestByCtrl.text = item.requestBy;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item.indentDate);
      indentDateCtrl.text = DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {}
    update();
    ;
  }

  Future<void> _fetchAllDropdownsThenDetail(int indentId) async {
    // Load all dropdowns first
    await _fetchAllDropdowns();
    // Now fetch detail — dropdowns are ready so ID matching will work
    await _fetchIndentDetail(indentId);
  }
}
