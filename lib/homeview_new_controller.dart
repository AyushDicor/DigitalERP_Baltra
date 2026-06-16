// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:digitalerp/Menu_new_list_responce.dart';
// import 'package:digitalerp/app_routes/app_routes.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'payment_request/payment_request_controller.dart';
// import 'screen/ui/graph/graph_controller.dart';
// import 'screen/ui/graph/graph_filter_controller.dart';
// import 'screen/ui/home/approval/submit/update_approvalstatus_responce.dart';
// import 'screen/ui/home/home_controller.dart';
// import 'services/api_service/request_keys.dart';
// import 'utils/show_message.dart';
//
// class HomeViewNewController extends AppBaseController {
//   HomeController homeController = Get.find<HomeController>();
//   RxInt unApprovalCount = 0.obs;
//   List<UpdateApprovalstatusResponse> value = [];
//   List<MenuNewData> menuListData = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     getUnApprovalCount();
//     getNewMenuList(0);
//   }
//
//   Future<void> getUnApprovalCount() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.compId] =
//           homeController.currentUserData!.compId.toString();
//       body[RequestKeys.userId] =
//           homeController.currentUserData!.userid.toString();
//       body[RequestKeys.branchId] =
//           homeController.currentUserData!.branchId.toString();
//       var res = await api.getUnApprovalCount(body);
//       if (res.status == 200) {
//         unApprovalCount.value =
//             res.data?.first.counttotalunapproved?.toInt() ?? 0;
//         // for (int i = 0; i <= unApprovalCount.length - 1; i++) {
//         //   totalCount.add({"itemid": unApprovalCount[i].counttotalunapproved});
//
//         // await SharedPre.setValue(SharedPre.unApprovalCount, json.encode(unApprovalCount));
//       } else {
//         // ShowMessage.showSnackBar(
//         // 'getUnApprovalCount res.status not 200', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
//
//   bool _fetchInProgress = false;
//
//   Future<void> getNewMenuList(int menuId) async {
//     if (_fetchInProgress) return;
//     _fetchInProgress = true;
//
//     try {
//       isBusy = true;
//       update();
//
//       // 1) Wait until user data is available (compId/branchId/userid not null)
//       await _waitForUserDataReady();
//
//       // 2) If menuId must be > 0, wait for that too (optional)
//       if (menuId == 0) {
//         debugPrint("⏳ menuId is 0; waiting a tick...");
//         await Future.delayed(const Duration(milliseconds: 150));
//       }
//
//       final body = <String, String>{
//         RequestKeys.compId: homeController.currentUserData!.compId.toString(),
//         RequestKeys.branchId:
//             homeController.currentUserData!.branchId.toString(),
//         RequestKeys.userId: homeController.currentUserData!.userid.toString(),
//         RequestKeys.menuId: menuId.toString(),
//       };
//
//       debugPrint("[REQ] $body");
//
//       final res = await api.getNewMenuList(body);
//
//       final data = (res.data as List?)?.toList() ?? [];
//
//       final rawData = res.data;
//       if (rawData is List<MenuNewData>) {
//         // Already parsed
//         menuListData = rawData;
//         debugPrint("[OK] items=${menuListData.length}");
//       } else {
//         debugPrint("[ERR ${res.status}] items=${menuListData.length}");
//       }
//       menuListData = (res.data as List<dynamic>?)
//           ?.map((e) => MenuNewData.fromJson(e as Map<String, dynamic>))
//           .toList() ??
//           [];
//
//       // Only logout if you’re SURE empty means invalid user
//       if (menuListData.isEmpty) {
//         debugPrint("⚠ Empty menu → skip logout for first-load race conditions");
//         await logout();
//         // return;
//       }
//     } catch (e, st) {
//       debugPrint("getNewMenuList error: $e\n$st");
//       ShowMessage.showSnackBar('getMenuList catch', '$e');
//     } finally {
//       isBusy = false;
//       update();
//       _fetchInProgress = false;
//     }
//     for (var item in menuListData) {
//       debugPrint("Menu: ${item.menuname} → ID: ${item.menuid}");
//     }
//   }
//
//   Future<void> _waitForUserDataReady() async {
//     // If you already populate currentUserData via async init, just await that Future instead.
//     for (int i = 0; i < 30; i++) {
//       // ~3s max
//       final u = homeController.currentUserData;
//       if (u != null &&
//           u.compId != null &&
//           u.branchId != null &&
//           u.userid != null) {
//         return;
//       }
//       await Future.delayed(const Duration(milliseconds: 100));
//     }
//     // If still not ready, throw to avoid sending nulls to API
//     throw StateError("User data not ready (compId/branchId/userId are null).");
//   }
//
//   Map<String, dynamic> imageList() {
//     return {
//       'Executive': 'assets/iconsnew/Executive.png',
//       'Order Module': AppAssets.ordernewIcon,
//       'Visit': AppAssets.visitnewIcon,
//       'Payment Request': AppAssets.expensenewIcon,
//       'Party List': AppAssets.partylistnewIcon,
//       'Image': AppAssets.imagenewIcon,
//       'Accounts': AppAssets.accountNewIcon,
//       'MIS': AppAssets.misnewIcon,
//       'Approval': AppAssets.approvalnewIcon,
//       'Task Management': AppAssets.taskManagementnewIcon,
//       'Document Management': AppAssets.documentnewIcon,
//       'Follow Up': AppAssets.orderfollowpnewIcon,
//       'Lead Management': AppAssets.leadManagementNewIcon,
//       'Category Catalouge': 'assets/iconsnew/Category Catalogue.png',
//       'Complaints': AppAssets.complaintsIcon,
//       'Reimbursement': 'assets/iconsnew/Reimbursements.png',
//       'Performance': AppAssets.performancenewIcon,
//       'Attendance': AppAssets.attendencenewIcon,
//       'MRN': AppAssets.mrnIcon,
//       'Material Received':AppAssets.mrnrIcon
//     };
//     // map['Executive'] = AppAssets.executivenewIcon;
//     // map['Order Management'] = AppAssets.ordernewIcon;
//     // map['Visit'] = AppAssets.visitnewIcon;
//     // map['Party List'] = AppAssets.partylistnewIcon;
//     // map['Image'] = AppAssets.imagenewIcon;
//     // map['Accounts'] = 'Accounts';
//     // map['MIS'] = AppAssets.misnewIcon;
//     // map['Approval'] = AppAssets.approvalnewIcon;
//     // map['Task Management'] = 'Task Management';
//     // map['Document Management'] = AppAssets.documentnewIcon;
//     // map['Follow Up'] = AppAssets.followupIcon;
//     // return map;
//   }
//
//   static String getRouteNameById(int? menuId) {
//     // return AppRoutes.menuDefaultView;
//     if (menuId == 2377) {
//       return AppRoutes.executiveListView;
//     } else if (menuId == 2378) {
//       return AppRoutes.orderView;
//     } else if (menuId == 2379) {
//       return AppRoutes.visitPlan;
//     } else if (menuId == 2380) {
//       return AppRoutes.partyList;
//     } else if (menuId == 2381) {
//       return AppRoutes.imageView;
//     } else if (menuId == 2382) {
//       return AppRoutes.accountModule;
//     } else if (menuId == 2383) {
//       return AppRoutes.misModule;
//     } else if (menuId == 2384) {
//       return AppRoutes.approvalList;
//     } else if (menuId == 2385) {
//       return AppRoutes.taskManagement;
//     } else if (menuId == 2386) {
//       return AppRoutes.documentDownload;
//     } else if (menuId == 2387) {
//       return AppRoutes.orderFollowup;
//     } else if (menuId == 2419) {
//       return AppRoutes.leadManagement;
//     } else if (menuId == 2423) {
//       return AppRoutes.performance;
//     } else if (menuId == 2429) {
//       return AppRoutes.catalougeListView;
//     } else if (menuId == 2586) {
//       return AppRoutes.paymentRequestScreen;
//     }
//     //else if (menuId == 2700) {return AppRoutes.complaints; // make sure this exists
//     //}
//     else if (menuId == 2701) {
//       return AppRoutes.expense; // make sure this exists
//     }
//     else if (menuId == 2754) {
//       return AppRoutes.mrnScreen;
//     } else if (menuId == 2755) {
//       return AppRoutes.materialReceiptScreen;
//     }
//     else {
//       return AppRoutes.homeNew;
//     }
//   }
// }

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'payment_request/payment_request_controller.dart';
import 'screen/ui/home/approval/submit/update_approvalstatus_responce.dart';
import 'screen/ui/home/home_controller.dart';
import 'services/api_service/request_keys.dart';
import 'utils/show_message.dart';

class HomeViewNewController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  RxInt unApprovalCount = 0.obs;
  List<UpdateApprovalstatusResponse> value = [];
  List<MenuNewData> menuListData = [];
  bool get hasApprovalAccess =>
      menuListData.any((m) => m.menuid == 2384);

  bool isOpeningExternalFile = false;

  @override
  void onInit() {
    super.onInit();
    //getUnApprovalCount();
    //getNewMenuList(0);
  }
  void markOpeningExternalFile() {
    isOpeningExternalFile = true;
    Future.delayed(const Duration(seconds: 4), () {
      isOpeningExternalFile = false;
    });
  }

  Future<void> getUnApprovalCount() async {
    setBusy(true);
    try {
      final body = {
        RequestKeys.compId: homeController.currentUserData!.compId.toString(),
        RequestKeys.userId: homeController.currentUserData!.userid.toString(),
        RequestKeys.branchId:
            homeController.currentUserData!.branchId.toString(),
      };
      final res = await api.getUnApprovalCount(body);
      if (res.status == 200) {
        unApprovalCount.value =
            res.data?.first.counttotalunapproved?.toInt() ?? 0;
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  bool _fetchInProgress = false;

  Future<void> getNewMenuList(int menuId) async {
    if (_fetchInProgress) return;
    _fetchInProgress = true;

    try {
      isBusy = true;
      update();

      await _waitForUserDataReady();

      if (menuId == 0) {
        await Future.delayed(const Duration(milliseconds: 150));
      }

      final body = <String, String>{
        RequestKeys.compId: homeController.currentUserData!.compId.toString(),
        RequestKeys.branchId: homeController.currentUserData!.branchId.toString(),
        RequestKeys.userId: homeController.currentUserData!.userid.toString(),
        RequestKeys.menuId: menuId.toString(),
      };

      final res = await api.getNewMenuList(body);
      debugPrint("res.data runtimeType = ${res.data.runtimeType}");
      debugPrint("res.data = ${res.data}");
      final rawData = res.data;

      if (rawData == null) {
        menuListData = [];
        debugPrint("[WARN] res.data is null");
      } else if (rawData is List<MenuNewData>) {
        // Already correctly typed
        menuListData = rawData;
        debugPrint("[OK] already-parsed MenuNewData, items=${menuListData.length}");
      } else if (rawData is List) {
        // Safely map each item — skip anything that isn't a Map
        menuListData = rawData.whereType<Map<String, dynamic>>().map((e) {
          try {
            return MenuNewData.fromJson(e);
          } catch (parseErr) {
            debugPrint("[SKIP] Failed to parse menu item: $parseErr");
            return null;
          }
        }).whereType<MenuNewData>().toList();
        debugPrint("[OK] json-parsed, items=${menuListData.length}");
      } else {
        menuListData = [];
        debugPrint("[ERR] Unexpected res.data type: ${rawData.runtimeType}");
      }

      if (menuListData.isEmpty) {
        debugPrint("Empty menu list — logging out with message");
        await logout(); // clears session
        Get.offAllNamed(
          AppRoutes.login,
          arguments: {'error': 'Menu not configured for your account. Please contact your administrator.'},
        );
      }

    } catch (e, st) {
      debugPrint("getNewMenuList error: $e\n$st");
      ShowMessage.showSnackBar('getMenuList catch', '$e');
    } finally {
      isBusy = false;
      update();
      _fetchInProgress = false;
    }

    for (final item in menuListData) {
      debugPrint("Menu: ${item.menuname} -> ID: ${item.menuid}");
    }
  }

  Future<void> _waitForUserDataReady() async {
    for (int i = 0; i < 30; i++) {
      final u = homeController.currentUserData;
      if (u != null &&
          u.compId != null &&
          u.branchId != null &&
          u.userid != null) {
        return;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
    throw StateError("User data not ready (compId/branchId/userId are null).");
  }

  Map<String, dynamic> imageList() {
    return {
      'Executive'            : 'assets/iconsnew/Executive2.png',
      'Order Module'         : AppAssets.ordernewIcon,
      'Visit'                : AppAssets.visitnewIcon,
      'Payment Request'      : AppAssets.expensenewIcon,
      'Party List'           : AppAssets.partylistnewIcon,
      'Image'                : AppAssets.imagenewIcon,
      'Accounts'             : AppAssets.accountNewIcon,
      'MIS'                  : AppAssets.misnewIcon,
      'Approval'             : AppAssets.approvalnewIcon,
      'Task Management'      : AppAssets.taskManagementnewIcon,
      'Document Management'  : AppAssets.documentnewIcon,
      'Follow Up'            : AppAssets.orderfollowpnewIcon,
      'Lead Management'      : AppAssets.leadManagementNewIcon,
      'Category Catalouge'   : 'assets/iconsnew/Category Catalogue.png',
      'Complaints'           : AppAssets.complaintsIcon,
      'Reimbursement'        : 'assets/iconsnew/Reimbursements.png',
      'Performance'          : AppAssets.performancenewIcon,
      'Attendance'           : AppAssets.attendencenewIcon,
      'MRN'                  : AppAssets.mrnIcon,
      'GRN Entry'            : AppAssets.grnIcon,
      'Mrn QC'               : AppAssets.mrnQcIcon,
      'Material Received'    : AppAssets.mrnrIcon,
      'Create Indent'        : AppAssets.indentIcon,
      'Item Issue'           : AppAssets.issueItemIcon,
    };
  }

  static String getRouteNameById(int? menuId) {
    if (menuId == 2377) return AppRoutes.executiveListView;
    if (menuId == 2378) return AppRoutes.orderView;
    if (menuId == 2379) return AppRoutes.visitPlan;
    if (menuId == 2380) return AppRoutes.partyList;
    if (menuId == 2381) return AppRoutes.imageView;
    if (menuId == 2382) return AppRoutes.accountModule;
    if (menuId == 2383) return AppRoutes.misModule;
    if (menuId == 2384) return AppRoutes.approvalHub;
    if (menuId == 2385) return AppRoutes.taskManagement;
    if (menuId == 2386) return AppRoutes.documentDownload;
    if (menuId == 2387) return AppRoutes.orderFollowup;
    if (menuId == 2419) return AppRoutes.leadManagement;
    if (menuId == 2423) return AppRoutes.performance;
    if (menuId == 2429) return AppRoutes.catalougeListView;
    if (menuId == 2586) return AppRoutes.paymentRequestListScreen;
    if (menuId == 2701) return AppRoutes.reimbursement;
    if (menuId == 2754) return AppRoutes.mrnScreen;
    if (menuId == 2760) return AppRoutes.grnScreen;
    if (menuId == 2761) return AppRoutes.mrnQcList;
    if (menuId == 2755) return AppRoutes.materialReceiptScreen;
    if (menuId == 2769) return AppRoutes.indentList;
    if (menuId == 2770) return AppRoutes.issueItemList;
    return AppRoutes.homeNew;
  }
}
