import 'dart:convert';
import 'dart:io';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../repo/reimbursement_repo.dart';
import '../../grn/grn_response/additional_charge_model.dart';
import '../../home_controller.dart';
import '../mrn_response/mrn_models.dart';
import '../mrn_screens/mrn_list_screen.dart';
import 'mrn_additional_charges_mixin.dart';
import 'mrn_list_controller.dart';

class MrnController extends AppBaseController with MrnAdditionalChargesMixin {
  final HomeController homeController = Get.find<HomeController>();

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 0;
  final PageController pageController = PageController();

  // ── Step 1: Header ─────────────────────────────────────────────────────────
  List<MrnDropdownOption> seriesTypeList = [];
  MrnDropdownOption? selectedSeriesType;
  bool isLoadingSeriesType = false;

  final TextEditingController mrnDateCtrl = TextEditingController();
  String mrnNumber = '';

  // ── Source selection ───────────────────────────────────────────────────────
  MrnSourceType selectedSource = MrnSourceType.purchaseOrder;

  // ── Party ──────────────────────────────────────────────────────────────────
  final TextEditingController partyNameCtrl = TextEditingController();
  List<MrnDropdownOption> partyList = [];
  MrnDropdownOption? selectedParty;
  bool isLoadingParty = false;
  bool get isSourceLocked => isEditMode;
  bool get isPartyLocked => isEditMode;

  void setParty(MrnDropdownOption? v) {
    selectedParty = v;
    partyNameCtrl.text = v?.label ?? '';
    if (v != null) {
      fetchSites(partyId: int.tryParse(v.id) ?? 0);
      fetchWorkOrders(
        partyId: int.tryParse(v.id) ?? 0,
        siteId: int.tryParse(selectedSite?.id ?? '0') ?? 0,
      );
    }
    update();
  }

  // ── Site / Godown ──────────────────────────────────────────────────────────
  List<MrnDropdownOption> siteList = [];
  MrnDropdownOption? selectedSite;
  bool isLoadingSite = false;

  List<MrnDropdownOption> godownList = [];
  MrnDropdownOption? selectedGodown;
  bool isLoadingGodown = false;

  // ── Document Type ──────────────────────────────────────────────────────────
  List<MrnDropdownOption> documentTypeList = [];
  bool isLoadingDocumentTypes = false;
  Set<String> selectedDocumentTypeIds = {};

  String get selectedDocumentTypesString => selectedDocumentTypeIds.join(',');

  final TextEditingController billNoCtrl = TextEditingController();
  final TextEditingController billDateCtrl = TextEditingController();
  final TextEditingController challanNoCtrl = TextEditingController();
  final TextEditingController challanDateCtrl = TextEditingController();
  String receivedByName = '';

  // ── Addresses ──────────────────────────────────────────────────────────────
  MrnAddress? shippingAddress;
  MrnAddress? billingAddress;
  bool isLoadingAddresses = false;

  // ── Attachments ────────────────────────────────────────────────────────────
  Set<MrnAttachmentType> selectedAttachmentTypes = {
    MrnAttachmentType.bill,
    MrnAttachmentType.challan,
  };
  List<MrnDocument> billAttachments = [];
  List<MrnDocument> challanAttachments = [];
  final TextEditingController reasonNACtrl = TextEditingController();

  // ── Additional fields ──────────────────────────────────────────────────────
  List<MrnDropdownOption> paidTypeList = [
    MrnDropdownOption(id: 'Employee', label: 'Employee'),
    MrnDropdownOption(id: 'Company', label: 'Company'),
  ];
  List<MrnDropdownOption> paidByList = [];
  MrnDropdownOption? selectedPaidBy;
  bool isLoadingPaidBy = false;
  MrnDropdownOption? selectedPaidType;
  bool isLoadingPaidType = false;

  String selectedQcRequired = 'Yes';
  final List<String> qcRequiredOptions = ['Yes', 'No'];

  List<MrnDropdownOption> customerPoList = [];
  MrnDropdownOption? selectedCustomerPo;
  bool isLoadingCustomerPo = false;

  List<MrnDropdownOption> jobTypeList = [];
  MrnDropdownOption? selectedJobType;
  bool isLoadingJobType = false;

  List<MrnDropdownOption> workOrderList = [];
  MrnDropdownOption? selectedWorkOrder;
  bool isLoadingWorkOrder = false;

  List<String> existingBillFiles = [];
  List<String> existingDcFiles = [];

  final TextEditingController lotNoCtrl = TextEditingController();
  final TextEditingController grnNoCtrl = TextEditingController();
  final TextEditingController grnDateCtrl = TextEditingController();
  final TextEditingController gateEntryNoCtrl = TextEditingController();

  // ── Step 2: PO list & Items ────────────────────────────────────────────────
  List<PendingPoItem> poList = [];
  bool isLoadingPO = false;
  List<MrnItemLine> itemLines = [];
  bool isLoadingItems = false;
  String? expandedPoNumber;
  PendingPoItem? processingPo;

  // ── Direct entry dropdowns ─────────────────────────────────────────────────
  List<MrnDropdownOption> directItemList = [];
  bool isLoadingDirectItems = false;

  List<MrnDropdownOption> unitList = [];
  bool isLoadingUnit = false;

  List<MrnDropdownOption> makeList = [];
  bool isLoadingMake = false;

  bool isLoadingItemDetail = false;

  List<MrnDropdownOption> taxType = [];

  // ── Edit ───────────────────────────────────────────────────────────────────
  bool isEditMode = false;
  int? editStockId;

  // ── Step 3: Review ─────────────────────────────────────────────────────────
  final TextEditingController reviewRemarksCtrl = TextEditingController();

  // ── Financials ─────────────────────────────────────────────────────────────
  double get subtotal => itemLines.fold(0, (s, i) => s + i.amount);
  double get totalGst => itemLines.fold(0, (s, i) => s + i.gstAmount);
  double get grandTotal => subtotal + totalGst;
  double get totalDiscount => itemLines.fold(0, (s, i) => s + i.discountAmount);
  double get roundOff {
    final exact = grandTotal;
    final rounded = exact.roundToDouble();
    return double.parse((rounded - exact).toStringAsFixed(2));
  }

  double get grandTotalRounded => grandTotal + roundOff;

  final ImagePicker picker = ImagePicker();

  // ── Init / Dispose ─────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    mrnDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    billDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    challanDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    grnDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    mrnNumber = _generateMrnNumber();
    _setLoggedInUser();
    _fetchAllDropdowns();

    final args = Get.arguments;
    if (args is MrnListItem) {
      isEditMode = true;
      editStockId = args.id;
      _prefillFromListItem(args);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    mrnDateCtrl.dispose();
    billDateCtrl.dispose();
    challanDateCtrl.dispose();
    partyNameCtrl.dispose();
    billNoCtrl.dispose();
    challanNoCtrl.dispose();
    reasonNACtrl.dispose();
    reviewRemarksCtrl.dispose();
    lotNoCtrl.dispose();
    grnNoCtrl.dispose();
    grnDateCtrl.dispose();
    gateEntryNoCtrl.dispose();
    super.onClose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────
  void goToStep(int step) {
    if (step < 0 || step > 2) return;
    currentStep = step;
    pageController.animateToPage(step,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (step == 1 && selectedSource == MrnSourceType.purchaseOrder) {
      fetchPendingPoList();
    }
    update();
  }

  void nextStep() => goToStep(currentStep + 1);
  void prevStep() => goToStep(currentStep - 1);

  // ── Source ─────────────────────────────────────────────────────────────────
  void setSource(MrnSourceType src) {
    selectedSource = src;
    itemLines.clear();
    poList.clear();
    processingPo = null;
    existingBillFiles = [];
    existingDcFiles = [];
    if (src == MrnSourceType.purchaseOrder) {
      fetchPendingPoList();
    }
    update();
  }

  // ── Step 1 setters ─────────────────────────────────────────────────────────
  void setSeriesType(MrnDropdownOption? v) {
    selectedSeriesType = v;
    update();
  }

  void setSite(MrnDropdownOption? v) {
    selectedSite = v;
    selectedCustomerPo = null;
    selectedGodown = null;
    final siteId = int.tryParse(v?.id ?? '0') ?? 0;
    final partyId = int.tryParse(selectedParty?.id ?? '0') ?? 0;
    fetchWorkOrders(partyId: partyId, siteId: siteId);
    fetchCustomerPOs(siteId: siteId);
    fetchGodowns(siteId: siteId);

    update();
  }

  void setGodown(MrnDropdownOption? v) {
    selectedGodown = v;
    update();
  }

  void setQcRequired(String v) {
    selectedQcRequired = v;
    update();
  }

  // ── ✅ Customer PO selected → fetch dependent detail to auto-fill Job Type ──
  void setCustomerPo(MrnDropdownOption? v) {
    selectedCustomerPo = v;
    _refreshWorkOrders();
    update();

    if (v != null && v.id.isNotEmpty) {
      _fetchDependentDetail(
        type: 'customerpo',
        dependentId: v.id,
        onResult: (detail) {
          // Customer PO selection → auto-fill Job Type only
          if (detail.hasJobType) {
            final matched = jobTypeList.firstWhereOrNull(
              (j) => j.id == detail.jobtypeid.toString(),
            );
            if (matched != null) {
              selectedJobType = matched;
              if (kDebugMode) {
                print(
                    '✅ Auto-filled JobType from CustomerPO: ${matched.label}');
              }
              update();
            }
          }
        },
      );
    }
  }

  // ── ✅ Job Type selected → (no dependent call needed, just refresh work orders)
  void setJobType(MrnDropdownOption? v) {
    selectedJobType = v;
    _refreshWorkOrders();
    update();
  }

  // ── ✅ Work Order selected → fetch dependent detail to auto-fill Job Type + Customer PO ──
  void setWorkOrder(MrnDropdownOption? v) {
    selectedWorkOrder = v;
    update();

    if (v != null && v.id.isNotEmpty) {
      _fetchDependentDetail(
        type: 'workorder',
        dependentId: v.id,
        onResult: (detail) {
          bool changed = false;

          // Auto-fill Job Type
          if (detail.hasJobType) {
            final matched = jobTypeList.firstWhereOrNull(
              (j) => j.id == detail.jobtypeid.toString(),
            );
            if (matched != null) {
              selectedJobType = matched;
              changed = true;
              if (kDebugMode) {
                print('✅ Auto-filled JobType from WorkOrder: ${matched.label}');
              }
            }
          }

          // Auto-fill Customer PO
          if (detail.hasCustomerPo) {
            final matched = customerPoList.firstWhereOrNull(
              (c) => c.id == detail.customerpoid.toString(),
            );
            if (matched != null) {
              selectedCustomerPo = matched;
              changed = true;
              if (kDebugMode) {
                print(
                    '✅ Auto-filled CustomerPO from WorkOrder: ${matched.label}');
              }
            } else {
              // Not yet in list — create a stub so it can be matched later
              selectedCustomerPo = MrnDropdownOption(
                id: detail.customerpoid.toString(),
                label: '',
              );
              changed = true;
            }
          }

          if (changed) update();
        },
      );
    }
  }

  void toggleAttachmentType(MrnAttachmentType type) {
    if (selectedAttachmentTypes.contains(type)) {
      selectedAttachmentTypes.remove(type);
    } else {
      selectedAttachmentTypes.add(type);
    }
    update();
  }

  String get attachmentTypeLabel {
    if (selectedAttachmentTypes.isEmpty) return 'None selected';
    return selectedAttachmentTypes.map((t) {
      switch (t) {
        case MrnAttachmentType.bill:
          return 'Bill';
        case MrnAttachmentType.challan:
          return 'Challan';
      }
    }).join(', ');
  }

  // ── Re-match dropdowns after edit prefill ──────────────────────────────────
  void _rematchEditSelections() {
    if (!isEditMode || editStockId == null) return;

    if (selectedGodown != null && godownList.isNotEmpty) {
      selectedGodown =
          godownList.firstWhereOrNull((g) => g.id == selectedGodown!.id) ??
              selectedGodown;
    }
    if (selectedJobType != null && jobTypeList.isNotEmpty) {
      selectedJobType =
          jobTypeList.firstWhereOrNull((j) => j.id == selectedJobType!.id) ??
              selectedJobType;
    }
    if (selectedSeriesType != null && seriesTypeList.isNotEmpty) {
      selectedSeriesType = seriesTypeList
              .firstWhereOrNull((s) => s.id == selectedSeriesType!.id) ??
          selectedSeriesType;
    }
    if (selectedCustomerPo != null && customerPoList.isNotEmpty) {
      selectedCustomerPo = customerPoList
              .firstWhereOrNull((c) => c.id == selectedCustomerPo!.id) ??
          selectedCustomerPo;
    }
    if (selectedSite != null && siteList.isNotEmpty) {
      selectedSite =
          siteList.firstWhereOrNull((s) => s.id == selectedSite!.id) ??
              selectedSite;
    }
    if (selectedParty != null && partyList.isNotEmpty) {
      selectedParty =
          partyList.firstWhereOrNull((p) => p.id == selectedParty!.id) ??
              selectedParty;
    }

    update();
  }

  // ── Financial year string ─────────────────────────────────────────────────
  String get currentYearId {
    final now = DateTime.now();
    final fyStart = now.month >= 4 ? now.year : now.year - 1;
    final fyEnd = fyStart + 1;
    final fyEndShort = fyEnd.toString().substring(2);
    return '$fyStart-$fyEndShort';
  }

  void setPaidType(MrnDropdownOption? v) {
    selectedPaidType = v;
    selectedPaidBy = null;
    if (v?.id == 'Employee') {
      fetchPaidByEmployees();
    } else {
      paidByList = [];
    }
    update();
  }

  void setPaidBy(MrnDropdownOption? v) {
    selectedPaidBy = v;
    update();
  }

  void _prefillFromListItem(MrnListItem item) {
    mrnNumber = item.mrnNo;
    billNoCtrl.text = item.billNo;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item.mrnDate);
      mrnDateCtrl.text = DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {}
    partyNameCtrl.text = item.partyName;
    update();
    _fetchMrnDetail(item.id);
  }

  void removeExistingBillFile(int index) {
    if (index < existingBillFiles.length) {
      existingBillFiles.removeAt(index);
      update();
    }
  }

  void removeExistingDcFile(int index) {
    if (index < existingDcFiles.length) {
      existingDcFiles.removeAt(index);
      update();
    }
  }

  Future<void> fetchDocumentTypes() async {
    isLoadingDocumentTypes = true;
    update();
    try {
      final res = await api.getMrnDropdownList(
        _mrnDropdownBody(
          'documentlist',
          partyId: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        ),
      );
      if ((res.status == 200 || res.success == true) && res.data != null) {
        documentTypeList = res.data!;
        if (selectedDocumentTypeIds.isEmpty) {
          selectedDocumentTypeIds = documentTypeList.map((d) => d.id).toSet();
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Document Type', '$e');
    } finally {
      isLoadingDocumentTypes = false;
      update();
    }
  }

  void toggleDocumentType(String id) {
    if (selectedDocumentTypeIds.contains(id)) {
      selectedDocumentTypeIds.remove(id);
    } else {
      selectedDocumentTypeIds.add(id);
    }
    update();
  }

  // ── ✅ NEW: Central dependent detail fetcher ───────────────────────────────
  /// Calls getdependentalldetail and passes the result to [onResult].
  /// Silently swallows errors — auto-fill is best-effort, never blocking.
  Future<void> _fetchDependentDetail({
    required String type,
    required String dependentId,
    required void Function(DependentDetail detail) onResult,
  }) async {
    if (dependentId.isEmpty || dependentId == '0') return;

    try {
      final req = DependentDetailRequest(
        type: type,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        partyid: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
        dependentid: dependentId,
      );

      if (kDebugMode) {
        print(
            '🔗 getDependentAllDetail ▶ type=$type  dependentid=$dependentId');
      }

      final res = await api.getDependentAllDetail(req);

      if (kDebugMode) {
        print(
            '🔗 getDependentAllDetail ◀ status=${res.status}  data=${res.data?.toJson()}');
      }

      if ((res.status == 200 || res.success == true) && res.data != null) {
        onResult(res.data!);
      }
    } catch (e) {
      // Non-critical — log only, never show a snackbar for auto-fill failure
      if (kDebugMode) print('⚠️ getDependentAllDetail error ($type): $e');
    }
  }

  Future<void> _fetchMrnDetail(int stockid) async {
    setBusy(true);
    try {
      final body = {
        'stockid': stockid,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
      };
      if (kDebugMode) print('🔍 MRN Detail Request: $body');
      final res = await api.getMrnDetail(body);
      if (kDebugMode) print('📥 MRN Detail: ${res.status} | ${res.message}');
      if ((res.status == 200 || res.success == true) && res.data != null) {
        _applyMrnDetail(res.data!);
      } else {
        ShowMessage.showSnackBar(
            'Detail', res.message ?? 'Could not load MRN details');
      }
    } catch (e) {
      if (kDebugMode) print('❌ MRN detail error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchPaidByEmployees() async {
    isLoadingPaidBy = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('employee'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        paidByList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Paid By', '$e');
    } finally {
      isLoadingPaidBy = false;
      update();
    }
  }

  // ── Date pickers ───────────────────────────────────────────────────────────
  Future<void> _pickDate(BuildContext ctx, TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: AppConst.calenderFirstDate,
      lastDate: AppConst.calenderLastDate,
      builder: (c, child) => Theme(
        data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: newBlueColor)),
        child: child!,
      ),
    );
    if (picked != null) {
      ctrl.text = DateFormat('dd/MM/yyyy').format(picked);
      update();
    }
  }

  Future<void> pickMrnDate(BuildContext ctx) => _pickDate(ctx, mrnDateCtrl);
  Future<void> pickBillDate(BuildContext ctx) => _pickDate(ctx, billDateCtrl);
  Future<void> pickChallanDate(BuildContext ctx) =>
      _pickDate(ctx, challanDateCtrl);
  Future<void> pickGrnDate(BuildContext ctx) => _pickDate(ctx, grnDateCtrl);

  // ── Attachments ────────────────────────────────────────────────────────────
  Future<void> pickBillFromCamera() async =>
      _pickImageCamera(MrnAttachmentType.bill);
  Future<void> pickBillFromGallery() async =>
      _pickImageGallery(MrnAttachmentType.bill);
  Future<void> pickBillFile() async => _pickRealFile(MrnAttachmentType.bill);
  Future<void> pickChallanFile() async =>
      _pickRealFile(MrnAttachmentType.challan);
  Future<void> pickChallanFromCamera() async =>
      _pickImageCamera(MrnAttachmentType.challan);
  Future<void> pickChallanFromGallery() async =>
      _pickImageGallery(MrnAttachmentType.challan);

  void removeBillAttachment(String id) {
    billAttachments.removeWhere((d) => d.id == id);
    update();
  }

  void removeChallanAttachment(String id) {
    challanAttachments.removeWhere((d) => d.id == id);
    update();
  }

  Future<void> _pickRealFile(MrnAttachmentType type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );
      if (result != null) {
        for (final pf in result.files) {
          if (pf.path != null) {
            final file = File(pf.path!);
            final bytes = await file.length();
            _addAttachment(
              pf.path!,
              pf.extension?.toLowerCase() == 'pdf' ? 'pdf' : 'image',
              'File',
              type,
              overrideName: pf.name,
              overrideSize: _formatBytes(bytes),
            );
          }
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('File', 'Could not pick file: $e');
    }
  }

  Future<void> _pickImageGallery(MrnAttachmentType type) async {
    try {
      final xfiles = await picker.pickMultiImage(imageQuality: 75);
      for (final f in xfiles) {
        final file = File(f.path);
        final bytes = await file.length();
        _addAttachment(f.path, 'image', 'Gallery', type,
            overrideSize: _formatBytes(bytes));
      }
    } catch (e) {
      ShowMessage.showSnackBar('Gallery', 'Could not open gallery: $e');
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _pickImageCamera(MrnAttachmentType type) async {
    try {
      final xfile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 75);
      if (xfile != null) {
        final bytes = await File(xfile.path).length();
        _addAttachment(xfile.path, 'image', 'Camera', type,
            overrideSize: _formatBytes(bytes));
      }
    } catch (e) {
      ShowMessage.showSnackBar('Camera', 'Could not open camera: $e');
    }
  }

  void _addAttachment(
      String path, String type, String source, MrnAttachmentType attachmentType,
      {String? overrideName, String? overrideSize}) {
    final file = File(path);
    final doc = MrnDocument(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fileName: overrideName ?? path.split('/').last,
      filePath: path,
      fileType: type,
      fileSize: overrideSize ?? _fileSize(file),
      attachmentType: attachmentType,
      source: source,
      uploadedAt: DateTime.now(),
    );
    if (attachmentType == MrnAttachmentType.bill) {
      billAttachments.add(doc);
    } else {
      challanAttachments.add(doc);
    }
    update();
  }

  // ── Item interactions ──────────────────────────────────────────────────────
  void toggleItemExpanded(MrnItemLine item) {
    item.isExpanded = !item.isExpanded;
    update();
  }

  void setReceivedQty(MrnItemLine item, double qty) {
    final double clamped = qty.clamp(0.0, item.maxReceivable).toDouble();
    if (qty > item.maxReceivable) {
      ShowMessage.showSnackBar('Quantity Limit',
          'Max receivable is ${item.maxReceivable.toInt()} ${item.unit}');
    }
    item.receiveNowQty = clamped;
    update();
  }

  void increaseQty(MrnItemLine item) {
    if (item.receiveNowQty < item.maxReceivable) {
      item.receiveNowQty++;
      update();
    } else {
      ShowMessage.showSnackBar('Limit Reached',
          'Cannot exceed PO balance of ${item.maxReceivable.toInt()} ${item.unit}');
    }
  }

  void decreaseQty(MrnItemLine item) {
    if (item.receiveNowQty > 0) {
      item.receiveNowQty--;
      update();
    }
  }

  void setItemGodown(MrnItemLine item, MrnDropdownOption? godown) {
    item.selectedGodownId = godown?.id;
    update();
  }

  void setItemRemarks(MrnItemLine item, String val) {
    item.remarks = val;
    update();
  }

  void removeItem(MrnItemLine item) {
    itemLines.remove(item);
    update();
  }

  void resetMakeSelection() {
    makeList = [];
    update();
  }

  String effectiveGodownLabel(MrnItemLine item) {
    if (item.selectedGodownId != null) {
      return godownList
              .firstWhereOrNull((g) => g.id == item.selectedGodownId)
              ?.label ??
          selectedGodown?.label ??
          '—';
    }
    return selectedGodown?.label ?? '—';
  }

  void addDirectItem({
    required String itemName,
    required String itemCode,
    required String unit,
    required String make,
    required String godownId,
    required String godownLabel,
    required double qty,
    required double rate,
    required double gstPct,
    required double discountPct,
    required double discount,
    required String remarks,
  }) {
    itemLines.add(MrnItemLine(
      itemId: itemCode,
      itemName: itemName,
      itemCode: itemCode,
      unit: unit,
      source: 'Direct',
      orderNo: '',
      poQty: qty,
      previouslyReceivedQty: 0,
      receiveNowQty: qty,
      rate: rate,
      discountPercent: discountPct > 0
          ? discountPct
          : (qty * rate) > 0
              ? (discount / (qty * rate) * 100)
              : 0,
      discountAmount: discount,
      gstPercent: gstPct,
      selectedGodownId: godownId,
      remarks: remarks,
    ));
    update();
  }

  // ── ✅ PO selected → fetch dependent detail for all selected PO ids ────────
  void togglePOSelection(PendingPoItem po) {
    for (final p in poList) {
      p.isSelected = false;
    }
    po.isSelected = true;
    processingPo = po;
    itemLines.clear();
    _refreshWorkOrders();
    update();

    // Auto-fill Job Type + Customer PO from the selected PO's orderid
    _fetchDependentDetail(
      type: 'po',
      dependentId: po.orderid.toString(),
      onResult: (detail) {
        bool changed = false;

        // Auto-fill Job Type
        if (detail.hasJobType) {
          final matched = jobTypeList.firstWhereOrNull(
            (j) => j.id == detail.jobtypeid.toString(),
          );
          if (matched != null) {
            selectedJobType = matched;
            changed = true;
            if (kDebugMode) {
              print('✅ Auto-filled JobType from PO: ${matched.label}');
            }
          }
        }

        // Auto-fill Customer PO
        if (detail.hasCustomerPo) {
          final matched = customerPoList.firstWhereOrNull(
            (c) => c.id == detail.customerpoid.toString(),
          );
          if (matched != null) {
            selectedCustomerPo = matched;
            changed = true;
            if (kDebugMode) {
              print('✅ Auto-filled CustomerPO from PO: ${matched.label}');
            }
          } else {
            // Stub — will be resolved once customerPoList loads
            selectedCustomerPo = MrnDropdownOption(
              id: detail.customerpoid.toString(),
              label: '',
            );
            changed = true;
          }
        }

        if (changed) update();
      },
    );
  }

  /// Call this when MULTIPLE POs are involved (if you extend to multi-PO mode).
  /// Passes comma-separated ids: "27658,27659"
  void _fetchDependentForMultiplePOs(List<PendingPoItem> selectedPos) {
    if (selectedPos.isEmpty) return;
    final ids = selectedPos.map((p) => p.orderid.toString()).join(',');
    _fetchDependentDetail(
      type: 'po',
      dependentId: ids,
      onResult: (detail) {
        bool changed = false;
        if (detail.hasJobType) {
          final matched = jobTypeList.firstWhereOrNull(
            (j) => j.id == detail.jobtypeid.toString(),
          );
          if (matched != null) {
            selectedJobType = matched;
            changed = true;
          }
        }
        if (detail.hasCustomerPo) {
          final matched = customerPoList.firstWhereOrNull(
            (c) => c.id == detail.customerpoid.toString(),
          );
          selectedCustomerPo = matched ??
              MrnDropdownOption(id: detail.customerpoid.toString(), label: '');
          changed = true;
        }
        if (changed) update();
      },
    );
  }

  Future<MrnItemDetail?> fetchItemDetail(int itemid) async {
    isLoadingItemDetail = true;
    update();
    try {
      final res = await api.getItemDetail(
        compid: homeController.currentUserData?.compId ?? 0,
        itemid: itemid,
      );
      if ((res.status == 200 || res.success == true) && res.data != null) {
        return res.data;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      isLoadingItemDetail = false;
      update();
    }
  }

  // ── File upload helper ─────────────────────────────────────────────────────
  Future<String> _uploadAttachments(List<MrnDocument> docs) async {
    if (docs.isEmpty) return '';
    final List<String> uploadedNames = [];
    for (final doc in docs) {
      if (doc.filePath.isEmpty) continue;
      try {
        final res =
            await ReimbursementRepo.uploadReimbursementFile(doc.filePath);
        if (res.status == true && res.statusCode == 200) {
          final jsonData = res.data as Map<String, dynamic>?;
          String filename = jsonData?['data']?['filename'] as String? ??
              jsonData?['data']?['file_name'] as String? ??
              jsonData?['data']?['originalname'] as String? ??
              jsonData?['filename'] as String? ??
              jsonData?['file_name'] as String? ??
              '';
          if (filename.contains('/')) filename = filename.split('/').last;
          if (filename.isEmpty) filename = doc.fileName;
          if (!filename.contains('.')) {
            final originalExt = doc.fileName.contains('.')
                ? '.${doc.fileName.split('.').last}'
                : '';
            filename = '$filename$originalExt';
          }
          if (filename.isNotEmpty) {
            uploadedNames.add(filename);
            if (kDebugMode) print('✅ Uploaded: $filename');
          }
        } else {
          ShowMessage.showSnackBar(
              'Upload Failed', 'Could not upload ${doc.fileName}');
        }
      } catch (e) {
        if (kDebugMode) print('❌ Upload error for ${doc.fileName}: $e');
        ShowMessage.showSnackBar('Upload Error', '${doc.fileName}: $e');
      }
    }
    return uploadedNames.join(',');
  }

  // ── Submit ─────────────────────────────────────────────────────────────────
  Future<void> submitMRN() async {
    if (partyNameCtrl.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please select a party');
      return;
    }
    if (selectedSite == null) {
      ShowMessage.showSnackBar('Validation', 'Please select a site');
      return;
    }
    if (itemLines.isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please add at least one item');
      return;
    }
    if (itemLines.any((i) => i.receiveNowQty <= 0)) {
      ShowMessage.showSnackBar('Validation', 'All items must have qty > 0');
      return;
    }

    setBusy(true);
    try {
      final billFileStr = billAttachments.isNotEmpty
          ? await _uploadAttachments(billAttachments)
          : existingBillFiles.join(',');
      final challanFileStr = challanAttachments.isNotEmpty
          ? await _uploadAttachments(challanAttachments)
          : existingDcFiles.join(',');

      DateTime parseDate(String d) {
        try {
          return DateFormat('dd/MM/yyyy').parse(d);
        } catch (_) {
          return DateTime.now();
        }
      }

      final items = itemLines
          .map((i) => {
                'itemname': i.itemName,
                'itemid': int.tryParse(i.itemId) ?? 0,
                'rate': i.rate,
                'quantity': i.receiveNowQty,
                'amount': i.amount,
                'gstpercent': i.gstPercent,
                'gstamount': i.gstAmount,
                'discountpercent': i.discountPercent,
                'discountamount': i.discountAmount,
                'specification': i.remarks,
                'make': i.make,
                'makeid': i.makeId,
                'unitid': i.unitId,
                'godownid': int.tryParse(
                        i.selectedGodownId ?? selectedGodown?.id ?? '0') ??
                    0,
                'poid': processingPo?.orderid ?? 0,
                'transid': i.transId,
                'stockqty': i.receiveNowQty,
                'sgst': 0,
                'sgstamt': 0,
                'cgst': 0,
                'cgstamt': 0,
                'igst': 0,
                'igstamt': 0,
                'batchno': i.batchNo,
                'expirydate': '',
                'manufacturedate': '',
                'uniqueid': i.uniqueId,
              })
          .toList();

      final body = {
        'stockid': isEditMode ? (editStockId ?? 0) : 0,
        'type': selectedSource == MrnSourceType.purchaseOrder ? 'PO' : 'Direct',
        'pono': processingPo?.orderno ?? '',
        'seriesid': int.tryParse(selectedSeriesType?.id ?? '0') ?? 0,
        'receiptdate': parseDate(mrnDateCtrl.text).toIso8601String(),
        'partyname': partyNameCtrl.text.trim(),
        'partyid': int.tryParse(selectedParty?.id ?? '0') ?? 0,
        'billno': billNoCtrl.text.trim(),
        'godownid': int.tryParse(selectedGodown?.id ?? '0') ?? 0,
        'receivedby': receivedByName,
        'totalweight': 0,
        'description': reviewRemarksCtrl.text.trim(),
        'lotno': lotNoCtrl.text.trim(),
        'grnno': grnNoCtrl.text.trim(),
        'grndate': parseDate(grnDateCtrl.text).toIso8601String(),
        'totalamount': subtotal,
        'totalquantity': itemLines.fold(0.0, (s, i) => s + i.receiveNowQty),
        'poid': processingPo?.orderid ?? 0,
        'qcstatus': selectedQcRequired,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'yearid': currentYearId,
        'ledgertrans': '',
        'grandtotal': grandTotalRounded,
        'roundoff': roundOff,
        'menuid': 0,
        'totaltax': totalGst,
        'updateinvoiceid': 0,
        'freightmode': '',
        'freightmodeid': 0,
        'billdate': parseDate(billDateCtrl.text).toIso8601String(),
        'othervaluetaxxml': '',
        'mrntype': '',
        'gateentryNo': gateEntryNoCtrl.text.trim(),
        'billfile': billFileStr,
        'filetypeId': selectedDocumentTypesString,  // ← FIX: was 'filetypeid'
        'dcno': challanNoCtrl.text.trim(),
        'dcdate': parseDate(challanDateCtrl.text).toIso8601String(),
        'dcfile': challanFileStr,
        'reason': reasonNACtrl.text.trim(),
        'siteid': int.tryParse(selectedSite?.id ?? '0') ?? 0,
        'paidbyid': int.tryParse(selectedPaidBy?.id ?? '0') ?? 0,
        'paidby': selectedPaidBy?.label ?? '',
        'paidtype': selectedPaidType?.label ?? '',
        'customerpoid': int.tryParse(selectedCustomerPo?.id ?? '0') ?? 0,
        'jobtypeid': int.tryParse(selectedJobType?.id ?? '0') ?? 0,
        'orderid': processingPo?.orderid ?? 0,      // ← ADD: was missing
        'fromaddress': '',
        'toaddress': '',
        'mrnother': additionalChargesPayload,        // ← ADD: was missing
        'mrnitems': items,
      };

      if (kDebugMode) {
        const encoder = JsonEncoder.withIndent('  ');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('📦 MRN SUBMIT PAYLOAD');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print(encoder.convert(body));
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      }

      final res = await api.saveMrnEntry(body);
      if (res.status == 200 || res.success == true) {
        ShowMessage.showSnackBar(
            'Success', res.message ?? 'MRN saved successfully');
        if (Get.isRegistered<MrnListController>()) {
          Get.find<MrnListController>().fetchMrnList();
        }
        Get.off(() => MrnListScreen());
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to save MRN');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
    }
  }

  // ── Source label ───────────────────────────────────────────────────────────
  String sourceLabel(MrnSourceType s) {
    switch (s) {
      case MrnSourceType.purchaseOrder:
        return 'Purchase Order';
      case MrnSourceType.directPurchase:
        return 'Direct Purchase';
    }
  }

  // ── Base API body ──────────────────────────────────────────────────────────
  Map<String, dynamic> _mrnDropdownBody(
    String type, {
    int partyId = 0,
    int siteId = 0,
    int dependentId = 0,
  }) =>
      {
        'type': type,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'partyid': partyId,
        'siteid': siteId,
        'dependentid': dependentId,
      };

  // ── Fetch all dropdowns ────────────────────────────────────────────────────
  Future<void> _fetchAllDropdowns() async {
    await Future.wait([
      fetchSeriesTypes(),
      fetchSites(),
      fetchGodowns(),
      fetchCustomerPOs(),
      fetchJobTypes(),
      fetchWorkOrders(),
      fetchDirectItems(),
      fetchUnits(),
      fetchMakes(),
      fetchParties(),
      fetchAddresses(),
      _loadPOList(),
      fetchDocumentTypes(),
      fetchTax(),
    ]);
  }

  // ── Individual fetch methods ───────────────────────────────────────────────
  Future<void> fetchSeriesTypes() async {
    isLoadingSeriesType = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('series'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        seriesTypeList = res.data!;
        if (seriesTypeList.isNotEmpty && selectedSeriesType == null) {
          selectedSeriesType = seriesTypeList.first;
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Series', '$e');
    } finally {
      isLoadingSeriesType = false;
      _rematchEditSelections();
      update();
    }
  }

  Future<void> fetchSites({int partyId = 0}) async {
    isLoadingSite = true;
    if (!isEditMode) selectedSite = null;
    update();
    try {
      final res = await api.getMrnDropdownList(
        _mrnDropdownBody('Site', partyId: partyId),
      );
      if ((res.status == 200 || res.success == true) && res.data != null) {
        siteList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Site', '$e');
    } finally {
      isLoadingSite = false;
      _rematchEditSelections();
      update();
    }
  }

  Future<void> fetchGodowns({int siteId = 0}) async {
    isLoadingGodown = true;
    selectedGodown = null;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody(
        'Godown',
        siteId: siteId,
      ));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        godownList = res.data!;

        if (godownList.isNotEmpty) {
          selectedGodown = godownList.first;
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Godown', '$e');
    } finally {
      isLoadingGodown = false;
      _rematchEditSelections();
      update();
    }
  }

  Future<void> fetchCustomerPOs({int siteId = 0}) async {
    isLoadingCustomerPo = true;
    update();
    try {
      final res = await api.getMrnDropdownList(
          _mrnDropdownBody('customerorder', siteId: siteId));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        customerPoList = res.data!;
        if (selectedCustomerPo != null) {
          selectedCustomerPo = customerPoList
                  .firstWhereOrNull((c) => c.id == selectedCustomerPo!.id) ??
              selectedCustomerPo;
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('CustomerPO', '$e');
    } finally {
      isLoadingCustomerPo = false;
      update();
    }
  }

  Future<void> fetchJobTypes() async {
    isLoadingJobType = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('Jobtype'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        jobTypeList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('JobType', '$e');
    } finally {
      isLoadingJobType = false;
      _rematchEditSelections();
      update();
    }
  }

  Future<void> fetchWorkOrders({
    int partyId = 0,
    int siteId = 0,
    int poId = 0,
    int jobTypeId = 0,
    int customerPoId = 0,
  }) async {
    isLoadingWorkOrder = true;
    update();
    try {
      final body = {
        'type': 'workorder',
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'partyid': partyId,
        'siteid': siteId,
        'dependentid': poId > 0 ? poId : jobTypeId,
        'customerpoid': customerPoId,
        'jobtypeid': jobTypeId,
      };
      final res = await api.getMrnDropdownList(body);
      if ((res.status == 200 || res.success == true) && res.data != null) {
        workOrderList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('WorkOrder', '$e');
    } finally {
      isLoadingWorkOrder = false;
      update();
    }
  }

  Future<void> fetchDirectItems() async {
    isLoadingDirectItems = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('Item'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        directItemList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Items', '$e');
    } finally {
      isLoadingDirectItems = false;
      update();
    }
  }

  Future<void> fetchUnits() async {
    isLoadingUnit = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('Unit'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        unitList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Unit', '$e');
    } finally {
      isLoadingUnit = false;
      update();
    }
  }

  Future<void> fetchMakes({int dependentId = 0}) async {
    isLoadingMake = true;
    update();
    try {
      final res = await api.getMrnDropdownList(
        _mrnDropdownBody('Brand', dependentId: dependentId),
      );
      if ((res.status == 200 || res.success == true) && res.data != null) {
        makeList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Brand', '$e');
    } finally {
      isLoadingMake = false;
      update();
    }
  }

  Future<void> fetchTax() async {
    isLoadingChargeHeads = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('Otherdetail'));

      // ── ADD THIS DEBUG PRINT ──────────────────────────────────────────
      if (kDebugMode) {
        print('🔍 Otherdetail raw response: status=${res.status}');
        print('🔍 Otherdetail data count: ${res.data?.length}');
        if (res.data != null && res.data!.isNotEmpty) {
          print('🔍 First item id="${res.data!.first.id}" label="${res.data!.first.label}"');
        } else {
          print('🔍 Otherdetail data is NULL or EMPTY');
        }
      }
      // ─────────────────────────────────────────────────────────────────

      if ((res.status == 200 || res.success == true) && res.data != null) {
        chargeHeadList = res.data!
            .map((o) => AdditionalChargeHead(
          id: o.id,
          label: o.label,
          taxPercent: 0,
        ))
            .toList();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Charge Heads', '$e');
    } finally {
      isLoadingChargeHeads = false;
      update();
    }
  }


  Future<double?> fetchChargeHeadPercentage(String chargeHeadId) async {
    try {
      final request = MrnLedgerAddressRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        partyid: int.tryParse(chargeHeadId) ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
      );

      final response =
      await api.getMrnLedgerAddressAndValuePercent(request);

      if (response.data != null && response.data!.isNotEmpty) {
        return response.data!.first.gstpercent;
      }
    } catch (e) {
      debugPrint('Charge percentage error: $e');
    }

    return null;
  }


  Future<void> fetchParties() async {
    isLoadingParty = true;
    update();
    try {
      final res = await api.getMrnDropdownList(_mrnDropdownBody('Party'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        partyList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Party', '$e');
    } finally {
      isLoadingParty = false;
      _rematchEditSelections();
      update();
    }
  }

  Future<void> fetchAddresses() async {
    isLoadingAddresses = true;
    update();
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      shippingAddress = MrnAddress(
        label: 'Shipping',
        line1: 'Plot No. 12, MIDC Industrial Area',
        line2: 'Taloja Phase II',
        city: 'Navi Mumbai',
        state: 'Maharashtra',
        pincode: '410208',
      );
      billingAddress = MrnAddress(
        label: 'Billing',
        line1: '4th Floor, Tower B, Infinity IT Park',
        line2: 'DLF Cyber City',
        city: 'Gurugram',
        state: 'Haryana',
        pincode: '122002',
      );
    } finally {
      isLoadingAddresses = false;
      update();
    }
  }

  Future<void> _loadPOList() async {
    if (selectedSource != MrnSourceType.purchaseOrder) return;
    isLoadingPO = true;
    update();
    try {
      final req = GetPendingPoRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        partyid: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
        orderid: '',
        stockid: 0,
      );
      final res = await api.getPendingPoList(req);
      if ((res.status == 200 || res.success == true) && res.data != null) {
        poList = res.data!;
      } else {
        poList = [];
      }
    } catch (e) {
      poList = [];
      ShowMessage.showSnackBar('PO List', '$e');
    } finally {
      isLoadingPO = false;
      update();
    }
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  void _setLoggedInUser() {
    receivedByName = homeController.currentUserData?.name ?? 'User';
  }

  String _generateMrnNumber() {
    final year = DateTime.now().year;
    final seq =
        (DateTime.now().millisecondsSinceEpoch % 9000 + 1000).toString();
    return 'MRN-$year-$seq';
  }

  String _fileSize(File file) {
    try {
      final bytes = file.lengthSync();
      if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } catch (_) {
      return '—';
    }
  }

  Future<void> fetchPendingPoList() async {
    isLoadingPO = true;
    poList.clear();
    processingPo = null;
    update();
    try {
      final req = GetPendingPoRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        partyid: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
        orderid: '',
        stockid: 0,
      );
      final res = await api.getPendingPoList(req);
      if ((res.status == 200 || res.success == true) && res.data != null) {
        poList = res.data!;
      } else {
        poList = [];
        ShowMessage.showSnackBar(
            'PO List', res.message ?? 'No pending POs found');
      }
    } catch (e) {
      poList = [];
      ShowMessage.showSnackBar('PO List', '$e');
    } finally {
      isLoadingPO = false;
      update();
    }
  }

  Future<void> processSelectedPO() async {
    if (processingPo == null) {
      ShowMessage.showSnackBar('Select PO', 'Please select a PO first');
      return;
    }
    isLoadingItems = true;
    itemLines.clear();
    update();
    try {
      final req = ProcessPendingPoRequest(
        type: 1,
        compid: homeController.currentUserData?.compId ?? 0,
        branchid: homeController.currentUserData?.branchId ?? 0,
        userid: homeController.currentUserData?.userid ?? 0,
        partyid: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
        orderid: processingPo!.orderid.toString(),
        stockid: 0,
      );
      final res = await api.processPoItems(req);
      if ((res.status == 200 || res.success == true) &&
          res.data != null &&
          res.data!.isNotEmpty) {
        itemLines = res.data!
            .map((item) => item.toItemLine(
                  poNumber: processingPo!.orderno.isNotEmpty
                      ? processingPo!.orderno
                      : processingPo!.orderid.toString(),
                ))
            .toList();
      } else {
        ShowMessage.showSnackBar(
            'No Items', res.message ?? 'No pending items found for this PO');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Items', '$e');
    } finally {
      isLoadingItems = false;
      update();
    }
  }

  void _applyMrnDetail(MrnDetailData d) {
    billNoCtrl.text = d.billno;
    challanNoCtrl.text = d.dcno;
    lotNoCtrl.text = d.lotno;
    grnNoCtrl.text = d.grnno;
    gateEntryNoCtrl.text = d.gateentryno;
    receivedByName = d.receivedby;
    selectedQcRequired = d.qcstatus.isNotEmpty ? d.qcstatus : 'Yes';
    reviewRemarksCtrl.text = d.description;
    reasonNACtrl.text = d.reason;
    existingBillFiles = d.billfile.isNotEmpty
        ? d.billfile
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList()
        : [];
    existingDcFiles = d.dcfile.isNotEmpty
        ? d.dcfile
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList()
        : [];

    _setDateCtrl(mrnDateCtrl, d.receiptdate);
    _setDateCtrl(billDateCtrl, d.billdate);
    _setDateCtrl(challanDateCtrl, d.dcdate);
    _setDateCtrl(grnDateCtrl, d.grndate);

    partyNameCtrl.text = d.partyname;
    if (d.partyid > 0) {
      selectedParty =
          partyList.firstWhereOrNull((p) => p.id == d.partyid.toString()) ??
              MrnDropdownOption(id: d.partyid.toString(), label: d.partyname);
    }
    if (d.siteid > 0) {
      selectedSite =
          siteList.firstWhereOrNull((s) => s.id == d.siteid.toString()) ??
              MrnDropdownOption(id: d.siteid.toString(), label: d.sitename);
      fetchCustomerPOs(siteId: d.siteid);
    }
    if (d.godownid > 0) {
      selectedGodown =
          godownList.firstWhereOrNull((g) => g.id == d.godownid.toString()) ??
              MrnDropdownOption(id: d.godownid.toString(), label: d.godownname);
    }
    if (d.seriesid > 0) {
      selectedSeriesType = seriesTypeList
              .firstWhereOrNull((s) => s.id == d.seriesid.toString()) ??
          MrnDropdownOption(id: d.seriesid.toString(), label: '');
    }
    if (d.customerpoid > 0) {
      selectedCustomerPo = customerPoList
              .firstWhereOrNull((c) => c.id == d.customerpoid.toString()) ??
          MrnDropdownOption(id: d.customerpoid.toString(), label: '');
    }
    if (d.paidtype.isNotEmpty) {
      selectedPaidType =
          paidTypeList.firstWhereOrNull((p) => p.label == d.paidtype);
      if (d.paidtype == 'Employee' && d.paidbyid > 0) {
        selectedPaidBy =
            MrnDropdownOption(id: d.paidbyid.toString(), label: d.paidby);
      }
    }
    if (d.jobtypeid > 0) {
      selectedJobType =
          jobTypeList.firstWhereOrNull((j) => j.id == d.jobtypeid.toString()) ??
              MrnDropdownOption(id: d.jobtypeid.toString(), label: '');
    }
    selectedSource = d.type == 'PO'
        ? MrnSourceType.purchaseOrder
        : MrnSourceType.directPurchase;

    itemLines = d.items
        .map((i) => MrnItemLine(
              itemId: i.itemid.toString(),
              itemName: i.itemname,
              itemCode: i.itemid.toString(),
              unit: i.unitname,
              source: d.type,
              orderNo: d.pono == '0' ? '' : d.pono,
              poQty: i.quantity,
              previouslyReceivedQty: 0,
              receiveNowQty: i.quantity,
              rate: i.rate,
              discountPercent: i.discountpercent,
              discountAmount: i.discountamount,
              gstPercent: i.gstpercent,
              selectedGodownId: i.godownid > 0 ? i.godownid.toString() : null,
              remarks: i.specification,
              unitId: i.unitid,
              transId: i.transid,
              uniqueId: i.uniqueid,
              makeId: i.makeid,
              make: i.make,
              batchNo: i.batchno,
            ))
        .toList();
    if (d.mrnother.isNotEmpty) {
      prefillAdditionalChargesFromOther(d.mrnother);
      // AFTER
    } else {
      resetAdditionalCharges();
    }

    update();
  }

  void _setDateCtrl(TextEditingController ctrl, String raw) {
    if (raw.isEmpty) return;
    try {
      DateTime? dt;
      dt = DateTime.tryParse(raw);
      dt ??= DateFormat('dd-MM-yyyy').tryParseStrict(raw);
      dt ??= DateFormat('dd/MM/yyyy').tryParseStrict(raw);
      if (dt != null) ctrl.text = DateFormat('dd/MM/yyyy').format(dt);
    } catch (_) {}
  }

  void _refreshWorkOrders() {
    if (selectedSource == MrnSourceType.purchaseOrder) {
      fetchWorkOrders(
        partyId: int.tryParse(selectedParty?.id ?? '0') ?? 0,
        siteId: int.tryParse(selectedSite?.id ?? '0') ?? 0,
        poId: processingPo?.orderid ?? 0,
      );
    } else {
      fetchWorkOrders(
        jobTypeId: int.tryParse(selectedJobType?.id ?? '0') ?? 0,
        customerPoId: int.tryParse(selectedCustomerPo?.id ?? '0') ?? 0,
      );
    }
  }
}
