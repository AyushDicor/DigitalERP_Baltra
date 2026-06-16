//
//
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:digitalerp/response/brand_list_response.dart';
// import 'package:digitalerp/response/get_store_name_resp.dart';
// import 'package:digitalerp/response/rack_list_response.dart';
// import 'package:digitalerp/response/stcok_category_data_response.dart';
// import 'package:digitalerp/response/subcategory_brand_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_controller/stock_reconciliation_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class StockReconciliationFilterView extends StatelessWidget {
//   StockReconciliationFilterView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StockReconciliationController>(
//         init: StockReconciliationController(),
//         builder: (controller) {
//           return SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: DialogBgWidget(
//                 onApplyOrDoneButtonTap: () {
//                   controller.onSearch(context);
//                 },
//                 children: [
//                   SizedBox(height: Get.height * 0.02),
//                   _dropdownStoreName(controller),
//                   const SizedBox(height: 15),
//                   _dropdownMainGroup(controller),
//                   const SizedBox(height: 15),
//                   _dropdownSubGroup(controller),
//                   const SizedBox(height: 15),
//                   _dropdownBrandName(controller),
//                   const SizedBox(height: 15),
//                   _dropdownItemName(context, controller),
//                   const SizedBox(height: 15),
//                   _dropdownRackBin(controller),
//                   const SizedBox(height: 15),
//                   stockMoment(controller),
//                   const SizedBox(height: 5),
//                   controller.isCheckingStockMoment == true
//                       ? _dateColumn(controller, context)
//                       : SizedBox(),
//                   const SizedBox(height: 15),
//                   showReConsilationDate(controller),
//                 ]),
//           );
//         });
//   }
//
//   Widget _dropdownStoreName(StockReconciliationController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetStoreNameData>(
//         buttonHeight: Get.height * 0.0550,
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
//         value: controller.storeNameData,
//         hint: Text(
//           'Store Name',
//           style: const TextStyle()
//               .normal
//               .copyWith(fontSize: 14, color: Colors.black),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.storeNameDataList?.map((items) {
//           return DropdownMenuItem<GetStoreNameData>(
//             value: items,
//             child: Text(items.storename?? '',
//                 style: const TextStyle()
//                     .bold
//                     .copyWith(color: Colors.black, fontSize: 15)),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setStoreName(newValue);
//         },
//       ),
//     );
//   }
//   _dropdownMainGroup(StockReconciliationController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<StockCategoryList>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(
//           horizontal: 20,
//         ),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedMainCategoryValue,
//         hint: Text(
//           'Main Group',
//           style: const TextStyle()
//               .normal
//               .copyWith(fontSize: 14, color: Colors.black),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.stockMainCategoryList?.map((items) {
//           return DropdownMenuItem<StockCategoryList>(
//             value: items,
//             child: Text(items.categoryname.toString()),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setSelectMainGroupValue(newValue);
//         },
//         dropdownMaxHeight: Get.height * .25,
//       ),
//     );
//   }
//   _dropdownSubGroup(StockReconciliationController controller) {
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
//           style: const TextStyle()
//               .normal
//               .copyWith(fontSize: 14, color: Colors.black),
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
//   Widget _dropdownItemName(BuildContext context, StockReconciliationController controller) {
//     final itemController = TextEditingController(text: controller.selectedItem?.itemname ?? "");
//     final focusNode = FocusNode();
//
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         itemController.selection = TextSelection(
//           baseOffset: 0,
//           extentOffset: itemController.text.length,
//         );
//       }
//     });
//
//     return Container(
//       height: Get.height / 18,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         color: dropdownBoxColor,
//         gradient: blueDropdownGr,
//       ),
//       child: AutoCompleteTextField<ProductDataList>(
//         key: GlobalKey<AutoCompleteTextFieldState<ProductDataList>>(),
//         controller: itemController,
//         focusNode: focusNode,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(top: 10, left: 30),
//           hintText: 'Item Name / Item Code',
//           hintStyle: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black),
//           border: InputBorder.none,
//           suffixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,),
//         ),
//         clearOnSubmit: false,
//         suggestions: controller.itemList?.toList() ?? [],
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             style: ListTileStyle.list,
//             tileColor: dropdownBoxColor,
//             title: Text('${suggestion.itemname}'),
//           );
//         },
//         itemSorter: (a, b) {
//           return a.itemname!.compareTo(b.itemname!);
//         },
//         itemFilter: (suggestion, input) {
//           return suggestion.itemname!.toLowerCase().contains(input.toLowerCase()) ||
//               suggestion.itemcode!.toLowerCase().contains(input.toLowerCase());
//         },
//         itemSubmitted: (suggestion) {
//           controller.setItem(suggestion);
//           itemController.text = suggestion.itemname ?? '';
//           itemController.selection = TextSelection.fromPosition(
//             TextPosition(offset: itemController.text.length),
//           );
//         },
//       ),
//     );
//   }
// _dropdownBrandName(StockReconciliationController controller) {
//   final itemController = TextEditingController(text: controller.selectBrandList?.brandname ?? "");
//   final focusNode = FocusNode();
//
//   focusNode.addListener(() {
//     if (focusNode.hasFocus) {
//       itemController.selection = TextSelection(
//         baseOffset: 0,
//         extentOffset: itemController.text.length,
//       );
//     }
//   });
//
//   return Container(
//     height: Get.height / 18,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(7),
//       color: dropdownBoxColor,
//       gradient: blueDropdownGr,
//     ),
//     child: AutoCompleteTextField<BrandListData>(
//       key: GlobalKey<AutoCompleteTextFieldState<BrandListData>>(),
//       controller: itemController,
//       focusNode: focusNode,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(top: 10, left: 30),
//         hintText: 'Brand Name',
//         hintStyle: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black),
//         border: InputBorder.none,
//         suffixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,),
//       ),
//       clearOnSubmit: false,
//       suggestions: controller.brandList?.toList() ?? [],
//       itemBuilder: (context, suggestion) {
//         return ListTile(
//           style: ListTileStyle.list,
//           tileColor: dropdownBoxColor,
//           title: Text(suggestion.brandname.toString()),
//         );
//       },
//       itemSorter: (a, b) {
//         return a.brandname!.compareTo(b.brandname!);
//       },
//       itemFilter: (suggestion, input) {
//
//         return suggestion.brandname!.toLowerCase().contains(input.toLowerCase());
//       },
//       itemSubmitted: (suggestion) {
//         controller.setBrand(suggestion);
//         itemController.text = suggestion.brandname?? '';
//         itemController.selection = TextSelection.fromPosition(
//           TextPosition(offset: itemController.text.length),
//         );
//       },
//     ),
//   );
// }
//   _dropdownRackBin(StockReconciliationController controller) {
//     final rackController = TextEditingController(text: controller.selectRackNoList?.rackno ?? "");
//     final focusNode = FocusNode();
//
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         rackController.selection = TextSelection(
//           baseOffset: 0,
//           extentOffset: rackController.text.length,
//         );
//       }
//     });
//
//     return Container(
//       height: Get.height / 18,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(7),
//         color: dropdownBoxColor,
//         gradient: blueDropdownGr,
//       ),
//       child: AutoCompleteTextField<RackListData>(
//         key: GlobalKey<AutoCompleteTextFieldState<RackListData>>(),
//         controller: rackController,
//         focusNode: focusNode,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.only(top: 10, left: 30),
//           hintText: 'Rack / Bin',
//           hintStyle: TextStyle().normal.copyWith(fontSize: 14, color: Colors.black),
//           border: InputBorder.none,
//           suffixIcon: Icon(Icons.search, color: Colors.deepOrangeAccent,),
//         ),
//         clearOnSubmit: false,
//         suggestions: controller.rackList?.toList() ?? [],
//         itemBuilder: (context, suggestion) {
//           return ListTile(
//             style: ListTileStyle.list,
//             tileColor: dropdownBoxColor,
//             title: Text(suggestion.rackno.toString()),
//           );
//         },
//         itemSorter: (a, b) {
//           return a.rackno!.compareTo(b.rackno!);
//         },
//         itemFilter: (suggestion, input) {
//           return suggestion.rackno!.toLowerCase().contains(input.toLowerCase());
//         },
//         itemSubmitted: (suggestion) {
//           controller.setRackNo(suggestion);
//           rackController.text = suggestion.rackno ?? '';
//           rackController.selection = TextSelection.fromPosition(
//             TextPosition(offset: rackController.text.length),
//           );
//         },
//       ),
//     );
//   }
//   Widget stockMoment(StockReconciliationController controller) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(" Stock Moment",
//               style: controller.isCheckingStockMoment
//                   ? TextStyle().bold.copyWith(fontSize: 17, color: purpleColor)
//                   : const TextStyle().bold.copyWith(
//                 fontSize: 17,
//                 color: Colors.red,
//               )),
//           SizedBox(
//             width: 20,
//           ),
//           InkWell(
//             onTap: () {
//               controller.tapOnCheck();
//             },
//             child: Image.asset(
//               controller.isCheckingStockMoment
//                   ? AppAssets.checkIcon
//                   : AppAssets.uncheckIcon,
//               width: 17,
//               height: 17,
//               color: controller.isCheckingStockMoment ? purpleColor : red2Color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget showReConsilationDate(StockReconciliationController controller) {
//     return Container(
//       height: Get.height * 0.0550,
//       width: Get.width * 0.900,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           )),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Reconciliation Day:",
//                 style: const TextStyle().normal.copyWith(fontSize: 14)),
//             SizedBox(
//               width: 10,
//             ),
//             Container(
//               decoration:
//               BoxDecoration(border: Border.all(color: Colors.black54)),
//               height: 50,
//               width: 80,
//               child: TextField(
//                 controller: controller.reconciliationDayController,
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: "Enter Day....",
//                     hintStyle: TextStyle(color: Colors.black45, fontSize: 13)),
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _dateColumn(StockReconciliationController controller,
//       BuildContext context,) {
//     return Padding(
//       padding: EdgeInsets.only(left: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               const SizedBox(width: 5),
//               Text(
//                 'FromDate',
//                 style: const TextStyle().bold.copyWith(
//                   fontSize: 15,
//                   color: red2Color,
//                 ),
//               ),
//               const SizedBox(
//                 width: 60,
//               ),
//               Text(
//                 'To Date',
//                 style: const TextStyle().bold.copyWith(
//                   fontSize: 15,
//                   color: red2Color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _dateView(controller.firstDate, Get.width * .31, true, controller,
//                   context),
//               _dateView(controller.lastDate, Get.width * .31, false, controller,
//                   context),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _dateView(String value,
//       double width,
//       bool isFirst,
//       StockReconciliationController controller,
//       BuildContext context,) {
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId
//             ?.split('-')
//             .first}');
//     String date = controller.firstDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//         formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: initDate,
//             firstDate: DateTime(currentYear),
//             lastDate: DateTime.now());
//
//         if (pickedDate != null) {
//           String formattedDate =
//           DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (isFirst) {
//             controller.setDate(formattedDate, true);
//             controller.setDateByDate(pickedDate, true);
//           } else {
//             controller.setDate(formattedDate, false);
//             controller.setDateByDate(pickedDate, false);
//           }
//         } else {
//           if (kDebugMode) {
//             print('Date is not selected');
//           }
//         }
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(value, style: const TextStyle().medium),
//                 const SizedBox(width: 10),
//                 Image.asset(
//                   AppAssets.calendarIcon,
//                   width: 18,
//                   height: 18,
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:digitalerp/response/brand_list_response.dart';
import 'package:digitalerp/response/get_store_name_resp.dart';
import 'package:digitalerp/response/rack_list_response.dart';
import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/stock%20_reconcillation/stock_reconciliation_controller/stock_reconciliation_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//  Design tokens 
const Color _kBg          = Color(0xFFF5F6FA);
const Color _kWhite       = Colors.white;
const Color _kBlue        = purpleColor;
final Color _kBlueBg      = purpleLightest;
const Color _kBorder      = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub     = Color(0xFF64748B);
const Color _kTextHint    = Color(0xFF94A3B8);

//  Shared helpers 
Widget _appBar(String title, {VoidCallback? onFilter}) {
  return Container(
    color: _kWhite,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios_new, color: _kTextPrimary, size: 22),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: _kTextPrimary)),
      ),
      if (onFilter != null)
        GestureDetector(
          onTap: onFilter,
          child: Container(
            height: 40, width: 40,
            decoration: BoxDecoration(
                color: _kBlueBg, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.filter_list_sharp, color: _kBlue, size: 20),
          ),
        ),
    ]),
  );
}

Widget _styledDropdown({required Widget child}) => Container(
  decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorder)),
  child: child,
);

Widget _sectionLabel(String label) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Text(label,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary)),
);

DropdownButton2 _buildDropdown2<T>({
  required String hint,
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
}) =>
    DropdownButton2<T>(
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
      dropdownDecoration:
      BoxDecoration(borderRadius: BorderRadius.circular(18), color: _kWhite),
      dropdownMaxHeight: 220,
      buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.transparent),
      isExpanded: true,
      hint: Text(hint,
          style: const TextStyle(fontSize: 14, color: _kTextHint)),
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: _kTextSub, size: 22),
      items: items,
      onChanged: onChanged,
    );

class StockReconciliationFilterView extends StatelessWidget {
  const StockReconciliationFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockReconciliationController>(
      init: StockReconciliationController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar('Stock Filter'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Store Name
                      _sectionLabel('Store Name'),
                      _styledDropdown(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<GetStoreNameData>(
                            buttonHeight: 50,
                            buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 14),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: _kWhite),
                            dropdownMaxHeight: 220,
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.transparent),
                            isExpanded: true,
                            hint: const Text('Store Name',
                                style: TextStyle(
                                    fontSize: 14, color: _kTextHint)),
                            value: controller.storeNameData,
                            icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: _kTextSub, size: 22),
                            items: controller.storeNameDataList?.map((item) {
                              return DropdownMenuItem<GetStoreNameData>(
                                value: item,
                                child: Text(item.storename ?? '',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: _kTextPrimary)),
                              );
                            }).toList(),
                            onChanged: controller.setStoreName,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Main Group
                      _sectionLabel('Main Group'),
                      _styledDropdown(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<StockCategoryList>(
                            buttonHeight: 50,
                            buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 14),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: _kWhite),
                            dropdownMaxHeight: 220,
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.transparent),
                            isExpanded: true,
                            hint: const Text('Main Group',
                                style: TextStyle(
                                    fontSize: 14, color: _kTextHint)),
                            value: controller.selectedMainCategoryValue,
                            icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: _kTextSub, size: 22),
                            items: controller.stockMainCategoryList?.map((item) {
                              return DropdownMenuItem<StockCategoryList>(
                                value: item,
                                child: Text(item.categoryname.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: _kTextPrimary)),
                              );
                            }).toList(),
                            onChanged: controller.setSelectMainGroupValue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Sub Group
                      _sectionLabel('Sub Group'),
                      _styledDropdown(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<BrandData>(
                            buttonHeight: 50,
                            buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 14),
                            dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: _kWhite),
                            dropdownMaxHeight: 220,
                            buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.transparent),
                            isExpanded: true,
                            hint: const Text('Sub Group',
                                style: TextStyle(
                                    fontSize: 14, color: _kTextHint)),
                            value: controller.selectedSubGroup,
                            icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: _kTextSub, size: 22),
                            items: controller.subGroupList?.map((item) {
                              return DropdownMenuItem<BrandData>(
                                value: item,
                                child: Text(item.subcategoryname.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: _kTextPrimary)),
                              );
                            }).toList(),
                            onChanged: controller.setSubGroup,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Brand Name (autocomplete)
                      _sectionLabel('Brand Name'),
                      _autoCompleteField<BrandListData>(
                        hint: 'Brand Name',
                        initial: controller.selectBrandList?.brandname ?? '',
                        suggestions: controller.brandList?.toList() ?? [],
                        itemBuilder: (ctx, s) => ListTile(
                          tileColor: _kWhite,
                          title: Text(s.brandname.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: _kTextPrimary)),
                        ),
                        itemSorter: (a, b) =>
                            a.brandname!.compareTo(b.brandname!),
                        itemFilter: (s, input) => s.brandname!
                            .toLowerCase()
                            .contains(input.toLowerCase()),
                        onSubmitted: (s) => controller.setBrand(s),
                      ),
                      const SizedBox(height: 14),

                      // Item Name (autocomplete)
                      _sectionLabel('Item Name / Code'),
                      _autoCompleteField<ProductDataList>(
                        hint: 'Item Name / Item Code',
                        initial: controller.selectedItem?.itemname ?? '',
                        suggestions: controller.itemList?.toList() ?? [],
                        itemBuilder: (ctx, s) => ListTile(
                          tileColor: _kWhite,
                          title: Text(s.itemname.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: _kTextPrimary)),
                        ),
                        itemSorter: (a, b) =>
                            a.itemname!.compareTo(b.itemname!),
                        itemFilter: (s, input) =>
                        s.itemname!
                            .toLowerCase()
                            .contains(input.toLowerCase()) ||
                            s.itemcode!
                                .toLowerCase()
                                .contains(input.toLowerCase()),
                        onSubmitted: (s) => controller.setItem(s),
                      ),
                      const SizedBox(height: 14),

                      // Rack / Bin (autocomplete)
                      _sectionLabel('Rack / Bin'),
                      _autoCompleteField<RackListData>(
                        hint: 'Rack / Bin',
                        initial: controller.selectRackNoList?.rackno ?? '',
                        suggestions: controller.rackList?.toList() ?? [],
                        itemBuilder: (ctx, s) => ListTile(
                          tileColor: _kWhite,
                          title: Text(s.rackno.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: _kTextPrimary)),
                        ),
                        itemSorter: (a, b) => a.rackno!.compareTo(b.rackno!),
                        itemFilter: (s, input) => s.rackno!
                            .toLowerCase()
                            .contains(input.toLowerCase()),
                        onSubmitted: (s) => controller.setRackNo(s),
                      ),
                      const SizedBox(height: 14),

                      // Stock Movement toggle
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                        decoration: BoxDecoration(
                            color: _kWhite,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: _kBorder)),
                        child: Row(children: [
                          const Expanded(
                            child: Text('Stock Movement',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _kTextPrimary)),
                          ),
                          GestureDetector(
                            onTap: controller.tapOnCheck,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 44, height: 24,
                              decoration: BoxDecoration(
                                color: controller.isCheckingStockMoment
                                    ? _kBlue
                                    : _kBorder,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 200),
                                alignment: controller.isCheckingStockMoment
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  width: 20, height: 20,
                                  decoration: const BoxDecoration(
                                      color: _kWhite,
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),

                      // Date range (when stock movement on)
                      if (controller.isCheckingStockMoment) ...[
                        const SizedBox(height: 14),
                        _sectionLabel('Date Range'),
                        _dateRangeRow(controller, context),
                      ],

                      const SizedBox(height: 14),

                      // Reconciliation Day
                      _sectionLabel('Reconciliation Day'),
                      Container(
                        decoration: BoxDecoration(
                            color: _kWhite,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: _kBorder)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        child: TextField(
                          controller: controller.reconciliationDayController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 14, color: _kTextPrimary),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter day...',
                            hintStyle: TextStyle(
                                color: _kTextHint, fontSize: 14),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),

            // Bottom buttons
            Container(
              color: _kWhite,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _kBlue,
                      side: const BorderSide(color: _kBorder, width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => controller.onSearch(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _kBlue,
                      foregroundColor: _kWhite,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Apply',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  //  Autocomplete helper 
  Widget _autoCompleteField<T>({
    required String hint,
    required String initial,
    required List<T> suggestions,
    required Widget Function(BuildContext, T) itemBuilder,
    required int Function(T, T) itemSorter,
    required bool Function(T, String) itemFilter,
    required void Function(T) onSubmitted,
  }) {
    final ctrl = TextEditingController(text: initial);
    final focus = FocusNode();
    focus.addListener(() {
      if (focus.hasFocus) {
        ctrl.selection =
            TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
      }
    });

    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _kBorder)),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: AutoCompleteTextField<T>(
        key: GlobalKey<AutoCompleteTextFieldState<T>>(),
        controller: ctrl,
        focusNode: focus,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: _kTextHint, fontSize: 14),
          suffixIcon:
          const Icon(Icons.search, color: _kTextSub, size: 18),
          contentPadding: const EdgeInsets.only(top: 14),
        ),
        clearOnSubmit: false,
        suggestions: suggestions,
        itemBuilder: itemBuilder,
        itemSorter: itemSorter,
        itemFilter: itemFilter,
        itemSubmitted: (s) {
          onSubmitted(s);
          ctrl.selection = TextSelection.fromPosition(
              TextPosition(offset: ctrl.text.length));
        },
      ),
    );
  }

  //  Date range row 
  Widget _dateRangeRow(
      StockReconciliationController controller, BuildContext context) {
    return Row(children: [
      Expanded(child: _datePicker(controller, context, isFirst: true)),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('to',
            style: TextStyle(fontSize: 14, color: _kTextSub)),
      ),
      Expanded(child: _datePicker(controller, context, isFirst: false)),
    ]);
  }

  Widget _datePicker(StockReconciliationController controller,
      BuildContext context,
      {required bool isFirst}) {
    final int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
    final String date =
    isFirst ? controller.firstDate : controller.lastDate;
    final DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
        formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(currentYear),
          lastDate: DateTime.now(),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: _kBlue, onPrimary: Colors.white),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          final fmt = DateFormat(AppString.ddMMyyyy).format(picked);
          controller.setDate(fmt, isFirst);
          controller.setDateByDate(picked, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _kBorder)),
        child: Row(children: [
          Expanded(
            child: Text(
              date == AppString.dateTimeEmpty ? 'DD/MM/YYYY' : date,
              style: TextStyle(
                  fontSize: 13,
                  color: date == AppString.dateTimeEmpty
                      ? _kTextHint
                      : _kTextPrimary),
            ),
          ),
          const Icon(Icons.calendar_today_outlined,
              size: 15, color: _kTextSub),
        ]),
      ),
    );
  }
}