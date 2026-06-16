import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../screen/ui/home/order/select_category/product_list/product_list_controller.dart';
import '../../filter_variable.dart';

class ProductListFilterController extends AppBaseController {
  final double _lowerValue = 250;
  final double _upperValue = 10000;

  ProductListController productListController = Get.find<ProductListController>();
  var dropdownList = [];
  var indexOfSelectedValue;
  var selectedDropdownValue;
  var brandId;
  AnimationController? animationController;

  @override
  void onInit() {
    // TODO: implement onInit
    FilterScreanVariable.lowerLimit ?? _lowerValue;
    FilterScreanVariable.upperLimit ?? _upperValue;
    dropdownList.clear();

    dropdownList = productListController.subCategoryList;
    super.onInit();
  }

  void onChangedListValue(Object? newValue) {
    indexOfSelectedValue = dropdownList.indexOf(newValue);
    setSelectDropdownValue(newValue);
  }

  void setSelectDropdownValue(var newValue) {
    //FilterScreanVariable.selectedDropdown1Value = newValue;
    productListController.previewsSelectedValue = newValue;
    if (productListController != null) {
      brandId = newValue.subcategoryid ?? 0;
      update();
    }
  }

  void onApply() async {
    productListController.brandId = brandId;
    productListController.brandListIndex = indexOfSelectedValue ?? 0;
    await productListController.getFilterdProduct();
    Get.back();

    /*FilterScreanVariable.highToLow =
                    !(FilterScreanVariable.highToLow ?? true);

                FilterScreanVariable.lowToHigh =
                    !(FilterScreanVariable.lowToHigh ?? false);*/
  }
}
