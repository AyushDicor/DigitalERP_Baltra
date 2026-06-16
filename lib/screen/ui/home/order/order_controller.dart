import 'dart:convert';

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/response/cart_count_response.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/executive_order_list_response.dart';
import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/party_dropdown_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:get/get.dart';

class OrderController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  var decodedMap;
  int selectedSegmentVal = 0;
  bool isManager = false;
  bool isCustomer = false;
  String? fromDate, todate;
  PartyDropdownData? selectedPartyDropdownValue;
  ExecutiveDropdownData? selectedExecutiveDropdownValue;
  List<ExecutiveOrderData>? executiveOrderList = [];
  List<ExecutiveDropdownData> executiveList = [];
  List<PartyDropdownData> partyList = [];
  int? cartListCount;
  String? status;
  GetCartListResponse getCartListResp = GetCartListResponse();

  @override
  void onInit() async {
    // TODO: implement onInit
    isCustomer = homeController.currentUserData?.usertype.toString() == 'Customer';
    if (!(homeController.isCustomer ?? true)) {
      getExecutiveDropdownList();

    }
    getCartCount();
    getPartyDropdownList();
    getOrderList();

    super.onInit();

  }

  void setSelectedExecutiveNameDropdownValue(value) {
    selectedExecutiveDropdownValue = value;
    getOrderList();
    update();
  }

  void tapOnCard(String orderId) {
    Get.toNamed(AppRoutes.orderDetail, arguments: orderId)?.then((value) => setSegmentValue(selectedSegmentVal));
  }

  void onCartTap() {
    Get.toNamed(AppRoutes.cart);
  }

  void tapOnAdd() {
    Get.toNamed(AppRoutes.selectBrand);

    // Get.toNamed(AppRoutes.selectCategory);
  }

  setSegmentValue(int i) {
    selectedSegmentVal = i;
   status;
    if (i == 0) {
      status = 'Pending';
    } else if (i == 1) {
      status = 'Approved';
    } else {
      status = 'Rejected';
    }
    getOrderList(status: status);
    update();
  }


  void getExecutiveDropdownList() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '342613';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      var res = await api.getExecutiveDropdown(body);
      if (res.status == 200) {
        executiveList.addAll(res.data!);
        if (executiveList.length > 1) {
          isManager = true;
        } else {
          selectedExecutiveDropdownValue = executiveList.first;
        }
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getPartyDropdownList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '473693';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString() ?? '122';
      var res = await api.getPartyDropdownList(body);
      if (res.status == 200) {
        partyList.addAll(res.data!);
        selectedPartyDropdownValue = partyList.firstWhere(
              (element) => element.partyid == homeController.currentUserData!.accountCode,
          orElse: () => PartyDropdownData(),
        );
        print("===>${selectedPartyDropdownValue}");

        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {}
  }

  Future<void> getOrderList({String? status}) async {
    isListLoading = true;
    update();
    executiveOrderList?.clear();

    var customer = await SharedPre.getStringValue(SharedPre.selectedCustomer);
    if (customer.isNotEmpty) {
      decodedMap = CustomerListData.fromJson(json.decode(customer));
    }
    /// for testing purpose
    bool byOGParam = true;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = byOGParam ? homeController.currentUserData?.compId.toString() ?? '' : '39';
      body[RequestKeys.userId] = byOGParam ? homeController.currentUserData?.userid.toString() ?? '' : '342613';
      body[RequestKeys.fromDate] = byOGParam ? fromDate ?? getStartDateOfMonth(DateTime.now()) : '2022-04-16';
      body[RequestKeys.toDate] = byOGParam
          ? todate ?? formatDate(DateTime.now().toString(), AppString.dateTimeFormat, AppString.yyyyMMdd)
          : '2022-04-21';
      body[RequestKeys.partyId] = selectedPartyDropdownValue?.partyid!=null?selectedPartyDropdownValue?.partyid.toString() ?? '0' :"0";
      body[RequestKeys.Executiveid] = byOGParam ? selectedExecutiveDropdownValue?.executiveId.toString() ?? '0' : '0';
      body[RequestKeys.status] = byOGParam ? status ?? 'Pending' : '0';
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'';
      var res = await api.getExecutiveOrderList(body);
      if (res.status == 200) {
        print("===>OrderList");
        executiveOrderList?.addAll(res.data ?? []);
        executiveList.reversed;
      } else {
        // ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('catch Server Res', '$e');
    } finally {
      isListLoading = false;
      update();
    }
  }

  Future<void> getCartCount() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = homeController.currentUserData?.userid.toString() ?? '';
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '';
      CartCountResponse res = await api.getCartCount(body);
      if (res.status == 200) {
        homeController.itemInCart.value = res.data?.first.totalcartcount?.toInt() ?? homeController.itemInCart.value;
        //print('______________${itemInCart.value}_________');
      } else {
        //ShowMessage.showSnackBar('Failed Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Catch Server Res', '$e');
    } finally {}
  }
}
