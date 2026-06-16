import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_pending_shipping_resp.dart';
import 'package:digitalerp/response/get_shipping_status_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class PendingShippingController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  List<CustomerListData> partyList = [];
  List<GetShippingStatusData> statusList = [];
  List<GetPendingShippingData> pendingShippingList = [];
  CustomerListData? selectedPartyValue;
  GetShippingStatusData? selectedStatusValue;
  String selectFromDate = AppString.dateTimeEmpty, selectToDate = AppString.dateTimeEmpty;

  @override
  void onInit() async {
    final now = DateTime.now();
    selectFromDate = DateFormat('dd-MM-yyyy').format(now.subtract(const Duration(days: 10)));
    selectToDate = DateFormat('dd-MM-yyyy').format(now);

    // Load both dropdowns in parallel
    await Future.wait([
      getStatusList(),
      getCustomerList(),
    ]);

    // Auto-fetch results
    await getPendingShippingList();
    super.onInit();
  }

  Future<void> getStatusList() async {
    try {
      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
      };
      var res = await api.getShippingStatus(body);
      if (res.status == 200) {
        statusList = res.data ?? [];
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
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
        for (var element in partyList) {
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

  Future<void> getPendingShippingList() async {
    try {
      isBusy = true;
      update();

      String fromDate = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(selectFromDate));
      String toDate = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(selectToDate));

      Map<String, String> body = {
        RequestKeys.compId: homeController.currentUserData?.compId.toString() ?? '39',
        RequestKeys.branchId: homeController.currentUserData?.branchId.toString() ?? '39',
        RequestKeys.userId: homeController.currentUserData?.userid.toString() ?? '342613',
        RequestKeys.partyId: selectedPartyValue?.partyid.toString() ?? '',
        RequestKeys.statusId: selectedStatusValue?.statusid.toString() ?? '',
        RequestKeys.fromDate: fromDate,
        RequestKeys.toDate: toDate,
      };

      var res = await api.getPendingShipping(body);
      if (res.status == 200) {
        pendingShippingList = res.data ?? [];
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  void setStatusValue(GetShippingStatusData? value) {
    selectedStatusValue = value;
    update();
  }

  void setPartyValue(CustomerListData? value) {
    selectedPartyValue = value;
    update();
  }

  void setSelectedFromDate(String value) {
    selectFromDate = value;
    update();
  }

  void setSelectedToDate(String value) {
    selectToDate = value;
    update();
  }

  void onSearch() async {
    pendingShippingList = [];
    update();
    getPendingShippingList();
  }
}
