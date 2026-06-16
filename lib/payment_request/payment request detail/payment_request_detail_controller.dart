import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:digitalerp/payment_request/payment_request_model/payment_request_dropdown_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../repo/reimbursement_repo.dart';
import '../payment request list/payment_request_list_controller.dart';
import '../payment_request_model/payment_request_model.dart';

class PaymentRequestDetailController extends AppBaseController {
  final PaymentRequestModel request;
  PaymentRequestDetailController({required this.request});

  HomeController get homeController => Get.find<HomeController>();

  int get _userId  => homeController.currentUserData?.userid  ?? 0;
  int get _compId  => homeController.currentUserData?.compId  ?? 0;
  int get _branchId => homeController.currentUserData?.branchId ?? 0;
  String get _yearId => homeController.currentUserData?.yearId?.toString() ?? '';

  //  Dropdowns 
  List<PaymentRequestDropdownItem> partyTypeList    = [];
  List<PaymentRequestDropdownItem> requestTypeList  = [];
  List<PaymentRequestDropdownItem> partyList        = [];
  List<PaymentRequestDropdownItem> siteList         = [];
  List<PaymentRequestDropdownItem> approverList     = [];

  PaymentRequestDropdownItem? selectedPartyType;
  PaymentRequestDropdownItem? selectedRequestType;
  PaymentRequestDropdownItem? selectedParty;
  PaymentRequestDropdownItem? selectedSite;
  PaymentRequestDropdownItem? selectedApprover;

  //  Text controllers 
  final amountController  = TextEditingController();
  final reasonController  = TextEditingController();
  final refDocController  = TextEditingController();
  final partySearchCtrl   = TextEditingController();
  final siteSearchCtrl    = TextEditingController();

  //  Date 
  DateTime selectedDate = DateTime.now();

  //  File 
  final uploadedFiles = <String>[].obs;
  final picker = ImagePicker();

  bool isDropdownLoading = true;

  /// Only pending requests can be edited
  bool get canEdit => request.status?.toLowerCase() == 'pending';
  bool isEditMode = false;
  final isUploading = false.obs;

  //  Lifecycle 
  @override
  void onInit() {
    super.onInit();
    log('DEBUG partyId=${request.partyId} branchId=${request.branchId}');
    _prefillFields();
    _loadDropdowns();
  }

  @override
  void onClose() {
    amountController.dispose();
    reasonController.dispose();
    refDocController.dispose();
    partySearchCtrl.dispose();
    siteSearchCtrl.dispose();
    super.onClose();
  }

  void enterEditMode() {
    isEditMode = true;
    update();
  }

  void exitEditMode() {
    isEditMode = false;
    update();
  }


  //  Pre-fill 
  void _prefillFields() {
    log('DEBUG partyId=${request.partyId} branchId=${request.branchId} approverName=${request.approverName}');
    amountController.text = request.amount?.toStringAsFixed(2) ?? '';
    reasonController.text = request.reason ?? '';
    refDocController.text = request.refDocNo ?? '';
    partySearchCtrl.text  = request.partyName ?? '';
    siteSearchCtrl.text   = request.branchName ?? '';
    selectedDate          = request.requestDate ?? DateTime.now();

    // ← Pre-set selected objects from existing request data
    // These will be overwritten by _loadDropdowns() if a better match is found,
    // but they serve as fallback so validation never fails on unmodified data.
    if (request.partyId != null) {
      selectedParty = PaymentRequestDropdownItem(
          id: request.partyId.toString(), name: request.partyName);
    }
    if (request.branchId != null) {
      selectedSite = PaymentRequestDropdownItem(
          id: request.branchId.toString(), name: request.branchName);
    }

    if (request.documentName?.isNotEmpty == true) {
      uploadedFiles.addAll(
          request.documentName!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty));
    }
  }

  //  Load all dropdowns, then match pre-selected values 
  Future<void> _loadDropdowns() async {
    isDropdownLoading = true;
    update();

    await Future.wait([
      _fetch('PartyType', onDone: (list) {
        partyTypeList = list;
        selectedPartyType = list.firstWhereOrNull(
              (e) => e.name?.toLowerCase() == request.partyType?.toLowerCase(),
        );
      }),
      _fetch('Approver', onDone: (list) {
        approverList = list;
        selectedApprover = list.firstWhereOrNull(
              (e) => e.name?.toLowerCase() == request.approverName?.toLowerCase(),
        );
      }),
    ]);

    if (selectedPartyType != null) {
      await Future.wait([
        _fetch('RequestType', parentId: selectedPartyType!.safeId, onDone: (list) {
          requestTypeList = list;
          selectedRequestType = list.firstWhereOrNull(
                (e) => e.name?.toLowerCase() == request.requestType?.toLowerCase(),
          );
        }),
        _fetch('Party', parentId: selectedPartyType!.safeId, onDone: (list) {
          partyList = list;
          final match = list.firstWhereOrNull(
                (e) => e.name?.trim().toLowerCase() == request.partyName?.trim().toLowerCase(),
          );
          if (match != null) selectedParty = match;
        }),
      ]);
    }

    if (request.branchName?.isNotEmpty == true) {
      await _fetch('Site', searchText: request.branchName!, onDone: (list) {
        siteList = list;
        final match = list.firstWhereOrNull(
              (e) => e.name?.trim().toLowerCase() == request.branchName?.trim().toLowerCase(),
        );
        if (match != null) selectedSite = match;
      });
    }

    isDropdownLoading = false;
    update();
  }

  Future<void> _fetch(
      String type, {
        int parentId = 0,
        String searchText = '',
        required void Function(List<PaymentRequestDropdownItem>) onDone,
      }) async {
    try {
      final res = await api.paymentRequestDropdown({
        'type': type, 'compid': _compId, 'branchid': _branchId,
        'parentid': parentId, 'searchtext': searchText,
      });
      if (res.status == 200 && res.data != null) {
        onDone((res.data as List<dynamic>)
            .map((e) => PaymentRequestDropdownItem.fromJson(e as Map<String, dynamic>))
            .toList());
        update();
      }
    } catch (e) {
      log('_fetch $type error: $e');
    }
  }

  //  Dropdown callbacks 
  void onPartyTypeSelected(PaymentRequestDropdownItem? item) {
    selectedPartyType = item;
    selectedRequestType = selectedParty = null;
    requestTypeList.clear(); partyList.clear(); partySearchCtrl.clear();
    update();
    if (item != null) {
      _fetch('RequestType', parentId: item.safeId, onDone: (l) { requestTypeList = l; update(); });
      searchParty('');
    }
  }

  Future<void> searchParty(String text) async {
    if (selectedPartyType == null) return;
    await _fetch('Party', parentId: selectedPartyType!.safeId, searchText: text,
        onDone: (l) { partyList = l; update(); });
  }

  Future<void> searchSite(String text) async {
    if (text.isEmpty) { siteList = []; update(); return; }
    await _fetch('Site', searchText: text, onDone: (l) { siteList = l; update(); });
  }

  void onPartySelected(PaymentRequestDropdownItem item) {
    selectedParty = item; partySearchCtrl.text = item.name ?? ''; partyList.clear(); update();
  }

  void onSiteSelected(PaymentRequestDropdownItem item) {
    selectedSite = item; siteSearchCtrl.text = item.name ?? ''; siteList.clear(); update();
  }

  void onApproverSelected(PaymentRequestDropdownItem? item) {
    selectedApprover = item; update();
  }

  void onRequestTypeSelected(PaymentRequestDropdownItem? item) {
    selectedRequestType = item; update();
  }

  //  Date picker 
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) { selectedDate = picked; update(); }
  }

  //  Image / file 
  Future<void> getImage(ImageSource source) async {
    Get.back();

    final picked = await picker.pickImage(source: source, imageQuality: 65);

    if (picked != null) {
      await _uploadFile(File(picked.path)); // ← removed selectedImage.value line
    }
  }

  Future<void> _uploadFile(File file) async {
    try {
      isUploading.value = true;
      final res = await ReimbursementRepo.uploadReimbursementFile(file.path);

      // BEFORE: res.status == 200  ← wrong, status is bool not int
      // AFTER: res.status == true AND res.statusCode == 200
      if (res.status == true && res.statusCode == 200) {
        final jsonData = res.data as Map<String, dynamic>?;
        final filename = jsonData?['data']?['filename'] as String? ??
            jsonData?['filename'] as String? ?? '';
        if (filename.isNotEmpty) {
          uploadedFiles.add(filename);
          uploadedFiles.refresh();
          update();
          log('File added ✓ → $filename | Total: ${uploadedFiles.length}');
        } else {
          log('Filename empty. Full data: ${res.data}');
          ShowMessage.showSnackBar('Error', 'No filename returned');
        }
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Upload failed');
      }
    } catch (e) {
      log('Upload error: $e');
      ShowMessage.showSnackBar('Error', 'File upload failed');
    } finally {
      isUploading.value = false;
    }
  }

  //  Save (SavePaymentRequest API) 
  Future<bool> saveRequest() async {
    // If selectedParty is null but text is pre-filled (loaded from existing request),
    // create a stub item so we can still read the ID from the original request.
    final effectiveParty = selectedParty ??
        (partySearchCtrl.text.trim().isNotEmpty && request.partyId != null
            ? PaymentRequestDropdownItem(
            id: request.partyId.toString(), name: request.partyName)
            : null);

    final effectiveSite = selectedSite ??
        (siteSearchCtrl.text.trim().isNotEmpty && request.branchId != null
            ? PaymentRequestDropdownItem(
            id: request.branchId.toString(), name: request.branchName)
            : null);

    if (effectiveParty == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Party');
      return false;
    }
    if (effectiveSite == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Site');
      return false;
    }
    if (selectedApprover == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Approver');
      return false;
    }
    if (amountController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please enter Amount');
      return false;
    }
    if (reasonController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please enter Reason');
      return false;
    }

    try {
      setBusy(true);

      final body = {
        'reqid':       request.requestId ?? 0,
        'requestdate': DateFormat('yyyy-MM-dd').format(selectedDate),
        'partyid':     effectiveParty.safeId,   // ← use effective
        'siteid':      effectiveSite.safeId,    // ← use effective
        'amount':      double.tryParse(amountController.text.trim()) ?? 0.0,
        'compid':      _compId,
        'branchid':    _branchId,
        'userid':      _userId,
        'yearid':      _yearId,
        'approverid':  selectedApprover!.safeId,
        'filename':    uploadedFiles.join(','),
        'requestfor':  reasonController.text.trim(),
        'requesttype': selectedRequestType?.name ?? request.requestType ?? 'Payment',
        'items':       [],
      };


      log('SAVE PAYMENT REQUEST BODY :=> ${jsonEncode(body)}');

      final res = await api.paymentRequestEntry(body);
      if (res.status == 200) {
        if (Get.isRegistered<PaymentRequestListController>()) {
          PaymentRequestListController.to.getPaymentRequestList(isRefresh: true);
        }

        Get.back(); // go to list first

        // GetX snackbar is a global overlay, shows on top of list screen
        Get.snackbar(
          'Success',
          res.message ?? 'Updated Successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF2E7D32),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          borderRadius: 10,
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );

        return true;
      }else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to update');
        return false;
      }
    } catch (e) {
      log('saveRequest Error: $e');
      ShowMessage.showSnackBar('Error', 'Something went wrong: $e');
      return false;
    } finally {
      setBusy(false);
    }
  }

  //  Cancel request 
  Future<void> cancelRequest() async {
    setBusy(true);
    try {
      final res = await api.updatePaymentRequestStatus({
        RequestKeys.userId:  _userId.toString(),
        RequestKeys.compId:  _compId.toString(),
        'requestid': request.requestId.toString(),
        'action':    'cancel',
      });
      if (res.status == 200) {
        ShowMessage.showSnackBar('Success', 'Payment request cancelled');
        Get.back();
        if (Get.isRegistered<PaymentRequestListController>()) {
          PaymentRequestListController.to.getPaymentRequestList(isRefresh: true);
        }
      } else {
        ShowMessage.showSnackBar('Error', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
    }
  }
}