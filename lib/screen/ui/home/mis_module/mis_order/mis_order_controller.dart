import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/get_order_report_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_pending_shipping_resp.dart';
import 'package:digitalerp/response/get_shipping_status_resp.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:intl/intl.dart';

class MisOrderController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  List<CustomerListData>? partyList;
  List<String> statusList=['Pending', 'Approved', 'Rejected'];
  List<GetOrderReportData> orderReportList = [];
  CustomerListData? selectedPartyValue;
  String? selectedStatusValue;
  String selectFromDate = AppString.dateTimeEmpty, selectToDate = AppString.dateTimeEmpty;
  List<ExecutiveDropdownData>? executiveDropdownList;
  ExecutiveDropdownData? selectedExecutiveValue;

  @override
  void onInit() async {
    final now = DateTime.now();
    selectFromDate = DateFormat('dd-MM-yyyy').format(now.subtract(const Duration(days: 10)));
    selectToDate = DateFormat('dd-MM-yyyy').format(now);

    // Run both dropdown fetches in parallel instead of sequentially
    await Future.wait([
      getCustomerList(),
      getExecutiveDropdownList(),
    ]);

    // Then fetch report
    getOrderReportList();
    super.onInit();
  }

  void setExecutiveValue(ExecutiveDropdownData? value) {
    selectedExecutiveValue = value;
    update();
  }

  Future<void> getExecutiveDropdownList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '',
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '',
      };
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveDropdownList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('getExecutiveDropdown error', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }

  void hideLoader() {
    if (partyList != null && executiveDropdownList != null && statusList != null) {
      setBusy(false);
    }
  }

  void setStatusValue(String? selectedStatusValue) {
    this.selectedStatusValue = selectedStatusValue;
    update();
  }

  void setPartyValue(CustomerListData? value) {
    selectedPartyValue = value;
    update();
  }

  Future<void> getOrderReportList() async {
    try {
      isBusy = true;
      update();

      String fromDate = formatDate(selectFromDate, 'dd-MM-yyyy', 'yyyy-MM-dd');
      String toDate = formatDate(selectToDate, 'dd-MM-yyyy', 'yyyy-MM-dd');

      print('>>> FROM: $selectFromDate → $fromDate');
      print('>>> TO: $selectToDate → $toDate');

      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.executiveId: selectedExecutiveValue?.executiveId.toString() ?? '0',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '0',
        RequestKeys.status: selectedStatusValue?.toLowerCase() ?? '0',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
      };

      print('>>> BODY: $body');

      var res = await api.getOrderReport(body);
      print('>>> RES STATUS: ${res.status}');
      print('>>> RES DATA: ${res.data}');

      if (res.status == 200) {
        orderReportList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      print('>>> ERROR: $e');
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }



  Future<void> getCustomerList() async {
    try {
      Map<String, String> body = {
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.executiveId: '0',
      };
      var res = await api.getCustomersDetail(body);
      if (res.status == 200) {
        partyList = res.data ?? [];
        for (var element in partyList ?? []) {
          if (element.partyid.toString() == Get.arguments) {
            selectedPartyValue = element;
            break;
          }
        }
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }

  void setSelectedFromDate(String value) {
    selectFromDate = value;
    update();
  }

  void setSelectedToDate(String value) {
    selectToDate = value;
    update();
  }

  // void onSearch() async {
  //   if (selectFromDate == AppString.dateTimeEmpty) {
  //     ShowMessage.showSnackBar('Please check', 'Please select FromDate');
  //   } else if (selectToDate == AppString.dateTimeEmpty) {
  //     ShowMessage.showSnackBar('Please check', 'Please select ToDate');
  //   } else {
  //     orderReportList=[];
  //     update();
  //     getOrderReportList();
  //   }
  // }

  void onSearch() async {
    orderReportList = [];
    update();
    getOrderReportList();
  }
}
