import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:digitalerp/payment_request/payment%20request%20list/payment_request_list_screen.dart';
import 'package:digitalerp/payment_request/payment_request_model/payment_request_dropdown_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../repo/reimbursement_repo.dart';

class SelectedFileItem {
  final String path;
  final String name;
  final FileType type;
  final int bytes;

  SelectedFileItem({
    required this.path,
    required this.name,
    required this.type,
    required this.bytes,
  });

  String get sizeLabel {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class PaymentRequestController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  static PaymentRequestController get to =>
      Get.find<PaymentRequestController>();

  //  Dropdown lists 
  List<PaymentRequestDropdownItem> partyTypeList = [];
  List<PaymentRequestDropdownItem> requestTypeList = [];
  List<PaymentRequestDropdownItem> partyList = [];
  List<PaymentRequestDropdownItem> siteList = [];
  List<PaymentRequestDropdownItem> approverList = [];
  List<PaymentRequestDropdownItem> _allPartyList = [];
  // List<PaymentRequestDropdownItem> _allSiteList = [];



  //  Selected values 
  PaymentRequestDropdownItem? selectedPartyType;
  PaymentRequestDropdownItem? selectedRequestType;
  PaymentRequestDropdownItem? selectedParty;
  PaymentRequestDropdownItem? selectedSite;
  PaymentRequestDropdownItem? selectedApprover;

  //  Text controllers 
  final amountController = TextEditingController();
  final reasonController = TextEditingController();
  final refDocController = TextEditingController();
  final partySearchCtrl = TextEditingController();
  final siteSearchCtrl = TextEditingController();

  final FocusNode amountFocus = FocusNode();
  final FocusNode reasonFocus = FocusNode();
  final FocusNode refDocFocus = FocusNode();

  //  File upload 
  final selectedImage = ''.obs;
  final uploadedFileName = ''.obs;
  final picker = ImagePicker();
  final RxList<SelectedFileItem> selectedFiles = <SelectedFileItem>[].obs;
  final RxList<String> uploadedFileNames = <String>[].obs;

  bool isDropdownLoading = true;

  int get _userId => homeController.currentUserData?.userid ?? 0;
  int get _compId => homeController.currentUserData?.compId ?? 0;
  int get _branchId => homeController.currentUserData?.branchId ?? 0;
  String get _yearId =>
      homeController.currentUserData?.yearId?.toString() ?? '';

  Timer? _siteSearchDebounce;

  //  Lifecycle 
  @override
  void onInit() {
    super.onInit();
    log('=== PaymentRequestController onInit ===');
    if (Get.isRegistered<HomeController>()) {
      homeController = Get.find<HomeController>();
    } else {
      homeController = Get.put(HomeController());
    }
    _loadDropdowns();
  }

  Future<void> _loadDropdowns() async {
    isDropdownLoading = true;
    update();

    await Future.wait([
      _fetchDropdown('PartyType', onDone: (list) {
        partyTypeList = list;
        log('✅ PartyType loaded: ${list.length}');
      }),
      _fetchDropdown('Approver', onDone: (list) {
        approverList = list;
        log('✅ Approver loaded: ${list.length}');
      }),
    ]);

    isDropdownLoading = false;
    update();
  }

  //  Core dropdown fetcher 
  //
  // Parameter guide:
  //   type          → which dropdown to load (PartyType / RequestType / Party / Site / Approver)
  //   parentid      → the ID of the parent selection
  //                    • For RequestType : parentid = selectedPartyType.id
  //                    • For Party       : parentid = selectedPartyType.id
  //                    • Others          : 0
  //   requesttypeid → ONLY used when loading Party names
  //                    • Pass selectedRequestType.id so the API filters
  //                      parties that are valid for that request type
  //                    • All other calls send 0
  //   searchtext    → live search string (used for Party / Site)
  //
  Future<void> _fetchDropdown(
    String type, {
    int parentId = 0,
    int requestTypeId = 0, // ← NEW: default 0; non-zero only for Party
    String searchText = '',
    required void Function(List<PaymentRequestDropdownItem>) onDone,
  }) async {
    try {
      final body = {
        'type': type,
        'compid': _compId,
        'branchid': _branchId,
        'parentid': parentId,
        'searchtext': searchText,
        'requesttypeid': requestTypeId, // ← always sent; API ignores it when 0
      };

      log('>>> API [$type] body: ${jsonEncode(body)}');

      final res = await api.paymentRequestDropdown(body);

      if (res.status == 200 && res.data != null) {
        final items = (res.data as List<dynamic>)
            .map((e) =>
                PaymentRequestDropdownItem.fromJson(e as Map<String, dynamic>))
            .toList();
        onDone(items);
        update();
        log('>>> [$type] SUCCESS — ${items.length} items');
      } else {
        log('>>> [$type] FAILED — ${res.message}');
      }
    } catch (e) {
      log('>>> [$type] EXCEPTION — $e');
    }
  }

  //  Step 1: Party Type selected 
  // Load RequestType using partyType.id as parentid.
  // Reset everything downstream.
  void onPartyTypeSelected(PaymentRequestDropdownItem? item) {
    selectedPartyType = item;

    // Reset downstream selections
    selectedRequestType = null;
    selectedParty = null;
    requestTypeList.clear();
    partyList.clear();
    partySearchCtrl.clear();

    update();

    if (item != null) {
      // RequestType call:
      //   parentid      = partyType.id   (filters request types for this party type)
      //   requesttypeid = 0              (not relevant here)
      _fetchDropdown(
        'RequestType',
        parentId: item.safeId,
        requestTypeId: 0,
        onDone: (list) {
          requestTypeList = list;
          update();
        },
      );
    }
  }

  //  Step 2: Request Type selected 
  // Just store the selection and reset party.
  // Party list will be reloaded on next searchParty() call,
  // now with the correct requesttypeid.
  void onRequestTypeSelected(PaymentRequestDropdownItem? item) {
    selectedRequestType = item;
    selectedParty = null;
    partyList.clear();
    _allPartyList.clear(); // reset cache for new request type
    partySearchCtrl.clear();
    update();

    // ✅ Pre-load all parties immediately
    if (item != null && selectedPartyType != null) {
      _fetchDropdown(
        'Party',
        parentId: selectedPartyType!.safeId,
        requestTypeId: item.safeId,
        searchText: '', // empty = fetch all
        onDone: (list) {
          _allPartyList = list;
          update();
        },
      );
    }
  }

  //  Step 3: Party search 
  // This is where requesttypeid matters:
  //   parentid      = selectedPartyType.id   (which kind of party — Customer/Vendor/etc)
  //   requesttypeid = selectedRequestType.id (filters parties valid for this request type)
  //   searchtext    = what the user typed
  Future<void> searchParty(String searchText) async {
    if (selectedPartyType == null) {
      partyList = [];
      update();
      return;
    }

    // Load all parties if not yet cached
    if (_allPartyList.isEmpty) {
      final int requestTypeId = selectedRequestType?.safeId ?? 0;
      await _fetchDropdown(
        'Party',
        parentId: selectedPartyType!.safeId,
        requestTypeId: requestTypeId,
        searchText: '',
        onDone: (list) {
          _allPartyList = list;
        },
      );
    }

    // ✅ Filter locally — matches anywhere in name
    if (searchText.isEmpty) {
      partyList = _allPartyList;
    } else {
      final q = searchText.toLowerCase();
      partyList = _allPartyList
          .where((e) => e.name?.toLowerCase().contains(q) ?? false)
          .toList();
    }
    update();
  }

  //  Site search 
  // Site is independent — no requesttypeid needed
  Future<void> searchSite(String text) async {
    _siteSearchDebounce?.cancel();

    if (text.trim().length < 2) {
      siteList = [];
      update();
      return;
    }

    _siteSearchDebounce = Timer(const Duration(milliseconds: 400), () async {
      await _fetchDropdown(
        'Site',
        searchText: text.trim(),   // ← server-side search
        onDone: (list) {
          siteList = list;
          update();
        },
      );
    });
  }


    //  Selection handlers
  void onPartySelected(PaymentRequestDropdownItem item) {
    selectedParty = item;
    partySearchCtrl.text = item.name ?? '';
    partyList.clear();
    update();
  }

  void onSiteSelected(PaymentRequestDropdownItem item) {
    selectedSite = item;
    siteSearchCtrl.text = item.name ?? '';
    siteList.clear();
    update();
  }

  void onApproverSelected(PaymentRequestDropdownItem? item) {
    selectedApprover = item;
    update();
  }

  //  File picking 
  Future<void> pickMultipleImages(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final picked = await picker.pickMultiImage();
      for (final xFile in picked) {
        final file = File(xFile.path);
        selectedFiles.add(SelectedFileItem(
          path: xFile.path,
          name: xFile.name,
          type: FileType.image,
          bytes: await file.length(),
        ));
      }
    } else {
      final xFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 65);
      if (xFile != null) {
        final file = File(xFile.path);
        selectedFiles.add(SelectedFileItem(
          path: xFile.path,
          name: xFile.name,
          type: FileType.image,
          bytes: await file.length(),
        ));
      }
    }
  }

  Future<void> pickPdfFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      for (final pf in result.files) {
        if (pf.path != null) {
          selectedFiles.add(SelectedFileItem(
            path: pf.path!,
            name: pf.name,
            type: FileType.any,
            bytes: pf.size,
          ));
        }
      }
    }
  }

  void removeFile(int index) => selectedFiles.removeAt(index);

  Future<void> getImage(ImageSource source) async {
    Get.back();
    final picked = await picker.pickImage(source: source, imageQuality: 65);
    if (picked != null) {
      selectedImage.value = picked.path;
      await _uploadFile(File(picked.path));
    }
  }

  Future<void> _uploadFile(File file) async {
    try {
      setBusy(true);
      final res = await ReimbursementRepo.uploadReimbursementFile(file.path);

      // ← Same pattern as DetailController
      if (res.status == true && res.statusCode == 200) {
        final jsonData = res.data as Map<String, dynamic>?;
        final filename = jsonData?['data']?['filename'] as String?
            ?? jsonData?['filename'] as String?
            ?? '';
        if (filename.isNotEmpty) {
          uploadedFileName.value = filename;
          log('✅ Single upload: $filename');
        }
      } else {
        log('❌ Upload failed: ${res.message}');
      }
    } catch (e) {
      log('Upload error: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> uploadAllSelectedFiles() async {
    uploadedFileNames.clear();

    for (final fileItem in selectedFiles) {
      try {
        final res = await ReimbursementRepo.uploadReimbursementFile(fileItem.path);

        log('Upload res.status: ${res.status}');
        log('Upload res.statusCode: ${res.statusCode}');
        log('Upload res.data: ${res.data}');

        // ← Fix: match the same check as DetailController
        if (res.status == true && res.statusCode == 200) {
          final jsonData = res.data as Map<String, dynamic>?;
          final filename = jsonData?['data']?['filename'] as String?
              ?? jsonData?['filename'] as String?
              ?? '';

          if (filename.isNotEmpty) {
            uploadedFileNames.add(filename);
            log('✅ Uploaded: $filename | Total: ${uploadedFileNames.length}');
          } else {
            log('❌ Filename empty. res.data = ${res.data}');
          }
        } else {
          log('❌ Failed to upload ${fileItem.name}: ${res.message}');
        }
      } catch (e) {
        log('❌ Upload exception for ${fileItem.name}: $e');
      }
    }
  }

  //  Clear 
  void clearData() {
    _allPartyList.clear();
    selectedPartyType = selectedRequestType =
        selectedParty = selectedSite = selectedApprover = null;
    amountController.clear();
    reasonController.clear();
    refDocController.clear();
    partySearchCtrl.clear();
    siteSearchCtrl.clear();
    selectedImage.value = '';
    uploadedFileName.value = '';
    uploadedFileNames.clear();
    selectedFiles.clear();
    requestTypeList.clear();
    partyList.clear();
    siteList.clear();
    update();
  }

  //  Submit 
  Future<void> submitButton() async {
    if (selectedPartyType == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Party Type');
      return;
    }
    if (selectedRequestType == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Request Type');
      return;
    }
    if (selectedParty == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Party Name');
      return;
    }
    if (selectedSite == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Site/Branch');
      return;
    }
    if (selectedApprover == null) {
      ShowMessage.showSnackBar('Validation', 'Please select Approver');
      return;
    }
    if (amountController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please enter Amount');
      return;
    }
    if (reasonController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Validation', 'Please enter Reason');
      return;
    }

    try {
      setBusy(true);

      if (selectedFiles.isNotEmpty) {
        await uploadAllSelectedFiles();

        if (uploadedFileNames.isEmpty) {
          ShowMessage.showSnackBar('Error', 'File upload failed. Please try again.');
          return; // ← safe to guard now since upload actually works
        }
      }

      //  Build items array from uploaded filenames 
      // Send as list of objects — adjust the shape to match your API's expectation
      final List<Map<String, dynamic>> items = uploadedFileNames
          .map((filename) => {'filename': filename})
          .toList();

      final body = {
        'reqid': 0,
        'requestdate':   DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'partyid':       selectedParty!.safeId,
        'siteid':        selectedSite!.safeId,
        'amount':        double.tryParse(amountController.text.trim()) ?? 0.0,
        'compid':        _compId,
        'branchid':      _branchId,
        'userid':        _userId,
        'yearid':        _yearId,
        'approverid':    selectedApprover!.safeId,
        'filename':      uploadedFileNames.join(','),
        'requestfor':    reasonController.text.trim(),
        'requesttype':   selectedRequestType!.name ?? '',
        'requesttypeid': selectedRequestType!.safeId, // ← also send in submit
        'partytypeid':   selectedPartyType!.safeId, // ← and party type id
        'items':         [],
      };

      log('PAYMENT REQUEST BODY :=> ${jsonEncode(body)}');

      final res = await api.paymentRequestEntry(body);

      if (res.status == 200) {
        final resData = res.data as Map<String, dynamic>?;
        final reqId = resData?['ReqId'] as int? ?? 0;

        if (reqId == -1) {
          ShowMessage.showSnackBar(
            'In Queue Already',
            res.message ?? 'The payment request is already in queue.',
          );
          return; // keep form open, don't clear
        }

        ShowMessage.showSnackBar(
          'Success',
          res.message ?? 'Payment Request Created Successfully!',
        );
        clearData();
        Get.back();
      } else {
        ShowMessage.showSnackBar(
          'Error',
          res.message ?? 'Failed to create Payment Request',
        );
      }
    } catch (e) {
      log('Submit Error: $e');
      ShowMessage.showSnackBar('Error', 'Something went wrong: $e');
    } finally {
      setBusy(false);
    }
  }
}
