// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:digitalerp/download_document_management/download_document_type_.dart';
// import 'package:digitalerp/response/collection_customer_list_response.dart';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/response/executive_list_response.dart';
// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/client_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/customer_list/customer_list_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/services/api_service/request_keys.dart';
// import 'package:digitalerp/task%20management/Task_details_responce.dart';
// import 'package:digitalerp/task%20management/Task_list_responce.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:digitalerp/response/get_branchand_sit_res_model.dart';
//
// class TaskManagementController extends AppBaseController{
//   HomeController homeController = Get.find<HomeController>();
//
//   // controller
//   TextEditingController taskDetailsController = TextEditingController();
//   TextEditingController  commentController  = TextEditingController();
//   TextEditingController  taskNameController  = TextEditingController();
//   TextEditingController  detailsController  = TextEditingController();
//
//  // focus node
//   final FocusNode taskDetailsFocus = FocusNode();
//   final FocusNode commentFocus = FocusNode();
//   final FocusNode taskNameFocus= FocusNode();
//   final FocusNode detailsFocus = FocusNode();
//
//   final picker = ImagePicker();
//   var selectedImage = ''.obs;
//   var selectedImageBase64 = ''.obs;
//   var selectedImageFileName = ''.obs;
//
//
//   String dueDate ='Due Date';
//   List <TaskListData> taskListData = [];
//   List<ExecutiveDropdownData> assignList = [];
//    ExecutiveDropdownData? selectAssignList ;
//   ClientListData ? clientData;
//   List<CustomerListData> customerListData=[];
//   CustomerListData? selectCustomerListData;
//   DateTime? firstDateInDate;
//   DateTime? lastDateInDate;
//   List<TaskDetailsData> taskDetailsList = [];
//   List<TaskDetails> taskDetails = [];
//   List<BranchandSit> branchList = [];
//   BranchandSit? selectedBranch;
//
//   String selectedStatus = "Running";
//
//   List<String> statusDropDown = [
//     "Running",
//     "Close"
//   ];
//
//
//   String firstDate =  DateFormat(AppString.ddMMyyyy).format(DateTime(
//       DateTime.now().year,
//       DateTime.now().month,
//       DateTime.now().day -15,
//       DateTime.now().hour,
//       DateTime.now().minute,
//       DateTime.now().second));
//   String lastDate =  DateFormat(AppString.ddMMyyyy).format(DateTime.now());
//
//
//   void setDate(String value, bool isFirstDate) {
//     if (isFirstDate) {
//       firstDate = value;
//     } else {
//       lastDate = value;
//     }
//     update();
//   }
//
//   void setDateByDate(DateTime value, bool isFirstDate) {
//     if (isFirstDate) {
//       firstDateInDate = value;
//     } else {
//       lastDateInDate = value;
//     }
//     update();
//   }
//   void setSelectedBranch(BranchandSit value) {
//     selectedBranch = value;
//     update();
//   }
//
//
//   @override
//   void onInit() {
//     getTaskListView();
//     getExecutiveDropdownList();
//     getCustomerList();
//     getBranchList();
//     super.onInit();
//   }
//
//   bool _taskDetailValidate(){
//
//     if(commentController.text.trim().isEmpty){
//       ShowMessage.showSnackBar(AppString.requiredFieldTxt,AppString.pleaseEnterComment);
//     return false;
//     }
//
//     // if(selectedImage.isEmpty){
//     //   ShowMessage.showSnackBar(AppString.requiredFieldTxt,AppString.pleaseSelectFile);
//     // }
//     return true;
//   }
//
//   void setSelectDueDate(String value){
//     dueDate = value;
//     update();
//   }
//   void setSelectedImage(String value) {
//     selectedImage.value = value;
//     update();
//   }
//
//   void setSelectAssignDropdownValue(ExecutiveDropdownData? value) {
//     selectAssignList = value;
//     update();
//   }
//
//   void setSelectClientDropdownValue(CustomerListData? value) {
//     selectCustomerListData = value;
//     update();
//   }
//
//   void onChangedStatusListValue(String newValue) {
//
//     if (statusDropDown.contains(newValue)) {
//       selectedStatus = newValue;
//       // Implement your logic when the status is changed
//       print("Selected Status: $newValue");
//     }
//     update();
//   }
//
//
//
//
//   void taskUpdateDetailsApi(String taskId) async {
//     setBusy(true);
//     if (_taskDetailValidate()) {
//       try {
//         Map<String, String> body = {};
//         body[RequestKeys.compId] =
//             // '39'.toString();
//         homeController.currentUserData?.compId.toString()?? '';
//         body[RequestKeys.branchId] =
//         // '48';
//             homeController.currentUserData?.branchId.toString()?? '';
//         body[RequestKeys.userId] =
//             // '369622'.toString();
//         homeController.currentUserData?.userid.toString() ?? '369622';
//          body[RequestKeys.taskid] = taskId.toString();
//          // body[RequestKeys.status] = status.toString();
//          body[RequestKeys.comment] = commentController.text.tr.toString();
//          body[RequestKeys.status] = selectedStatus.toString();
//          body[RequestKeys.photo] =  selectedImageBase64.value;
//          // body[RequestKeys.photo] =  "";
//          body[RequestKeys.filename] = selectedImageFileName.value;
//          log("TASK BODY :=> ${jsonEncode(body)}");
//
//         var res = await api.getTaskUpdateDetails(body);
//         if (res.status == 200) {
//           ShowMessage.showSnackBar('taskUpdateDetails Success Res', res.message.toString());
//         } else {
//           ShowMessage.showSnackBar('taskUpdateDetails res.status not 200', res.message.toString());
//         }
//       } catch (e) {
//         ShowMessage.showSnackBar('taskUpdateDetails catch', '$e');
//       } finally {
//         setBusy(false);
//       }
//     }
//   }
//   void assignTaskApi() async {
//
//     setBusy(true);
//
//       try {
//         Map<String, String> body = {};
//         body[RequestKeys.compId] =
//             // '39'.toString();
//             homeController.currentUserData?.compId.toString() ?? '39';
//         body[RequestKeys.branchId] =
//             // ' 48'.toString();
//             homeController.currentUserData?.branchId.toString() ?? '48';
//         body[RequestKeys.userId] =
//             // '369622'.toString();
//         homeController.currentUserData?.userid.toString() ?? '369622';
//         body[RequestKeys.yearId] =
//             // '2023-24'.toString();
//             homeController.currentUserData?.yearId.toString() ?? '2023-24';
//         body[RequestKeys.taskName] = taskNameController.text.tr.toString();
//         body[RequestKeys.dueDate] = dueDate.toString();
//         body[RequestKeys.assignToId] =
//             // '139758'.toString();
//         selectAssignList!.executiveId.toString();
//         body[RequestKeys.assignTo] = selectAssignList!.executiveName.toString();
//         body[RequestKeys.clientid] =
//             // '226749'.toString();
//             clientData?.clientid.toString()?? '226749';
//         body[RequestKeys.clientReference] = selectCustomerListData!.partyname.toString();
//
//         var res = await api.getAssignTaskView(body);
//         if (res.status == 200) {
//           ShowMessage.showSnackBar('Assign Task  Success Res', res.message.toString());
//
//         } else {
//           ShowMessage.showSnackBar('Assign Task  res.status not 200', res.message.toString());
//         }
//       } catch (e) {
//         ShowMessage.showSnackBar('server Res', '$e');
//       } finally {
//         setBusy(false);
//       }
//
//   }
//   void getTaskDetailsApi(String taskId) async {
//     unfocus();
//     setBusy(true);
//       try {
//         Map<String, String> body = {};
//         body[RequestKeys.compId] =
//             // '39'.toString();
//             homeController.currentUserData?.compId.toString() ?? '39';
//         body[RequestKeys.taskid] = taskId.toString();
//             // homeController.currentUserData?.branchId.toString() ?? '48';
//         body[RequestKeys.userId] =
//             // '369622'.toString();
//         homeController.currentUserData?.userid.toString() ?? '369622';
//
//         var res = await api.getTaskDetails(body);
//         if (res.status == 200) {
//           taskDetailsList = res.data??[];
//
//         } else {
//           ShowMessage.showSnackBar('Assign Task  res.status not 200', res.message.toString());
//         }
//       } catch (e) {
//         ShowMessage.showSnackBar('server Res', '$e');
//       } finally {
//         setBusy(false);
//       }
//
//   }
//    Future <void> getTaskListView() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {
//         RequestKeys.compId: homeController.currentUserData?.compId.toString()?? '39', // Adjust as needed
//         RequestKeys.branchId: homeController.currentUserData?.branchId.toString()?? '48', // Adjust as needed
//         RequestKeys.userId:  homeController.currentUserData?.userid.toString()?? '369622', // Adjust as needed
//         // RequestKeys.yearId:  homeController.currentUserData?.yearId.toString()?? '2023-24', // Adjust as needed
//         RequestKeys.fromDate: DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDate),),// Adjust as needed
//         RequestKeys.toDate: DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDate),), // Adjust as needed
//         RequestKeys.executiveId: selectAssignList?.executiveId.toString() ?? '0',
//
//         RequestKeys.status: selectedStatus,
//       };
//       // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
//       //       body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '48';
//       //       body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '369622';
//       //       body[RequestKeys.yearId] = homeController.currentUserData?.yearId.toString() ?? '2023-24';
//       //       body[RequestKeys.fromDate] = firstDate.toString();
//       //       body[RequestKeys.toDate] = homeController.currentUserData?.branchId.toString() ?? '48';
//       //       body[RequestKeys.executiveId] = selectAssignList!.executiveId.toString();
//       //       body[RequestKeys.status] =  selectedStatus.toString();
//       var res = await api.getTaskListView(body);
//       if (res.status == 200) {
//         taskListData = res.data ?? [];
//       } else {
//         //ShowMessage.showSnackBar('', '${res.message}');
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//   void getExecutiveDropdownList() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {
//         RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
//         RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
//       };
//       // body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '39';
//       // body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '369622';
//
//       var res = await api.getExecutiveDropdown(body);
//       if (res.status == 200) {
//         assignList = res.data ?? [];
//       }
//       // else {
//       //   ShowMessage.showSnackBar(
//       //       'getExecutiveDropdown Server res.status not 200', res.message.toString());
//       // }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//   Future<void> getCustomerList() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.userId] =
//           homeController.currentUserData?.userid.toString() ?? '342613';
//       body[RequestKeys.compId] =
//           homeController.currentUserData?.compId.toString() ?? '39';
//       body[RequestKeys.executiveId] =
//           selectAssignList?.executiveId.toString() ?? '0';
//       var res = await api.getCustomersDetail(body);
//       if (res.status == 200) {
//         customerListData = res.data ?? [];
//       } else {
//         //ShowMessage.showSnackBar('', '${res.message}');
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//   Future<void> getBranchList() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '';
//       body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
//       var res = await api.getBranchandSite(body);
//       if (res.status == 200) {
//         branchList = res.data ?? [];
//         update();
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//
//
// }

import 'dart:convert';
import 'dart:developer';

import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/client_list_responce.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/task%20management/task%20models/Task_details_responce.dart';
import 'package:digitalerp/task%20management/task%20models/Task_list_responce.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:digitalerp/response/get_branchand_sit_res_model.dart';

import '../../repo/reimbursement_repo.dart';
import '../../response/task_dropdown_response.dart';

class TaskManagementController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  // Text controllers
  TextEditingController taskDetailsController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  ExecutiveDropdownData? selectedEscalateTo;

  // Focus nodes
  final FocusNode taskDetailsFocus = FocusNode();
  final FocusNode commentFocus = FocusNode();
  final FocusNode taskNameFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();

  // Image picker
  final picker = ImagePicker();
  var selectedImage = ''.obs;
  var selectedImageBase64 = ''.obs;
  var selectedImageFileName = ''.obs;
  final RxList<Map<String, String>> followupFiles = <Map<String, String>>[].obs;

  // State
  String dueDate = 'Due Date';

  // Loading states
  bool isListLoading = false; // ← for task list skeleton
  bool isDetailLoading = false; // ← for task detail skeleton
  bool get isProjectTask =>
      currentTaskDetail?.tasksection?.toLowerCase() == 'project';
  bool get isDirectTask =>
      currentTaskDetail?.tasksection?.toLowerCase() == 'direct task';

  bool _isAssignedToMe(TaskListData t) {
    final assignedTo = (t.assignedto ?? '').toUpperCase();
    final userName = _currentUserName;
    if (userName.isEmpty) return false;
    // Match if assignedto starts with the user's name
    return assignedTo == userName || assignedTo.startsWith('$userName-');
  }

  //  Filter state
  String selectedPriority  = '';   // '', 'High', 'Low'
  String selectedSiteName  = '';
  String selectedClientName = '';
  String selectedAssignedTo = '';
  String selectedTaskFilter = 'All'; // ← NEW: All / Direct Task / Project
  final List<String> taskFilterOptions = ['All', 'Direct Task', 'Project', 'Lead Task'];
  final List<String> statusDropDown = ['Running', 'Close'];

  // Data
  List<TaskListData> taskListData = [];
  List<ExecutiveDropdownData> assignList = [];
  List<TaskHistory> taskHistory = [];
  List<BranchandSit> branchList = [];
  List<String> selectedSites = [];
  List<String> get escalateToOptions =>
      ['' , ...assignList.map((e) => e.executiveName ?? '').where((n) => n.isNotEmpty)];
  List<TaskDropdownItem> unitList = [];
  TaskDropdownItem? selectedUnit;

  String get selectedEscalateToName =>
      selectedEscalateTo?.executiveName ?? '';

  ExecutiveDropdownData? selectAssignList;
  ClientListData? clientData;
  List<CustomerListData> customerListData = [];
  CustomerListData? selectCustomerListData;
  DateTime? firstDateInDate;
  DateTime? lastDateInDate;
  TaskDetail? currentTaskDetail;
  int? selectedUnitId;
  String get currentUnitName => currentTaskDetail?.unitname ?? '';
  int selectedTabIndex = 0;
  String get _currentUserName {
    final name = homeController.currentUserData?.name?.trim() ?? '';
    return name.toUpperCase();
  }
  List<TaskListData> get assignedToMeList =>
      taskListData.where(_isAssignedToMe).toList();

  List<TaskListData> get assignedByMeList =>
      taskListData.where((t) => !_isAssignedToMe(t)).toList();

// Active list based on selected tab
  List<TaskListData> get activeTabList =>
      selectedTabIndex == 0 ? assignedToMeList : assignedByMeList;


  BranchandSit? selectedBranch;
  List<TaskListData> get filteredTaskList {
    var list = List<TaskListData>.from(activeTabList); // ✅ was taskListData

    if (selectedTaskFilter != 'All') {
      list = list.where((t) => t.flag == selectedTaskFilter).toList();
    }
    if (selectedStatus.isNotEmpty) {
      list = list.where((t) =>
      (t.status ?? '').toLowerCase() == selectedStatus.toLowerCase()).toList();
    }
    if (selectedPriority.isNotEmpty) {
      list = list.where((t) =>
      (t.priority ?? '').toLowerCase() == selectedPriority.toLowerCase()).toList();
    }
    if (selectedSiteName.isNotEmpty) {
      list = list.where((t) => t.sitename == selectedSiteName).toList();
    }
    if (selectedClientName.isNotEmpty) {
      list = list.where((t) => t.clientname == selectedClientName).toList();
    }
    if (selectedAssignedTo.isNotEmpty) {
      list = list.where((t) => t.assignedto == selectedAssignedTo).toList();
    }
    return list;
  }

  String selectedStatus = 'Running';

  //  Date range
  String firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  //  Setters
  void switchTab(int index) {
    selectedTabIndex = index;
    selectedTaskFilter = 'All'; // reset chip on tab switch
    update();
  }


  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  void setTaskFilter(String filter) {
    selectedTaskFilter = filter;
    update();
  }

  void setDateByDate(DateTime value, bool isFirstDate) {
    if (isFirstDate) {
      firstDateInDate = value;
    } else {
      lastDateInDate = value;
    }
    update();
  }

  void setSelectedBranch(BranchandSit value) {
    selectedBranch = value;
    update();
  }

  void setSelectDueDate(String value) {
    dueDate = value;
    update();
  }

  void setSelectedImage(String value) {
    selectedImage.value = value;
    update();
  }

  void setSelectAssignDropdownValue(ExecutiveDropdownData? value) {
    selectAssignList = value;
    update();
  }

  void setSelectClientDropdownValue(CustomerListData? value) {
    selectCustomerListData = value;
    update();
  }

  void onChangedStatusListValue(String newValue) {
    if (statusDropDown.contains(newValue)) {
      selectedStatus = newValue;
    }
    update();
  }

  void resetFilters() {
    firstDate = DateFormat(AppString.ddMMyyyy).format(
        DateTime.now().subtract(const Duration(days: 30)));
    lastDate  = DateFormat(AppString.ddMMyyyy).format(DateTime.now());
    selectedStatus      = 'Running';
    selectedPriority    = '';
    selectedSiteName    = '';
    selectedClientName  = '';
    selectedAssignedTo  = '';
    selectedTaskFilter  = 'All';
    selectedTabIndex    = 0; // ✅ reset to first tab
    selectAssignList    = null;
    update();
    getTaskListView();
  }


  void resetFollowupForm() {
    commentController.clear();
    quantityController.clear();
    selectedImageFileName.value = '';
    selectedImageBase64.value = '';
    selectedImage.value = '';
    selectedEscalateTo = null;
    selectedUnit = null;
    followupFiles.clear();
  }

  //  Lifecycle
  @override
  void onInit() {
    getTaskListView();
    getExecutiveDropdownList();
    getCustomerList();
    getBranchList();
    _loadUnitDropdown();
    super.onInit();
  }

  //  Validation
  bool _taskDetailValidate() {
    if (commentController.text.trim().isEmpty) {
      ShowMessage.showSnackBar(
          AppString.requiredFieldTxt, AppString.pleaseEnterComment);
      return false;
    }
    return true;
  }

  //  API: Update task details
  void taskUpdateDetailsApi(String taskId) async {
    setBusy(true);
    if (_taskDetailValidate()) {
      try {
        final body = {
          RequestKeys.compId:
              homeController.currentUserData?.compId.toString() ?? '',
          RequestKeys.branchId:
              homeController.currentUserData?.branchId.toString() ?? '',
          RequestKeys.userId:
              homeController.currentUserData?.userid.toString() ?? '',
          RequestKeys.taskid: taskId,
          RequestKeys.comment: commentController.text.trim(),
          RequestKeys.status: selectedStatus,
          RequestKeys.photo: selectedImageBase64.value,
          RequestKeys.filename: selectedImageFileName.value,
        };
        log('TASK UPDATE BODY :=> ${jsonEncode(body)}');
        final res = await api.getTaskUpdateDetails(body);
        if (res.status == 200) {
          ShowMessage.showSnackBar('Success', res.message.toString());
          commentController.clear();
          selectedImageBase64.value = '';
          selectedImageFileName.value = '';
        } else {
          ShowMessage.showSnackBar('Error', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('Error', '$e');
      } finally {
        setBusy(false);
        update();
      }
    } else {
      setBusy(false);
    }
  }

  //  API: Assign task
  // void assignTaskApi() async {
  //   setBusy(true);
  //   try {
  //     final body = {
  //       RequestKeys.compId:
  //           homeController.currentUserData?.compId.toString() ?? '',
  //       RequestKeys.branchId:
  //           homeController.currentUserData?.branchId.toString() ?? '',
  //       RequestKeys.userId:
  //           homeController.currentUserData?.userid.toString() ?? '',
  //       RequestKeys.yearId:
  //           homeController.currentUserData?.yearId.toString() ?? '',
  //       RequestKeys.taskName: taskNameController.text.trim(),
  //       RequestKeys.dueDate: dueDate,
  //       RequestKeys.assignToId: selectAssignList!.executiveId.toString(),
  //       RequestKeys.assignTo: selectAssignList!.executiveName.toString(),
  //       RequestKeys.clientid: clientData?.clientid.toString() ?? '0',
  //       RequestKeys.clientReference:
  //           selectCustomerListData!.partyname.toString(),
  //     };
  //     log('ASSIGN TASK BODY :=> ${jsonEncode(body)}');
  //     final res = await api.getAssignTaskView(body);
  //     if (res.status == 200) {
  //       ShowMessage.showSnackBar('Success', res.message.toString());
  //       taskNameController.clear();
  //       selectAssignList = null;
  //       selectCustomerListData = null;
  //       dueDate = 'Due Date';
  //       await getTaskListView(); // ← refresh list after assign
  //     } else {
  //       ShowMessage.showSnackBar('Error', res.message.toString());
  //     }
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Error', '$e');
  //   } finally {
  //     setBusy(false);
  //     update();
  //   }
  // }

  //  API: Get task details
  // taskId is now int in TaskListData — always call with .toString()







  Future<void> addFollowupFile(String localPath, String originalName) async {
    // ✅ Add placeholder
    followupFiles.add({
      'displayName': originalName,
      'serverName': '',
      'isUploading': 'true',
    });
    final index = followupFiles.length - 1; // ✅ index AFTER add

    try {
      final res = await ReimbursementRepo.uploadReimbursementFile(localPath);

      log('📎 Upload response data: ${jsonEncode(res.data)}');
      log('📎 Upload status: ${res.status}');

      if (res.status == true && res.data != null) {
        final outerMap = res.data as Map<String, dynamic>;

        // ✅ filename is nested inside data.data.filename
        final innerData = outerMap['data'] as Map<String, dynamic>?;
        final serverName = innerData?['filename']?.toString() ?? '';

        log('📎 Server filename: $serverName');

        // ✅ Replace entire list to force RxList to detect change
        final updated = List<Map<String, String>>.from(followupFiles);
        updated[index] = {
          'displayName': originalName,
          'serverName': serverName,
          'isUploading': 'false',
        };
        followupFiles.assignAll(updated);

      } else {
        followupFiles.removeAt(index);
        ShowMessage.showSnackBar('Upload Failed', res.message ?? 'Could not upload file');
      }
    } catch (e) {
      if (index < followupFiles.length) followupFiles.removeAt(index);
      ShowMessage.showSnackBar('Error', 'Upload error: $e');
    }
  }

  void removeFollowupFile(int index) {
    followupFiles.removeAt(index);
  }


  Future<void> _loadUnitDropdown() async {
    try {
      final userBranchId = int.tryParse(
          homeController.currentUserData?.branchId.toString() ?? '0') ?? 0;

      // Use actual branchId, fallback to 201 if 0
      final branchId = userBranchId == 0 ? 201 : userBranchId;

      final body = {
        'type': 'Unit',
        'compid': int.tryParse(
            homeController.currentUserData?.compId.toString() ?? '0') ?? 0,
        'branchid': branchId,  // ← key fix
        'clientid': 0,
      };

      log('🔵 Unit dropdown body: ${jsonEncode(body)}');
      final res = await api.getTaskDropdown(body);
      log('🔵 Unit status: ${res.status}, count: ${res.data?.length}');

      if (res.status == 200 && res.data != null) {
        unitList = res.data!;
        update();
      }
    } catch (e) {
      log('❌ Unit dropdown error: $e');
    }
  }

  Future<void> getTaskDetailsApi(String taskId) async {
    followupFiles.clear();
    commentController.clear();

    isDetailLoading = true;
    currentTaskDetail = null;
    taskHistory = [];
    update();

    final branchId = homeController.currentUserData?.branchId?.toString();
    final validBranchId =
        (branchId == null || branchId == '0') ? '201' : branchId;

    try {
      final body = {
        'taskid': taskId,
        'compid': homeController.currentUserData?.compId.toString() ?? '',
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
        //'branchid': validBranchId,
      };
      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('📤 TEST 2: TASK DETAIL API (GetTaskDetail)');
      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('Request Body: ${jsonEncode(body)}');

      final res = await api.getTaskDetails(body);

      log('📥 Response:');
      log('   Status: ${res.status}');
      log('   Success: ${res.success}');
      log('   Message: ${res.message}');
      log('   Has Data: ${res.data != null}');

      if (res.status == 200 && res.data != null) {
        currentTaskDetail = res.data!.taskdetail;
        taskHistory = res.data!.history ?? [];

        log('✅ SUCCESS:');
        log('   Task Detail:');
        log('     - ID: ${currentTaskDetail?.taskid}');
        log('     - Section: ${currentTaskDetail?.tasksection}');
        log('     - Task: ${currentTaskDetail?.task}');
        log('     - Status: ${currentTaskDetail?.status}');
        log('     - Priority: ${currentTaskDetail?.priority}');
        log('     - Assigned To: ${currentTaskDetail?.assignedto}');
        log('     - Client: ${currentTaskDetail?.clientname}');
        log('     - Site: ${currentTaskDetail?.sitename}');

        // Set status for dropdown
        if (currentTaskDetail?.status != null) {
          selectedStatus = currentTaskDetail!.status!;
        }

        // ✅ Pre-fill comment with last comment from API
        commentController.text = currentTaskDetail?.lastcomment ?? '';

        // ✅ Reset escalate selection, pre-hint will show from currentTaskDetail.escalateto
        selectedEscalateTo = null;

        // ✅ Store unit id for submit
        selectedUnitId = currentTaskDetail?.unitid;

        selectedUnit = unitList.cast<TaskDropdownItem?>().firstWhere(
              (u) => u?.id == currentTaskDetail?.unitid,
          orElse: () => null,
        );

        log('✅ Task loaded: ${currentTaskDetail?.task}');
        log('   Type: ${currentTaskDetail?.tasksection}');
        log('   History count: ${taskHistory.length}');
      } else {
        ShowMessage.showSnackBar('Error', res.message ?? 'Failed to load');
      }
    } catch (e) {
      log('❌ Exception in getTaskDetailsApi: $e');
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isDetailLoading = false;
      update();
    }
  }

  //  API: Get task list
  // Future<void> getTaskListView() async {
  //   isListLoading = true;
  //   update();
  //
  //   try {
  //     final validBranchId = (homeController.currentUserData?.branchId?.toString() == '0')
  //         ? '201' // Use first available branch
  //         : homeController.currentUserData?.branchId.toString() ?? '201';
  //
  //     final body = {
  //       'compid': homeController.currentUserData?.compId.toString() ?? '',
  //       'userid': homeController.currentUserData?.userid.toString() ?? '',
  //       'branchid': validBranchId,
  //       'datefrom': '2026-01-01', // Wide date range for testing
  //       'dateto': '2026-12-31',
  //       'status': '', // Empty = all statuses
  //     };
  //
  //     log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  //     log('📤 TEST 1: TASK LIST API (TasksByRole)');
  //     log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  //     log('Request Body: ${jsonEncode(body)}');
  //
  //     final res = await api.getTaskListView(body);
  //
  //     log('📥 Response:');
  //     log('   Status: ${res.status}');
  //     log('   Success: ${res.success}');
  //     log('   Message: ${res.message}');
  //     log('   Data Count: ${res.data?.length ?? 0}');
  //
  //     if (res.status == 200 && res.data != null && res.data!.isNotEmpty) {
  //       taskListData = res.data!;
  //       log('✅ SUCCESS: Loaded ${taskListData.length} tasks');
  //       log('   First task:');
  //       log('     - ID: ${taskListData[0].taskid}');
  //       log('     - Task: ${taskListData[0].task}');
  //       log('     - Flag: ${taskListData[0].flag}');
  //       log('     - Status: ${taskListData[0].status}');
  //       log('     - Priority: ${taskListData[0].priority}');
  //     } else {
  //       log('⚠️ NO DATA: ${res.message}');
  //       // Try with different status
  //       if (body['status'] == '') {
  //         body['status'] = 'Running';
  //         log('🔄 Retrying with status=Running...');
  //         final retryRes = await api.getTaskListView(body);
  //         if (retryRes.status == 200) {
  //           taskListData = retryRes.data ?? [];
  //           log('✅ Retry succeeded: ${taskListData.length} tasks');
  //         }
  //       }
  //     }
  //     log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
  //
  //   } catch (e, stackTrace) {
  //     log('❌ EXCEPTION in getTaskListView:');
  //     log('   Error: $e');
  //     log('   Stack: $stackTrace');
  //     ShowMessage.showSnackBar('Error', '$e');
  //   } finally {
  //     isListLoading = false;
  //     update();
  //   }
  // }
  Future<void> getTaskListView() async {
    isListLoading = true;
    update();

    try {
      final body = {
        'compid':   homeController.currentUserData?.compId.toString()   ?? '',
        'userid':   homeController.currentUserData?.userid.toString()   ?? '',
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
        'datefrom': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(firstDate)),
        'dateto':   DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(lastDate)),
        'status':   selectedStatus,  // ✅ was hardcoded ''
      };

      log('📤 TASK LIST REQUEST: ${jsonEncode(body)}');
      final res = await api.getTaskListView(body);
      log('📥 TASK LIST RESPONSE: Status=${res.status}, Count=${res.data?.length ?? 0}');

      if (res.status == 200) {
        taskListData = res.data ?? [];
        log('✅ Tasks loaded: ${taskListData.length}');
      } else {
        if (res.message != 'Tasks Not Available') {
          ShowMessage.showSnackBar('Error', res.message ?? 'Failed to load tasks');
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      isListLoading = false;
      update();
    }
  }

  Future<void> saveTaskFollowupApi(String taskId) async {
    if (commentController.text.trim().isEmpty) {
      ShowMessage.showSnackBar('Required', 'Please enter a comment');
      return;
    }
    if (followupFiles.any((f) => f['isUploading'] == 'true')) {
      ShowMessage.showSnackBar('Please Wait', 'Files are still uploading...');
      return;
    }

    setBusy(true);
    try {
      final validBranchId =
          (homeController.currentUserData?.branchId?.toString() == '0')
              ? '201' // Use first available branch
              : homeController.currentUserData?.branchId.toString() ?? '201';

      // Base body — same for both Direct and Project
      final Map<String, dynamic> body = {
        'taskid': int.tryParse(taskId) ?? 0,
        'compid': int.tryParse(
                homeController.currentUserData?.compId.toString() ?? '0') ??
            0,
        // 'branchid': int.tryParse(
        //     homeController.currentUserData?.branchId.toString() ?? '0') ??
        //     0,
        'branchid': homeController.currentUserData?.branchId.toString() ?? '',
        'userid': int.tryParse(
                homeController.currentUserData?.userid.toString() ?? '0') ??
            0,
        'yearid': homeController.currentUserData?.yearId.toString() ?? '',
        'status': selectedStatus,
        'comment': commentController.text.trim(),
        'files': followupFiles
            .where((f) => f['isUploading'] == 'false' && (f['serverName'] ?? '').isNotEmpty)
            .map((f) => f['serverName']!)
            .join(','),
      };

      // Project Task only — add qty, unitid, escalatetoid
      if (isProjectTask) {
        if (quantityController.text.isNotEmpty) {
          body['quantity'] = double.tryParse(quantityController.text) ?? 0.0;
        }
        // ✅ Use selectedUnitId (set from detail on load, fixed per task)
        body['unitid'] = selectedUnit?.id ?? currentTaskDetail?.unitid ?? 0;

        // ✅ Escalate — only send if selected
        if (selectedEscalateTo != null) {
          body['escalatetoid'] = selectedEscalateTo!.executiveId ?? 0;
        } else {
          body['escalatetoid'] = currentTaskDetail?.escalatetoid ?? 0;
        }
      }


      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('📤 TEST 3: SAVE FOLLOWUP API (SaveTaskFollowup)');
      log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      log('Task Type: ${isProjectTask ? "Project" : "Direct Task"}');
      log('Request Body: ${jsonEncode(body)}');

      final res = await api.saveTaskFollowup(body);

      log('📥 Response:');
      log('   Status: ${res.status}');
      log('   Success: ${res.success}');
      log('   Message: ${res.message}');
      log('   Response Data: ${jsonEncode(res.toJson())}');

      if (res.status == 200) {
        ShowMessage.showSnackBar(
            'Success', res.message ?? 'Followup saved successfully');

        // Clear form fields
        commentController.clear();
        quantityController.clear();
        selectedImageFileName.value = '';
        selectedImageBase64.value = '';
        selectedImage.value = '';
        selectedEscalateTo = null;

        // Update completedquantity locally so progress bar refreshes
        if (isProjectTask &&
            res.data?.completedquantity != null &&
            currentTaskDetail != null) {
          currentTaskDetail!.completedquantity = res.data!.completedquantity;
        }

        // Reload task details to refresh history list
        await getTaskDetailsApi(taskId);
      } else {
        ShowMessage.showSnackBar(
            'Error', res.message ?? 'Failed to save followup');
      }
    } catch (e) {
      log('❌ Exception in saveTaskFollowupApi: $e');
      ShowMessage.showSnackBar('Error', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  //  API: Executive dropdown
  Future<void> getExecutiveDropdownList() async {
    try {
      final body = {
        'type': 'TASKTO',                                                    // ← same as CreateTaskController
        'compid': int.tryParse(
            homeController.currentUserData?.compId.toString() ?? '0') ?? 0,
        'branchid': 0,
        'clientid': 0,
      };

      log('🔵 AssignList (TASKTO) body: ${jsonEncode(body)}');
      final res = await api.getTaskDropdown(body);                          // ← same API as CreateTaskController
      log('🔵 AssignList status: ${res.status}, count: ${res.data?.length}');

      if (res.status == 200 && res.data != null) {
        assignList = res.data!
            .map((e) => ExecutiveDropdownData(
          executiveName: e.name ?? '',
          executiveId: e.id ?? 0,
        ))
            .toList();
        update();
        log('✅ assignList loaded: ${assignList.length}');
      }
    } catch (e) {
      log('❌ Error loading assignList: $e');
    }
  }

  //  API: Customer list
  Future<void> getCustomerList() async {
    try {
      final body = {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.executiveId:
            selectAssignList?.executiveId.toString() ?? '0',
      };
      final res = await api.getCustomersDetail(body);
      if (res.status == 200) {
        customerListData = res.data ?? [];
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    }
  }

  //  API: Branch list
  Future<void> getBranchList() async {
    try {
      final body = {
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
      };
      final res = await api.getBranchandSite(body);
      if (res.status == 200) {
        branchList = res.data ?? [];
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
    }
  }
}
