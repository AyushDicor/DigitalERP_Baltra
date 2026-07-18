import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/dashboard_details_response.dart';
import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/graph/graph_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class DashboardController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();
  static DashboardController to = Get.find<DashboardController>();
  RxBool isLoading = false.obs;
  // RxInt unApprovalCount = 0.obs;
  bool isManager = false;
  String? executiveId;
  var dio = Dio();

  String? dsrPdfPrintUrl;
  final isPrintDsr = RxBool(false);

  String? earnPoint = '0';
  String? usedPoint = '0';
  String? balance = '0';
  List<DashboardDetailsData>? dashboardDetailsData = [];
  List<ExecutiveDropdownData>? dropdownList = [];

  // Baltra dashboard: live counts from the Orders + Party List APIs.
  int orderCount = 0;
  int partyCount = 0;

  ///for saving offline cart list from calling cartlistApi
  List offlineCartList = [];
  List<GetCartListData> onlineCartList = [];
  List totalCount = [];

  ExecutiveDropdownData? selectedDropdownValue;

  void setSelectDropdownValue(ExecutiveDropdownData value) {
    selectedDropdownValue = value;
    getDashboardDetails(value.executiveId.toString());
    update();
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 100));
    executiveId = homeController.currentUserData!.accountCode.toString();

    if (!(homeController.isCustomer ?? true)) {
      // For managers: wait for dropdown, then load dashboard with correct ID
      await getDropdownList();
    } else {
      // For customers: load directly
      getDashboardDetails(executiveId!);
    }

    getCartList();
    fetchBaltraCounts();
    super.onInit();
  }

  // Baltra: live Order + Visit counts for the static dashboard.
  String _ymd(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> fetchBaltraCounts() async {
    final now = DateTime.now();
    final monthStart = _ymd(DateTime(now.year, now.month, 1));

    // Orders — same request the Orders module uses.
    try {
      final body = <String, String>{
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.fromDate: monthStart,
        RequestKeys.toDate: _ymd(now),
        RequestKeys.partyId: '0',
        RequestKeys.Executiveid: '0',
        RequestKeys.status: 'Pending',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      final res = await api.getExecutiveOrderList(body);
      if (res.status == 200) {
        orderCount = (res.data ?? []).length;
      }
    } catch (_) {}

    // Parties — same request the Party List module uses.
    try {
      final body = <String, String>{
        RequestKeys.userId:
            homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId:
            homeController.currentUserData?.compId.toString() ?? '',
        RequestKeys.executiveId: '0',
        RequestKeys.branchId:
            homeController.currentUserData?.branchId.toString() ?? '',
      };
      final res = await api.getPartyWithBranch(body);
      if (res.status == 200) {
        partyCount = (res.data ?? []).length;
      }
    } catch (_) {}

    update();
  }

  Future<void> getDashboardDetails(String executiveId) async {
    isLoading.value = true;
    dashboardDetailsData?.clear();
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      if (!(homeController.isCustomer ?? true)) {
        body[RequestKeys.executiveId] = executiveId;
      }
      var res = await api.getDashboardDetails(body);

      // if (res.status == 200) {
      //   dashboardDetailsData?.addAll(res.data!);
      //   update();
      //   // ✅ Guard before accessing index [0]
      //   if (dashboardDetailsData != null && dashboardDetailsData!.isNotEmpty) {
      //     dashBoardDetail();
      //   }
      // } else {
      //   if (res.message != null && res.message!.isNotEmpty) {
      //     ShowMessage.showSnackBar('Dashboard Error', res.message ?? '');
      //   }
      // }
      if (res.status != 200) {
        debugPrint("Dashboard API not ready: ${res.message}");
        return;
      }

// ✅ continue normal flow
      dashboardDetailsData?.addAll(res.data ?? []);
      update();

      if (dashboardDetailsData != null && dashboardDetailsData!.isNotEmpty) {
        dashBoardDetail();
      }
      update();
    } catch (e) {
      ShowMessage.showSnackBar('Error', 'Server error occurred');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // Future<void> getUnApprovalCount() async {
  //   setBusy(true);
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.compId] = homeController.currentUserData!.compId.toString();
  //     body[RequestKeys.userId] = homeController.currentUserData!.userid.toString();
  //     body[RequestKeys.branchId] = homeController.currentUserData!.branchId.toString();
  //     var res = await api.getUnApprovalCount(body);
  //     if (res.status == 200) {
  //       unApprovalCount.value = res.data?.first.counttotalunapproved?.toInt() ?? 0;
  //       // unApprovalCount = res.data ?? [];
  //       // for (int i = 0; i <= unApprovalCount.length - 1; i++) {
  //       //   totalCount.add({"itemid": unApprovalCount[i].counttotalunapproved});
  //
  //       // await SharedPre.setValue(SharedPre.unApprovalCount, json.encode(unApprovalCount));
  //     } else {
  //       ShowMessage.showSnackBar('getUnApprovalCount res.status not 200', res.message.toString());
  //     }
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Server Res', '$e');
  //   } finally {
  //     setBusy(false);
  //   }
  // }

  Future<void> getDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      var res = await api.getExecutiveDropdown(body);

      if (res.status != 200) {
        debugPrint("Dropdown API not ready: ${res.message}");
        // Fallback to accountCode if dropdown fails
        getDashboardDetails(executiveId!);
        return;
      }

      dropdownList?.addAll(res.data ?? []);

      if (dropdownList?.length == 1) {
        // Only one executive — auto-select
        setSelectDropdownValue(dropdownList!.first);
      } else {
        isManager = true;
        // ✅ Auto-match logged-in user's executiveId from dropdown
        final myAccountCode = homeController.currentUserData?.accountCode.toString();
        final match = dropdownList?.firstWhereOrNull(
              (e) => e.executiveId.toString() == myAccountCode,
        );
        if (match != null) {
          setSelectDropdownValue(match); // This calls getDashboardDetails internally
        } else if (dropdownList != null && dropdownList!.isNotEmpty) {
          // Fallback: use first item
          setSelectDropdownValue(dropdownList!.first);
        } else {
          getDashboardDetails(executiveId!);
        }
      }
      update();
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
      getDashboardDetails(executiveId!); // fallback
    } finally {
      setBusy(false);
    }
  }

  void tapOnMap() {
    Get.toNamed(AppRoutes.map);
  }

  Future<void> tapOnPrintDSR() async {
    try {
      isPrintDsr.value = true;
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.userId] =
          homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.branchId] =
          homeController.currentUserData?.branchId.toString() ?? '';
      body[RequestKeys.yearId] =
          homeController.currentUserData?.yearId.toString() ?? '';
      body[RequestKeys.executiveId] =
          selectedDropdownValue?.executiveId.toString() ?? '';
      var res = await api.getDSRPdf(body);
      if (res.success ?? false) {
        dsrPdfPrintUrl = res.data?.first.url;

        /// new way
        downloadAndSharePdfFile(
          downloadUrl: dsrPdfPrintUrl ?? '',
          pdfFileName: 'dsrFile${DateTime.now().millisecond}',
        ).then((value) => isPrintDsr.value = false);

        /// old way
        /*
        shareAndDownloadPdfFile(dsrPdfPrintUrl);
         */
        ShowMessage.showSnackBar('Success Server Res', res.message.toString());
      } else {
        ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {}
  }

  // void shareAndDownloadPdfFile(String? downloadUrl) async {
  //   PermissionStatus storagePermission = await Permission.storage.request();
  //
  //   if (storagePermission == PermissionStatus.granted) {
  //     String path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  //
  //     String fullPath = "$path/dsrFile${DateTime.now().millisecond}.pdf";
  //
  //     try {
  //       ///this is for download the file to server through Url.
  //       var response = await dio.get(
  //         downloadUrl!,
  //         onReceiveProgress: ((count, total) => showDownloadProgress(count, total)),
  //         //Received data with List<int>
  //         options: Options(
  //             responseType: ResponseType.bytes,
  //             followRedirects: false,
  //             validateStatus: (status) {
  //               return status! < 500;
  //             }),
  //       );
  //
  //       ///below process for save the downloaded file in device.
  //
  //       File file = File(fullPath);
  //       var raf = file.openSync(mode: FileMode.write);
  //       raf.writeFromSync(response.data);
  //       await raf.close();
  //       isPrintDsr.value = false;
  //       //update();
  //       Share.shareFiles([file.path]);
  //     } catch (e) {
  //       debugPrint(e.toString());
  //     }
  //   } else if (storagePermission == PermissionStatus.denied) {
  //     ShowMessage.showSnackBar('Recommended', 'This Permission is recommended');
  //   } else if (storagePermission == PermissionStatus.permanentlyDenied) {
  //     openAppSettings().then((value) {
  //       isPrintDsr.value = false;
  //     });
  //   }
  // }

  void dashBoardDetail() {
    // ✅ Double-guard here too
    if (dashboardDetailsData == null || dashboardDetailsData!.isEmpty) return;

    earnPoint = dashboardDetailsData![0].documentNumber?.toString() ?? '0';
    usedPoint = dashboardDetailsData![0].description?.toString() ?? '0';
    balance = dashboardDetailsData![0].executiveName?.toString() ?? '0';
    update();
  }

  Future<void> getCartList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData!.compId.toString();
      body[RequestKeys.userId] =
          homeController.currentUserData!.userid.toString();
      var res = await api.getCartList(body);
      // if (res.status != 200) {
      //   if (res.message != null && res.message!.isNotEmpty) {
      //     ShowMessage.showSnackBar('Cart Error', res.message!);
      //   }
      // } else {
      //   ShowMessage.showSnackBar(
      //       'getCartList res.status not 200', res.message ?? '');
      // }
      if (res.status != 200) {
        debugPrint("Cart API issue: ${res.message}");
        return;
      }
      onlineCartList = res.data ?? [];
      // ✅ correct success flow

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }
}
