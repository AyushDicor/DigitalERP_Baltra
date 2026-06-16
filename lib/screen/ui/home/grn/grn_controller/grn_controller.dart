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
import '../../home_controller.dart';
import '../../mrn_module/mrn_response/mrn_models.dart';
import '../grn_response/additional_charge_model.dart';
import 'grn_additional_charges_mixin.dart';
import '../grn_response/grn_models.dart';
import '../grn_screens/grn_list_screen.dart';
import 'grn_list_contoller.dart';

class GrnController extends AppBaseController with GrnAdditionalChargesMixin {
  final HomeController homeController = Get.find<HomeController>();

  // ── Step tracking ──────────────────────────────────────────────────────────
  int currentStep = 0;
  final PageController pageController = PageController();

  // ── Step 1: Header ─────────────────────────────────────────────────────────
  List<GrnDropdownOption> seriesTypeList = [];
  GrnDropdownOption? selectedSeriesType;
  bool isLoadingSeriesType = false;

  final TextEditingController GrnDateCtrl = TextEditingController();
  String GrnNumber = '';

  // ── Source selection ───────────────────────────────────────────────────────
  GrnSourceType selectedSource = GrnSourceType.grn;

  // ── Party ──────────────────────────────────────────────────────────────────
  final TextEditingController partyNameCtrl = TextEditingController();
  List<GrnDropdownOption> partyList = [];
  GrnDropdownOption? selectedParty;
  bool isLoadingParty = false;
  bool get isSourceLocked => isEditMode;
  bool get isPartyLocked => isEditMode;

  void setParty(GrnDropdownOption? v) {
    selectedParty = v;
    partyNameCtrl.text = v?.label ?? '';

    selectedGodown = null;
    godownList.clear();

    if (v != null) {
      fetchSites(partyId: int.tryParse(v.id) ?? 0);
      fetchWorkOrders(
        partyId: int.tryParse(v.id) ?? 0,
        siteId: int.tryParse(selectedSite?.id ?? '0') ?? 0,
      );

      fetchLedgerAddresses();
    }
    update();
  }

  // ── Site / Godown ──────────────────────────────────────────────────────────
  List<GrnDropdownOption> siteList = [];
  GrnDropdownOption? selectedSite;
  bool isLoadingSite = false;

  List<GrnDropdownOption> godownList = [];
  GrnDropdownOption? selectedGodown;
  bool isLoadingGodown = false;

  // ── Bill / Challan ─────────────────────────────────────────────────────────
  final TextEditingController billNoCtrl = TextEditingController();
  final TextEditingController billDateCtrl = TextEditingController();
  final TextEditingController challanNoCtrl = TextEditingController();
  final TextEditingController challanDateCtrl = TextEditingController();
  String receivedByName = '';

  // ── Addresses ──────────────────────────────────────────────────────────────
  GrnAddress? shippingAddress;
  GrnAddress? billingAddress;
  bool isLoadingAddresses = false;
  final TextEditingController fromAddressCtrl = TextEditingController();
  final TextEditingController toAddressCtrl = TextEditingController();

  // ── Attachments ────────────────────────────────────────────────────────────
  Set<GrnAttachmentType> selectedAttachmentTypes = {
    GrnAttachmentType.bill,
    GrnAttachmentType.challan,
  };
  List<GrnDocument> billAttachments = [];
  List<GrnDocument> challanAttachments = [];
  final TextEditingController reasonNACtrl = TextEditingController();

  // ── Additional fields ──────────────────────────────────────────────────────
  List<GrnDropdownOption> paidTypeList = [
    GrnDropdownOption(id: 'Employee', label: 'Employee'),
    GrnDropdownOption(id: 'Company', label: 'Company'),
  ];
  List<GrnDropdownOption> paidByList = [];
  GrnDropdownOption? selectedPaidBy;
  bool isLoadingPaidBy = false;
  GrnDropdownOption? selectedPaidType;
  bool isLoadingPaidType = false;
  List<GrnItemLine> itemLines = [];

  String selectedQcRequired = 'Yes';
  final List<String> qcRequiredOptions = ['Yes', 'No'];

  List<GrnDropdownOption> customerPoList = [];
  GrnDropdownOption? selectedCustomerPo;
  bool isLoadingCustomerPo = false;

  List<GrnDropdownOption> jobTypeList = [];
  GrnDropdownOption? selectedJobType;
  bool isLoadingJobType = false;

  List<GrnDropdownOption> workOrderList = [];
  GrnDropdownOption? selectedWorkOrder;
  bool isLoadingWorkOrder = false;

  List<String> existingBillFiles = [];
  List<String> existingDcFiles = [];

  List<GrnDropdownOption> documentTypeList = [];
  bool isLoadingDocumentTypes = false;
  Set<String> selectedDocumentTypeIds = {};

  String get selectedDocumentTypesString => selectedDocumentTypeIds.join(',');

  final TextEditingController lotNoCtrl = TextEditingController();
  final TextEditingController grnNoCtrl = TextEditingController();
  final TextEditingController grnDateCtrl = TextEditingController();
  final TextEditingController gateEntryNoCtrl = TextEditingController();
  final TextEditingController grnDisplayNoCtrl = TextEditingController();

  // ── Direct entry dropdowns ─────────────────────────────────────────────────
  List<GrnDropdownOption> directItemList = [];
  bool isLoadingDirectItems = false;

  List<GrnDropdownOption> unitList = [];
  bool isLoadingUnit = false;

  List<GrnDropdownOption> makeList = [];
  bool isLoadingMake = false;

  bool isLoadingItemDetail = false;
  //
  List<GrnDropdownOption> taxType = [];

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
    GrnDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    billDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    challanDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    grnDateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    GrnNumber = _generateGrnNumber();
    _setLoggedInUser();
    _fetchAllDropdowns();
    grnDisplayNoCtrl.text = GrnNumber;

    final args = Get.arguments;
    if (args is GrnListItem) {
      isEditMode = true;
      editStockId = args.id;
      _prefillFromListItem(args);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    GrnDateCtrl.dispose();
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
    fromAddressCtrl.dispose();
    toAddressCtrl.dispose();
    grnDisplayNoCtrl.dispose();
    super.onClose();
  }

  // ── Navigation ─────────────────────────────────────────────────────────────
  void goToStep(int step) {
    if (step < 0 || step > 2) return;
    currentStep = step;
    pageController.animateToPage(step,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
  }

  void nextStep() => goToStep(currentStep + 1);
  void prevStep() => goToStep(currentStep - 1);

  // ── Source ─────────────────────────────────────────────────────────────────
  void setSource(GrnSourceType src) {
    selectedSource = src;
    itemLines.clear();
    existingBillFiles = [];
    existingDcFiles = [];
    update();
  }

  // ── Step 1 setters ─────────────────────────────────────────────────────────
  void setSeriesType(GrnDropdownOption? v) {
    selectedSeriesType = v;
    update();
  }

  void setSite(GrnDropdownOption? v) {
    selectedSite = v;
    selectedCustomerPo = null;
    selectedGodown = null; // reset previous godown

    final siteId = int.tryParse(v?.id ?? '0') ?? 0;
    final partyId = int.tryParse(selectedParty?.id ?? '0') ?? 0;

    fetchWorkOrders(partyId: partyId, siteId: siteId);
    fetchCustomerPOs(siteId: siteId);
    fetchGodowns(siteId: siteId); // pass site id here
    fetchLedgerAddresses();

    update();
  }

  void setGodown(GrnDropdownOption? v) {
    selectedGodown = v;
    update();
  }

  void setQcRequired(String v) {
    selectedQcRequired = v;
    update();
  }

  // ── ✅ Customer PO selected → fetch dependent detail to auto-fill Job Type ──
  void setCustomerPo(GrnDropdownOption? v) {
    selectedCustomerPo = v;
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

  // ── ✅ Job Type selected (no dependent call needed) ────────────────────────
  void setJobType(GrnDropdownOption? v) {
    selectedJobType = v;
    update();
  }

  // ── ✅ Work Order selected → fetch dependent detail to auto-fill Job Type + Customer PO ──
  void setWorkOrder(GrnDropdownOption? v) {
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
              selectedCustomerPo = GrnDropdownOption(
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

  void toggleAttachmentType(GrnAttachmentType type) {
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
        case GrnAttachmentType.bill:
          return 'Bill';
        case GrnAttachmentType.challan:
          return 'Challan';
      }
    }).join(', ');
  }

  // ── Financial year string ─────────────────────────────────────────────────
  String get currentYearId {
    final now = DateTime.now();
    final fyStart = now.month >= 4 ? now.year : now.year - 1;
    final fyEnd = fyStart + 1;
    final fyEndShort = fyEnd.toString().substring(2);
    return '$fyStart-$fyEndShort';
  }

  void setPaidType(GrnDropdownOption? v) {
    selectedPaidType = v;
    selectedPaidBy = null;
    if (v?.id == 'Employee') {
      fetchPaidByEmployees();
    } else {
      paidByList = [];
    }
    update();
  }

  void setPaidBy(GrnDropdownOption? v) {
    selectedPaidBy = v;
    update();
  }

  void _prefillFromListItem(GrnListItem item) {
    if (kDebugMode) {
      print('🔑 Edit mode — item.id: ${item.id}');
      print('🔑 item.GrnNo: "${item.GrnNo}"');
      print('🔑 item.billNo: "${item.billNo}"');
      print('🔑 item.partyName: "${item.partyName}"');
    }
    GrnNumber = item.GrnNo;
    grnDisplayNoCtrl.text = item.GrnNo;
    billNoCtrl.text = item.billNo;
    grnNoCtrl.text = item.GrnNo;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(item.GrnDate);
      GrnDateCtrl.text = DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {}
    partyNameCtrl.text = item.partyName;
    update();
    _fetchGrnDetail(item.id);
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
      final res = await api.getGrnDropdownList(
        _GrnDropdownBody(
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
      if (kDebugMode) print('⚠️ getDependentAllDetail error ($type): $e');
    }
  }

  Future<void> _fetchGrnDetail(int stockid) async {
    setBusy(true);
    try {
      final body = {
        'stockid': stockid,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
      };
      if (kDebugMode) print('🔍 Grn Detail Request: $body');
      final res = await api.getGrnDetail(body);
      if (kDebugMode) print('📥 Grn Detail: ${res.status} | ${res.message}');
      if ((res.status == 200 || res.success == true) && res.data != null) {
        await _applyGrnDetail(res.data!);
      } else {
        ShowMessage.showSnackBar(
            'Detail', res.message ?? 'Could not load Grn details');
      }
    } catch (e) {
      if (kDebugMode) print('❌ Grn detail error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> fetchPaidByEmployees() async {
    isLoadingPaidBy = true;
    update();
    try {
      final res = await api.getGrnDropdownList(_GrnDropdownBody('employee'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        paidByList = res.data!.cast<GrnDropdownOption>();
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

  Future<void> pickBillDate(BuildContext ctx) => _pickDate(ctx, billDateCtrl);
  Future<void> pickChallanDate(BuildContext ctx) =>
      _pickDate(ctx, challanDateCtrl);
  Future<void> pickReceiptDate(BuildContext ctx) => _pickDate(ctx, GrnDateCtrl);
  Future<void> pickGrnDate(BuildContext ctx) => _pickDate(ctx, grnDateCtrl);

  // ── Attachments ────────────────────────────────────────────────────────────
  Future<void> pickBillFromCamera() async =>
      _pickImageCamera(GrnAttachmentType.bill);
  Future<void> pickBillFromGallery() async =>
      _pickImageGallery(GrnAttachmentType.bill);
  Future<void> pickBillFile() async => _pickRealFile(GrnAttachmentType.bill);
  Future<void> pickChallanFile() async =>
      _pickRealFile(GrnAttachmentType.challan);
  Future<void> pickChallanFromCamera() async =>
      _pickImageCamera(GrnAttachmentType.challan);
  Future<void> pickChallanFromGallery() async =>
      _pickImageGallery(GrnAttachmentType.challan);

  void removeBillAttachment(String id) {
    billAttachments.removeWhere((d) => d.id == id);
    update();
  }

  void removeChallanAttachment(String id) {
    challanAttachments.removeWhere((d) => d.id == id);
    update();
  }

  Future<void> _pickRealFile(GrnAttachmentType type) async {
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

  Future<void> _pickImageGallery(GrnAttachmentType type) async {
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

  Future<void> _pickImageCamera(GrnAttachmentType type) async {
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
      String path, String type, String source, GrnAttachmentType attachmentType,
      {String? overrideName, String? overrideSize}) {
    final file = File(path);
    final doc = GrnDocument(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fileName: overrideName ?? path.split('/').last,
      filePath: path,
      fileType: type,
      fileSize: overrideSize ?? _fileSize(file),
      attachmentType: attachmentType,
      source: source,
      uploadedAt: DateTime.now(),
    );
    if (attachmentType == GrnAttachmentType.bill) {
      billAttachments.add(doc);
    } else {
      challanAttachments.add(doc);
    }
    update();
  }

  // ── Item interactions ──────────────────────────────────────────────────────
  void toggleItemExpanded(GrnItemLine item) {
    item.isExpanded = !item.isExpanded;
    update();
  }

  void setReceivedQty(GrnItemLine item, double qty) {
    final double clamped = qty.clamp(0.0, item.maxReceivable).toDouble();
    if (qty > item.maxReceivable) {
      ShowMessage.showSnackBar('Quantity Limit',
          'Max receivable is ${item.maxReceivable.toInt()} ${item.unit}');
    }
    item.receiveNowQty = clamped;
    update();
  }

  void increaseQty(GrnItemLine item) {
    if (item.receiveNowQty < item.maxReceivable) {
      item.receiveNowQty++;
      update();
    } else {
      ShowMessage.showSnackBar('Limit Reached',
          'Cannot exceed balance of ${item.maxReceivable.toInt()} ${item.unit}');
    }
  }

  void decreaseQty(GrnItemLine item) {
    if (item.receiveNowQty > 0) {
      item.receiveNowQty--;
      update();
    }
  }

  void setItemGodown(GrnItemLine item, GrnDropdownOption? godown) {
    item.selectedGodownId = godown?.id;
    update();
  }

  void setItemRemarks(GrnItemLine item, String val) {
    item.remarks = val;
    update();
  }

  void removeItem(GrnItemLine item) {
    itemLines.remove(item);
    update();
  }

  void resetMakeSelection() {
    makeList = [];
    update();
  }

  String effectiveGodownLabel(GrnItemLine item) {
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
    itemLines.add(GrnItemLine(
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

  Future<GrnItemDetail?> fetchItemDetail(int itemid) async {
    isLoadingItemDetail = true;
    update();
    try {
      final res = await api.getGrnItemDetail(
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
  Future<String> _uploadAttachments(List<GrnDocument> docs) async {
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
  Future<void> submitGRN() async {
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
        'type': 'GRN',
        'pono': '',
        'seriesid': int.tryParse(selectedSeriesType?.id ?? '0') ?? 0,
        'receiptdate': parseDate(GrnDateCtrl.text).toIso8601String(),
        'partyname': partyNameCtrl.text.trim(),
        'partyid': int.tryParse(selectedParty?.id ?? '0') ?? 0,
        'billno': billNoCtrl.text.trim(),
        'billdate': parseDate(billDateCtrl.text).toIso8601String(),
        'godownid': int.tryParse(selectedGodown?.id ?? '0') ?? 0,
        'receivedby': receivedByName,
        'totalweight': 0,
        'description': reviewRemarksCtrl.text.trim(),
        'lotno': lotNoCtrl.text.trim(),
        'grnno': grnNoCtrl.text.trim(),
        'grndate': parseDate(grnDateCtrl.text).toIso8601String(),
        'gateentryNo': gateEntryNoCtrl.text.trim(),
        'totalamount': subtotal,
        'totalquantity': itemLines.fold(0.0, (s, i) => s + i.receiveNowQty),
        'poid': 0,
        'qcstatus': selectedQcRequired,
        'grandtotal': grandTotalRounded,
        'roundoff': roundOff,
        'totaltax': totalGst,
        'siteid': int.tryParse(selectedSite?.id ?? '0') ?? 0,
        'compid': homeController.currentUserData?.compId ?? 0,
        'branchid': homeController.currentUserData?.branchId ?? 0,
        'userid': homeController.currentUserData?.userid ?? 0,
        'yearid': currentYearId,
        'ledgertrans': '',
        'menuid': 0,
        'updateinvoiceid': 0,
        'freightmode': '',
        'freightmodeid': 0,
        'othervaluetaxxml': '',
        'filetypeid': selectedDocumentTypesString,
        'dcno': challanNoCtrl.text.trim(),
        'dcdate': parseDate(challanDateCtrl.text).toIso8601String(),
        'dcfile': challanFileStr,
        'billfile': billFileStr,
        'reason': reasonNACtrl.text.trim(),
        'paidbyid': int.tryParse(selectedPaidBy?.id ?? '0') ?? 0,
        'paidby': selectedPaidBy?.label ?? '',
        'paidtype': selectedPaidType?.label ?? '',
        'customerpoid': int.tryParse(selectedCustomerPo?.id ?? '0') ?? 0,
        'jobtypeid': int.tryParse(selectedJobType?.id ?? '0') ?? 0,
        'fromaddress': fromAddressCtrl.text.trim(),
        'toaddress': toAddressCtrl.text.trim(),
        'mrnother': additionalChargesPayload,
        'mrnitems': items,
      };

      if (kDebugMode) {
        const encoder = JsonEncoder.withIndent('  ');
        print('📦 GRN SUBMIT PAYLOAD');
        print(encoder.convert(body));
      }

      final res = await api.saveGrnEntry(body);
      if (res.status == 200 || res.success == true) {
        ShowMessage.showSnackBar(
            'Success', res.message ?? 'GRN saved successfully');
        if (Get.isRegistered<GrnListController>()) {
          Get.find<GrnListController>().fetchGrnList();
        }
        Get.off(() => GrnListScreen());
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to save GRN');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
    }
  }

  // ── Source label ───────────────────────────────────────────────────────────
  String sourceLabel(GrnSourceType s) {
    switch (s) {
      case GrnSourceType.grn:
        return 'GRN';
    }
  }

  // ── Base API body ──────────────────────────────────────────────────────────
  Map<String, dynamic> _GrnDropdownBody(
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
      fetchDocumentTypes(),
      fetchChargeHeads(),
    ]);
  }

  // ── Individual fetch methods ───────────────────────────────────────────────
  Future<void> fetchLedgerAddresses() async {
    final partyId = int.tryParse(selectedParty?.id ?? '0') ?? 0;
    final siteId = int.tryParse(selectedSite?.id ?? '0') ?? 0;

    if (partyId == 0) return;

    try {
      final req = LedgerAddressRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        partyid: partyId,
        siteid: siteId,
      );

      final res = await api.getLedgerAddressAndValuePercent(req);

      if ((res.status == 200 || res.success == true) && res.data.isNotEmpty) {
        final data = res.data.first;

        fromAddressCtrl.text = data.fromaddress;
        toAddressCtrl.text = data.toaddress;

        if (kDebugMode) {
          print('Addresses loaded successfully');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('fetchLedgerAddresses error: $e');
      }
    }

    update();
  }

  Future<double?> fetchChargeHeadPercentage(String chargeHeadId) async {
    try {
      final request = LedgerAddressRequest(
        compid: homeController.currentUserData?.compId ?? 0,
        partyid: int.tryParse(chargeHeadId) ?? 0,
        siteid: int.tryParse(selectedSite?.id ?? '0') ?? 0,
      );

      final response = await api.getLedgerAddressAndValuePercent(request);

      if (response.data != null && response.data!.isNotEmpty) {
        return response.data!.first.gstpercent;
      }
    } catch (e) {
      debugPrint('Charge percentage error: $e');
    }

    return null;
  }

  Future<void> fetchSeriesTypes() async {
    isLoadingSeriesType = true;
    update();
    try {
      final res = await api.getGrnDropdownList(_GrnDropdownBody('series'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        seriesTypeList = res.data!;
        if (seriesTypeList.isNotEmpty)
          selectedSeriesType = seriesTypeList.first;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Series', '$e');
    } finally {
      isLoadingSeriesType = false;
      update();
    }
  }

  Future<void> fetchSites({int partyId = 0}) async {
    isLoadingSite = true;
    selectedSite = null;
    update();
    try {
      final res = await api.getGrnDropdownList(
        _GrnDropdownBody('Site', partyId: partyId),
      );
      if ((res.status == 200 || res.success == true) && res.data != null) {
        siteList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Site', '$e');
    } finally {
      isLoadingSite = false;
      update();
    }
  }

  Future<void> fetchGodowns({int siteId = 0}) async {
    isLoadingGodown = true;
    selectedGodown = null;
    update();

    try {
      final res = await api.getGrnDropdownList(
        _GrnDropdownBody('Godown', siteId: siteId),
      );

      if ((res.status == 200 || res.success == true) && res.data != null) {
        godownList = res.data!;

        // auto select first godown
        if (godownList.isNotEmpty) {
          selectedGodown = godownList.first;
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Godown', '$e');
    } finally {
      isLoadingGodown = false;
      update();
    }
  }

  Future<void> fetchCustomerPOs({int siteId = 0}) async {
    isLoadingCustomerPo = true;
    update();
    try {
      final res = await api.getGrnDropdownList(
          _GrnDropdownBody('customerorder', siteId: siteId));
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
      final res = await api.getGrnDropdownList(_GrnDropdownBody('Jobtype'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        jobTypeList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('JobType', '$e');
    } finally {
      isLoadingJobType = false;
      update();
    }
  }

  Future<void> fetchWorkOrders({int partyId = 0, int siteId = 0}) async {
    isLoadingWorkOrder = true;
    update();
    try {
      final res = await api.getGrnDropdownList(
        _GrnDropdownBody('workorder', partyId: partyId, siteId: siteId),
      );
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
      final res = await api.getGrnDropdownList(_GrnDropdownBody('Item'));
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
      final res = await api.getGrnDropdownList(_GrnDropdownBody('Unit'));
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
      final res = await api.getGrnDropdownList(
        _GrnDropdownBody('Brand', dependentId: dependentId),
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
      final res = await api.getGrnDropdownList(_GrnDropdownBody('Otherdetail'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        // Map GrnDropdownOption list → AdditionalChargeHead list.
        // GrnDropdownOption has .id and .label; taxpercent comes from extra
        // fields if the API returns them, otherwise defaults to 0.
        chargeHeadList = res.data!
            .map((o) => AdditionalChargeHead(
                  id: o.id,
                  accountId: o.id,
                  label: o.label,
                  // TODO(backend): if the API attaches taxpercent to each
                  // option, switch to AdditionalChargeHead.fromJson(o.toJson())
                  // For now taxPercent defaults to 0 until backend confirms.
                  taxPercent: 0,
                ))
            .toList();

        if (kDebugMode) {
          print('✅ fetchTax → ${chargeHeadList.length} charge heads loaded');
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Charge Heads', '$e');
    } finally {
      isLoadingChargeHeads = false;
      update();
    }
  }

  Future<void> fetchParties() async {
    isLoadingParty = true;
    update();
    try {
      final res = await api.getGrnDropdownList(_GrnDropdownBody('Party'));
      if ((res.status == 200 || res.success == true) && res.data != null) {
        partyList = res.data!;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Party', '$e');
    } finally {
      isLoadingParty = false;
      update();
    }
  }

  Future<void> fetchAddresses() async {
    // Addresses come from _applyGrnDetail when in edit mode
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  void _setLoggedInUser() {
    receivedByName = homeController.currentUserData?.name ?? 'User';
  }

  String _generateGrnNumber() {
    final year = DateTime.now().year;
    final seq =
        (DateTime.now().millisecondsSinceEpoch % 9000 + 1000).toString();
    return 'Grn-$year-$seq';
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

  Future<void> _applyGrnDetail(GrnDetailData d) async {
    billNoCtrl.text = d.billno;
    challanNoCtrl.text = d.dcno;
    lotNoCtrl.text = d.lotno;
    if (d.grnno.isNotEmpty) grnNoCtrl.text = d.grnno;
    gateEntryNoCtrl.text = d.gateentryno;
    receivedByName = d.receivedby;
    selectedQcRequired = d.qcstatus.isNotEmpty ? d.qcstatus : 'Yes';
    reviewRemarksCtrl.text = d.description;
    reasonNACtrl.text = d.reason;
    fromAddressCtrl.text = d.fromaddress;
    toAddressCtrl.text = d.toaddress;
    existingBillFiles = d.billfile.isNotEmpty
        ? d.billfile
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .map((s) => s.startsWith('http') ? s.split('/Images/').last : s)
            .toList()
        : [];
    existingDcFiles = d.dcfile.isNotEmpty
        ? d.dcfile
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .map((s) => s.startsWith('http') ? s.split('/Images/').last : s)
            .toList()
        : [];

    _setDateCtrl(GrnDateCtrl, d.receiptdate);
    _setDateCtrl(billDateCtrl, d.billdate);
    _setDateCtrl(challanDateCtrl, d.dcdate);
    _setDateCtrl(grnDateCtrl, d.grndate);

    partyNameCtrl.text = d.partyname;
    if (d.partyid > 0) {
      selectedParty =
          partyList.firstWhereOrNull((p) => p.id == d.partyid.toString()) ??
              GrnDropdownOption(id: d.partyid.toString(), label: d.partyname);
    }
    if (d.siteid > 0) {
      selectedSite =
          siteList.firstWhereOrNull((s) => s.id == d.siteid.toString()) ??
              GrnDropdownOption(id: d.siteid.toString(), label: d.sitename);
      fetchCustomerPOs(siteId: d.siteid);
    }
    if (d.godownid > 0) {
      selectedGodown =
          godownList.firstWhereOrNull((g) => g.id == d.godownid.toString()) ??
              GrnDropdownOption(id: d.godownid.toString(), label: d.godownname);
    }
    if (d.seriesid > 0) {
      selectedSeriesType = seriesTypeList
              .firstWhereOrNull((s) => s.id == d.seriesid.toString()) ??
          GrnDropdownOption(id: d.seriesid.toString(), label: '');
    }
    if (d.customerpoid > 0) {
      selectedCustomerPo = customerPoList
              .firstWhereOrNull((c) => c.id == d.customerpoid.toString()) ??
          GrnDropdownOption(id: d.customerpoid.toString(), label: '');
    }
    if (d.paidtype.isNotEmpty) {
      selectedPaidType =
          paidTypeList.firstWhereOrNull((p) => p.label == d.paidtype);
      if (d.paidtype == 'Employee' && d.paidbyid > 0) {
        selectedPaidBy =
            GrnDropdownOption(id: d.paidbyid.toString(), label: d.paidby);
      }
    }
    if (d.jobtypeid > 0) {
      selectedJobType =
          jobTypeList.firstWhereOrNull((j) => j.id == d.jobtypeid.toString()) ??
              GrnDropdownOption(id: d.jobtypeid.toString(), label: '');
    }
    if (d.fromaddress.isNotEmpty) {
      shippingAddress = GrnAddress(label: 'From Address', line1: d.fromaddress);
    }


    itemLines = d.items
        .map((i) => GrnItemLine(
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


    if (d.grnother.isNotEmpty) {
      if (chargeHeadList.isEmpty) await fetchTax();
      prefillAdditionalChargesFromOther(d.grnother);
    } else {
      resetAdditionalCharges();
    }

    selectedSource = GrnSourceType.grn;



    if (kDebugMode) print('📦 Items populated: ${itemLines.length}');
    update(['items_list']);
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
}
