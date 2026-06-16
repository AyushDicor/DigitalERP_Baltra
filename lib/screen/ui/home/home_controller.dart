// import 'dart:async';
// import 'package:digitalerp/home_view_new.dart';
// import 'package:digitalerp/homeview_new_controller.dart';
// import 'package:digitalerp/payment_request/payment_request_controller.dart';
// import 'package:digitalerp/response/bottom_tab_item.dart';
// import 'package:digitalerp/response/cart_count_response.dart';
// import 'package:digitalerp/response/login_response.dart';
// import 'package:digitalerp/response/token_update_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/graph/all_graph_screen.dart';
// import 'package:digitalerp/screen/ui/home/attendance/attendance_view.dart';
// import 'package:digitalerp/screen/ui/home/dashboard/dashboard_view.dart';
// import 'package:digitalerp/screen/ui/home/executive_list/executive_list_view.dart';
// import 'package:digitalerp/screen/ui/home/order/order_view.dart';
// import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_view.dart';
// import 'package:digitalerp/services/api_service/request_keys.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/shared_pre.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:upgrader/upgrader.dart';
//
// class HomeController extends AppBaseController {
//   BottomTabItem? selectedTab;
//   int selectedTabV = 0;
//   int selectedTabI = 0;
//   UserData? currentUserData = UserData();
//   List<BottomTabItem> bottomList = [];
//   List<Position> userPositionsList = [];
//   bool isLocationSend = false;
//   int currentYear = 0;
//   bool? isCustomer;
//   String? name;
//   RxInt itemInCart = 0.obs;
//   RxInt unApprovalCount = 0.obs;
//   static StreamController<String> counterController =
//   StreamController<String>.broadcast();
//   static String cartCount = '';
//   // final cfg =
//   //     AppcastConfiguration(url: AppConst.appCastUrl, supportedOS: ['android']);
//
//   void setLocationSending(bool value) {
//     isLocationSend = value;
//     update();
//   }
//
//   @override
//   void onInit() async {
//     var obj = await SharedPre.getObjs(SharedPre.userData);
//     currentUserData = UserData.fromJson(obj);
//
//     isCustomer = currentUserData?.usertype == 'Customer';
//     name = currentUserData?.name.toString();
//     scaffoldKey = GlobalKey<ScaffoldState>();
//
//     // Register synchronously FIRST so GetBuilder can find it immediately
//     final menuCtrl = Get.put<HomeViewNewController>(HomeViewNewController());
//
//     int index = 0;
//     onItemTapped(index);
//     update(); // ← trigger HomeView to build with shimmer showing
//
//     // NOW fetch async in background — shimmer shows while this runs
//     menuCtrl.getNewMenuList(0);
//     menuCtrl.getUnApprovalCount();
//
//     sendLocations();
//     String? token = await FirebaseMessaging.instance.getToken();
//     updateToken(token);
//     Get.put<PaymentRequestController>(PaymentRequestController());
//
//     super.onInit();
//   }
//
// // DELETE the old menulist() method entirely
//
//   void menulist() {
//     Get.find<HomeViewNewController>().getNewMenuList(0);
//     Get.put<HomeViewNewController>(HomeViewNewController())
//         .getUnApprovalCount();
//   }
//
//   // Future<void> getMenuList() async {
//   //   currentUserData = await userDataController.getUserData;
//   //   currentYear = int.parse(currentUserData?.yearId?.split('-').first ?? '');
//   //   try {
//   //     Map<String, String> body = {};
//   //     body[RequestKeys.userId] = currentUserData?.userid.toString() ?? '';
//   //     body[RequestKeys.compId] = currentUserData?.compId.toString() ?? '';
//   //     MenuDetailsResponse res = await api.getMenuList(body);
//   //     if (res.status == 200) {
//   //       res.data?.forEach((element) {
//   //         bottomList.add(BottomTabItem(
//   //             element.menuId == 1
//   //                 ? AppAssets.dashboardIcon
//   //                 : element.menuId == 2
//   //                     ? AppAssets.attendanceIcon
//   //                     : element.menuId == 3
//   //                         ? AppAssets.executiveListIcon
//   //                         : element.menuId == 4
//   //                             ? AppAssets.orderIcon
//   //                             : element.menuId == 5
//   //                                 ? AppAssets.visitPlanIcon
//   //                                 : element.menuId == 6
//   //                                     ? AppAssets.customerListIcon
//   //                                     : element.menuId == 7
//   //                                         ? AppAssets.imageCaptureIcon
//   //                                         : element.menuId == 8
//   //                                             ? AppAssets.accountsModuleIcon
//   //                                             : element.menuId == 9
//   //                                                 ? AppAssets.leaveApprovalIcon
//   //                                                 : element.menuId == 10
//   //                                                     ? AppAssets.misIcon
//   //                                                     : element.menuId == 11
//   //                                                     ? AppAssets.approvalIcon
//   //                                                       : element.menuId == 12
//   //                                                       ? AppAssets.marketingIcon
//   //                                                         : element.menuId == 13
//   //                                                         ? AppAssets.taskManagementIcon
//   //                                                           : element.menuId == 14
//   //                                                           ? AppAssets.followupIcon
//   //                                                             :AppAssets.dashboardIcon,
//   //
//   //
//   //             element.menuName.toString(),
//   //             element.menuId.toString()));
//   //         update();
//   //       });
//   //
//   //       getCartCount();
//   //     } else {
//   //       ShowMessage.showSnackBar(
//   //           'getMenuList Server res.status not 200', res.message.toString());
//   //     }
//   //   } catch (e) {
//   //     ShowMessage.showSnackBar('getMenuList Catch', '$e');
//   //   }
//   // }
//   Future<void> getCartCount() async {
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.userId] = currentUserData?.userid.toString() ?? '';
//       body[RequestKeys.compId] = currentUserData?.compId.toString() ?? '';
//       CartCountResponse res = await api.getCartCount(body);
//       if (res.status == 200) {
//         itemInCart.value = res.data?.first.totalcartcount?.toInt() ?? 0;
//       } else {
//         ShowMessage.showSnackBar(
//             'getCartCount res.status not 200', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('getCartCount Catch', '$e');
//     }
//   }
//
//   void onItemTapped(int index) {
//     selectedTabI = index;
//     selectedTabV = index;
//     // selectedTab = bottomList[index];
//     // selectedTabI = bottomList.indexOf(selectedTab!);
//     // /// new way
//     // selectedTabV = int.parse(selectedTab.toString()) - 1;
//     // ///old way
//     /*
//     if ('1' == selectedTab!.id) {
//       selectedTabV = 0;
//     } else if ('2' == selectedTab!.id) {
//       selectedTabV = 1;
//     } else if ('3' == selectedTab!.id) {
//       selectedTabV = 2;
//     } else if ('4' == selectedTab!.id) {
//       selectedTabV = 3;
//     } else if ('5' == selectedTab!.id) {
//       selectedTabV = 4;
//     } else if ('6' == selectedTab!.id) {
//       selectedTabV = 5;
//     } else if ('7' == selectedTab!.id) {
//       selectedTabV = 6;
//     } else if ('8' == selectedTab!.id) {
//       selectedTabV = 7;
//     } else if ('9' == selectedTab!.id) {
//       selectedTabV = 8;
//     }
//      */
//     update();
//   }
//
//   // List<Widget> pages = [
//   //   const HomeViewNew(),
//   //   const DashboardView(),
//   //   const AttendanceView(),
//   //   const ExecutiveListView(),
//   //   const OrderView(),
//   //   const VisitPlanView(),
//   //   const CustomerListView(),
//   //   const ImageView(),
//   //   const AccountModuleView(),
//   //   const ManagerLeaveHistoryView(),
//   //   const MisModuleView(),
//   //   const ApprovalLists(),
//   //   const LeadManagementView(),
//   //   const TaskListView(),
//   //   const OrderFollowupView()
//   // ];
//   // 5 tabs matching Figma nav: Home · Orders · Visits · Team · More
//   // List<Widget> page = [
//   //   const DashboardView(),       // Tab 0 — Home
//   //   OrderView(),                 // Tab 1 — Orders
//   //   AttendanceView(),             // Tab 2 — Attendance
//   //   const ExecutiveListView(),   // Tab 3 — Team
//   //   const HomeViewNew(),         // Tab 4 — More (Quick Links)
//   // ];
//
//   void collectLocations() {
//     Timer.periodic(
//       const Duration(seconds: 5),
//           (timer) async {
//         if (kDebugMode) {
//           print('-----${DateTime.now()}---');
//           var pos = await getUserCurrentPosition();
//           userPositionsList.add(pos);
//         }
//       },
//     );
//   }
//
//   void sendLocations() {
//     Timer.periodic(
//       const Duration(minutes: 15),
//           (timer) async {
//         if (await SharedPre.getBoolValue(SharedPre.isLocationSend)) {
//           saveLocationAPI();
//           debugPrint("-------------locationSent---------");
//         } else {
//           debugPrint("-------------locationNotSent---------");
//         }
//       },
//     );
//   }
//
//   Future<void> saveLocationAPI() async {
//     Position currentPosition = await getUserCurrentPosition();
//     String currentAddress = await getUserCurrentAddress();
//     String battery = await getBatteryPercent();
//     String? deviceID = await getDeviceIdentifier();
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.compId] = currentUserData?.compId.toString() ?? '';
//       body[RequestKeys.branchId] = currentUserData?.branchId.toString() ?? '';
//       body[RequestKeys.userId] = currentUserData?.userid.toString() ?? '';
//       body[RequestKeys.yearId] = currentUserData?.yearId.toString() ?? '';
//       body[RequestKeys.latitude] = currentPosition.latitude.toString();
//       body[RequestKeys.longitude] = currentPosition.longitude.toString();
//       body[RequestKeys.location] = currentAddress;
//       body[RequestKeys.deviceId] = deviceID ?? '';
//       body[RequestKeys.batteryLevel] = '$battery %';
//       var res = await api.saveLocationRoute(body);
//       if (res.status != 200) {
//         ShowMessage.showSnackBar(
//             'saveLocationRoute  res.status not 200', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('saveLocationRoute catch', '$e');
//     } finally {}
//   }
//
//   Future<void> updateToken(String? token) async {
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.compId] = currentUserData!.compId.toString();
//       body[RequestKeys.userId] = currentUserData!.userid.toString();
//       body[RequestKeys.token] = token ?? 'abcde874556';
//       TokenUpdateResponse res = await api.tokenUpdate(body);
//       if (res.status == 200) {
//         print('======Token Updated Successfully=====');
//       } else {
//         ShowMessage.showSnackBar(
//             'tokenUpdate res.status not 200', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('tokenUpdate catch', '$e');
//     }
//   }
// // Future<void> getUnApprovalCount() async {
// //   setBusy(true);
// //   try {
// //     Map<String, String> body = {};
// //     body[RequestKeys.compId] = currentUserData!.compId.toString();
// //     body[RequestKeys.userId] = currentUserData!.userid.toString();
// //     body[RequestKeys.branchId] = currentUserData!.branchId.toString();
// //     var res = await api.getUnApprovalCount(body);
// //     if (res.status == 200) {
// //       unApprovalCount.value = res.data?.first.counttotalunapproved?.toInt() ?? 0;
// //       // unApprovalCount = res.data ?? [];
// //       // for (int i = 0; i <= unApprovalCount.length - 1; i++) {
// //       //   totalCount.add({"itemid": unApprovalCount[i].counttotalunapproved});
// //
// //       // await SharedPre.setValue(SharedPre.unApprovalCount, json.encode(unApprovalCount));
// //     } else {
// //       ShowMessage.showSnackBar('getUnApprovalCount res.status not 200', res.message.toString());
// //     }
// //   } catch (e) {
// //     ShowMessage.showSnackBar('Server Res', '$e');
// //   } finally {
// //     setBusy(false);
// //   }
// // }
// }


import 'dart:async';
import 'package:digitalerp/home_view_new.dart';
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/payment_request/payment_request_controller.dart';
import 'package:digitalerp/response/bottom_tab_item.dart';
import 'package:digitalerp/response/cart_count_response.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/response/token_update_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/all_graph_screen.dart';
import 'package:digitalerp/screen/ui/home/attendance/attendance_view.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_list_view.dart';
import 'package:digitalerp/screen/ui/home/order/order_view.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_view.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../../../app_routes/app_routes.dart';

class HomeController extends AppBaseController {
  BottomTabItem? selectedTab;
  int selectedTabV = 0;
  int selectedTabI = 0;
  UserData? currentUserData = UserData();
  List<BottomTabItem> bottomList = [];
  List<Position> userPositionsList = [];
  bool isLocationSend = false;
  int currentYear = 0;
  bool? isCustomer;
  String? name;
  RxInt itemInCart = 0.obs;
  RxInt unApprovalCount = 0.obs;
  static StreamController<String> counterController =
  StreamController<String>.broadcast();
  static String cartCount = '';

  void setLocationSending(bool value) {
    isLocationSend = value;
    update();
  }

  @override
  void onInit() async {
    // ✅ LOAD USER DATA WITH BRANCH ID
    await loadUserData();

    isCustomer = currentUserData?.usertype == 'Customer';
    name = currentUserData?.name.toString();
    scaffoldKey = GlobalKey<ScaffoldState>();

    // Register synchronously FIRST so GetBuilder can find it immediately
    final menuCtrl = Get.put<HomeViewNewController>(HomeViewNewController());

    int index = 0;
    onItemTapped(index);
    update(); // ← trigger HomeView to build with shimmer showing

    // NOW fetch async in background — shimmer shows while this runs
    menuCtrl.getNewMenuList(0);
    menuCtrl.getUnApprovalCount();

    sendLocations();
    String? token = await FirebaseMessaging.instance.getToken();
    updateToken(token);
    Get.put<PaymentRequestController>(PaymentRequestController());

    super.onInit();
  }

  // ✅ NEW: Load user data from SharedPreferences
  Future<void> loadUserData() async {
    try {
      final obj = SharedPre.getObjs(SharedPre.userData); // no await needed, it's sync

      if (obj == null || obj.isEmpty) {
        debugPrint("⚠️ No user data found — redirecting to login");
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      currentUserData = UserData.fromJson(obj);

      debugPrint("📱 HomeController - User Data Loaded:");
      debugPrint("   User ID: ${currentUserData?.userid}");
      debugPrint("   Company ID: ${currentUserData?.compId}");
      debugPrint("   Branch ID: ${currentUserData?.branchId}");
      debugPrint("   Name: ${currentUserData?.name}");

      // Corrupt saved data — force re-login
      if ((currentUserData?.branchId ?? 0) == 0) {
        debugPrint("⚠️ branchId is 0 — clearing bad data, redirecting to login");
        await SharedPre.clear(SharedPre.userData);
        Get.offAllNamed(AppRoutes.login);
        return;
      }

      update();
    } catch (e) {
      debugPrint("❌ Error loading user data: $e");
      Get.offAllNamed(AppRoutes.login);
    }
  }

  // ✅ NEW: Refresh user data (call this after login or branch change)
  Future<void> refreshUserData() async {
    debugPrint("🔄 Refreshing user data...");
    await loadUserData();
  }

  void menulist() {
    Get.find<HomeViewNewController>().getNewMenuList(0);
    Get.put<HomeViewNewController>(HomeViewNewController())
        .getUnApprovalCount();
  }

  Future<void> getCartCount() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] = currentUserData?.compId.toString() ?? '';

      // ✅ DEBUG: Print request body
      debugPrint("🛒 Getting cart count with: $body");

      CartCountResponse res = await api.getCartCount(body);
      if (res.status == 200) {
        itemInCart.value = res.data?.first.totalcartcount?.toInt() ?? 0;
      } else {
        ShowMessage.showSnackBar(
            'getCartCount res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('getCartCount Catch', '$e');
    }
  }

  void onItemTapped(int index) {
    selectedTabI = index;
    selectedTabV = index;
    update();
  }

  void collectLocations() {
    Timer.periodic(
      const Duration(seconds: 5),
          (timer) async {
        if (kDebugMode) {
          print('-----${DateTime.now()}---');
          var pos = await getUserCurrentPosition();
          userPositionsList.add(pos);
        }
      },
    );
  }

  void sendLocations() {
    Timer.periodic(
      const Duration(minutes: 15),
          (timer) async {
        if (await SharedPre.getBoolValue(SharedPre.isLocationSend)) {
          saveLocationAPI();
          debugPrint("-------------locationSent---------");
        } else {
          debugPrint("-------------locationNotSent---------");
        }
      },
    );
  }

  Future<void> saveLocationAPI() async {
    Position currentPosition = await getUserCurrentPosition();
    String currentAddress = await getUserCurrentAddress();
    String battery = await getBatteryPercent();
    String? deviceID = await getDeviceIdentifier();
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = currentUserData?.compId.toString() ?? '';
      body[RequestKeys.branchId] = currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.userId] = currentUserData?.userid.toString() ?? '';
      body[RequestKeys.yearId] = currentUserData?.yearId.toString() ?? '';
      body[RequestKeys.latitude] = currentPosition.latitude.toString();
      body[RequestKeys.longitude] = currentPosition.longitude.toString();
      body[RequestKeys.location] = currentAddress;
      body[RequestKeys.deviceId] = deviceID ?? '';
      body[RequestKeys.batteryLevel] = '$battery %';

      // ✅ DEBUG: Print location request
      debugPrint("📍 Saving location with branchId: ${body[RequestKeys.branchId]}");

      var res = await api.saveLocationRoute(body);
      if (res.status != 200) {
        ShowMessage.showSnackBar(
            'saveLocationRoute  res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('saveLocationRoute catch', '$e');
    } finally {}
  }

  Future<void> updateToken(String? token) async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = currentUserData!.compId.toString();
      body[RequestKeys.userId] = currentUserData!.userid.toString();
      body[RequestKeys.token] = token ?? 'abcde874556';
      TokenUpdateResponse res = await api.tokenUpdate(body);
      if (res.status == 200) {
        print('======Token Updated Successfully=====');
      } else {
        ShowMessage.showSnackBar(
            'tokenUpdate res.status not 200', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('tokenUpdate catch', '$e');
    }
  }
}