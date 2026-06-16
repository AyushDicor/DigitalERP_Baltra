import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/services/api_service/request_keys.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockTakingController extends AppBaseController {
  HomeController homeController = Get.find<HomeController>();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final FocusNode quantityFocus = FocusNode();
  final FocusNode productFocus = FocusNode();
  List <StockCategoryList> stockCategoryList = [];
  List<ProductDataList> stockProductList = [];


  var selectedCategoryValue;

  var productQuantity = 2;

  var selectedproduct ;

  int? partyId;

  @override
  void onInit() {
    // TODO: implement onInit
    partyId = Get.arguments;
    getCategoryList();
    getProductList();
    super.onInit();
  }


  void setSelectDropdownValue(Object? newValue) {
    selectedCategoryValue = newValue;
    getProductList(categoryId: selectedCategoryValue.categoryid.toString());
    update();
  }
  void productQtyIncrease() {
    productQuantity = productQuantity+1;
    update();
  }
  void productQtyDecrease() {
    productQuantity = productQuantity-1;
    update();
  }

  Future <void> tapOnSubmit() async{

    if(productController.text.isEmpty ){

      ShowMessage.showSnackBar('Static msg', 'please select product');

    } else if(quantityController.text.isEmpty){

      ShowMessage.showSnackBar('Static msg', 'please add quantity');

    }else if(selectedproduct == null){

      ShowMessage.showSnackBar('Static msg', 'This is invalid product');

    }else {
      try {
        Map<String, String> body = {};
        body[RequestKeys.compId] =
            homeController.currentUserData?.compId.toString() ?? '39';
        body[RequestKeys.brandId] =
            homeController.currentUserData?.branchId.toString() ?? '39';
        body[RequestKeys.userId] =
            homeController.currentUserData?.userid.toString() ?? '39';
        body[RequestKeys.visitId] = '0';
        body[RequestKeys.partyId] = partyId.toString();
        body[RequestKeys.itemId] = selectedproduct.itemid.toString();
        body[RequestKeys.quantity] = quantityController.text;

        var res = await api.stockSubmitData(body);
        if (res.status == 200) {
          Get.back();

          ShowMessage.showSnackBar(
              'Server Success msg', res.message.toString());
        } else {
          ShowMessage.showSnackBar('Server Res', res.message.toString());
        }
      } catch (e) {
        ShowMessage.showSnackBar('Server Res', '$e');
      } finally {
        setListLoading(false);
      }
    }
  }

  Future <void> getCategoryList() async {
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] =
          homeController.currentUserData?.compId.toString() ??
              ''; //39.toString();
      var res = await api.getStockCategoryData(body);
      if (res.status == 200) {
        stockCategoryList = res.data ?? [];
        //update();
      } else {
        //ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      isBusy = false;
      update();
    }
  }

  Future <void> getProductList({String? categoryId}) async {
    /*setListLoading(true);
    subCategoryItemId = (selectedIndex == -1)
        ? 0
        : subCategoryList[selectedIndex].subcategoryid;*/
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.subCategoryId] =  '0';
      body[RequestKeys.brandId] = '0';
      if(categoryId != null){ body[RequestKeys.categoryId] = categoryId.toString();}
      body[RequestKeys.branchId] = homeController.currentUserData?.branchId.toString()??'0';


      // body[RequestKeys.rateFrom] = subCategoryItemId.toString();
      // body[RequestKeys.rateTo] = subCategoryItemId.toString();
      // body[RequestKeys.itemName] = "";
      var res = await api.getProductData(body);
      if (res.status == 200) {
        stockProductList = res.data ?? [];

        /*if (stockProductList.length > 1) {
          isManager = true;
        } else {
          selectedProduct = productList.first;
        }*/
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setListLoading(false);
    }
  }

}
