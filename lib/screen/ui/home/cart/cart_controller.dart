import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/response/login_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/offline_cart_list.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends AppBaseController {
  final HomeController homeController = Get.find<HomeController>();

  final quantityTextController = TextEditingController();
  final quantityTextFocus = FocusNode();

  UserData? currentUserData;
  List<GetCartListData> cartList = [];
  List<GetCartListData> cartDeletedListItem = [];
  int? flag;
  late final  list ;

  init() async {
    // TODO: implement onInit
    var obj = SharedPre.getObjs(SharedPre.userData) ?? {};
    currentUserData = UserData.fromJson(obj);
    getDetails();
    getOfflineList();

  }
  @override
  void onInit() {
    // TODO: implement onInit
    init();
    super.onInit();
  }

  void tapOnDelete(int index) async {
    var item = cartList[index];
    list.removeWhere((element)
      => element.itemId == cartList[index].productid);
    await SharedPre.setValue(
        SharedPre.offlineCartList, json.encode(list));
    //cartDeletedListItem.add(item); /// using for manage product list cart color on back tap
    bool deleted = await removeFromCartAPI(itemId: item.id.toString());
    if (deleted) {
      cartList.removeAt(index);
      if(cartList.isEmpty){
        await SharedPre.clear(SharedPre.offlineCartList);
      }
      homeController.itemInCart.value = homeController.itemInCart.value-1 ;
      getDetails();
      update();
    }
  }

  void tapOnProcess() {
    if (cartList.isNotEmpty) {
      Get.toNamed(AppRoutes.yourOrder);
    } else {
      ShowMessage.showSnackBar('', 'Cart List is Empty');
      backTap();
    }
  }

  void getOfflineList() async{
    var list1 = await SharedPre.getStringValue(SharedPre.offlineCartList);
    if(list1.isNotEmpty) {
      var obj1 = json.decode(list1);
      list = obj1.map((model) => OfflineCart.fromJson(model)).toList();
    }
  }

  void tapOnProduct(String itemId) {
    Get.toNamed(AppRoutes.productDetails, arguments: itemId,);
  }

  void tapOnQuantityText(int index){
    for(var element in cartList){
      element.isTextField = false;
    }

    cartList[index].isTextField = true ;
    quantityTextController.clear();
    update();
  }

  void productQtyDecrease(int index) {
    cartList[index].quantity = (cartList[index].quantity?.toInt() ?? 0) - 1;
    cartListLength = cartListLength! - 1;

    var item = cartList[index];
    flag = 0;
    updateCartAPI(item.id.toString(), cartList[index].quantity.toString());
    update();
  }

  void productQtyDecreaseFromTextField(int index) {
    //cartList[index].quantity = int.parse(quantityTextController.text) - 1;
    quantityTextController.text = (double.parse(quantityTextController.text) - 1).toString();
    var item = cartList[index];
    flag = 0;
    /*updateCartAPI(item.id.toString(), cartList[index].quantity.toString());

    update();*/
    update();
  }


  void productQtyIncrease(int index) {
    cartList[index].quantity = (cartList[index].quantity?.toInt() ?? 0) + 1;
    cartListLength = cartListLength! + 1;
    var item = cartList[index];
    flag = 1;
    updateCartAPI(item.id.toString(), cartList[index].quantity.toString());
    update();
  }

  void productQtyIncreaseFromTextField(int index) {
   // cartList[index].quantity = int.parse(quantityTextController.text) + 1;
    quantityTextController.text = (double.parse(quantityTextController.text) + 1).toString();
    var item = cartList[index];
    flag = 1;
    /*updateCartAPI(item.id.toString(), cartList[index].quantity.toString());
    update();*/
    update();
  }

 void onSubmitTextFieldQty(String qty, int index){
if(quantityTextController.text.isNotEmpty && double.parse(quantityTextController.text) > 0){
  //cartList[index].quantity = int.parse(qty);
  var item = cartList[index];
  updateCartAPI(item.id.toString(), qty);
}else{
  ShowMessage.showSnackBar('MSG', 'QUANTITY MUST BE GRATER THEN 0');
}

 }


  Future<bool> updateCartAPI(String id, String qty) async {
    // UserData? currentUserData = await userDataController.getUserData;
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = currentUserData?.userid?.toString() ?? '';
      body[RequestKeys.compId] = currentUserData?.compId?.toString() ?? '';
      body[RequestKeys.id] = id;
      body[RequestKeys.quantity] = qty;

      var res = await api.updateCart(body);
      if (res.status == 200) {
        ShowMessage.showSnackBar('', res.message.toString());

        getDetails();
        update();
        return true;
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
        return false;
      }
    } catch (e) {
      ShowMessage.showSnackBar('', '$e');
      return false;
    } finally {}
  }

  Future<void> getDetails() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = currentUserData!.compId.toString();
      body[RequestKeys.userId] = currentUserData!.userid.toString();
      var res = await api.getCartList(body);
      if (res.status == 200) {
        cartList = res.data ?? [];
        cartListLength = cartList.length;
        SharedPre.setValue(SharedPre.cartListLength, cartListLength);
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
