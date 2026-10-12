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
import 'package:digitalerp/utils/order_edit_session.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourOrderController extends AppBaseController {
  final CartController cartController = Get.find<CartController>();
  final HomeController homeController = Get.find<HomeController>();
  // Read by the executive dropdown on the Select Company screen.
  final OrderController orderController = Get.find<OrderController>();

  final TextEditingController searchController = TextEditingController();

  final FocusNode searchFocus = FocusNode();

  ExecutiveDropdownData? selectedDropdownValue;
  final discountController = TextEditingController(text: '0');
  final discountFocus = FocusNode();

  final cashDiscountController = TextEditingController(text: '0');
  final cashDiscountFocus = FocusNode();

  PartyDropdownData? selectCompany;
  List<PartyDropdownData> partyList = [];
  bool? isCustomer;
  String? companyName;
  String? partyId;

  /// Set when checking out an existing order that was loaded for editing.
  /// The party is then fixed to the order's party and saving calls
  /// placeorderedit instead of orderentry.
  OrderEditSession? editSession;
  bool get isEditing => editSession != null;

  String? customer;
  var customer2;
  CustomerListData? customerdecodedList;

  // ---------------------------------------------------------------- totals

  /// Cart value before discounts, as computed by the server.
  double get amount {
    final rows = cartController.cartList;
    if (rows.isEmpty) return 0.0;
    final server = rows.first.subtotal ?? 0.0;
    if (server > 0) return server;
    return rows.fold<double>(0, (s, e) => s + (e.total ?? 0));
  }

  double get shipping => cartController.cartList.isEmpty
      ? 0.0
      : (cartController.cartList.first.shippingamount ?? 0.0);

  double get discountPercent => _percent(discountController.text);
  double get cashDiscountPercent => _percent(cashDiscountController.text);

  double get discountValue => amount * discountPercent / 100;

  /// Amount after the trade discount.
  double get subTotal => amount - discountValue;

  double get cashDiscountValue => subTotal * cashDiscountPercent / 100;

  double get grandTotal => subTotal - cashDiscountValue;

  double get totalQty => cartController.cartList
      .fold<double>(0, (s, e) => s + (e.quantity ?? 0));

  double _percent(String s) {
    final v = double.tryParse(s.trim()) ?? 0;
    return v.clamp(0, 99).toDouble();
  }

  @override
  void onInit() async {
    editSession = OrderEditSession.current;
    isCustomer =
        homeController.currentUserData?.usertype.toString() == 'Customer';
    companyName = homeController.currentUserData?.name.toString();

    if (editSession != null) {
      // Party can't change on an existing order.
      selectCompany = PartyDropdownData(
        partyid: int.tryParse(editSession!.partyId),
        partyname: editSession!.partyName,
      );
    } else {
      getPartyDropdownList();
    }

    super.onInit();
  }

  void setDropdownValue(ExecutiveDropdownData value) {
    selectedDropdownValue = value;
    update();
  }

  // Both fields only feed the getters above; the old versions threw a
  // FormatException whenever a field was cleared.
  void discountCalculate(String value) => update();

  void cashDiscountCalculate(String value) => update();

  void tapOnSearch() {
    if (isEditing) return;
    Get.toNamed(AppRoutes.selectCompany)?.then((value) => update());
  }

  /// Fields shared by orderentry and placeorderedit. Note the server's
  /// naming: discountamount carries the subtotal AFTER discount and cdamount
  /// the grand total — kept exactly as the app has always sent them.
  Map<String, String> _orderBody() {
    final user = homeController.currentUserData!;
    return {
      RequestKeys.userId: user.userid.toString(),
      RequestKeys.compId: user.compId.toString(),
      RequestKeys.yearId: user.yearId.toString(),
      RequestKeys.branchId: user.branchId.toString(),
      RequestKeys.executiveId: selectedDropdownValue?.executiveId.toString() ??
          user.accountCode?.toString() ??
          '',
      RequestKeys.partyId: selectCompany?.partyid?.toString() ?? '0',
      RequestKeys.totalAmount: amount.toString(),
      RequestKeys.shippingAmount: shipping.toString(),
      RequestKeys.discountPercent: _fmtPercent(discountPercent),
      RequestKeys.discountAmount: subTotal.toString(),
      RequestKeys.cashDiscountPercent: _fmtPercent(cashDiscountPercent),
      RequestKeys.cashDiscountAmount: grandTotal.toString(),
      RequestKeys.grandTotal: grandTotal.toString(),
    };
  }

  String _fmtPercent(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toString();

  Future<void> tapOnPlaceOrder() async {
    if (isBusy) return;
    if (cartController.cartList.isEmpty) {
      ShowMessage.showSnackBar('Order', 'Your cart is empty');
      return;
    }
    final isCustomerUser = isCustomer ?? false;
    if (!isEditing && !isCustomerUser && selectCompany == null) {
      ShowMessage.showSnackBar('Order', AppString.pleaseSelectCompanyTxt);
      return;
    }

    setBusy(true);
    try {
      final body = _orderBody();
      if (isEditing) {
        final res = await api.placeOrderEdit({
          'orderid': int.tryParse(editSession!.orderId) ?? editSession!.orderId,
          ...body,
        });
        if (res.status == 200) {
          await OrderEditSession.clear();
          homeController.itemInCart.value = 0;
          Get.offAllNamed(AppRoutes.orderPlaced, arguments: 'edited');
        } else {
          ShowMessage.showSnackBar(
              'Update Order', res.message ?? 'Could not update the order');
        }
      } else {
        final res = await api.orderPlace(body);
        if (res.status == 200) {
          Get.offAllNamed(AppRoutes.orderPlaced);
          homeController.itemInCart.value = 0;
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
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
        // Previously also did partyList.addAll(res.data!) on the same list,
        // doubling every party.
        partyList = res.data ?? [];
        getCustomerData();
        update();
      }
    } catch (e) {
      // ShowMessage.showSnackBar('Server Res', '$e');
    } finally {}
  }

  @override
  void onClose() {
    SharedPre.clear(SharedPre.selectedCustomer);
    SharedPre.clear(SharedPre.selectedCustomer2);
    discountController.dispose();
    cashDiscountController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void getCustomerData() async {
    customer = await SharedPre.getStringValue(SharedPre.selectedCustomer);

    if (homeController.currentUserData?.usertype == "Customer") {
      selectCompany = partyList.firstWhere(
        (element) =>
            element.partyid == homeController.currentUserData!.accountCode,
        orElse: () => PartyDropdownData(),
      );
      if ((customer ?? '').isNotEmpty) {
        try {
          customerdecodedList =
              CustomerListData.fromJson(json.decode(customer!));
        } catch (_) {}
      }
      update();
    } else {
      // Order started from a visit plan: pre-select that customer.
      customer2 = await SharedPre.getObjs(SharedPre.selectedCustomer2);

      if (customer2 != null) {
        var dataList = VisitPlanDetailsDataList.fromJson(customer2);
        selectCompany = PartyDropdownData(
          partyid: dataList.partyid,
          partyname: dataList.customername,
        );
        update();
      }
    }
  }
}
