// import 'package:digitalerp/app_routes/app_routes.dart';
// import 'package:digitalerp/response/attendance_summary_response.dart';
// import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/services/api_service/request_keys.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// class ExecutiveAttendanceController extends AppBaseController {
//   HomeController homeController = Get.find<HomeController>();
//   bool isAttendanceMarked = false;
//   List<AttendanceSummaryData>? attendanceSummaryData;
//   Position? currentPosition;
//   bool enableBtn = true;
//   bool isBtnShow = true;
//   String exeId = '';
//   String executiveName = 'Executive'; // ← new: shown in the view header
//
//   void setBtnShow() {
//     isBtnShow = !isBtnShow;
//     update();
//   }
//
//   //  Constructor: accepts both old String and new ExecutiveLatLongData 
//   ExecutiveAttendanceController(dynamic arg) {
//     if (arg is ExecutiveLatLongData) {
//       exeId = arg.userid.toString();
//       executiveName = arg.executivename ?? 'Executive';
//     } else {
//       // backwards-compatible: was passing userid as plain String
//       exeId = arg?.toString() ?? '';
//     }
//   }
//
//   @override
//   void onInit() {
//     getAttendanceDetails(true);
//     super.onInit();
//   }
//
//   void tapOnApprovedLeave() {
//     Get.toNamed(AppRoutes.executiveApprovedOrLeaveView, arguments: true);
//   }
//
//   void tapOnRejectedLeave() {
//     Get.toNamed(AppRoutes.executiveApprovedOrLeaveView, arguments: false);
//   }
//
//   void tapOnSeeMore() {
//     Get.toNamed(AppRoutes.executiveAttendanceList, arguments: exeId);
//   }
//
//   void getAttendanceDetails(bool isBusy,
//       {String? month, String? fromDate, String? toDate}) async {
//     setBusy(isBusy);
//     attendanceSummaryData?.clear();
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.userId] = exeId;
//       body[RequestKeys.compId] =
//           homeController.currentUserData?.compId.toString() ?? '0';
//       body[RequestKeys.fromDate] =
//           fromDate ?? getStartDateOfMonth(DateTime.now());
//       body[RequestKeys.toDate] = toDate ??
//           formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
//               AppString.yyyyMMdd);
//       body[RequestKeys.filter] = 'yes';
//       var res = await api.getAttendanceSummary(body);
//       if (res.status == 200) {
//         attendanceSummaryData = res.data;
//
//         enableBtn = (attendanceSummaryData?[0].details?.last.date.toString() ==
//             formatDate(DateTime.now().toString(),
//                 AppString.dateTimeFormat, AppString.ddMMyyyy) &&
//             attendanceSummaryData?[0].details?.last.outTime != null)
//             ? false
//             : true;
//
//         isAttendanceMarked =
//         (attendanceSummaryData?[0].details?.last.date.toString() ==
//             formatDate(DateTime.now().toString(),
//                 AppString.dateTimeFormat, AppString.ddMMyyyy) &&
//             attendanceSummaryData?[0].details?.last.outTime == null)
//             ? true
//             : false;
//
//         /// Sort date-wise descending
//         attendanceSummaryData?[0].details?.sort((a, b) {
//           if (DateTime.parse(formatDate(
//               a.date.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
//               .isBefore(DateTime.parse(formatDate(b.date.toString(),
//               AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
//             return 1;
//           }
//           return 0;
//         });
//
//         update();
//       } else {
//         ShowMessage.showSnackBar('Server Res', res.message.toString());
//       }
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res catch', '$e');
//     } finally {
//       setBusy(false);
//     }
//   }
// }

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/attendance_summary_response.dart';
import 'package:digitalerp/response/executive_list_with_lat_long_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/performance_tracker_widget.dart';

class ExecutiveAttendanceController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  //  Executive identity 
  String exeId = '';
  String executiveName = 'Executive';
  String executivePhoto = '';
  String executiveDesignation = '';

  //  Attendance 
  bool isAttendanceMarked = false;
  List<AttendanceSummaryData>? attendanceSummaryData;
  Position? currentPosition;
  bool enableBtn = true;
  bool isBtnShow = true;

  //  Dashboard stats 
  bool isDashboardBusy = false;
  String totalOrders = '0';
  String pendingVisits = '0';
  String paymentDue = '₹0';

  // Revenue chart — weekly spots (Mon–Sun)
  List<FlSpot> revenueSpots = [];
  String revenuePeriod = 'W';
  String revenueTotal = '₹0';
  String revenueChange = '';

  // Visits chart — weekly values (Mon–Sun)
  List<double> visitsValues = [];
  String visitsPeriod = 'W';
  String visitsTotal = '0';
  String visitsChange = '';

  // Recent orders table
  List<dynamic> recentOrders = [];

  //  Constructor 
  ExecutiveAttendanceController(dynamic arg) {
    if (arg is ExecutiveLatLongData) {
      exeId = arg.userid.toString();
      executiveName = arg.executivename ?? 'Executive';
      executivePhoto = arg.photo ?? '';
      executiveDesignation = arg.designation ?? 'Executive';
    } else {
      exeId = arg?.toString() ?? '';
    }
  }

  @override
  void onInit() {
    getAttendanceDetails(true);
    getExecutiveDashboard();
    getPerformanceData();
    super.onInit();
  }

  void setBtnShow() {
    isBtnShow = !isBtnShow;
    update();
  }

  //  Dashboard API 
  // Ask your backend team to create:
  //   POST /api/ExecutiveReportPerson/ExecutiveReportPersonList
  //   Body: { userid, compid, executiveid }
  //   Returns: { totalOrders, pendingVisits, paymentDue,
  //              revenueWeekly: [mon..sun], visitsWeekly: [mon..sun],
  //              recentOrders: [{documentNumber, description, executiveName}] }
  //
  // Until the API is ready, the screen shows zeros gracefully.
  // Future<void> getExecutiveDashboard() async {
  //   isDashboardBusy = true;
  //   update();
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.userId] =
  //         homeController.currentUserData?.userid.toString() ?? '';
  //     body[RequestKeys.compId] =
  //         homeController.currentUserData?.compId.toString() ?? '';
  //     // Pass executiveId so backend filters data for this executive
  //     body[RequestKeys.executiveId] = exeId;
  //
  //     var res = await api.getExecutiveDashboard(body);
  //
  //     if (res.status == 200 && res.data != null) {
  //       final d = res.data!;
  //
  //       totalOrders = d.totalOrders?.toString() ?? '0';
  //       pendingVisits = d.pendingVisits?.toString() ?? '0';
  //       paymentDue = d.paymentDue ?? '₹0';
  //
  //       // Revenue spots
  //       final List rawRevenue = d.revenueWeekly ?? [];
  //       revenueSpots = List.generate(
  //         rawRevenue.length,
  //             (i) => FlSpot(i.toDouble(), (rawRevenue[i] as num).toDouble()),
  //       );
  //       revenueTotal = d.revenueTotal ?? '₹0';
  //       revenueChange = d.revenueChange ?? '';
  //
  //       // Visits bars
  //       visitsValues = (d.visitsWeekly as List? ?? [])
  //           .map((v) => (v as num).toDouble())
  //           .toList();
  //       visitsTotal = d.visitsTotal ?? '0';
  //       visitsChange = d.visitsChange ?? '';
  //
  //       recentOrders = d.recentOrders ?? [];
  //     }
  //   } catch (e) {
  //     // Fail silently — dashboard shows zeros, attendance still works
  //   } finally {
  //     isDashboardBusy = false;
  //     update();
  //   }
  // }

  Future<void> getExecutiveDashboard() async {
    isDashboardBusy = true;
    update();
    try {
      // TODO: Uncomment when backend API is ready
      // Map<String, String> body = {};
      // body[RequestKeys.userId] =
      //     homeController.currentUserData?.userid.toString() ?? '';
      // body[RequestKeys.compId] =
      //     homeController.currentUserData?.compId.toString() ?? '';
      // body[RequestKeys.executiveId] = exeId;
      // var res = await api.getExecutiveDashboard(body);
      // if (res.status == 200 && res.data != null) { ... }

      // Stub data until API is ready — UI shows zeros gracefully
      totalOrders = '0';
      pendingVisits = '0';
      paymentDue = '₹0';
      revenueSpots = [];
      revenueTotal = '₹0';
      revenueChange = '';
      visitsValues = [];
      visitsTotal = '0';
      visitsChange = '';
      recentOrders = [];
    } catch (e) {
      // Fail silently
    } finally {
      isDashboardBusy = false;
      update();
    }
  }

  //  Attendance API (unchanged) 
  void getAttendanceDetails(bool isBusy,
      {String? month, String? fromDate, String? toDate}) async {
    setBusy(isBusy);
    attendanceSummaryData?.clear();
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = exeId;
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '0';
      body[RequestKeys.fromDate] =
          fromDate ?? getStartDateOfMonth(DateTime.now());
      body[RequestKeys.toDate] = toDate ??
          formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
              AppString.yyyyMMdd);
      body[RequestKeys.filter] = 'yes';
      var res = await api.getAttendanceSummary(body);
      if (res.status == 200) {
        attendanceSummaryData = res.data;

        enableBtn = (attendanceSummaryData?[0].details?.last.date.toString() ==
                    formatDate(DateTime.now().toString(),
                        AppString.dateTimeFormat, AppString.ddMMyyyy) &&
                attendanceSummaryData?[0].details?.last.outTime != null)
            ? false
            : true;

        isAttendanceMarked =
            (attendanceSummaryData?[0].details?.last.date.toString() ==
                        formatDate(DateTime.now().toString(),
                            AppString.dateTimeFormat, AppString.ddMMyyyy) &&
                    attendanceSummaryData?[0].details?.last.outTime == null)
                ? true
                : false;

        attendanceSummaryData?[0].details?.sort((a, b) {
          if (DateTime.parse(formatDate(
                  a.date.toString(), AppString.ddMMyyyy, AppString.yyyyMMdd))
              .isBefore(DateTime.parse(formatDate(b.date.toString(),
                  AppString.ddMMyyyy, AppString.yyyyMMdd)))) {
            return 1;
          }
          return 0;
        });

        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res catch', '$e');
    } finally {
      setBusy(false);
    }
  }

  //  Performance tracker (when api ready uncomment)
  // PerformanceData? performanceData;
  // String performancePeriod = 'M'; // default: this month
  //
  // String get performancePeriodLabel {
  //   switch (performancePeriod) {
  //     case 'D': return 'Today';
  //     case 'W': return 'This week';
  //     case 'Y': return 'This year';
  //     default:  return 'This month';
  //   }
  // }
  //
  // void setPerformancePeriod(String p) {
  //   performancePeriod = p;
  //   getPerformanceData();
  //   update();
  // }
  //
  // // Call this from onInit() alongside getExecutiveDashboard()
  // Future<void> getPerformanceData() async {
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.userId] =
  //         homeController.currentUserData?.userid.toString() ?? '';
  //     body[RequestKeys.compId] =
  //         homeController.currentUserData?.compId.toString() ?? '';
  //     body[RequestKeys.executiveId] = exeId;
  //     body['period'] = performancePeriod;
  //
  //     var res = await api.getExecutivePerformance(body);
  //     if (res.status == 200 && res.data != null) {
  //       performanceData = PerformanceData.fromJson(res.data!);
  //       update();
  //     }
  //   } catch (e) {
  //     // Silent fail — widget shows "coming soon" state
  //   }
  // }

  PerformanceData? performanceData;
  String performancePeriod = 'M';

  String get performancePeriodLabel {
    switch (performancePeriod) {
      case 'D':
        return 'Today';
      case 'W':
        return 'This week';
      case 'Y':
        return 'This year';
      default:
        return 'This month';
    }
  }

  void setPerformancePeriod(String p) {
    performancePeriod = p;
    getPerformanceData();
    update();
  }

  Future<void> getPerformanceData() async {
    // API not built yet — safe stub, performanceData stays null
    // Widget shows "coming soon" card until backend is ready.
    //
    // When backend creates the endpoint, replace with:
    // 
    // try {
    //   Map<String, String> body = {};
    //   body[RequestKeys.userId]      = homeController.currentUserData?.userid.toString() ?? '';
    //   body[RequestKeys.compId]      = homeController.currentUserData?.compId.toString() ?? '';
    //   body[RequestKeys.executiveId] = exeId;
    //   body['period']                = performancePeriod;
    //   var res = await api.getExecutivePerformance(body);
    //   if (res.status == 200 && res.data != null) {
    //     performanceData = PerformanceData.fromJson(res.data!);
    //     update();
    //   }
    // } catch (_) {}
    return;
  }

  void tapOnApprovedLeave() {
    Get.toNamed(AppRoutes.executiveApprovedOrLeaveView, arguments: true);
  }

  void tapOnRejectedLeave() {
    Get.toNamed(AppRoutes.executiveApprovedOrLeaveView, arguments: false);
  }

  void tapOnSeeMore() {
    Get.toNamed(AppRoutes.executiveAttendanceList, arguments: exeId);
  }

  void setRevenuePeriod(String p) {
    revenuePeriod = p;
    getExecutiveDashboard();
    update();
  }

  void setVisitsPeriod(String p) {
    visitsPeriod = p;
    getExecutiveDashboard();
    update();
  }
}
