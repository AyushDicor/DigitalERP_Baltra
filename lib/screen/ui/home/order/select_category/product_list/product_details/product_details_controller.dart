import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/product_detail_response.dart';
import 'package:digitalerp/response/related_product_response.dart';
import 'package:digitalerp/response/unit_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/cart_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/cart_view.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/offline_cart_list.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends AppBaseController {
  final HomeController _homeController = Get.find<HomeController>();
  final quantityTextController = TextEditingController();
  final variantQuantityTextController = TextEditingController();
  final quantityTextFocus = FocusNode();
  final variantQuantityTextFocus = FocusNode();
  RxBool isInCart = false.obs;
  ProductDetailsData? productDetailsResponse;
  var selectedIndexValue = 0;
  int? indexOfSelectedValue;
  RxBool isTextField = false.obs;

  int productQty = 2;
  String? productCode;
  int? cartListCount;
  int? myCartItemCount;
  var selectedUnit;
  var selectedUnit2;
  String? rate;

  double variantFinalValue = 0.0;
  double prductdeatailPrice = 0.0;
  RxDouble totalAmount = 0.0.obs;

  var unitId;
  List<UnitListData> unitList = [];
  List<RelatedProductList> itemVariantList = [];

  @override
  void onInit() async {
    // TODO: implement onInit
    productCode = Get.arguments;
    cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
    getDetails();
    getRelatedProduct();
    super.onInit();
  }

  Future<void> getDetails() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.itemId] = productCode ?? '12';
      var res = await api.productDetail(body);
      if (res.status == 200) {
        productDetailsResponse = res.data?[0];
        checkItemInCart();
        getUnits();
      } else {
        productDetailsResponse = null;
        ShowMessage.showSnackBar('productDetail Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('productDetail Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> checkItemInCart() async {
    var list1 = await SharedPre.getStringValue(SharedPre.offlineCartList);
    if (list1.isNotEmpty) {
      var obj1 = json.decode(await SharedPre.getStringValue(SharedPre.offlineCartList));

      var list = obj1.map((model) => OfflineCart.fromJson(model)).toList();

      list.forEach((element) {
        if (element.itemId == int.parse(productCode ?? '0')) {
          isInCart.value = true;
        } else {
          //isInCart.value = false;
        }
      });
    } else {
      isInCart.value = false;
    }
  }

  void tapOnCart2() {
    Get.toNamed(AppRoutes.cart)?.then((value) {
      getDetails();
    });
  }

  Future<void> getUnits() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.itemId] = productCode ?? '12';
      var res = await api.unitDetail(body);
      if (res.status == 200) {
        unitList.clear();
        unitList.addAll(res.data ?? []);
        final value = unitList.toSet().toList();
        selectedUnit = value.first;
        calculateFinalAmount();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getRelatedProduct() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '';
      body[RequestKeys.itemId] = productCode ?? '12'; //242604.toString();
      var res = await api.relatedProducts(body);
      if (res.status == 200) {
        itemVariantList = res.data ?? [];
        _variantUnitSelection();
      } else if (res.status == 500) {
        itemVariantList = [];
      } else {
        ShowMessage.showSnackBar('relatedProducts Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('relatedProducts Server Res', '$e');
    } finally {
      setBusy(false);
    }
  }

  /// TO show selected unit value in variant list //First time only
  void _variantUnitSelection() {
    for (int i = 0; i < itemVariantList.length; i++) {
      for (var value in unitList) {
        if (itemVariantList[i].unitid == value.unitid) {
          itemVariantList[i].selectedUnit = value;
          break;
        }
      }
    }
    //calculateTotalPrice();
  }

  ///
  String variantRate(int index) {
    if (itemVariantList[index].selectedUnit == null) {
      rate = itemVariantList[index].rate?.toStringAsFixed(2);
      return rate!;
    }
    rate = itemVariantList[index].selectedUnit?.rate.toString() ?? '';
    return rate!;
  }

  void calculateTotalPriceOfIncreasedVariantQuantity(int i) {
    double? value;
    if (itemVariantList[i].quantity! > 0) {
      value = itemVariantList[i].selectedUnit?.rate;
      value ??= itemVariantList[i].rate;
      final realvalue = itemVariantList[i].quantity! * (value ?? 0.0);
      variantFinalValue = (realvalue + variantFinalValue) - ((itemVariantList[i].quantity! - 1) * (value ?? 0.0));
    }

    calculateFinalAmount();

    //for loop to calculate total price of variant
    // add price of product also
  }

  void calculateTotalPriceOfDecreasedVariantQuantity(int i) {
    double? value;
    if (itemVariantList[i].quantity! > 0) {
      value = itemVariantList[i].selectedUnit?.rate;
      value ??= itemVariantList[i].rate;
      final realvalue = itemVariantList[i].quantity! * (value ?? 0.0);
      variantFinalValue = (realvalue + variantFinalValue) - ((itemVariantList[i].quantity! + 1) * (value ?? 0.0));
    } else {
      variantFinalValue = variantFinalValue - itemVariantList[i].rate!;
    }
    calculateFinalAmount();

    //for loop to calculate total price of variant
    // add price of product also
  }

  void onChangeQuantityText(String value) {
    productDetailsResponse?.quantity = double.parse(value);

    if (unitList.isEmpty) {
      totalAmount = (double.parse(productDetailsResponse?.quantity.toString() ?? '') *
              double.parse(productDetailsResponse?.rate.toString() ?? ''))
          .obs;
    } else {
      calculateFinalAmount();
    }
    update();
  }

  void onChangeVariantQuantityText(String value, int index) {
    double? tempAmmount = variantFinalValue;
    double? value2;
    itemVariantList[index].quantity = double.parse(value);
    value2 = itemVariantList[index].selectedUnit?.rate;
    value2 ??= itemVariantList[index].rate;
    variantFinalValue = itemVariantList[index].quantity! * (value2 ?? 0.0) + tempAmmount;
    calculateFinalAmount();
    update();
  }

  void tapOnQuantityText() {
    isTextField.value = true;
  }

  void tapOnVariantQuantityText(int index) {
    for (var element in itemVariantList) {
      element.isTextField = false;
    }
    variantQuantityTextController.clear();
    itemVariantList[index].isTextField = true;
    isInCart = false.obs;
    update();
  }

  void calculateFinalAmount() {
    prductdeatailPrice =
        (unitList[selectedIndexValue].rate ?? 0) * double.parse(productDetailsResponse?.quantity.toString() ?? '');

    totalAmount = (prductdeatailPrice + variantFinalValue).obs;
  }

  void addItem() async {
    if ((productDetailsResponse?.quantity ?? 0) < 0 || productDetailsResponse?.quantity == 0.0) {
      ShowMessage.showSnackBar('mes', 'product quantity must be grater then 0');
    } else {
      ///for adding offlineItem
      List offlineCartList = [];
      offlineCartList.add(productDetailsResponse?.toJson());
      await SharedPre.setValue(SharedPre.offlineCartList, json.encode(offlineCartList));

      isInCart.value = true;
      var response = await addToCartAPI(
          itemId: productDetailsResponse?.itemId.toString() ?? '',
          itemRate: productDetailsResponse?.rate.toString() ?? '',
          quantity: productDetailsResponse?.quantity?.toInt().toString() ?? "",
          unitId: unitList[selectedIndexValue].unitid.toString());
      _homeController.itemInCart.value = response?.data?.first.totalnumber ?? _homeController.itemInCart.value;
      //update();
    }
  }

  void addToCartFormVariant() async {
    for (var element in itemVariantList) {
      if (element.quantity != 0) {
        var res = await callAddToCart(
            itemId: element.itemid.toString(),
            itemRate: element.rate?.toInt().toString() ?? '',
            quantity: element.quantity?.toInt().toString() ?? '',
            unitId: element.unitid?.toInt().toString() ?? '');
        if (res.status == 200) {
          ShowMessage.showSnackBar('', res.message.toString());
          myCartItemCount = res.data?.first.totalnumber ?? 0;
          _homeController.itemInCart.value = res.data?.first.totalnumber ?? _homeController.itemInCart.value;
          SharedPre.setValue(SharedPre.cartListLength, myCartItemCount);
          cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
        } else {
          ShowMessage.showSnackBar('', '${res.message}');
        }
      }
    }
    /*for (int i = 0; itemVariantList.length >= i; i++) {
      if (itemVariantList[i].quantity != 0) {
        var res = await callAddToCart(
            itemId: itemVariantList[i].itemid.toString(),
            itemRate: itemVariantList[i].rate?.toInt().toString() ?? '',
            quantity: itemVariantList[i].quantity?.toInt().toString() ?? '',
            unitId: itemVariantList[i].unitid?.toInt().toString() ?? '');

        if (res.status == 200) {
          ShowMessage.showSnackBar('', res.message.toString());
          myCartItemCount = res.data?.first.totalnumber ?? 0;
          _homeController.itemInCart.value =
              res.data?.first.totalnumber ?? _homeController.itemInCart.value;
          SharedPre.setValue(SharedPre.cartListLength, myCartItemCount);
          cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);
        } else {
          ShowMessage.showSnackBar('', '${res.message}');
        }
      }
    }*/
    //productList[index].isInCart = true;

    /*var product = productList[index];
    product.isInCart = await addToCartAPI(
      itemId: product.itemid.toString(),
      itemRate: product.rate?.toInt().toString() ?? '',
      quantity: product.quantity?.toInt().toString() ?? '',
    );
    if (product.isInCart ?? false) {
      update();
    }*/
  }

  void tapOnItemVariantCard(int productIndex) {
    // String itemId = itemVariantList[productIndex].itemid.toString();
    // Get.toNamed(AppRoutes.productDetails,
    //     arguments: itemId, preventDuplicates: false);
  }

  void tapOnCard(int index) {
    selectedIndexValue = index;
    update();
  }

  void tapOnGotoCart(BuildContext context) {
    /*Navigator.push(context, MaterialPageRoute(builder: ((context) =>CartView() ) )).then((value) => getDetails());*/
    Get.delete<CartController>();
    Get.to(() => const CartView())?.then((value) => getDetails());
    update();
  }

  void setSelectUnitValue(var newValue) {
    //FilterScreanVariable.selectedDropdown1Value = newValue;
    indexOfSelectedValue = unitList.indexOf(newValue);
    selectedUnit = newValue;
    unitId = newValue.unitid ?? 0;
    update();
  }

  // void tapOnAddToCart() {
  //   if (!isInCart) {
  //     isInCart = true;
  //     update();
  //     ShowMessage.showSnackBar(messageTxt, productAddedTxt);
  //   } else {
  //     ShowMessage.showSnackBar(messageTxt, productQtyUpdateTxt);
  //   }
  // }

  void productQtyDecrease() {
    productDetailsResponse?.quantity = double.parse(productDetailsResponse?.quantity.toString() ?? '0') - 1;
    isInCart.value = false;
    if (unitList.isEmpty) {
      totalAmount = (double.parse(productDetailsResponse?.quantity.toString() ?? '') *
              double.parse(productDetailsResponse?.rate.toString() ?? ''))
          .obs;
    } else {
      calculateFinalAmount();
    }
    update();
  }

  void productQtyDecreaseFromTextField() {
    debugPrint('_______________________');
    isInCart.value = false;
    productDetailsResponse?.quantity = double.parse(quantityTextController.text) - 1;
    quantityTextController.text = (double.parse(quantityTextController.text) - 1).toString();
    if (unitList.isEmpty) {
      totalAmount = (double.parse(productDetailsResponse?.quantity.toString() ?? '') *
              double.parse(productDetailsResponse?.rate.toString() ?? ''))
          .obs;
    } else {
      calculateFinalAmount();
    }

    update();
  }

  void variantProductQtyDecrease(int index) {
    itemVariantList[index].quantity = itemVariantList[index].quantity! - 1;
    calculateTotalPriceOfDecreasedVariantQuantity(index);
    update();
  }

  void variantQtyDecreaseFromTextField(int index) {
    itemVariantList[index].quantity = double.parse(variantQuantityTextController.text) - 1;
    variantQuantityTextController.text = (double.parse(variantQuantityTextController.text) - 1).toString();
    calculateTotalPriceOfDecreasedVariantQuantity(index);
    //productList[index].isInCart = false;

    update();
  }

  void variantProductQtyIncrease(int index) {
    itemVariantList[index].quantity = itemVariantList[index].quantity! + 1;
    calculateTotalPriceOfIncreasedVariantQuantity(index);

    update();
  }

  void variantQtyIncreaseFromTextField(int index) {
    itemVariantList[index].quantity = double.parse(variantQuantityTextController.text) + 1;

    variantQuantityTextController.text = (double.parse(variantQuantityTextController.text) + 1).toString();
    calculateTotalPriceOfIncreasedVariantQuantity(index);
    //productList[index].isInCart = false;

    update();
  }

  void productQtyIncrease() {
    isInCart.value = false;

    productDetailsResponse?.quantity = double.parse(productDetailsResponse?.quantity.toString() ?? '0') + 1;
    if (unitList.isEmpty) {
      totalAmount = (double.parse(productDetailsResponse?.quantity.toString() ?? '') *
              double.parse(productDetailsResponse?.rate.toString() ?? ''))
          .obs;
    } else {
      calculateFinalAmount();
    }

    update();
  }

  void productQtyIncreaseFromTextField() {
    isInCart.value = false;
    productDetailsResponse?.quantity = double.parse(quantityTextController.text) + 1;
    quantityTextController.text = (double.parse(quantityTextController.text) + 1).toString();
    if (unitList.isEmpty) {
      totalAmount = (double.parse(productDetailsResponse?.quantity.toString() ?? '') *
              double.parse(productDetailsResponse?.rate.toString() ?? ''))
          .obs;
    } else {
      calculateFinalAmount();
    }

    update();
  }
}
