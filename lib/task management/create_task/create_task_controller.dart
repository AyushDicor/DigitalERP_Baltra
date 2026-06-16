import 'dart:convert';
import 'dart:developer';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../repo/reimbursement_repo.dart';
import '../../response/task_dropdown_response.dart';
import '../../utils/app_constant_new.dart';

class CreateTaskController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  static CreateTaskController get to => Get.find<CreateTaskController>();

  //  Text controllers 
  TextEditingController taskController = TextEditingController();
  TextEditingController clientReferenceController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  //  Focus nodes 
  final FocusNode taskFocus = FocusNode();
  final FocusNode clientReferenceFocus = FocusNode();

  //  Loading 
  var isLoading = false.obs;
  var attachedFiles = <Map<String, String>>[].obs;

  //  Dropdown data 
  List<TaskDropdownItem> taskToList = []; // TASKTO
  List<TaskDropdownItem> clientRefList = []; // CLIENTREF
  List<TaskDropdownItem> siteList = []; // SITES
  List<TaskDropdownItem> priorityList = []; // PRIORITY

  //  Selected values 
  TaskDropdownItem? selectedTaskTo; // Assigned To
  // TaskDropdownItem? selectedGivenBy;     // Given By
  TaskDropdownItem? selectedClientRef; // Client Reference
  TaskDropdownItem? selectedSite; // Site
  TaskDropdownItem? selectedPriority; // Priority

  String get givenByName => homeController.currentUserData?.name ?? '';
  int get givenById => homeController.currentUserData?.userid ?? 0;

  //  Dates 
  DateTime? taskDate;
  DateTime? dueDate;

  //  Auto ID 
  int autoTaskId = 0;

  @override
  void onInit() {
    super.onInit();
    _initDefaults();
    _loadAllDropdowns();
  }

  @override
  void onClose() {
    taskController.dispose();
    clientReferenceController.dispose();
    taskDateController.dispose();
    dueDateController.dispose();
    taskFocus.dispose();
    clientReferenceFocus.dispose();
    super.onClose();
  }

  void _initDefaults() {
    taskDate = DateTime.now();
    taskDateController.text = DateFormat('dd-MM-yyyy').format(taskDate!);
  }

  //  Setters 
  void setTaskTo(TaskDropdownItem? val) {
    selectedTaskTo = val;
    update();
  }
  // void setGivenBy(TaskDropdownItem? val) {
  //   selectedGivenBy = val;
  //   update();
  // }

  void setClientRef(TaskDropdownItem? val) {
    selectedClientRef = val;
    update();
  }

  void setSite(TaskDropdownItem? val) {
    selectedSite = val;
    update();
  }

  void setPriority(TaskDropdownItem? val) {
    selectedPriority = val;
    update();
  }

  void setTaskDate(DateTime date) {
    taskDate = date;
    taskDateController.text = DateFormat('dd-MM-yyyy').format(date);
    update();
  }

  void setDueDate(DateTime date) {
    dueDate = date;
    dueDateController.text = DateFormat('dd-MM-yyyy').format(date);
    update();
  }

  void _showSuccessDialog(String message) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //  Success icon 
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: newGreenLightColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.check_rounded,
                    color: newGreenColor, size: 38),
              ),
              const SizedBox(height: 16),

              //  Title 
              const Text(
                'Task Created!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: newTextPrimary),
              ),
              const SizedBox(height: 8),

              //  Message 
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 13, color: newTextSecondary, height: 1.5),
              ),

              //  Task ID chip 
              if (autoTaskId > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: newBlueLightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Task ID: #$autoTaskId',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: newBlueColor),
                  ),
                ),
              ],
              const SizedBox(height: 24),

              //  Buttons 
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back(); // close dialog
                      clearForm();
                      // stay on screen for another task
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: newBlueColor,
                      side: const BorderSide(color: newBlueColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Add Another',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back(); // close dialog
                      Get.back(result: true); // back to task list
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: newGreenColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Done',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void clearForm() {
    taskController.clear();
    clientReferenceController.clear();
    dueDateController.clear();
    selectedTaskTo = null;
    //selectedGivenBy = null;
    selectedClientRef = null;
    selectedSite = null;
    selectedPriority = null;
    dueDate = null;
    taskDate = DateTime.now();
    attachedFiles.clear();
    taskDateController.text = DateFormat('dd-MM-yyyy').format(taskDate!);
    update();
  }

  //  Load all dropdowns 
  Future<void> _loadAllDropdowns() async {
    await Future.wait([
      _loadDropdown('TASKTO'),
      _loadDropdown('CLIENTREF'),
      _loadDropdown('SITES'),
      _loadDropdown('PRIORITY'),
      _loadAutoId(),
    ]);
    update();
  }

  Future<void> addFileFromPick(String localPath, String originalName) async {
    attachedFiles.add({
      'displayName': originalName,
      'serverName': '',
      'isUploading': 'true',
    });
    final index = attachedFiles.length - 1; // ✅ index AFTER add

    try {
      final res = await ReimbursementRepo.uploadReimbursementFile(localPath);

      log('📎 Upload response data: ${jsonEncode(res.data)}');
      log('📎 Upload status: ${res.status}');

      if (res.status == true && res.data != null) {
        final outerMap = res.data as Map<String, dynamic>;
        final innerData = outerMap['data'] as Map<String, dynamic>?;
        final serverName = innerData?['filename']?.toString() ?? '';

        log('📎 Server filename: $serverName');

        final updated = List<Map<String, String>>.from(attachedFiles);
        updated[index] = {
          'displayName': originalName,
          'serverName': serverName,
          'isUploading': 'false',
        };
        attachedFiles.assignAll(updated);

      } else {
        attachedFiles.removeAt(index);
        ShowMessage.showSnackBar('Upload Failed', res.message ?? 'Could not upload file');
      }
    } catch (e) {
      if (index < attachedFiles.length) attachedFiles.removeAt(index);
      ShowMessage.showSnackBar('Error', 'Upload error: $e');
    }
  }

  void removeAttachedFile(int index) {
    attachedFiles.removeAt(index);
  }

  Future<void> _loadDropdown(String type) async {
    try {
      final body = {
        'type': type,
        'compid': int.tryParse(
                homeController.currentUserData?.compId.toString() ?? '0') ??
            0,
        'branchid': 0,
        'clientid': 0,
      };

      final res = await api.getTaskDropdown(body);

      if (res.status == 200 && res.data != null) {
        switch (type) {
          case 'TASKTO':
            taskToList = res.data!;
            break;
          case 'CLIENTREF':
            clientRefList = res.data!; // stays empty if 500 — that's fine
            break;
          case 'SITES':
            siteList = res.data!;
            break;
          case 'PRIORITY':
            priorityList = res.data!;
            break;
        }
        update();
      }
      // silently ignore 500 — list stays empty, field hidden in UI
    } catch (e) {
      log('❌ Exception loading dropdown [$type]: $e');
    }
  }

  Future<void> _loadAutoId() async {
    try {
      final body = {
        'type': 'AUTOID',
        'compid': int.tryParse(
                homeController.currentUserData?.compId.toString() ?? '0') ??
            0,
        'branchid': int.tryParse(
                homeController.currentUserData?.branchId.toString() ?? '0') ??
            0,
        'clientid': 0,
      };

      final res = await api.getTaskDropdown(body);
      if (res.status == 200 && res.data != null && res.data!.isNotEmpty) {
        autoTaskId = res.data!.first.id ?? 0;
        log('✅ Auto Task ID: $autoTaskId');
        update();
      }
    } catch (e) {
      log('❌ Exception loading AUTOID: $e');
    }
  }

  //  Validation 
  bool _validate() {
    if (taskController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Required', 'Please enter task description');
      return false;
    }
    if (selectedTaskTo == null) {
      ShowMessage.showSnackBar('Required', 'Please select Assigned To');
      return false;
    }
    // Client is optional — no validation needed
    return true;
  }

  //  Submit 
  Future<void> submitCreateTask() async {
    if (!_validate()) return;

    if (attachedFiles.any((f) => f['isUploading'] == 'true')) {
      ShowMessage.showSnackBar('Please Wait', 'Files are still uploading...');
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        'taskid': 0,
        'date': DateFormat('yyyy-MM-dd').format(taskDate ?? DateTime.now()),
        'task': taskController.text.trim(),
        'taskto': selectedTaskTo?.name ?? '',
        'tasktoid': selectedTaskTo?.id ?? 0,
        'taskgivenby': givenByName, // ← always logged-in user
        'givenbyid': givenById, // ← always logged-in user
        'clientreference': selectedClientRef?.name ?? '',
        'clientid': selectedClientRef?.id ?? 0,
        'duedate':
            dueDate != null ? DateFormat('yyyy-MM-dd').format(dueDate!) : '',
        'status': '',
        'compid': int.tryParse(
                homeController.currentUserData?.compId.toString() ?? '0') ??
            0,
        'branchid': int.tryParse(
                homeController.currentUserData?.branchId.toString() ?? '0') ??
            0,
        'userid': int.tryParse(
                homeController.currentUserData?.userid.toString() ?? '0') ??
            0,
        'yearid': homeController.currentUserData?.yearId.toString() ?? '',
        'priority': selectedPriority?.name ?? '',
        'siteid': selectedSite?.id ?? 0,
        'attachfile': attachedFiles
            .where((f) => f['isUploading'] == 'false' && f['serverName']!.isNotEmpty)
            .map((f) => f['serverName']!)
            .join(','),
      };

      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('📤 TEST 4: CREATE TASK API (CreateDirectTask)');
      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('Request Body: ${jsonEncode(body)}');

      final res = await api.createDirectTask(body);

      if (res.status == 200) {
        log('✅ SUCCESS: Task created');
        // ✅ Reload auto ID for next task
        await _loadAutoId();
        // ✅ Show custom dialog instead of snackbar
        _showSuccessDialog(
          res.message?.isNotEmpty == true
              ? res.message!
              : 'Your task has been assigned successfully.',
        );
      } else {
        log('❌ FAILED: ${res.message}');
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to create task');
      }
      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
    } catch (e) {
      log('❌ Exception in submitCreateTask: $e');
      log('   Error: $e');
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isLoading.value = false;
    }
  }
}
