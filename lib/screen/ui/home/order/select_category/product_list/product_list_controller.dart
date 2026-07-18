import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/select_category_controller.dart';
import 'package:digitalerp/utils/filter_variable.dart';
import 'package:digitalerp/utils/offline_cart_list.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../response/subcategory_brand_response.dart';
import '../../../../../../services/api_service/request_keys.dart';
import '../../../../../../utils/show_message.dart';
import '../../../home_controller.dart';

class ProductListController extends AppBaseController {
  SelectCategoryController selectCategoryController= Get.find<SelectCategoryController>();

  final SelectBrandController selectBrandController = Get.find<SelectBrandController>();
  final HomeController _homeController = Get.find<HomeController>();
  final quantityTextController = TextEditingController();
  final quantityTextFocus = FocusNode();
  bool isGridView = true;
  int selectedIndex = -1;
  bool isInCart = false;
  BrandData? selectedBrand;
  ProductDataList? selectedProduct;
  bool isAddedInCart = false;
  PriceRange priceRange = PriceRange(0, 2000);
  bool isManager = false;
  int? subCategoryItemId;
  int brandListIndex = 0;
  FilterScreanVariable filter = FilterScreanVariable();
  List<BrandData> subCategoryList = [];
  List<ProductDataList> productList = [];
  List<ProductDataList> newProductList = [];
  List<ProductDataList> temp = [];
  int? categoryId, brandId, myCartItemCount, firstPageSelectedBrandId;
  final searchController = TextEditingController();
  int? cartListCount;
  var previewsSelectedValue;
  List offlineCartList = [];
  late final offlineList;

  @override
  void onInit() async {
    cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);

    categoryId = selectCategoryController.categoryListItem[selectCategoryController.selectedIndex].categoryid;
    firstPageSelectedBrandId = selectBrandController.brandId;

    getSubCategoryList();
    super.onInit();
  }

  void productQtyDecrease(int index) {
    productList[index].quantity = productList[index].quantity! - 1;
    productList[index].isInCart = false;

    update();
  }

  void productQtyDecreaseFromTextField(int index) {
    productList[index].quantity = double.parse(quantityTextController.text) - 1;
    quantityTextController.text = (double.parse(quantityTextController.text) - 1).toString();
    productList[index].isInCart = false;

    update();
  }

  void productQtyIncrease(int index) {
    productList[index].quantity = productList[index].quantity! + 1;
    productList[index].isInCart = false;
    update();
  }

  // Type an exact quantity (e.g. 100) instead of tapping + repeatedly.
  void setTypedQuantity(int index, String value) {
    final q = double.tryParse(value.trim()) ?? 0;
    if (q <= 0) {
      ShowMessage.showSnackBar('', 'Quantity must be greater than 0');
      return;
    }
    productList[index].quantity = q;
    // Re-add with the new quantity — same cart sync the +/- stepper uses.
    addToCart(index);
  }

  void productQtyIncreaseFromTextField(int index) {
    productList[index].quantity = double.parse(quantityTextController.text) + 1;
    quantityTextController.text = (double.parse(quantityTextController.text) + 1).toString();
    productList[index].isInCart = false;

    update();
  }

  void removeFromCart(int index) {
    isAddedInCart = false;
    update();
  }

  void updateMethod() {
    update();
  }

  void tapOnQuantityText(int index) {
    for (var element in productList) {
      element.isTextField = false;
    }
    quantityTextController.clear();
    productList[index].isTextField = true;
    update();
  }

  void onChangeQuantityText(int index, String value) {
    productList[index].quantity = double.parse(value);
  }

  void checkItemInCart() async {
    var list1 = await SharedPre.getStringValue(SharedPre.offlineCartList);
    if (list1.isNotEmpty) {
      var obj1 = json.decode(await SharedPre.getStringValue(SharedPre.offlineCartList));
      debugPrint('______________${obj1}_________');
      var list = obj1.map((model) => OfflineCart.fromJson(model)).toList();
      list.forEach((element) {
        for (int i = 0; i < productList.length; i++) {
          if (element.itemId == productList[i].itemid) {
            //debugPrint('______________${element.itemId}_________');
            productList[i].isInCart = true;
          }
        }
      });
      update();
    }
  }

  void addToCart(int index) async {
    if (productList[index].quantity! < 0 || productList[index].quantity == 0.0) {
      ShowMessage.showSnackBar('mes', 'product quantity must be grater then 0');
    } else {
      productList[index].isInCart = true;

      ///for saveing item in offline check
      offlineCartList.add(productList[index].toJson());
      debugPrint('______________${offlineCartList}_________');
      await SharedPre.setValue(SharedPre.offlineCartList, json.encode(offlineCartList));

      /*var product = productList[index];
    product.isInCart = await addToCartAPI(
      itemId: product.itemid.toString(),
      itemRate: product.rate?.toInt().toString() ?? '',
      quantity: product.quantity?.toInt().toString() ?? '',
    );
    if (product.isInCart ?? false) {
      update();
    }*/
      var res = await callAddToCart(
          itemId: productList[index].itemid.toString(),
          itemRate: productList[index].rate?.toInt().toString() ?? '',
          quantity: productList[index].quantity?.toInt().toString() ?? '',
          unitId: productList[index].unitid?.toInt().toString() ?? '');

      if (res.status == 200) {
        ShowMessage.showSnackBar('', res.message.toString());
        myCartItemCount = res.data?.first.totalnumber ?? 0;
        _homeController.itemInCart.value = res.data?.first.totalnumber ?? _homeController.itemInCart.value;
        //SharedPre.setValue(SharedPre.cartListLength, myCartItemCount);
        // cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);

        update();
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
      }
    }
  }

  void setSelectedIndex(int value) {
    selectedIndex = value;
    selectedBrand = subCategoryList[value];
    productList.clear();
    subCategoryItemId = subCategoryList[selectedIndex].subcategoryid;
    getProductList();
  }

  void tapOnCart2() {
    Get.toNamed(AppRoutes.cart)?.then((value) {
      getProductList();
    });
  }

  void tapOnListViewType() {
    isGridView = !isGridView;
    update();
  }

  void tapOnProduct(String itemId) {
    Get.toNamed(AppRoutes.productDetails, arguments: itemId)?.then((value) {
      getProductList();
    });
  }

  void getSubCategoryList() async {
    try {
      setListLoading(true);
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = categoryId.toString();
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString()??'0';

      var res = await api.getSubCategoryBrandData(body);
      if (res.status == 200) {
        subCategoryList.clear();
        subCategoryList.addAll(res.data ?? []);

        /// for calling product API after category
        getProductList();

        if (subCategoryList.length > 1) {
          isManager = true;
        } else {
          selectedBrand = subCategoryList.first;
        }
        update();
      } else {
        ShowMessage.showSnackBar('Server Fail', res.message.toString());
        setListLoading(false);
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
      setListLoading(false);
    } finally {
      setBusy(false);
    }
  }

  void tapOnCategoryBtn() {
    selectedIndex = -1;
    getProductList();
  }

  getFilterdProduct() {
    if (subCategoryItemId == null || subCategoryItemId != null) {
      selectedIndex = brandListIndex;
      subCategoryList[selectedIndex];
      productList.clear();
      subCategoryItemId = brandId;
      getFilterdProductList();
      // lowToHighOrHighToLowFilter();
      update();
    }
  }

  Future<void> getFilterdProductList() async {
    setListLoading(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = categoryId.toString();
      body[RequestKeys.subCategoryId] = subCategoryItemId == null ? '0' : subCategoryItemId.toString();
      body[RequestKeys.brandId] = subCategoryItemId.toString();
      if (FilterScreanVariable.lowerLimit != null || FilterScreanVariable.upperLimit != null) {
        body[RequestKeys.rateFrom] = (FilterScreanVariable.lowerLimit ?? 0).toString();
        body[RequestKeys.rateTo] = (FilterScreanVariable.upperLimit ?? 0).toString();
      } else {
        // Set rateFrom and rateTo to 0 if no price range is selected
        body[RequestKeys.rateFrom] = '0';
        body[RequestKeys.rateTo] = '0';
      }
      // body[RequestKeys.rateFrom] = "0";
      // body[RequestKeys.rateTo] =  "0";
      body[RequestKeys.itemName] = "";
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString()??'';

      var res = await api.getProductData(body);
      if (res.status == 200) {
        productList = res.data ?? [];
        if (productList.length > 1) {
          isManager = true;
        } else {
          selectedProduct = productList.first;
        }
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

  Future<void> lowToHighOrHighToLowFilter() async {
    await getFilterdProductList();
    if (FilterScreanVariable.lowerLimit == null) {
      if (FilterScreanVariable.lowToHigh ?? false) {
        productList.sort((a, b) => (a.rate ?? 0.0).compareTo(b.rate ?? 0.0));
      } else {
        productList.sort((a, b) => (b.rate ?? 0.0).compareTo(a.rate ?? 0.0));
      }
    } else {
      productList.forEach((element) async {
        if ((element.rate ?? 0.0) > (FilterScreanVariable.lowerLimit ?? 0.0) &&
            (element.rate ?? 0.0) > (FilterScreanVariable.upperLimit ?? 0.0)) {
          productList = temp;
        } else if ((element.rate ?? 0.0) > (FilterScreanVariable.lowerLimit ?? 0.0) &&
            (element.rate ?? 0.0) < (FilterScreanVariable.upperLimit ?? 0.0)) {
          temp.add(element);
          productList = temp;
        }
      });
      if (FilterScreanVariable.lowToHigh ?? false) {
        productList.sort((a, b) => (a.rate ?? 0.0).compareTo(b.rate ?? 0.0));
      } else {
        productList.sort((a, b) => (b.rate ?? 0.0).compareTo(a.rate ?? 0.0));
      }
    }
  }

  void getProductList() async {
    setListLoading(true);
    subCategoryItemId = (selectedIndex == -1) ? 0 : subCategoryList[selectedIndex].subcategoryid;
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.categoryId] = categoryId.toString();
      body[RequestKeys.subCategoryId] = subCategoryItemId == null ? '0' : subCategoryItemId.toString();
      body[RequestKeys.brandId] = firstPageSelectedBrandId.toString();
      body[RequestKeys.rateFrom] = '0';
      body[RequestKeys.rateTo] = '0';
      body[RequestKeys.itemName] = "";
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString()??'0';

      var res = await api.getProductData(body);
      if (res.status == 200) {
        productList = res.data ?? [];
        checkItemInCart();
        if (productList.length > 1) {
          isManager = true;

          for (var i = 0; i >= productList.length; i++) {}
        } else {
          selectedProduct = productList.first;
        }
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

  searchProduct(String value) {
    if (value.isEmpty) {
      getProductList();
      update();
    } else {
      final suggestions = productList.where((element) {
        final productTitle = element.itemname!.toLowerCase();
        final productCode = element.itemcode!.toLowerCase();
        final input = searchController.text.toLowerCase();
        return (productTitle.contains(input) || productCode.contains(input));
      }).toList();
      productList = suggestions;
      update();
    }
  }
}

/*class ProductData {
  String name;
  String image;
  bool isAddedInCart;
  int productQty, price;

  ProductData({
    required this.name,
    required this.isAddedInCart,
    required this.image,
    required this.productQty,
    required this.price,
  });
}*/

class PriceRange {
  int minRange, maxRange;

  PriceRange(this.minRange, this.maxRange);
}
