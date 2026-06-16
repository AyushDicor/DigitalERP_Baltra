// lib/screen/ui/home/reimbursements/controller/new_reimbursement_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'package:digitalerp/model/reimbursement_dropdown_response_model.dart';
import 'package:digitalerp/model/save_reimbursement_response_model.dart';
import 'package:digitalerp/model/upload_reimbursement_file_response_model.dart';
import 'package:digitalerp/repo/reimbursement_repo.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_constant_new.dart';

//  Line item model 
class ReimbursementLineItem {
  RxList<String> attachmentFileNames = <String>[].obs;
  RxList<String> attachmentFilePaths = <String>[].obs;
  RxBool isUploading = false.obs;
  // Ledger list is per-item because each item can have a different group
  RxList<ReimbursementDropdownItem> availableLedgers =
      <ReimbursementDropdownItem>[].obs;
  RxBool isLoadingLedgers = false.obs;
  int sno;
  ReimbursementDropdownItem? expenseGroup;
  ReimbursementDropdownItem? expenseLedger;
  String description;
  double amount;

  ReimbursementLineItem({
    required this.sno,
    this.expenseGroup,
    this.expenseLedger,
    this.description = '',
    this.amount = 0.0,
  });

  Map<String, dynamic> toApiJson() => {
    "sno"            : sno,
    "parentid"       : expenseGroup?.id ?? 0,
    "expenseledgerid": expenseLedger?.id ?? 0,
    "description"    : description,
    "amount"         : amount,
    "referencefile"  : attachmentFileNames.join(','), // ✅ comma-separated, all files
    "receiptfile"    : "",
    "status"         : "P",
    "transid"        : 0,
  };
}

//  Controller 
class NewReimbursementController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  // Current user convenience getters
  String get currentUserName => homeController.currentUserData?.name ?? '';
  int get currentUserId => homeController.currentUserData?.userid ?? 0;
  int get _compId => homeController.currentUserData?.compId ?? 0;
  int get _branchId => homeController.currentUserData?.branchId ?? 0;

  //  Loading flags 
  final RxBool isLoadingDropdowns = false.obs;
  final RxBool isSaving = false.obs;

  //  Dropdown lists 
  final RxList<ReimbursementDropdownItem> seriesTypes =
      <ReimbursementDropdownItem>[].obs;
  // Site is now the full list; filteredSites is what the search shows
  final RxList<ReimbursementDropdownItem> allSites =
      <ReimbursementDropdownItem>[].obs;
  final RxList<ReimbursementDropdownItem> filteredSites =
      <ReimbursementDropdownItem>[].obs;
  final RxList<ReimbursementDropdownItem> expenseGroups =
      <ReimbursementDropdownItem>[].obs;

  //  Header selections 
  final Rx<ReimbursementDropdownItem?> selectedSeries = Rx(null);
  final Rx<ReimbursementDropdownItem?> selectedSite = Rx(null);

  //  Request By — API returns a single item, auto-selected 
  // Stored so its .id can be sent as reqid in the save body.
  // UI should show autoSelectedRequestBy?.name in a disabled text field.
  final Rx<ReimbursementDropdownItem?> autoSelectedRequestBy = Rx(null);

  //  Date 
  // Auto-set to today; user can change but NOT to a future date.
  final Rx<DateTime> expenseDate = DateTime.now().obs;
  final TextEditingController expenseDateCtrl = TextEditingController();
  final RxString expenseDateDisplay = ''.obs;

  //  Site search controller 
  final TextEditingController siteSearchCtrl = TextEditingController();

  //  Line items 
  final RxList<ReimbursementLineItem> lineItems =
      <ReimbursementLineItem>[].obs;

  double get totalAmount =>
      lineItems.fold(0.0, (sum, item) => sum + item.amount);

  // ══
  // INIT
  // ══

  @override
  void onInit() {
    super.onInit();
    _setDefaultDate();
    _loadAllDropdowns();
  }

  @override
  void onClose() {
    expenseDateCtrl.dispose();
    siteSearchCtrl.dispose();
    super.onClose();
  }

  //  Set today as default date 
  void _setDefaultDate() {
    final today = DateTime.now();
    expenseDate.value = today;
    expenseDateDisplay.value = DateFormat('dd MMM yyyy').format(today);
    expenseDateCtrl.text = DateFormat('dd MMM yyyy').format(today);
  }

  // ══
  // DROPDOWN LOADERS
  // ══

  Future<void> _loadAllDropdowns() async {
    isLoadingDropdowns.value = true;

    await Future.wait([
      _fetchSeriesTypes(),
      _fetchSites(),
      _fetchExpenseGroups(),
     // _fetchRequestBy(),
    ]);

    isLoadingDropdowns.value = false;
  }

  // Series Type — auto-select first item after loading
  Future<void> _fetchSeriesTypes() async {
    try {
      final result = await ReimbursementRepo.getReimbursementDropdown({
        "type": "SeriesType",
        "compid": _compId,
        "branchid": _branchId,
        "parentid": 0,
      });
      if (result.statusCode == 200 && result.data != null) {
        final model = ReimbursementDropdownResponseModel.fromJson(
            result.data as Map<String, dynamic>);
        final list = model.data ?? [];
        seriesTypes.assignAll(list);
        log('✅ SeriesType loaded: ${list.length} items');

        // AUTO-SELECT: first item in the list
        if (list.isNotEmpty) {
          selectedSeries.value = list.first;
          log('✅ SeriesType auto-selected: ${list.first.name}');
        }
      }
    } catch (e) {
      log('❌ _fetchSeriesTypes: $e');
    }
  }

  // Site — load all, store in allSites, copy to filteredSites for search
  Future<void> _fetchSites() async {
    try {
      final result = await ReimbursementRepo.getReimbursementDropdown({
        "type": "Site",
        "compid": _compId,
        "branchid": _branchId,
        "parentid": 0,
      });
      if (result.statusCode == 200 && result.data != null) {
        final model = ReimbursementDropdownResponseModel.fromJson(
            result.data as Map<String, dynamic>);
        final list = model.data ?? [];
        allSites.assignAll(list);
        filteredSites.assignAll(list); // initially show all
        log('✅ Site loaded: ${list.length} items');
      }
    } catch (e) {
      log('❌ _fetchSites: $e');
    }
  }

  // ExpenseGroup — load top-level groups
  // Note: expenseledgerid = 0 at the top level (no ledger selected yet)
  Future<void> _fetchExpenseGroups() async {
    try {
      final result = await ReimbursementRepo.getReimbursementDropdown({
        "type": "ExpenseLedger",   // ← now fetching ledgers at top level
        "compid": _compId,
        "branchid": _branchId,
        "parentid": 0,
        "expenseledgerid": 0,
      });
      if (result.statusCode == 200 && result.data != null) {
        final model = ReimbursementDropdownResponseModel.fromJson(
            result.data as Map<String, dynamic>);
        expenseGroups.assignAll(model.data ?? []); // holds ledgers now
        log('✅ ExpenseLedger list loaded: ${expenseGroups.length} items');
      }
    } catch (e) {
      log('❌ _fetchExpenseGroups: $e');
    }
  }

  // Request By — API returns a single item, auto-select it
  Future<void> _fetchRequestBy() async {
    try {
      final result = await ReimbursementRepo.getReimbursementDropdown({
        "type": "Employee",
        "compid": _compId,
        "branchid": _branchId,
        "parentid": 0,
      });
      if (result.statusCode == 200 && result.data != null) {
        final model = ReimbursementDropdownResponseModel.fromJson(
            result.data as Map<String, dynamic>);
        final list = model.data ?? [];
        if (list.isNotEmpty) {
          autoSelectedRequestBy.value = list.first;
          log('✅ RequestBy auto-selected: ${list.first.name} (id: ${list.first.id})');
        }
      }
    } catch (e) {
      log('❌ _fetchRequestBy: $e');
    }
  }

  // ══
  // SITE SEARCH
  // ══

  // Filters the already-loaded allSites list — no extra API call needed.
  void searchSite(String query) {
    if (query.trim().isEmpty) {
      filteredSites.clear();  // ← nothing shows until user types
    } else {
      final q = query.toLowerCase();
      filteredSites.assignAll(
        allSites.where((s) => (s.name ?? '').toLowerCase().contains(q)),
      );
    }
  }

  void onSiteSelected(ReimbursementDropdownItem item) {
    selectedSite.value = item;
    siteSearchCtrl.text = item.name ?? '';
    filteredSites.clear(); // hide dropdown list after selection
  }

  void clearSiteSelection() {
    selectedSite.value = null;
    siteSearchCtrl.clear();
    filteredSites.assignAll(allSites);
  }

  // ══
  // DATE PICKER
  // ══

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: expenseDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(), // ← NO future dates allowed
    );
    if (picked != null) {
      expenseDate.value = picked;
      expenseDateDisplay.value = DateFormat('dd MMM yyyy').format(picked);
      expenseDateCtrl.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  // ══
  // LINE ITEM MANAGEMENT
  // ══

  void addLineItem() {
    lineItems.add(ReimbursementLineItem(sno: lineItems.length + 1));
  }

  void removeLineItem(int index) {
    if (index >= 0 && index < lineItems.length) {
      lineItems.removeAt(index);
      for (int i = 0; i < lineItems.length; i++) {
        lineItems[i].sno = i + 1;
      }
      lineItems.refresh();
    }
  }

  // Called when user selects an ExpenseGroup in a line item.
  // Fetches ledgers for that group using:
  //   type            = "ExpenseLedger"   ← gets actual ledger items
  //   expenseledgerid = group.id          ← filters ledgers belonging to this group
  //   parentid        = 0                 ← not used for ledger fetch
  //  Replace onExpenseGroupSelected with these two methods 

// Step 1: User picks Expense Ledger → fetch & lock Expense Group
  Future<void> onExpenseLedgerSelected(
      int itemIndex, ReimbursementDropdownItem ledger) async {
    final item = lineItems[itemIndex];
    item.expenseLedger = ledger;
    item.expenseGroup = null;
    item.isLoadingLedgers.value = true;
    lineItems.refresh();

    try {
      final result = await ReimbursementRepo.getReimbursementDropdown({
        "type": "ExpenseGroup",
        "compid": _compId,
        "branchid": _branchId,
        "parentid": 0,
        "expenseledgerid": ledger.id,
      });

      if (result.statusCode == 200 && result.data != null) {
        final model = ReimbursementDropdownResponseModel.fromJson(
            result.data as Map<String, dynamic>);
        final groups = model.data ?? [];
        if (groups.isNotEmpty) {
          item.expenseGroup = groups.first;
          log('✅ ExpenseGroup auto-selected & locked: ${groups.first.name}');
        }
      }
    } catch (e) {
      log('❌ onExpenseLedgerSelected (group fetch): $e');
    } finally {
      item.isLoadingLedgers.value = false;
      lineItems.refresh();
    }
  }

  void updateLineItemAmount(int index, double amount) {
    lineItems[index].amount = amount;
    lineItems.refresh();
  }

  void updateLineItemDescription(int index, String desc) {
    lineItems[index].description = desc;
    lineItems.refresh();
  }

  // ══
  // FILE UPLOAD
  // ══

  Future<void> pickAndUploadFiles(int itemIndex) async {
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add Attachment",
                style: GoogleFonts.dmSans(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ListTile(
              leading:
              const Icon(Icons.camera_alt_outlined, color: purpleColor),
              title: Text("Camera", style: GoogleFonts.dmSans()),
              onTap: () async {
                Get.back();
                await _pickFromCamera(itemIndex);
              },
            ),
            ListTile(
              leading:
              const Icon(Icons.image_outlined, color: purpleColor),
              title: Text("Gallery", style: GoogleFonts.dmSans()),
              onTap: () async {
                Get.back();
                await _pickFromGallery(itemIndex);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined,
                  color: purpleColor),
              title: Text("PDF / File", style: GoogleFonts.dmSans()),
              onTap: () async {
                Get.back();
                await _pickFromFilePicker(itemIndex);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromCamera(int itemIndex) async {
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      if (photo == null) return;
      await _uploadFile(itemIndex,
          filePath: photo.path, fileName: photo.name);
    } catch (e) {
      log('❌ _pickFromCamera: $e');
      _showError("Error capturing image");
    }
  }

  Future<void> _pickFromGallery(int itemIndex) async {
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage(imageQuality: 80);
      if (images.isEmpty) return;
      for (final image in images) {
        await _uploadFile(itemIndex,
            filePath: image.path, fileName: image.name);
      }
    } catch (e) {
      log('❌ _pickFromGallery: $e');
      _showError("Error picking from gallery");
    }
  }

  Future<void> _pickFromFilePicker(int itemIndex) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null || result.files.isEmpty) return;
      for (final file in result.files) {
        if (file.path == null) continue;
        await _uploadFile(itemIndex,
            filePath: file.path!, fileName: file.name);
      }
    } catch (e) {
      log('❌ _pickFromFilePicker: $e');
      _showError("Error picking file");
    }
  }

  Future<void> _uploadFile(int itemIndex,
      {required String filePath, required String fileName}) async {
    final item = lineItems[itemIndex];
    try {
      item.isUploading.value = true;
      item.attachmentFilePaths.add(filePath);
      lineItems.refresh();

      final uploadResult =
      await ReimbursementRepo.uploadReimbursementFile(filePath);

      if (uploadResult.statusCode == 200 && uploadResult.data != null) {
        final model = UploadReimbursementFileResponseModel.fromJson(
            uploadResult.data as Map<String, dynamic>);
        final serverFilename = model.data?.filename ?? '';
        item.attachmentFileNames.add(serverFilename);
        _showSuccess("$fileName uploaded successfully");
        log('✅ Uploaded → $serverFilename');
      } else {
        item.attachmentFilePaths.remove(filePath);
        _showError(uploadResult.message ?? "File upload failed");
      }
    } catch (e) {
      item.attachmentFilePaths.remove(filePath);
      log('❌ _uploadFile: $e');
      _showError("Error uploading $fileName");
    } finally {
      item.isUploading.value = false;
      lineItems.refresh();
    }
  }

  void removeAttachment(int itemIndex, int fileIndex) {
    final item = lineItems[itemIndex];
    item.attachmentFileNames.removeAt(fileIndex);
    item.attachmentFilePaths.removeAt(fileIndex);
    lineItems.refresh();
  }

  // ══
  // VALIDATION
  // ══

  bool _validate() {
    if (selectedSeries.value == null) {
      _showError("Please select Series Type");
      return false;
    }
    if (selectedSite.value == null) {
      _showError("Please select Site");
      return false;
    }
    if (lineItems.isEmpty) {
      _showError("Please add at least one expense item");
      return false;
    }
    for (int i = 0; i < lineItems.length; i++) {
      final item = lineItems[i];
      if (item.expenseLedger == null) {
        _showError("Item ${i + 1}: Please select Expense Ledger");
        return false;
      }
      if (item.amount <= 0) {
        _showError("Item ${i + 1}: Amount must be greater than 0");
        return false;
      }
      if (selectedSeries.value == null && seriesTypes.isNotEmpty) {
        selectedSeries.value = seriesTypes.first;
      }
    }
    return true;
  }

  // ══
  // SAVE
  // ══

  Future<void> saveReimbursement() async {
    if (!_validate()) return;

    try {
      isSaving.value = true;

      final requestData = {
        "expenseid": 0,
        "seriesid": selectedSeries.value!.id,
        "expenserno": "",
        "expensedate": DateFormat('yyyy-MM-dd').format(expenseDate.value),
        "siteid": selectedSite.value!.id,
        "reqid": currentUserId,
        "amount": totalAmount,
        "compid": _compId,
        "branchid": _branchId,
        "userid": homeController.currentUserData?.userid,
        "yearid":
        homeController.currentUserData?.yearId?.toString() ?? "",
        "items": lineItems.map((e) => e.toApiJson()).toList(),
      };

      log('SaveReimbursement → $requestData');
      log('Item toApiJson: ${jsonEncode(lineItems.map((e) => e.toApiJson()).toList())}');
      final result = await ReimbursementRepo.saveReimbursement(requestData);

      if (result.statusCode == 200) {
        log('Raw response data → ${result.data}');

        // ← Safe cast instead of hard cast
        final rawData = result.data;
        if (rawData == null) {
          _showError("Empty response from server");
          return;
        }

        final model = SaveReimbursementResponseModel.fromJson(
            Map<String, dynamic>.from(rawData)); // ← Map.from() instead of 'as'

        log('Parsed → success: ${model.success}, message: ${model.message}');

        if (model.success == true) {
          Get.focusScope?.unfocus();

          Get.snackbar(
            "Success ✓",
            model.message ?? "Reimbursement submitted successfully",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            icon: const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 24),
          );

          _clearForm();
          isSaving.value = false;

          await Future.delayed(const Duration(milliseconds: 600));

// Bypass GetX navigation — use Navigator directly
          Navigator.of(Get.context!).pop(true);

        } else {
          Get.snackbar(
            "Failed ✗",
            model.message ?? "Failed to submit reimbursement",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.shade600,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            icon: const Icon(Icons.error_outline, color: Colors.white, size: 24),
          );
        }
      } else {
        _showError(result.message ?? "Failed to save reimbursement");
      }
    } catch (e, s) {
      log('❌ saveReimbursement: $e', stackTrace: s);
      _showError("Error saving reimbursement");
    } finally {
      if (isSaving.value) isSaving.value = false; // ← only if not already set
    }
  }

  // ══
  // HELPERS
  // ══

  void _clearForm() {
    // Re-select series first item (keep auto-selection behaviour)
    selectedSeries.value =
    seriesTypes.isNotEmpty ? seriesTypes.first : null;
    selectedSite.value = null;
    siteSearchCtrl.clear();
    filteredSites.assignAll(allSites);
    _setDefaultDate();
    lineItems.clear();
    // autoSelectedRequestBy is NOT reset — it never changes during a session
  }

  void _showError(String msg) => Get.snackbar(
    "Error",
    msg,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.red.shade600,
    colorText: Colors.white,
    duration: const Duration(seconds: 3),
    margin: const EdgeInsets.all(12),
    borderRadius: 10,
  );

  void _showSuccess(String msg) => Get.snackbar(
    "Success",
    msg,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.green.shade600,
    colorText: Colors.white,
    duration: const Duration(seconds: 2),
    margin: const EdgeInsets.all(12),
    borderRadius: 10,
  );
}