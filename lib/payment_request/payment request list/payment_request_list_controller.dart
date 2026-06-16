// import 'dart:convert';
// import 'dart:developer';
// import 'package:digitalerp/response/customer_detail_response.dart';
// import 'package:digitalerp/response/get_branchand_sit_res_model.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/services/api_service/request_keys.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../app_routes/app_routes.dart';
//
// class PaymentRequestListController extends AppBaseController {
//   HomeController homeController = Get.find<HomeController>();
//   static PaymentRequestListController get to =>
//       Get.find<PaymentRequestListController>();
//
//   // List data
//   List<PaymentRequestData> paymentRequestList = [];
//   List<PaymentRequestData> filteredPaymentRequestList = [];
//   final List<String> requestTypeOptions = ['All', 'Payment', 'Advance', 'Reimbursement', 'Other'];
//
//
//   // Dropdown data
//   List<CustomerListData> partyListData = [];
//   List<BranchandSit> branchandSit = [];
//
//   // Selected filters
//   CustomerListData? selectedParty;
//   BranchandSit? selectedBranch;
//   String? selectedStatus;
//   DateTime? fromDate;
//   DateTime? toDate;
//   String? selectedRequestType;
//
//   // Status options
//   final List<String> statusOptions = [
//     'All',
//     'Pending',
//     'Approved',
//     'Rejected',
//   ];
//
//   // Search controller
//   TextEditingController searchController = TextEditingController();
//   final FocusNode searchFocus = FocusNode();
//
//   // Pagination
//   int currentPage = 1;
//   int itemsPerPage = 20;
//   bool hasMoreData = true;
//
//   //  Date range
//   String firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
//       DateTime.now().year,
//       DateTime.now().month,
//       DateTime.now().day - 30,
//       DateTime.now().hour,
//       DateTime.now().minute,
//       DateTime.now().second));
//   String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());
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
//
//   @override
//   void onInit() {
//     super.onInit();
//     getPaymentRequestList();
//     getCustomerList();
//     getBranchandSiteDropdownList();
//   }
//
//   @override
//   void onClose() {
//     searchController.dispose();
//     searchFocus.dispose();
//     super.onClose();
//   }
//
//   // Clear all filters
//   void clearFilters() {
//     firstDate = DateFormat(AppString.ddMMyyyy).format(
//         DateTime.now().subtract(const Duration(days: 30)));
//     lastDate  = DateFormat(AppString.ddMMyyyy).format(DateTime.now());
//     selectedParty = null;
//     selectedBranch = null;
//     selectedStatus = null;
//     fromDate = null;
//     toDate = null;
//     searchController.clear();
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   // Set selected party filter
//   void setSelectedParty(CustomerListData? value) {
//     selectedParty = value;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   void setSelectedRequestType(String? value) {
//     selectedRequestType = value;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   // Set selected branch filter
//   void setSelectedBranch(BranchandSit? value) {
//     selectedBranch = value;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   // Set selected status filter
//   void setSelectedStatus(String? value) {
//     selectedStatus = value;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   // Set date range
//   void setFromDate(DateTime? date) {
//     fromDate = date;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   void setToDate(DateTime? date) {
//     toDate = date;
//     currentPage = 1;
//     applyFilters();
//     update();
//   }
//
//   // Search function
//   void onSearchChanged(String query) {
//     currentPage = 1;
//     applyFilters();
//   }
//   void tapOnAdd() {
//     Get.toNamed(AppRoutes.paymentRequestScreen);
//   }
//
//   // Apply all filters
//   void applyFilters() {
//     filteredPaymentRequestList = paymentRequestList.where((request) {
//       // Party filter
//       if (selectedParty != null &&
//           request.partyId != selectedParty!.partyid) {
//         return false;
//       }
//
//       // Request type filter
//       if (selectedRequestType != null &&
//           selectedRequestType != 'All' &&
//           request.requestType?.toLowerCase() != selectedRequestType?.toLowerCase()) {
//         return false;
//       }
//
//       // Branch filter
//       if (selectedBranch != null &&
//           request.branchId != selectedBranch!.branchid) {
//         return false;
//       }
//
//       // Status filter
//       if (selectedStatus != null &&
//           selectedStatus != 'All' &&
//           request.status?.toLowerCase() != selectedStatus?.toLowerCase()) {
//         return false;
//       }
//
//       // Date range filter
//       if (fromDate != null && request.requestDate != null) {
//         if (request.requestDate!.isBefore(fromDate!)) {
//           return false;
//         }
//       }
//       if (toDate != null && request.requestDate != null) {
//         if (request.requestDate!.isAfter(toDate!)) {
//           return false;
//         }
//       }
//
//       // Search filter
//       if (searchController.text.isNotEmpty) {
//         String searchTerm = searchController.text.toLowerCase();
//         return (request.partyName?.toLowerCase().contains(searchTerm) ??
//             false) ||
//             (request.reason?.toLowerCase().contains(searchTerm) ?? false) ||
//             (request.requestNo?.toLowerCase().contains(searchTerm) ?? false) ||
//             (request.amount?.toString().contains(searchTerm) ?? false);
//       }
//
//       return true;
//     }).toList();
//
//     update();
//   }
//
//   // Get payment request list from API
//   Future<void> getPaymentRequestList({bool isRefresh = false}) async {
//     if (isRefresh) {
//       currentPage = 1;
//       hasMoreData = true;
//     }
//
//     setBusy(true);
//     try {
//       Map<String, dynamic> body = {
//         'userid':   homeController.currentUserData?.userid   ?? '',
//         'compid':   homeController.currentUserData?.compId   ?? '',
//         'branchid': homeController.currentUserData?.branchId ?? '',
//         'fromdate': DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(firstDate)),
//         'todate':   DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(lastDate)),
//       };
//
//       log("PAYMENT REQUEST LIST BODY :=> ${jsonEncode(body)}");
//
//       var res = await api.getPaymentRequestList(body);
//       if (res.status == 200) {
//         if (isRefresh) {
//           paymentRequestList.clear();
//         }
//         log("RAW API RESPONSE: ${jsonEncode(res.data)}");
//
//         final rawList = res.data ?? [];
//         final data = (rawList as List<dynamic>)
//             .map((e) => PaymentRequestData.fromJson(e as Map<String, dynamic>))
//             .toList();
//
//         if (data.isEmpty) {
//           hasMoreData = false;
//         } else {
//           paymentRequestList.addAll(data);
//           currentPage++;
//         }
//
//         applyFilters();
//       }
//
//       else {
//         ShowMessage.showSnackBar('Error', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Error', '$e');
//       log('getPaymentRequestList Error: $e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//   // Load more data for pagination
//   Future<void> loadMore() async {
//     if (!isBusy && hasMoreData) {
//       await getPaymentRequestList();
//     }
//   }
//
//   // Get customer list for dropdown filter
//   Future<void> getCustomerList() async {
//     try {
//       Map<String, String> body = {
//         RequestKeys.userId:
//         homeController.currentUserData?.userid.toString() ?? '',
//         RequestKeys.compId:
//         homeController.currentUserData?.compId.toString() ?? '',
//         RequestKeys.branchId:
//         homeController.currentUserData?.branchId.toString() ?? '',
//         RequestKeys.voucherType: "20",
//       };
//
//       var res = await api.getCustomer(body);
//       if (res.status == 200) {
//         final raw = res.data ?? [];
//         if (raw is List<CustomerListData>) {
//           partyListData = raw;
//         } else if (raw is List) {
//           partyListData = raw
//               .whereType<Map<String, dynamic>>()
//               .map((e) => CustomerListData.fromJson(e))
//               .toList();
//         } else {
//           partyListData = [];
//         }
//       }
//     } catch (e) {
//       log('getCustomerList Error: $e');
//     }
//   }
//
//   // Get branch and site dropdown list
//   Future<void> getBranchandSiteDropdownList() async {
//     try {
//       Map<String, String> body = {
//         RequestKeys.userId:
//         homeController.currentUserData?.userid.toString() ?? '',
//         RequestKeys.compId:
//         homeController.currentUserData?.compId.toString() ?? '',
//       };
//
//       var res = await api.getBranchandSite(body);
//       if (res.status == 200) {
//         branchandSit = res.data ?? [];
//       }
//     } catch (e) {
//       log('getBranchandSiteDropdownList Error: $e');
//     }
//   }
//
//   // View payment request details
//   void viewPaymentRequestDetails(PaymentRequestData request) {
//     // Navigate to details screen or show bottom sheet
//     Get.bottomSheet(
//       PaymentRequestDetailsSheet(request: request),
//       isScrollControlled: true,
//       backgroundColor: Colors.white,
//     );
//   }
//
//   // Cancel payment request
//   Future<void> cancelPaymentRequest(int requestId) async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {
//         RequestKeys.userId:
//         homeController.currentUserData?.userid.toString() ?? '',
//         RequestKeys.compId:
//         homeController.currentUserData?.compId.toString() ?? '',
//         'requestid': requestId.toString(),
//         'action': 'cancel',
//       };
//
//       var res = await api.updatePaymentRequestStatus(body);
//       if (res.status == 200) {
//         ShowMessage.showSnackBar('Success', 'Payment request cancelled');
//         getPaymentRequestList(isRefresh: true);
//       } else {
//         ShowMessage.showSnackBar('Error', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Error', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
// }
//
// // Payment Request Data Model
// class PaymentRequestData {
//   int? requestId;
//   String? requestNo;
//   int? partyId;
//   String? partyName;
//   String? partyType;
//   String? requestType;
//   int? branchId;
//   String? branchName;
//   double? amount;
//   String? reason;
//   String? refDocNo;
//   String? status;
//   DateTime? requestDate;
//   int? approverId;
//   String? approverName;
//   String? documentPath;
//   String? documentName;
//   DateTime? approvedDate;
//   String? remarks;
//
//   PaymentRequestData({
//     this.requestId,
//     this.requestNo,
//     this.partyId,
//     this.partyName,
//     this.partyType,
//     this.requestType,
//     this.branchId,
//     this.branchName,
//     this.amount,
//     this.reason,
//     this.refDocNo,
//     this.status,
//     this.requestDate,
//     this.approverId,
//     this.approverName,
//     this.documentPath,
//     this.documentName,
//     this.approvedDate,
//     this.remarks,
//   });
//
//   factory PaymentRequestData.fromJson(Map<String, dynamic> json) {
//     return PaymentRequestData(
//       requestId:    json['ReqId'],
//       requestNo:    json['RequestNo'],
//       partyName:    json['PartyName'],
//       branchName:   json['SiteName'],       // SiteName → branchName
//       reason:       json['Requestfor'],     // Requestfor → reason
//       approverName: json['RequestBy'],      // RequestBy → approverName
//       amount:       json['Amount'] != null ? double.parse(json['Amount'].toString()) : null,
//       status:       json['Status'],
//       requestDate:  json['RequestDate'] != null
//           ? DateFormat('dd-MM-yyyy').parse(json['RequestDate'])  // date is "14-04-2026"
//           : null,
//       documentName: json['Document'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'requestid': requestId,
//       'requestno': requestNo,
//       'partyid': partyId,
//       'partyname': partyName,
//       'partytype':partyType,
//       'requesttype':requestType,
//       'branchid': branchId,
//       'branchname': branchName,
//       'amount': amount,
//       'reason': reason,
//       'refdocno': refDocNo,
//       'status': status,
//       'requestdate': requestDate?.toIso8601String(),
//       'approverid': approverId,
//       'approvername': approverName,
//       'documentpath': documentPath,
//       'documentname': documentName,
//       'approveddate': approvedDate?.toIso8601String(),
//       'remarks': remarks,
//     };
//   }
//
//   Color getStatusColor() {
//     switch (status?.toLowerCase()) {
//       case 'approved':   return const Color(0xFF2196F3); // blue
//       case 'finalised':  return const Color(0xFF9C27B0); // purple
//       case 'paid':       return const Color(0xFF4CAF50); // green
//       case 'rejected':   return const Color(0xFFF44336); // red
//       case 'pending':    return const Color(0xFFFF9800); // orange
//       default:           return Colors.grey;
//     }
//   }
//
//   IconData getStatusIcon() {
//     switch (status?.toLowerCase()) {
//       case 'approved':   return Icons.thumb_up_alt_rounded;
//       case 'finalised':  return Icons.verified_rounded;
//       case 'paid':       return Icons.check_circle_rounded;
//       case 'rejected':   return Icons.cancel_rounded;
//       case 'pending':    return Icons.access_time_rounded;
//       default:           return Icons.help_outline;
//     }
//   }
// }
//
// // Payment Request Details Bottom Sheet
// class PaymentRequestDetailsSheet extends StatelessWidget {
//   final PaymentRequestData request;
//
//   const PaymentRequestDetailsSheet({Key? key, required this.request})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Payment Request Details',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => Get.back(),
//                   icon: Icon(Icons.close),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//
//             // Status badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: request.getStatusColor().withValues(alpha:0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     request.getStatusIcon(),
//                     color: request.getStatusColor(),
//                     size: 16,
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     request.status ?? 'N/A',
//                     style: TextStyle(
//                       color: request.getStatusColor(),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             // Request details
//             _buildDetailRow('Request No', request.requestNo ?? 'N/A'),
//             _buildDetailRow('Party Name', request.partyName ?? 'N/A'),
//             _buildDetailRow('Party Type', request.partyType ?? 'N/A'),
//             _buildDetailRow('Request Type', request.requestType ?? 'N/A'),
//             _buildDetailRow('Branch/Site', request.branchName ?? 'N/A'),
//             _buildDetailRow(
//               'Amount',
//               '₹ ${request.amount?.toStringAsFixed(2) ?? '0.00'}',
//             ),
//             _buildDetailRow('Reason', request.reason ?? 'N/A'),
//             _buildDetailRow('Ref Doc No', request.refDocNo ?? 'N/A'),
//             _buildDetailRow(
//               'Request Date',
//               request.requestDate != null
//                   ? DateFormat('dd-MM-yyyy').format(request.requestDate!)
//                   : 'N/A',
//             ),
//             _buildDetailRow('Approver Name', request.approverName ?? 'N/A'),
//             if (request.approvedDate != null)
//               _buildDetailRow(
//                 'Approved Date',
//                 DateFormat('dd-MM-yyyy').format(request.approvedDate!),
//               ),
//             if (request.remarks != null && request.remarks!.isNotEmpty)
//               _buildDetailRow('Remarks', request.remarks ?? ''),
//
//             const SizedBox(height: 20),
//
//             // Action buttons
//             if (request.status?.toLowerCase() == 'pending')
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         Get.back();
//                         PaymentRequestListController.to
//                             .cancelPaymentRequest(request.requestId ?? 0);
//                       },
//                       icon: Icon(Icons.cancel),
//                       label: Text('Cancel Request'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         foregroundColor: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_branchand_sit_res_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_routes/app_routes.dart';
import '../payment request detail/payment_request_detail_controller.dart';
import '../payment_request_controller.dart';
import '../payment_request_filter/payment_request_filter_sheet.dart';
import '../payment_request_model/payment_request_model.dart';

class PaymentRequestListController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  static PaymentRequestListController get to =>
      Get.find<PaymentRequestListController>();

  // List data - using the separate model
  List<PaymentRequestModel> paymentRequestList = [];
  List<PaymentRequestModel> get filteredPaymentRequestList {
    final filtered = activeFilter.apply(paymentRequestList);
    final q = searchController.text.trim().toLowerCase();
    if (q.isEmpty) return filtered;
    return filtered.where((r) =>
    (r.partyName  ?? '').toLowerCase().contains(q) ||
        (r.reason     ?? '').toLowerCase().contains(q) ||
        (r.requestNo  ?? '').toLowerCase().contains(q)
    ).toList();
  }
  final List<String> requestTypeOptions = [
    'All',
    'Payment',
    'Advance',
    'Reimbursement',
    'Other'
  ];

  // Dropdown data
  List<CustomerListData> partyListData = [];
  List<BranchandSit> branchandSit = [];

  // Selected filters
  CustomerListData? selectedParty;
  BranchandSit? selectedBranch;
  String? selectedStatus;
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedRequestType;

  // Status options
  final List<String> statusOptions = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
  ];


//Payment Request Filter
  PaymentRequestFilter activeFilter = const PaymentRequestFilter();
  void applyFilter(PaymentRequestFilter f) {
    activeFilter = f;
    update();
  }

  void resetFilter() {
    activeFilter = const PaymentRequestFilter();
    update();
  }
  // Search controller
  TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  // Pagination
  int currentPage = 1;
  int itemsPerPage = 20;
  bool hasMoreData = true;

  // Date range
  String firstDate = DateFormat(AppString.ddMMyyyy).format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day - 30,
      DateTime.now().hour,
      DateTime.now().minute,
      DateTime.now().second));
  String lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());

  void setDate(String value, bool isFirstDate) {
    if (isFirstDate) {
      firstDate = value;
    } else {
      lastDate = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<HomeController>()) {
      homeController = Get.find<HomeController>();
    } else {
      homeController = Get.put(HomeController());
    }

    // ✅ DEBUG: Verify branch ID before API call
    debugPrint("💳 PaymentRequestListController initialized");
    debugPrint("   Branch ID: ${homeController.currentUserData?.branchId}");
    debugPrint("   Company ID: ${homeController.currentUserData?.compId}");

    getPaymentRequestList();
    getCustomerList();
    getBranchandSiteDropdownList();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocus.dispose();
    super.onClose();
  }

  // Clear all filters
  void clearFilters() {
    firstDate = DateFormat(AppString.ddMMyyyy)
        .format(DateTime.now().subtract(const Duration(days: 30)));
    lastDate = DateFormat(AppString.ddMMyyyy).format(DateTime.now());
    selectedParty = null;
    selectedBranch = null;
    selectedStatus = null;
    selectedRequestType = null;
    fromDate = null;
    toDate = null;
    searchController.clear();
    currentPage = 1;
    applyFilters();
    update();
  }

  // Set selected party filter
  void setSelectedParty(CustomerListData? value) {
    selectedParty = value;
    currentPage = 1;
    applyFilters();
    update();
  }

  void setSelectedRequestType(String? value) {
    selectedRequestType = value;
    currentPage = 1;
    applyFilters();
    update();
  }

  // Set selected branch filter
  void setSelectedBranch(BranchandSit? value) {
    selectedBranch = value;
    currentPage = 1;
    applyFilters();
    update();
  }

  // Set selected status filter
  void setSelectedStatus(String? value) {
    selectedStatus = value;
    currentPage = 1;
    applyFilters();
    update();
  }

  // Set date range
  // Set date range
  void setFromDate(DateTime? date) {
    fromDate = date;
    if (date != null) {
      firstDate = DateFormat(AppString.ddMMyyyy).format(date);
    }
    currentPage = 1;
    getPaymentRequestList(isRefresh: true); // Fetch new data from API
    update();
  }

  void setToDate(DateTime? date) {
    toDate = date;
    if (date != null) {
      lastDate = DateFormat(AppString.ddMMyyyy).format(date);
    }
    currentPage = 1;
    getPaymentRequestList(isRefresh: true); // Fetch new data from API
    update();
  }

  // Search function
  void onSearchChanged(String query) {
    currentPage = 1;
    applyFilters();
  }

  Future<void> tapOnAdd() async {
    if (Get.isRegistered<PaymentRequestController>()) {
      Get.delete<PaymentRequestController>(force: true);
    }
    await Get.toNamed(AppRoutes.paymentRequestScreen);
    getPaymentRequestList(isRefresh: true); // fires on return
  }

  // Apply all filters
  void applyFilters() {
    update(); // getter recalculates automatically on rebuild
  }

  // Get payment request list from API
  Future<void> getPaymentRequestList({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMoreData = true;
    }
    if (isBusy) return;

    setBusy(true);
    try {
      Map<String, dynamic> body = {
        'userid': homeController.currentUserData?.userid ?? '',
        'compid': homeController.currentUserData?.compId ?? '',
        'branchid': homeController.currentUserData?.branchId ?? '',
        'fromdate': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(firstDate)),
        'todate': DateFormat('yyyy-MM-dd')
            .format(DateFormat('dd-MM-yyyy').parse(lastDate)),
      };

      log("PAYMENT REQUEST LIST BODY :=> ${jsonEncode(body)}");

      var res = await api.getPaymentRequestList(body);
      if (res.status == 200) {
        // ✅ Always clear and replace — API returns full list, not pages
        paymentRequestList.clear();

        log("RAW API RESPONSE: ${jsonEncode(res.data)}");

        final rawList = res.data ?? [];
        final data = (rawList as List<dynamic>)
            .map((e) => PaymentRequestModel.fromJson(e as Map<String, dynamic>))
            .toList();

        paymentRequestList.addAll(data);
        hasMoreData = false;

        applyFilters();
      } else {
        ShowMessage.showSnackBar('Error', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Error', '$e');
      log('getPaymentRequestList Error: $e');
    } finally {
      setBusy(false);
    }
  }

  // Load more data for pagination
  Future<void> loadMore() async {
    // if (!isBusy && hasMoreData) {
    //   await getPaymentRequestList();
    // }
  }

  // Get customer list for dropdown filter
  Future<void> getCustomerList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId:
        homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
        homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.branchId:
        homeController.currentUserData?.branchId.toString() ?? '',
        RequestKeys.voucherType: "20",
      };

      var res = await api.getCustomer(body);
      if (res.status == 200) {
        final raw = res.data ?? [];
        if (raw is List<CustomerListData>) {
          partyListData = raw;
        } else if (raw is List) {
          partyListData = raw
              .whereType<Map<String, dynamic>>()
              .map((e) => CustomerListData.fromJson(e))
              .toList();
        } else {
          partyListData = [];
        }
      }
    } catch (e) {
      log('getCustomerList Error: $e');
    }
  }

  // Get branch and site dropdown list
  Future<void> getBranchandSiteDropdownList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId:
        homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
        homeController.currentUserData?.compId.toString() ?? '',
      };

      var res = await api.getBranchandSite(body);
      if (res.status == 200) {
        branchandSit = res.data ?? [];
      }
    } catch (e) {
      log('getBranchandSiteDropdownList Error: $e');
    }
  }

  // View payment request details
  Future<void> viewPaymentRequestDetails(PaymentRequestModel request) async {
    if (Get.isRegistered<PaymentRequestDetailController>()) {
      Get.delete<PaymentRequestDetailController>(force: true);
    }
    Get.put(PaymentRequestDetailController(request: request));
    await Get.toNamed(AppRoutes.paymentRequestDetailScreen);
    getPaymentRequestList(isRefresh: true); // ✅ already there
  }

  // Cancel payment request
  Future<void> cancelPaymentRequest(int requestId) async {
    setBusy(true);
    try {
      Map<String, String> body = {
        RequestKeys.userId:
        homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
        homeController.currentUserData?.compId.toString() ?? '',
        'requestid': requestId.toString(),
        'action': 'cancel',
      };

      var res = await api.updatePaymentRequestStatus(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('Success', 'Payment request cancelled');
        getPaymentRequestList(isRefresh: true);
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

// Payment Request Details Bottom Sheet
class PaymentRequestDetailsSheet extends StatelessWidget {
  final PaymentRequestModel request;

  const PaymentRequestDetailsSheet({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Request Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: request.getStatusColor().withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    request.getStatusIcon(),
                    color: request.getStatusColor(),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    request.status ?? 'N/A',
                    style: TextStyle(
                      color: request.getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Request details
            _buildDetailRow('Request No', request.requestNo ?? 'N/A'),
            _buildDetailRow('Party Name', request.partyName ?? 'N/A'),
            _buildDetailRow('Party Type', request.partyType ?? 'N/A'),
            _buildDetailRow('Request Type', request.requestType ?? 'N/A'),
            _buildDetailRow('Branch/Site', request.branchName ?? 'N/A'),
            _buildDetailRow('Amount', request.getFormattedAmount()),
            _buildDetailRow('Reason', request.reason ?? 'N/A'),
            _buildDetailRow('Ref Doc No', request.refDocNo ?? 'N/A'),
            _buildDetailRow('Request Date', request.getFormattedRequestDate()),
            _buildDetailRow('Approver Name', request.approverName ?? 'N/A'),
            if (request.approvedDate != null)
              _buildDetailRow(
                  'Approved Date', request.getFormattedApprovedDate()),
            if (request.remarks != null && request.remarks!.isNotEmpty)
              _buildDetailRow('Remarks', request.remarks ?? ''),

            const SizedBox(height: 20),

            // Action buttons
            if (request.canBeCancelled())
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        PaymentRequestListController.to
                            .cancelPaymentRequest(request.requestId ?? 0);
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('Cancel Request'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}