import 'dart:convert';

import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/get_invoice_detail_res_model.dart';
import 'package:digitalerp/response/get_month_wise_sales_res_model.dart';
import 'package:digitalerp/response/get_sales_receipt_graph_res_model.dart';
import 'package:digitalerp/response/incentive_graph_detail_res_model.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/response/show_performance_graph_res_model.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/api.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GraphController extends GetxController {
  HomeController homeController = Get.find<HomeController>();
  static GraphController to = Get.find<GraphController>();
  List<ExecutiveDropdownData> executiveList = [];
  List<SalesReceiptData> salesReceiptData = [];
  List<MonthWiseSales> monthWiseSales = [];
  List<InvoiceDetailData> invoiceDetailData = [];
  List<PerformanceGraphData> performanceGraphData = [];
  List<IncentiveGraphData> incentiveGraphData = [];
  String? fromDate, todate;
  bool isSalesReceiptBarLoading = false;
  bool isLoading = false;
  bool isMonthWiseSalesLoading = false;
  bool isInvoiceDetailLoading = false;
  bool isPerformanceGraphLoading = false;
  bool isIncentiveGraphLoading = false;
  ExecutiveDropdownData? selectedExecutiveDropdownValue;
  UserData? currentUserData = UserData();

  @override
  Future<void> onInit() async {
    Get.put<HomeViewNewController>(HomeViewNewController());
    Get.put<HomeController>(HomeController());
    var obj = SharedPre.getObjs(SharedPre.userData) ?? {};
    currentUserData = UserData.fromJson(obj);
    print("obj====================> $obj");
    // currentUserData = UserData.fromJson(obj);
    getExecutiveDropdownList();

    super.onInit();
  }

  void setSelectedExecutiveNameDropdownValue(value) {
    selectedExecutiveDropdownValue = value;
    // getOrderList();
    update();
  }

  void getExecutiveDropdownList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] =
          currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] =
          currentUserData?.compId.toString() ?? '39';
      var res = await Api().getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList.addAll(res.data!);

        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }

  Future<void> getAllGraph() async {
    isLoading = true;
    update();
    await Future.wait([
      getSalesReceiptGraph(),
      showPerformanceGraph(),
      incentiveGraphDetail(),
    ]);
    isLoading = false;
    update();
  }

  Future<void> getSalesReceiptGraph() async {
    isSalesReceiptBarLoading = true;

    // update();
    salesReceiptData.clear();

    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam
          ? currentUserData?.compId.toString() ?? ''
          : '68';
      body[RequestKeys.branchId] = byOGParam
          ? currentUserData?.branchId.toString() ?? ''
          : '121';
      body[RequestKeys.userId] = byOGParam
          ? currentUserData?.userid.toString() ?? ''
          : '462675';

      body[RequestKeys.executiveid] = byOGParam
          ? selectedExecutiveDropdownValue?.executiveId.toString() ?? '0'
          : '226566';
      body[RequestKeys.fromDate] = byOGParam
          ? fromDate ?? getStartDateOfMonth(DateTime.now())
          : '2024-04-01';
      body[RequestKeys.toDate] = byOGParam
          ? (todate ??
              formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
                  AppString.yyyyMMdd))
          : '2024-08-14';
      var res = await Api().getSalesReceiptGraph(body);
      if (res.status == 200) {
        print("===>OrderList");
        salesReceiptData = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isSalesReceiptBarLoading = false;
      update();
    }
  }

  Future<void> getMonthWiseSales(
      {required String month, required String flag}) async {
    isMonthWiseSalesLoading = true;

    update();
    monthWiseSales.clear();

    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam
          ? currentUserData?.compId.toString() ?? ''
          : '68';
      body[RequestKeys.branchId] = byOGParam
          ? currentUserData?.branchId.toString() ?? ''
          : '121';
      body[RequestKeys.userId] = byOGParam
          ? currentUserData?.userid.toString() ?? ''
          : '462675';

      body[RequestKeys.executiveid] = byOGParam
          ? selectedExecutiveDropdownValue?.executiveId.toString() ?? '0'
          : '226566';
      body[RequestKeys.fromDate] = byOGParam
          ? fromDate ?? getStartDateOfMonth(DateTime.now())
          : '2024-04-01';
      body[RequestKeys.toDate] = byOGParam
          ? (todate ??
              formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
                  AppString.yyyyMMdd))
          : '2024-08-14';
      body[RequestKeys.month] = byOGParam ? month : 'August';
      body[RequestKeys.flag] = byOGParam ? flag : 'Sales';
      var res = await Api().getMonthWiseSales(body);
      if (res.status == 200) {
        print("===>monthWiseSales");
        monthWiseSales = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isMonthWiseSalesLoading = false;
      update();
    }
  }

  Future<void> getInvoiceDetail(String invoiceId) async {
    isInvoiceDetailLoading = true;

    update();
    invoiceDetailData.clear();

    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam
          ? currentUserData?.compId.toString() ?? ''
          : '68';
      body[RequestKeys.branchId] = byOGParam
          ? currentUserData?.branchId.toString() ?? ''
          : '121';
      body[RequestKeys.userId] = byOGParam
          ? currentUserData?.userid.toString() ?? ''
          : '462675';

      body[RequestKeys.invoiceid] = byOGParam ? invoiceId : '585118';
      body[RequestKeys.toDate] = byOGParam
          ? (todate ??
              formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
                  AppString.yyyyMMdd))
          : '2024-08-14';
      var res = await Api().getInvoiceDetail(body);
      if (res.status == 200) {
        print("===>invoiceDetailData");
        invoiceDetailData = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isInvoiceDetailLoading = false;
      update();
    }
  }

  Future<void> showPerformanceGraph() async {
    isPerformanceGraphLoading = true;
    // update();
    performanceGraphData.clear();

    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam
          ? currentUserData?.compId.toString() ?? ''
          : '68';
      body[RequestKeys.branchId] = byOGParam
          ? currentUserData?.branchId.toString() ?? ''
          : '121';
      body[RequestKeys.userId] = byOGParam
          ? currentUserData?.userid.toString() ?? ''
          : '462675';
      body[RequestKeys.yearId] = byOGParam
          ? currentUserData?.yearId.toString() ?? ''
          : '2024-25';

      body[RequestKeys.executiveid] = byOGParam
          ? selectedExecutiveDropdownValue?.executiveId.toString() ?? '0'
          : '226566';
      body[RequestKeys.fromDate] = byOGParam
          ? fromDate ?? getStartDateOfMonth(DateTime.now())
          : '2024-04-01';
      body[RequestKeys.toDate] = byOGParam
          ? (todate ??
              formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
                  AppString.yyyyMMdd))
          : '2024-08-14';
      var res = await Api().showPerformanceGraph(body);
      if (res.status == 200) {
        print("===>showPerformanceGraph");
        performanceGraphData = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isPerformanceGraphLoading = false;
      update();
    }
  }

  Future<void> incentiveGraphDetail() async {
    isIncentiveGraphLoading = true;
    // update();
    incentiveGraphData.clear();

    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam
          ? currentUserData?.compId.toString() ?? ''
          : '68';
      body[RequestKeys.branchId] = byOGParam
          ? currentUserData?.branchId.toString() ?? ''
          : '121';
      body[RequestKeys.userId] = byOGParam
          ? currentUserData?.userid.toString() ?? ''
          : '462675';
      body[RequestKeys.executiveid] = byOGParam
          ? selectedExecutiveDropdownValue?.executiveId.toString() ?? '0'
          : '226566';
      body[RequestKeys.fromDate] = byOGParam
          ? fromDate ?? getStartDateOfMonth(DateTime.now())
          : '2024-04-01';
      body[RequestKeys.toDate] = byOGParam
          ? (todate ??
              formatDate(DateTime.now().toString(), AppString.dateTimeFormat,
                  AppString.yyyyMMdd))
          : '2024-08-14';
      var res = await Api().incentiveGraphDetail(body);
      if (res.status == 200) {
        print("===>incentiveGraphDetail");
        incentiveGraphData = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isIncentiveGraphLoading = false;
      update();
    }
  }

  String getStartDateOfMonth(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd')
        .format(DateTime(dateTime.year, dateTime.month, 1));
  }
}
