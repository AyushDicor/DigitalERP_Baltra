// import 'package:digitalerp/response/get_store_name_resp.dart';
// import 'package:digitalerp/response/stcok_category_data_response.dart';
// import 'package:digitalerp/response/subcategory_brand_response.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../fab/menu_fab.dart';
// import 'stock_report_controller.dart';
// import 'package:digitalerp/response/get_parentgroup_resp.dart';
// import 'package:digitalerp/response/get_party_for_parent_resp.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:digitalerp/utils/app_assets.dart';
//
// class StockReportView extends StatelessWidget {
//   const StockReportView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StockReportController>(
//       init: StockReportController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(AppAssets.dashboardBg),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: AppString.stockReport,
//                       onBackTap: () => controller.backTap(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: controller.isBusy
//                     ? showLoader()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               _dropdownStoreName(controller),
//                               const SizedBox(height: 15),
//                               _dropdownMainGroup(controller),
//                               const SizedBox(height: 15),
//                               _dropdownSubGroup(controller),
//                               const SizedBox(height: 15),
//                               _dropdownItemName(controller),
//                               const SizedBox(height: 30),
//                               SolidAppButton(
//                                 onPressed: controller.onSearch,
//                                 name: 'Search',
//                                 topColor: orangeColor,
//                                 bottomColor: red2Color,
//                                 textSize: 16,
//                                 hPadding: 30,
//                               ),
//                               const SizedBox(height: 20),
//                               ListView.builder(
//                                 // itemCount: 5,
//                                 padding: EdgeInsets.zero,
//                                 itemCount: controller.list?.length ?? 0,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   var item = controller.list![index];
//                                   return CommonItem(
//                                     isCardShow: true,
//                                     data: [
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.mainGrp,
//                                         leftValue: item.maingroup,
//                                         rightTitle: AppString.subGrp,
//                                         rightValue: item.subgroup,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.brand,
//                                         leftValue: item.brand,
//                                         rightTitle: AppString.itemName,
//                                         rightValue: item.itemname,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.rate,
//                                         leftValue: item.rate.toString(),
//                                         rightTitle: AppString.qty,
//                                         rightValue: item.quantity.toString(),
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.unit,
//                                         leftValue: item.unit.toString(),
//                                         rightTitle: AppString.amount,
//                                         rightValue: item.amount.toString(),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: MenuFab(parentMenuId: 2383),
//       ),
//     );
//   }
//
//   Widget _dropdownStoreName(StockReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetStoreNameData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.storeName,
//         hint: Text(
//           'Store Name',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.storeNameList?.map((items) {
//           return DropdownMenuItem<GetStoreNameData>(
//             value: items,
//             child: Text(items.storename ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setStoreName(newValue);
//         },
//       ),
//     );
//   }
//
//   _dropdownMainGroup(StockReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<StockCategoryList>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedCategoryValue,
//         hint: Text(
//           'Main Group',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.stockCategoryList?.map((items) {
//           return DropdownMenuItem<StockCategoryList>(
//             value: items,
//             child: Text(items.categoryname.toString()),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setSelectDropdownValue(newValue);
//         },
//       ),
//     );
//   }
//
//   _dropdownSubGroup(StockReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<BrandData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedSubGroup,
//         hint: Text(
//           'Sub Group',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.subGroupList?.map((items) {
//           return DropdownMenuItem<BrandData>(
//             value: items,
//             child: Text(items.subcategoryname.toString()),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setSubGroup(newValue);
//         },
//       ),
//     );
//   }
//
//   _dropdownItemName(StockReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<ProductDataList>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedItem,
//         hint: Text(
//           'Item Name',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.itemList?.map((items) {
//           return DropdownMenuItem<ProductDataList>(
//             value: items,
//             child: Text(items.itemname.toString()),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setItem(newValue);
//         },
//       ),
//     );
//   }
// }


import 'package:digitalerp/response/get_store_name_resp.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../fab/menu_fab.dart';
import 'stock_report_controller.dart';
import 'package:digitalerp/response/get_parentgroup_resp.dart';
import 'package:digitalerp/response/get_party_for_parent_resp.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/items.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:digitalerp/utils/solid_app_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:digitalerp/utils/app_assets.dart';

//  Design tokens 
const Color _kBg          = Color(0xFFF8F9FC);
const Color _kWhite       = Colors.white;
const Color _kText        = newTextPrimary;
const Color _kSub         = newTextSecondary;

class StockReportView extends StatelessWidget {
  const StockReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockReportController>(
      init: StockReportController(),
      builder: (controller) => Scaffold(
        backgroundColor: _kBg,
        appBar: _buildAppBar('Stock Report'),
        body: controller.isBusy
            ? const Center(child: CircularProgressIndicator(color: purpleColor))
            : SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionCard(children: [
                _label('Store Name'),
                _dropdown(_dropdownStoreName(controller)),
                const SizedBox(height: 14),
                _label('Main Group'),
                _dropdown(_dropdownMainGroup(controller)),
                const SizedBox(height: 14),
                _label('Sub Group'),
                _dropdown(_dropdownSubGroup(controller)),
                const SizedBox(height: 14),
                _label('Item Name'),
                _dropdown(_dropdownItemName(controller)),
              ]),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.onSearch,
                  icon: const Icon(Icons.search_rounded, size: 20),
                  label: const Text('Search',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    foregroundColor: _kWhite,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              if ((controller.list?.length ?? 0) > 0) ...[
                const SizedBox(height: 24),
                _label('Results'),
                const SizedBox(height: 8),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.list?.length ?? 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = controller.list![index];
                    return CommonItem(
                      isCardShow: true,
                      data: [
                        CommonItemRowModel(
                          leftTitle: AppString.mainGrp,
                          leftValue: item.maingroup,
                          rightTitle: AppString.subGrp,
                          rightValue: item.subgroup,
                        ),
                        CommonItemRowModel(
                          leftTitle: AppString.brand,
                          leftValue: item.brand,
                          rightTitle: AppString.itemName,
                          rightValue: item.itemname,
                        ),
                        CommonItemRowModel(
                          leftTitle: AppString.rate,
                          leftValue: item.rate.toString(),
                          rightTitle: AppString.qty,
                          rightValue: item.quantity.toString(),
                        ),
                        CommonItemRowModel(
                          leftTitle: AppString.unit,
                          leftValue: item.unit.toString(),
                          rightTitle: AppString.amount,
                          rightValue: item.amount.toString(),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget _dropdownStoreName(StockReportController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<GetStoreNameData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.storeName,
          hint: Text('Store Name',
              style: TextStyle(fontSize: 14, color: newTextSecondary)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.storeNameList?.map((items) {
            return DropdownMenuItem<GetStoreNameData>(
              value: items,
              child: Text(items.storename ?? '',
                  style: const TextStyle(fontSize: 14, color: newTextPrimary)),
            );
          }).toList(),
          onChanged: controller.setStoreName,
        ),
      );

  Widget _dropdownMainGroup(StockReportController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<StockCategoryList>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedCategoryValue,
          hint: Text('Main Group',
              style: TextStyle(fontSize: 14, color: newTextPrimary)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.stockCategoryList?.map((items) {
            return DropdownMenuItem<StockCategoryList>(
              value: items,
              child: Text(items.categoryname.toString(),
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setSelectDropdownValue,
        ),
      );

  Widget _dropdownSubGroup(StockReportController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<BrandData>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedSubGroup,
          hint: Text('Sub Group',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.subGroupList?.map((items) {
            return DropdownMenuItem<BrandData>(
              value: items,
              child: Text(items.subcategoryname.toString(),
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setSubGroup,
        ),
      );

  Widget _dropdownItemName(StockReportController controller) =>
      DropdownButtonHideUnderline(
        child: DropdownButton2<ProductDataList>(
          buttonHeight: 50,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: _kWhite),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.transparent),
          isExpanded: true,
          value: controller.selectedItem,
          hint: Text('Item Name',
              style: TextStyle(fontSize: 14, color: _kSub)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: _kSub, size: 22),
          items: controller.itemList?.map((items) {
            return DropdownMenuItem<ProductDataList>(
              value: items,
              child: Text(items.itemname.toString(),
                  style: const TextStyle(fontSize: 14, color: _kText)),
            );
          }).toList(),
          onChanged: controller.setItem,
        ),
      );
}

//  Shared helpers 
AppBar _buildAppBar(String title, {List<Widget>? actions}) => AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  shadowColor: Colors.black12,
  surfaceTintColor: Colors.white,
  centerTitle: false,
  leading: GestureDetector(
    onTap: () => Get.back(),
    child: const Icon(Icons.arrow_back_ios_new_rounded,
        color: Color(0xFF111827), size: 20),
  ),
  title: Text(title,
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF111827))),
  actions: actions,
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1),
    child: Container(color: const Color(0xFFE4E7EF), height: 1),
  ),
);

Widget _sectionCard({required List<Widget> children}) => Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withValues(alpha:0.06),
          blurRadius: 12,
          offset: const Offset(0, 4))
    ],
  ),
  child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: children),
);

Widget _label(String text) => Padding(
  padding: const EdgeInsets.only(bottom: 6),
  child: Text(text,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151))),
);

Widget _dropdown(Widget child) => Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: const Color(0xFFE4E7EF)),
    boxShadow: [
      BoxShadow(
          color: Colors.black.withValues(alpha:0.03),
          blurRadius: 4,
          offset: const Offset(0, 2))
    ],
  ),
  child: child,
);