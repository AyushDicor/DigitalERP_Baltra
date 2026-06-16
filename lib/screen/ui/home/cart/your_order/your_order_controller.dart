import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/customer_detail_response.dart';
import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/response/party_dropdown_list_response.dart';
import 'package:digitalerp/response/visit_plan_detail_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/cart_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrderController extends AppBaseController {
  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();
  final OrderController orderController = Get.find<OrderController>();

  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocus = FocusNode();

  ExecutiveDropdownData? selectedDropdownValue;
  final discountController = TextEditingController(text: 0.toString());
  final discountFocus = FocusNode();

  final cashDiscountController = TextEditingController(text: 0.toString());
  final cashDiscountFocus = FocusNode();

  PartyDropdownData? selectCompany;
  List <PartyDropdownData> partyList=[];
  bool? isCustomer;
  String? companyName;
  String? partyId;

  double subTotal = 0.0;
  double grandTotal = 0.0;
  String discountedValue = '';
  String cashDiscountedValue = '';
  String? customer;
  var customer2;
  CustomerListData? customerdecodedList;

  @override
  void onInit() async {
    // TODO: implement onInit
    getPartyDropdownList();
    isCustomer = homeController.currentUserData?.usertype.toString() == 'Customer';
    companyName = homeController.currentUserData?.name.toString();

    print("==>");


    super.onInit();
  }



  void setDropdownValue(ExecutiveDropdownData value) {
    selectedDropdownValue = value;
    update();
  }

  void discountCalculate(String value) {
    String patttern = r'^[1-9]([0-9]{0,1})([.][0-9]{1,3})?$';
    RegExp regExp = RegExp(patttern);
    discountedValue = value;
    if (value.isEmpty || !regExp.hasMatch(value)) {
      subTotal = double.parse('${cartController.cartList.first.subtotal}');
      grandTotal = subTotal;
      update();
    }
    if (value == '-value') {
      ShowMessage.showSnackBar('msgTitle', 'not  valid input');
    }
    int discountPercent = int.parse(value);

    int discountableAmount = double.parse('${cartController.cartList.first.subtotal}').toInt();
    subTotal = discountableAmount - (discountableAmount * discountPercent / 100);
    grandTotal = subTotal;
    update();
  }

  void cashDiscountCalculate(String value) {
    cashDiscountedValue = value;
    if (value.isEmpty) {
      grandTotal = subTotal;
      update();
    }
    int discountPercent = int.parse(value);
    grandTotal = subTotal - (subTotal * discountPercent / 100);
    update();
  }

  void tapOnSearch() {
    Get.toNamed(AppRoutes.selectCompany)?.then((value) => update());
  }

  Future<void> tapOnPlaceOrder() async {
    print( "selectCompany${selectCompany}");

    if (discountController.text.isEmpty) {
      ShowMessage.showSnackBar('Server Res', 'please fill discount value');
      discountFocus.requestFocus();
    } else if (cashDiscountController.text.isEmpty) {
      ShowMessage.showSnackBar('Server Res', 'please fill cash discount value');
      cashDiscountFocus.requestFocus();
    } else if (homeController.currentUserData?.usertype.toString() == 'Customer') {
      {
        setBusy(true);
        try {
          Map<String, String> body = {};
          body[RequestKeys.userId] = homeController.currentUserData!.userid.toString();
          body[RequestKeys.compId] = homeController.currentUserData!.compId.toString();
          body[RequestKeys.yearId] = homeController.currentUserData!.yearId.toString();
          body[RequestKeys.branchId] = homeController.currentUserData!.branchId.toString();
          body[RequestKeys.executiveId] = selectedDropdownValue?.executiveId.toString() ??
              homeController.currentUserData?.accountCode.toString() ?? "";
          body[RequestKeys.partyId] = selectCompany?.partyid.toString() ?? '0';
          body[RequestKeys.totalAmount] = cartController.cartList.first.subtotal.toString();
          body[RequestKeys.shippingAmount] = cartController.cartList[0].shippingamount.toString();
          body[RequestKeys.discountPercent] = discountedValue;
          body[RequestKeys.discountAmount] = subTotal.toString();
          body[RequestKeys.cashDiscountPercent] = cashDiscountedValue;
          body[RequestKeys.cashDiscountAmount] = grandTotal.toString();
          body[RequestKeys.grandTotal] = grandTotal.toString();


          var res = await api.orderPlace(body);
          if (res.status == 200) {
            Get.offAllNamed(AppRoutes.orderPlaced);
            homeController.itemInCart.value = 0;
          } else {
            ShowMessage.showSnackBar('Server Res', res.message.toString());
          }
        } catch (e) {
          ShowMessage.showSnackBar('Server Res', '$e');
        } finally {
          setBusy(false);
        }
      }
    } else if (selectCompany == null) {
      ShowMessage.showSnackBar('Server Res', AppString.pleaseSelectCompanyTxt);
    } else {
      setBusy(true);
      try {
        Map<String, String> body = {};
        body[RequestKeys.userId] = homeController.currentUserData!.userid.toString();
        body[RequestKeys.compId] = homeController.currentUserData!.compId.toString();
        body[RequestKeys.yearId] = homeController.currentUserData!.yearId.toString();
        body[RequestKeys.branchId] = homeController.currentUserData!.branchId.toString();
        body[RequestKeys.executiveId] = selectedDropdownValue?.executiveId.toString() ??
            homeController.currentUserData?.accountCode.toString() ??
            "";
        body[RequestKeys.partyId] = selectCompany?.partyid.toString() ?? '';
        body[RequestKeys.totalAmount] = cartController.cartList.first.subtotal.toString();
        body[RequestKeys.shippingAmount] = cartController.cartList[0].shippingamount.toString();
        body[RequestKeys.discountPercent] = discountedValue;
        body[RequestKeys.discountAmount] = subTotal.toString();
        body[RequestKeys.cashDiscountPercent] = cashDiscountedValue;
        body[RequestKeys.cashDiscountAmount] = grandTotal.toString();
        body[RequestKeys.grandTotal] = grandTotal.toString();
        var res = await api.orderPlace(body);
        if (res.status == 200) {
          Get.offAllNamed(AppRoutes.orderPlaced);
          homeController.itemInCart.value = 0;
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('Server Res', '$e');
      } finally {
        setBusy(false);
      }
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
        getCustomerData();
        partyList = res.data??[];
        partyList.addAll(res.data!);
        update();
      }
    } catch (e) {
      // ShowMessage.showSnackBar('Server Res', '$e');
    } finally {}
  }

  @override
  void onClose() {
    // TODO: implement onClose
    SharedPre.clear(SharedPre.selectedCustomer);
    SharedPre.clear(SharedPre.selectedCustomer2);
    super.onClose();
  }

  void getCustomerData() async {
    print("===>");
    customer = await SharedPre.getStringValue(SharedPre.selectedCustomer);
    print("===>1");
    print("account Code=>${homeController.currentUserData!.accountCode}");
    print("party Id=>${customer}");

    if (homeController.currentUserData?.usertype=="Customer" ?? false) {
      selectCompany = partyList.firstWhere(
            (element) => element.partyid == homeController.currentUserData!.accountCode,
        orElse: () => PartyDropdownData(),
      );
      update();
      print("selectCompany===> ${selectCompany?.partyid}");
      print("===>2");
      customerdecodedList = CustomerListData.fromJson(json.decode(customer!));


      print("selectCompany===> ${selectCompany?.partyid}");

      // Set the selected company
      // selectCompany = selectParty;
      update();
    } else {
      // If the first customer data is not available, fetch another customer data
      customer2 = await SharedPre.getObjs(SharedPre.selectedCustomer2);

      if (customer2 != null) {
        // Decode the JSON data into a VisitPlanDetailsDataList object
        var dataList = VisitPlanDetailsDataList.fromJson(customer2);

        // Manually create the PartyDropdownData from the retrieved VisitPlanDetailsDataList
        var selectParty = PartyDropdownData(
          partyid: dataList.partyid,
          partyname: dataList.customername,
        );

        selectCompany = selectParty;
        update();
      }
    }
  }

}
