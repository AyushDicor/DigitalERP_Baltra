// import 'package:digitalerp/response/stcok_category_data_response.dart';
// import 'package:digitalerp/response/subcategory_brand_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_detail/stock_taking_view/stock_taking_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class StockTakingView extends StatelessWidget {
//   const StockTakingView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StockTakingController>(
//       init: StockTakingController(),
//       builder: (controller) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: Center(
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage(AppAssets.dashboardBg),
//                             fit: BoxFit.fill)),
//                     child: SafeArea(
//                         child: MyAppBar(
//                             title: 'Stock Taking',
//                             onBackTap: () => controller.backTap())),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.17,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       children: [
//                         _dropdown(controller),
//                         const SizedBox(height: 30),
//                         aucompleteText(controller, context),
//                         const SizedBox(height: 30),
//                         TextFormField(
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                           ],
//                           maxLength: 5,
//                           style: const TextStyle().normal,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.done,
//                           controller: controller.quantityController,
//                           focusNode: controller.quantityFocus,
//                           decoration: const InputDecoration()
//                               .txtFieldStyle2(
//                                 hintText: ' Enter Quantity',
//                                 labelName: ' Quantity',
//                               )
//                               .copyWith(
//                                 labelStyle: const TextStyle().bold.copyWith(
//                                       fontSize: 12,
//                                       color: red2Color,
//                                     ),
//                               ),
//                         )
//                         /*Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Quantity',
//                               style: const TextStyle()
//                                   .normal
//                                   .copyWith(fontSize: 14, color: msgTextColor),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: orangeColor.withValues(alpha:0.72),
//                                   borderRadius: BorderRadius.circular(50)),
//                               padding: const EdgeInsets.all(2),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       if (controller.productQuantity != 1) {
//                                         controller.productQtyDecrease();
//                                       }
//                                     },
//                                     child: const Icon(
//                                       Icons.remove_circle,
//                                       color: Colors.white,
//                                       size: 28,
//                                     ),
//                                   ),
//                                   Text(
//                                     '  ${controller.productQuantity}  ',
//                                     style: const TextStyle()
//                                         .bold
//                                         .bold
//                                         .copyWith(fontSize: 20, color: Colors.white),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       controller.productQtyIncrease();
//                                     },
//                                     child: const Icon(
//                                       Icons.add_circle,
//                                       color: Colors.white,
//                                       size: 28,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),*/
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: AppBottomButton(
//                     onPressed: () {
//                       controller.tapOnSubmit();
//                     },
//                     name: 'Submit',
//                   ),
//                 )
//               ],
//             ),
//           ),
//           /*
//           bottomNavigationBar: ElevatedButton(
//             onPressed: () {
//               controller.tapOnSubmit();
//             },
//             style: ElevatedButton.styleFrom(
//               elevation: 10,
//               padding: EdgeInsets.zero,
//               primary: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40.0),
//               ),
//             ),
//             child: Container(
//               // width: Get.width,
//               height: 60,
//               decoration: const BoxDecoration(
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(40.0)),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       grTopColor,
//                       grBottomColor,
//                     ],
//                   )),
//               alignment: Alignment.center,
//               child: Text(
//                 'Submit',
//                 style: const TextStyle().bold.copyWith(color: Colors.white),
//               ),
//             ),
//           ),
//
//            */
//         );
//       },
//     );
//   }
//
//   _dropdown(StockTakingController controller) {
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
//           'Select Category',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.stockCategoryList.map((items) {
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
//   Widget aucompleteText(
//       StockTakingController controller, BuildContext context) {
//     return RawAutocomplete<ProductDataList>(
//       focusNode: controller.productFocus,
//       textEditingController: controller.productController,
//       optionsViewBuilder: ((context, onSelected, options) => Material(
//             child: ListView.builder(
//                 padding: EdgeInsets.all(10.0),
//                 itemCount: options.length,
//                 itemBuilder: ((context, index) {
//                   ProductDataList option = options.elementAt(index);
//                   return GestureDetector(
//                       onTap: () {
//                         onSelected(option);
//                       },
//                       child: ListTile(
//                           title: Text('${option.itemname}',
//                               style: const TextStyle(color: Colors.black38))));
//                 })),
//           )),
//       fieldViewBuilder:
//           (context, textEditingController, focusNode, onFieldSubmitted) =>
//               TextFormField(
//         focusNode: focusNode,
//         controller: textEditingController,
//         onEditingComplete: onFieldSubmitted,
//         style: const TextStyle().normal,
//         keyboardType: TextInputType.text,
//         onFieldSubmitted:(valu) => focusNode.unfocus() ,
//         textInputAction: TextInputAction.done,
//         decoration: const InputDecoration()
//             .txtFieldStyle2(
//               hintText: ' Enter Product Name',
//               labelName: ' Product Name',
//             )
//             .copyWith(
//               labelStyle: const TextStyle().bold.copyWith(
//                     fontSize: 12,
//                     color: red2Color,
//                   ),
//             ),
//       ),
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<ProductDataList>.empty();
//         }
//         return controller.stockProductList.where((option) {
//           return option.itemname
//               .toString()
//               .toLowerCase()
//               .startsWith(textEditingValue.text.toLowerCase());
//         }).toList();
//       },
//       displayStringForOption: (ProductDataList option) =>
//           option.itemname.toString(),
//       onSelected: (selection) {
//
//           controller.selectedproduct = selection;
//           debugPrint('You just selected $selection');
//
//       },
//     );
//   }
// }

import 'package:digitalerp/response/stcok_category_data_response.dart';
import 'package:digitalerp/response/subcategory_brand_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_detail/stock_taking_view/stock_taking_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StockTakingView extends StatelessWidget {
  const StockTakingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockTakingController>(
      init: StockTakingController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => controller.backTap(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Stock Taking',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => controller.tapOnSubmit(),
                icon: const Icon(Icons.check_circle_outline_rounded,
                    color: Colors.white, size: 20),
                label: const Text('Submit',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Category dropdown 
              const Text('Category',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: newTextSecondary)),
              const SizedBox(height: 6),
              _categoryDropdown(controller),
              const SizedBox(height: 20),

              //  Product autocomplete 
              const Text('Product Name',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: newTextSecondary)),
              const SizedBox(height: 6),
              _productAutocomplete(controller, context),
              const SizedBox(height: 20),

              //  Quantity field 
              const Text('Quantity',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: newTextSecondary)),
              const SizedBox(height: 6),
              TextField(
                controller: controller.quantityController,
                focusNode: controller.quantityFocus,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 5,
                style: const TextStyle(fontSize: 14, color: newTextPrimary),
                decoration: InputDecoration(
                  hintText: 'Enter quantity',
                  hintStyle:
                      const TextStyle(fontSize: 14, color: newTextSecondary),
                  prefixIcon: const Icon(
                      Icons.production_quantity_limits_outlined,
                      color: newTextSecondary,
                      size: 20),
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: newBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                        const BorderSide(color: newBlueColor, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Category dropdown 

  Widget _categoryDropdown(StockTakingController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<StockCategoryList>(
        isExpanded: true,
        buttonHeight: 48,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        buttonDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        dropdownMaxHeight: 220,
        value: controller.selectedCategoryValue,
        hint: const Text('Select Category',
            style: TextStyle(fontSize: 14, color: newTextSecondary)),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 20),
        items: controller.stockCategoryList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.categoryname.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: controller.setSelectDropdownValue,
      ),
    );
  }

  //  Product autocomplete 

  Widget _productAutocomplete(
      StockTakingController controller, BuildContext context) {
    return RawAutocomplete<ProductDataList>(
      focusNode: controller.productFocus,
      textEditingController: controller.productController,
      optionsViewBuilder: (ctx, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (ctx, i) {
                final option = options.elementAt(i);
                return InkWell(
                  onTap: () => onSelected(option),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    child: Row(children: [
                      const Icon(Icons.inventory_2_outlined,
                          size: 16, color: newTextSecondary),
                      const SizedBox(width: 8),
                      Text(option.itemname.toString(),
                          style: const TextStyle(
                              fontSize: 14, color: newTextPrimary)),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      fieldViewBuilder: (ctx, textCtrl, focusNode, onSubmit) => TextField(
        focusNode: focusNode,
        controller: textCtrl,
        onEditingComplete: onSubmit,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        style: const TextStyle(fontSize: 14, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: 'Search product name...',
          hintStyle: const TextStyle(fontSize: 14, color: newTextSecondary),
          prefixIcon: const Icon(Icons.search_rounded,
              color: newTextSecondary, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: newBlueColor, width: 1.5),
          ),
        ),
      ),
      optionsBuilder: (tv) {
        if (tv.text.isEmpty) return const [];
        return controller.stockProductList.where((o) => o.itemname
            .toString()
            .toLowerCase()
            .startsWith(tv.text.toLowerCase()));
      },
      displayStringForOption: (o) => o.itemname.toString(),
      onSelected: (s) {
        controller.selectedproduct = s;
      },
    );
  }
}
