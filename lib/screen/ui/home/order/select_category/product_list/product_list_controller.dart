import 'dart:convert';

import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/response/select_category_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_brand/select_brand_controller.dart';
import 'package:digitalerp/utils/filter_variable.dart';
import 'package:digitalerp/utils/offline_cart_list.dart';
import 'package:digitalerp/utils/shared_pre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../response/subcategory_brand_response.dart';
import '../../../../../../services/api_service/request_keys.dart';
import '../../../../../../utils/show_message.dart';
import '../../../home_controller.dart';

/// Product screen opened straight after Select Brand.
///
/// Flow is Brand -> Product. The old Select Category screen is gone and
/// categories are not shown at all: the top of this screen carries one
/// dropdown listing every sub-group of the brand (All | AIR FRYER |
/// BAR-BE-QUE | ... | CHIMNEY), and picking one loads its items.
///
/// Backend notes (verified live on supportapi):
///   * `subcategorylistwithbranch` needs a real categoryid (0 -> "Data Not
///     Available"), so the dropdown is built by asking each category of the
///     brand for its sub-groups and merging the results.
///   * `itemlistwithbranch` with categoryid=0 returns the WHOLE company item
///     master (incl. other brands), so "All" is built by fetching every
///     category of the brand and merging - never by passing 0.
class ProductListController extends AppBaseController {
  final SelectBrandController selectBrandController = Get.find<SelectBrandController>();
  final HomeController _homeController = Get.find<HomeController>();
  final quantityTextController = TextEditingController();
  final quantityTextFocus = FocusNode();
  bool isGridView = true;

  /// Index into [subCategoryList]; -1 = All sub-groups.
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
  List<CategoryItem> categoryList = [];

  /// Every sub-group of the brand (flattened across its categories).
  List<BrandData> subCategoryList = [];

  /// subcategoryid -> parent categoryid, needed by `itemlistwithbranch`.
  final Map<int, int> subCategoryParent = {};
  List<ProductDataList> productList = [];

  /// Unfiltered result of the last fetch; [searchProduct] filters from here
  /// so backspacing in the search box widens the list again.
  List<ProductDataList> _masterProductList = [];
  List<ProductDataList> newProductList = [];
  List<ProductDataList> temp = [];
  int? categoryId, brandId, myCartItemCount, firstPageSelectedBrandId;
  final searchController = TextEditingController();
  int? cartListCount;
  var previewsSelectedValue;
  List offlineCartList = [];
  late final offlineList;

  /// Guards against a slow earlier fetch overwriting a newer chip selection.
  int _fetchToken = 0;

  /// No sub-group picked -> show the whole brand.
  bool get isAllCategories => selectedIndex == -1;

  String get selectedCategoryName => isAllCategories
      ? 'All Products'
      : (subCategoryList[selectedIndex].subcategoryname ?? 'Products');

  @override
  void onInit() async {
    cartListCount = await SharedPre.getIntValue(SharedPre.cartListLength);

    // Brand id comes from Select Brand (Get.arguments) - fall back to the
    // brand controller so deep links / hot restarts still work.
    final arg = Get.arguments;
    firstPageSelectedBrandId =
        arg is int ? arg : int.tryParse(arg?.toString() ?? '') ?? selectBrandController.brandId;

    getCategoryList();
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
    // Re-add with the new quantity - same cart sync the +/- stepper uses.
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
            productList[i].isInCart = true;
          }
        }
      });
      update();
    }
  }

  // Items with an add-to-cart call in flight. The server add is additive, and
  // the "+" button stayed visible until the response, so a quick double tap
  // added the item twice.
  final Set<int> _adding = {};

  void addToCart(int index) async {
    final itemId = productList[index].itemid ?? -1;
    if (_adding.contains(itemId)) return;
    if (productList[index].quantity! < 0 || productList[index].quantity == 0.0) {
      ShowMessage.showSnackBar('mes', 'product quantity must be grater then 0');
    } else {
      _adding.add(itemId);
      productList[index].isInCart = true;
      update();
      try {

      ///for saveing item in offline check
      offlineCartList.add(productList[index].toJson());
      debugPrint('______________${offlineCartList}_________');
      await SharedPre.setValue(SharedPre.offlineCartList, json.encode(offlineCartList));

      var res = await callAddToCart(
          itemId: productList[index].itemid.toString(),
          itemRate: productList[index].rate?.toInt().toString() ?? '',
          quantity: productList[index].quantity?.toInt().toString() ?? '',
          unitId: productList[index].unitid?.toInt().toString() ?? '');

      if (res.status == 200) {
        ShowMessage.showSnackBar('', res.message.toString());
        myCartItemCount = res.data?.first.totalnumber ?? 0;
        _homeController.itemInCart.value = res.data?.first.totalnumber ?? _homeController.itemInCart.value;

        update();
      } else {
        ShowMessage.showSnackBar('', '${res.message}');
      }
      } finally {
        _adding.remove(itemId);
      }
    }
  }

  // --------------------- Sub-group dropdown ---------------------

  /// Categories are not shown in the UI any more; they are still fetched
  /// because every product/sub-category call needs a categoryid.
  void getCategoryList() async {
    setListLoading(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
      body[RequestKeys.brandId] = firstPageSelectedBrandId.toString();
      body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '0';
      var res = await api.getCategoryData(body);
      if (res.status == 200) {
        categoryList = (res.data as List?)?.cast<CategoryItem>() ?? <CategoryItem>[];
      } else {
        categoryList = [];
        ShowMessage.showSnackBar('Server Res', res.message.toString());
      }
      update();
      // Default view = every product of the brand ("All").
      getProductList();
      // Fill the dropdown in the background so the list is not held up.
      loadAllSubCategories();
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
      setListLoading(false);
    }
  }

  /// Every sub-group of the brand, flattened across its categories, for the
  /// single dropdown on top of the screen. Each sub-group keeps its parent
  /// category id in [subCategoryParent] because `itemlistwithbranch` needs
  /// both ids.
  Future<void> loadAllSubCategories() async {
    final ids = categoryList.map((c) => c.categoryid).whereType<int>().toList();
    if (ids.isEmpty) return;
    try {
      final pages = await Future.wait(ids.map(_fetchSubCategories));
      final merged = <BrandData>[];
      subCategoryParent.clear();
      for (var i = 0; i < ids.length; i++) {
        for (final sub in pages[i]) {
          final id = sub.subcategoryid;
          // The same sub-group name can appear under more than one category.
          if (id == null || id == 0 || subCategoryParent.containsKey(id)) continue;
          subCategoryParent[id] = ids[i];
          merged.add(sub);
        }
      }
      merged.sort((a, b) => (a.subcategoryname ?? '')
          .toLowerCase()
          .compareTo((b.subcategoryname ?? '').toLowerCase()));
      subCategoryList = merged;
      update();
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    }
  }

  Future<List<BrandData>> _fetchSubCategories(int categoryId) async {
    Map<String, String> body = {};
    body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
    body[RequestKeys.categoryId] = categoryId.toString();
    body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '0';
    var res = await api.getSubCategoryBrandData(body);
    if (res.status == 200) return res.data ?? [];
    return [];
  }

  /// Dropdown selection. -1 = All sub-groups.
  void setSelectedIndex(int value) {
    if (value == selectedIndex) return;
    selectedIndex = value;
    selectedBrand = value == -1 ? null : subCategoryList[value];
    previewsSelectedValue = selectedBrand;
    searchController.clear();
    productList.clear();
    if (value == -1) {
      categoryId = null;
      subCategoryItemId = 0;
    } else {
      subCategoryItemId = subCategoryList[value].subcategoryid;
      categoryId = subCategoryParent[subCategoryItemId];
    }
    update();
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

  void tapOnCategoryBtn() {
    selectedIndex = -1;
    getProductList();
  }

  getFilterdProduct() {
    // Called from the filter dialog. brandListIndex is its dropdown index
    // into subCategoryList; it mirrors the sub-group dropdown on screen.
    if (subCategoryList.isNotEmpty && brandListIndex >= 0 && brandListIndex < subCategoryList.length) {
      selectedIndex = brandListIndex;
      selectedBrand = subCategoryList[selectedIndex];
      subCategoryItemId = selectedBrand?.subcategoryid;
      categoryId = subCategoryParent[subCategoryItemId];
    } else {
      selectedIndex = -1;
      selectedBrand = null;
      subCategoryItemId = 0;
      categoryId = null;
    }
    productList.clear();
    getFilterdProductList();
    update();
  }

  Future<void> getFilterdProductList() async {
    final hasRange = FilterScreanVariable.lowerLimit != null || FilterScreanVariable.upperLimit != null;
    await _loadProducts(
      subCategoryId: subCategoryItemId ?? 0,
      rateFrom: hasRange ? (FilterScreanVariable.lowerLimit ?? 0).toString() : '0',
      rateTo: hasRange ? (FilterScreanVariable.upperLimit ?? 0).toString() : '0',
    );
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

  // ------------------------- Product fetch -------------------------

  void getProductList() async {
    if (selectedIndex == -1 || selectedIndex >= subCategoryList.length) {
      subCategoryItemId = 0;
      categoryId = null;
    } else {
      subCategoryItemId = subCategoryList[selectedIndex].subcategoryid;
      categoryId = subCategoryParent[subCategoryItemId];
    }
    await _loadProducts(subCategoryId: subCategoryItemId ?? 0, rateFrom: '0', rateTo: '0');
  }

  /// One `itemlistwithbranch` call for a single category.
  Future<List<ProductDataList>> _fetchProductsForCategory({
    required int categoryId,
    required int subCategoryId,
    required String rateFrom,
    required String rateTo,
  }) async {
    Map<String, String> body = {};
    body[RequestKeys.compId] = _homeController.currentUserData?.compId.toString() ?? '39';
    body[RequestKeys.categoryId] = categoryId.toString();
    body[RequestKeys.subCategoryId] = subCategoryId.toString();
    body[RequestKeys.brandId] = firstPageSelectedBrandId.toString();
    body[RequestKeys.rateFrom] = rateFrom;
    body[RequestKeys.rateTo] = rateTo;
    body[RequestKeys.itemName] = "";
    body[RequestKeys.branchId] = _homeController.currentUserData?.branchId.toString() ?? '0';

    var res = await api.getProductData(body);
    if (res.status == 200) return res.data ?? [];
    // "Data Not Available" for an empty category is normal in All mode -
    // only surface real failures.
    if (!(res.message ?? '').toLowerCase().contains('not available')) {
      ShowMessage.showSnackBar('Server Res', res.message.toString());
    }
    return [];
  }

  /// Loads products for the current category selection. In "All" mode every
  /// category of the brand is fetched in parallel and merged (de-duped by
  /// itemid, since the backend can list an item under more than one
  /// category).
  Future<void> _loadProducts({
    required int subCategoryId,
    required String rateFrom,
    required String rateTo,
  }) async {
    final token = ++_fetchToken;
    setListLoading(true);
    try {
      List<ProductDataList> result;
      if (isAllCategories) {
        final ids = categoryList.map((c) => c.categoryid).whereType<int>().toList();
        if (ids.isEmpty) {
          result = [];
        } else {
          final pages = await Future.wait(ids.map((id) => _fetchProductsForCategory(
                categoryId: id,
                subCategoryId: 0,
                rateFrom: rateFrom,
                rateTo: rateTo,
              )));
          final seen = <int>{};
          result = [
            for (final page in pages)
              for (final p in page)
                if (p.itemid == null || seen.add(p.itemid!)) p
          ];
        }
      } else {
        result = await _fetchProductsForCategory(
          categoryId: categoryId ?? 0,
          subCategoryId: subCategoryId,
          rateFrom: rateFrom,
          rateTo: rateTo,
        );
      }

      // A newer chip tap already replaced this request - drop the result.
      if (token != _fetchToken) return;

      _masterProductList = result;
      productList = List.of(_masterProductList);
      checkItemInCart();
      isManager = productList.length > 1;
      if (productList.length == 1) selectedProduct = productList.first;
      if (searchController.text.isNotEmpty) searchProduct(searchController.text);
      update();
    } catch (e) {
      if (token == _fetchToken) ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      if (token == _fetchToken) setListLoading(false);
    }
  }

  searchProduct(String value) {
    final input = value.trim().toLowerCase();
    if (input.isEmpty) {
      productList = List.of(_masterProductList);
    } else {
      productList = _masterProductList.where((element) {
        final productTitle = (element.itemname ?? '').toLowerCase();
        final productCode = (element.itemcode ?? '').toLowerCase();
        return productTitle.contains(input) || productCode.contains(input);
      }).toList();
    }
    update();
  }
}

class PriceRange {
  int minRange, maxRange;

  PriceRange(this.minRange, this.maxRange);
}
