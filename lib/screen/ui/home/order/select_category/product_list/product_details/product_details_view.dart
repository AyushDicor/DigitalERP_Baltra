// // import 'package:digitalerp/response/unit_list_response.dart';
// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_controller.dart';
// // import 'package:digitalerp/utils/app_assets.dart';
// // import 'package:digitalerp/utils/app_constant.dart';
// // import 'package:digitalerp/utils/app_network_image.dart';
// // import 'package:digitalerp/utils/my_app_bar_new.dart';
// // import 'package:digitalerp/utils/safeAreaWrapper.dart';
// // import 'package:dropdown_button2/dropdown_button2.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // class ProductDetailsView extends StatelessWidget {
// //   const ProductDetailsView({
// //     Key? key,
// //   }) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<ProductDetailsController>(
// //       init: ProductDetailsController(),
// //       builder: (controller) {
// //         return Scaffold(
// //           resizeToAvoidBottomInset: false,
// //           body: Center(
// //             child: Stack(
// //               children: [
// //                 Positioned(
// //                   top: 0,
// //                   bottom: 0,
// //                   right: 0,
// //                   left: 0,
// //                   child: Container(
// //                     decoration: const BoxDecoration(
// //                       image: DecorationImage(
// //                           image: AssetImage(AppAssets.productDetailsBg),
// //                           fit: BoxFit.fill),
// //                     ),
// //                     child: SafeArea(
// //                       child: MyAppBar(
// //                         title: 'Product Details',
// //                         onBackTap: () => controller.backTap(),
// //                         showCartIcon: true,
// //                         onCartTap: () => controller.tapOnCart2(),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 controller.isBusy
// //                     ? showLoader()
// //                     : Positioned(
// //                         right: 0,
// //                         left: 0,
// //                         bottom: 0,
// //                         top: Get.height * 0.145,
// //                         child: SingleChildScrollView(
// //                           child: Column(
// //                             children: [
// //                               /*SizedBox(height: Get.height * 0.05)*/
// //                               SizedBox(
// //                                 height: Get.width * .4,
// //                                 child: AppNetworkImage(
// //                                   image: controller
// //                                           .productDetailsResponse?.itemImage ??
// //                                       '',
// //                                   fit: BoxFit.contain,
// //                                   // width: Get.width * .8,
// //                                 ),
// //                               ),
// //                               SizedBox(height: Get.height * 0.12),
// //                               Container(
// //                                 decoration: const BoxDecoration(
// //                                   borderRadius: BorderRadius.vertical(
// //                                       top: Radius.circular(45)),
// //                                   color: whiteBoxColor,
// //                                 ),
// //                                 padding: const EdgeInsets.symmetric(
// //                                     horizontal: 20, vertical: 30),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Row(
// //                                       mainAxisAlignment:
// //                                           MainAxisAlignment.spaceBetween,
// //                                       children: [
// //                                         Expanded(
// //                                           child: Text(
// //                                             controller.productDetailsResponse
// //                                                     ?.itemName ??
// //                                                 '',
// //                                             style: const TextStyle()
// //                                                 .bold
// //                                                 .copyWith(
// //                                                     fontSize: 18,
// //                                                     color: purpleColor),
// //                                           ),
// //                                         ),
// //                                         _qtyController(controller)
// //                                       ],
// //                                     ),
// //                                     const SizedBox(height: 15),
// //                                     Text(
// //                                       controller.productDetailsResponse
// //                                               ?.itemDescription ??
// //                                           '',
// //                                       style: const TextStyle().medium.copyWith(
// //                                           fontSize: 12, color: Colors.black),
// //                                       maxLines: 6,
// //                                     ),
// //                                     const SizedBox(height: 15),
// //                                     Text(
// //                                       'Unit',
// //                                       style: const TextStyle()
// //                                           .bold
// //                                           .copyWith(fontSize: 14),
// //                                     ),
// //                                     const SizedBox(height: 10),
// //                                     _unitCard(controller, 0),
// //                                     const SizedBox(
// //                                       height: 20,
// //                                     ),
// //                                     ListView.builder(
// //                                       shrinkWrap: true,
// //                                       physics:
// //                                           const NeverScrollableScrollPhysics(),
// //                                       itemCount:
// //                                           controller.itemVariantList.length,
// //                                       itemBuilder: (context, index) {
// //                                         return listOrderCard(context, index,
// //                                                 controller) /*produCard(
// //                                             context, index, controller)*/
// //                                             ;
// //                                       },
// //                                     ),
// //                                     const SizedBox(
// //                                       height: 40,
// //                                     )
// //
// //                                     /*
// //                             SizedBox(
// //                               height: 75,
// //                               child: ListView.separated(
// //                                 separatorBuilder: (context, index) => const SizedBox(width: 30),
// //                                 padding: const EdgeInsets.symmetric(vertical: 10),
// //                                 scrollDirection: Axis.horizontal,
// //                                 itemCount: 4,
// //                                 itemBuilder: (context, index) => _unitCard(controller, index),
// //                               ),
// //                             ),
// //
// //                              */
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                 _bottomButton(controller, context),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _unitCard(ProductDetailsController controller, int index) {
// //     var item = controller.productDetailsResponse?.unit;
// //     return InkWell(
// //       onTap: () => controller.tapOnCard(index),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(10),
// //           gradient: LinearGradient(
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //               colors: controller.selectedIndexValue == index
// //                   ? [orangeColor, red2Color]
// //                   : [Colors.white, Colors.white]),
// //           boxShadow: const [
// //             BoxShadow(
// //                 blurRadius: 4, color: Colors.black12, offset: Offset(0, 4))
// //           ],
// //         ),
// //         height: 55,
// //         width: 120,
// //         alignment: Alignment.center,
// //         child: DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //             buttonHeight: 40,
// //             buttonPadding:
// //                 const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: const LinearGradient(
// //                 colors: [
// //                   orangeColor,
// //                   red2Color
// //                   /*grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)*/
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: false,
// //             /*hint: Text(
// //               'Select Unit',
// //               style: const TextStyle().normal.copyWith(
// //                   fontSize: 11,
// //                   fontWeight: FontWeight.normal,
// //                   color: msgTextColor),
// //               overflow: TextOverflow.ellipsis,
// //             ),*/
// //             value: controller.selectedUnit,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.unitList.map((items) {
// //               return DropdownMenuItem(
// //                 value: items,
// //                 child: Text(items.unitname.toString()),
// //               );
// //             }).toList(),
// //             onChanged: (newValue) => controller.setSelectUnitValue(newValue),
// //           ),
// //         ),
// //         /*Text(
// //           item ?? '',
// //           style: const TextStyle().bold.copyWith(
// //               color: controller.selectedIndexValue == index
// //                   ? Colors.white
// //                   : medGreyColor,
// //               fontSize: 14),
// //         ),*/
// //       ),
// //     );
// //   }
// //
// //   Widget _qtyController(ProductDetailsController controller) {
// //     return Obx(() => Container(
// //           decoration: BoxDecoration(
// //               color: orangeColor.withValues(alpha:0.72),
// //               borderRadius: BorderRadius.circular(50)),
// //           padding: const EdgeInsets.all(3),
// //           width: controller.isTextField.value ? 110 : 72,
// //           child: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               InkWell(
// //                 onTap: controller.isTextField.value
// //                     ? () {
// //                         if (double.parse(
// //                                     controller.quantityTextController.text) >
// //                                 0 &&
// //                             controller.quantityTextController.text.isNotEmpty) {
// //                           controller.productQtyDecreaseFromTextField();
// //                         }
// //                       }
// //                     : () {
// //                         if (controller.productDetailsResponse?.quantity != 1) {
// //                           controller.productQtyDecrease();
// //                         }
// //                       },
// //                 child: const Icon(
// //                   Icons.remove_circle,
// //                   color: Colors.white,
// //                   size: 19,
// //                 ),
// //               ),
// //               controller.isTextField.value
// //                   ? ConstrainedBox(
// //                       constraints:
// //                           const BoxConstraints(maxWidth: 65, maxHeight: 30),
// //                       child: TextFormField(
// //                         maxLines: 1,
// //                         textAlign: TextAlign.center,
// //                         textAlignVertical: TextAlignVertical.bottom,
// //                         cursorColor: Colors.grey,
// //                         keyboardType: TextInputType.number,
// //                         decoration: InputDecoration(
// //                           counterText: '',
// //                           contentPadding:
// //                               const EdgeInsets.only(top: 5, bottom: 15),
// //                           hintText: '',
// //                           hintTextDirection: TextDirection.rtl,
// //                           /*hintStyle: const TextStyle(
// //                           fontSize: 12, height: 1.0, color: Colors.white),*/
// //                           fillColor: Colors.transparent,
// //                           filled: true,
// //                           border: InputBorder.none,
// //                           focusedBorder: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(30),
// //                             borderSide: const BorderSide(
// //                               color: Colors.transparent,
// //                             ),
// //                           ),
// //                         ),
// //                         style: const TextStyle().bold.copyWith(
// //                             fontSize: 13, height: 1, color: Colors.white),
// //                         controller: controller.quantityTextController,
// //                         focusNode: controller.quantityTextFocus,
// //                         onChanged: (value) {
// //                           controller.onChangeQuantityText(value);
// //                         },
// //                       ),
// //                     )
// //                   : Expanded(
// //                       child: GestureDetector(
// //                         onTap: () {
// //                           controller.tapOnQuantityText();
// //                         },
// //                         child: Text(
// //                           '${controller.productDetailsResponse?.quantity?.toInt().toString()}',
// //                           style: const TextStyle()
// //                               .bold
// //                               .bold
// //                               .copyWith(color: Colors.white),
// //                           textAlign: TextAlign.center,
// //                         ),
// //                       ),
// //                     ),
// //               InkWell(
// //                 onTap: controller.isTextField.value
// //                     ? () {
// //                         if (controller.quantityTextController.text.isNotEmpty) {
// //                           controller.productQtyIncreaseFromTextField();
// //                         }
// //                       }
// //                     : () {
// //                         controller.productQtyIncrease();
// //                       },
// //                 child: const Icon(
// //                   Icons.add_circle,
// //                   color: Colors.white,
// //                   size: 19,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ));
// //   }
// //
// //   Widget _bottomButton(
// //       ProductDetailsController controller, BuildContext context) {
// //     return Positioned(
// //       bottom: 0,
// //       right: 0,
// //       left: 0,
// //       child: SafeAreaWrapper(
// //         child: Container(
// //           width: Get.width,
// //           height: 60,
// //           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// //           decoration: const BoxDecoration(
// //             borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
// //             gradient: gr1,
// //           ),
// //           alignment: Alignment.center,
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   const SizedBox(width: 26),
// //                   controller.unitList.isNotEmpty
// //                       ? Obx(() => Text(
// //                             '\u{20B9}${controller.totalAmount.toStringAsFixed(2)}',
// //                             style: const TextStyle()
// //                                 .bold
// //                                 .copyWith(color: Colors.white, fontSize: 20),
// //                           ))
// //                       : Visibility(
// //                           visible: controller.totalAmount.value == 0.0,
// //                           child: Text(
// //                             '\u{20B9}${(controller.productDetailsResponse?.rate ?? 00).toStringAsFixed(2)}',
// //                             style: const TextStyle()
// //                                 .bold
// //                                 .copyWith(color: Colors.white, fontSize: 20),
// //                           ),
// //                           replacement: Text(
// //                             '\u{20B9}${(controller.totalAmount).toStringAsFixed(2)}',
// //                             style: const TextStyle()
// //                                 .bold
// //                                 .copyWith(color: Colors.white, fontSize: 20),
// //                           ),
// //                         ),
// //                 ],
// //               ),
// //               Obx(() => MaterialButton(
// //                     onPressed: controller.isInCart.value
// //                         ? () {
// //                             controller.tapOnGotoCart(context);
// //                           }
// //                         : () {
// //                             controller.addItem();
// //                             controller.addToCartFormVariant();
// //                           },
// //                     shape: const StadiumBorder(),
// //                     color: Colors.white,
// //                     padding:
// //                         const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
// //                     child: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Image.asset(
// //                           AppAssets.cartIcon,
// //                           height: 14,
// //                           width: 16,
// //                           color: red2Color,
// //                         ),
// //                         const SizedBox(width: 10),
// //                         Text(
// //                           controller.isInCart.value
// //                               ? 'Go to Cart'
// //                               : 'Add to Cart',
// //                           style:
// //                               const TextStyle().bold.copyWith(color: red2Color),
// //                         ),
// //                       ],
// //                     ),
// //                   ))
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget listOrderCard(
// //       BuildContext context, int index, ProductDetailsController controller) {
// //     //var isInCart = controller.productList[index].isAddedInCart;
// //     //var item = controller.productList[index];
// //     return InkWell(
// //       onTap: () {
// //         /*controller.tapOnItemVariantCard(index)*/
// //       },
// //       child: Card(
// //         shape:
// //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
// //         margin: const EdgeInsets.symmetric(vertical: 10),
// //         elevation: 4,
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 10),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               const SizedBox(width: 10),
// //               AppNetworkImage(
// //                 image: controller.itemVariantList[index].itemimage ?? '',
// //                 fit: BoxFit.fill,
// //                 height: Get.height * 0.1,
// //                 width: Get.width * 0.2,
// //               ),
// //               const SizedBox(width: 18),
// //               Expanded(
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       controller.itemVariantList[index].itemname ?? '',
// //                       style: const TextStyle()
// //                           .bold
// //                           .copyWith(color: Colors.black, fontSize: 14),
// //                       textAlign: TextAlign.start,
// //                       maxLines: 2,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     const SizedBox(height: 20),
// //                     Row(
// //                       children: [
// //                         Text(
// //                           '\u{20B9} ${controller.variantRate(index)}',
// //                           style: const TextStyle()
// //                               .bold
// //                               .copyWith(color: purpleColor, fontSize: 18),
// //                         ),
// //                         const SizedBox(
// //                           width: 10,
// //                         ),
// //                         _unitCard2(controller, index)
// //                       ],
// //                     )
// //                   ],
// //                 ),
// //               ),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   /*InkWell(
// //                     onTap: () {
// //                       controller.addToCartFormVariant(index);
// //                     },
// //                     child: Container(
// //                       padding:
// //                           const EdgeInsets.only(left: 3, top: 3, bottom: 3),
// //                       height: 26,
// //                       width: 43,
// //                       decoration: const BoxDecoration(
// //                           gradient: LinearGradient(
// //                               colors:
// //                                   */ /*item.isInCart ?? false ? onlyGrey :*/ /* grad1),
// //                           borderRadius: BorderRadius.only(
// //                             bottomLeft: Radius.circular(25),
// //                             topLeft: Radius.circular(25),
// //                           )),
// //                       alignment: Alignment.centerLeft,
// //                       child: const CircleAvatar(
// //                         radius: 10,
// //                         backgroundColor: Colors.white,
// //                         child: Align(
// //                           alignment: Alignment.center,
// //                           child: Icon(
// //                             Icons.add,
// //                             size: 18,
// //                             color: */ /*item.isInCart ?? false
// //                                 ? Colors.grey red2Color
// //                                 :*/ /*
// //                                 purpleColor,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),*/
// //                   const SizedBox(height: 20),
// //                   _qtyController2(
// //                     controller,
// //                     index,
// //                   )
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _unitCard2(ProductDetailsController controller, int index) {
// //     //var item = controller.productDetailsResponse?.unit;
// //     return InkWell(
// //       //onTap: () => controller.tapOnCard(index),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(7),
// //           gradient: LinearGradient(
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //               colors: controller.selectedIndexValue == index
// //                   ? [orangeColor, red2Color]
// //                   : [/*Colors.white, Colors.white*/ orangeColor, red2Color]),
// //           boxShadow: const [
// //             BoxShadow(
// //                 blurRadius: 4, color: Colors.black12, offset: Offset(0, 4))
// //           ],
// //         ),
// //         height: 25,
// //         alignment: Alignment.center,
// //         child: DropdownButtonHideUnderline(
// //           child: DropdownButton2<UnitListData?>(
// //             buttonHeight: 18,
// //             buttonPadding:
// //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: const LinearGradient(
// //                 colors: [
// //                   orangeColor,
// //                   red2Color
// //                   /*grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)*/
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: false,
// //             hint: Text(
// //               controller.itemVariantList[index].unit ?? '',
// //               style: const TextStyle().normal.copyWith(
// //                   fontSize: 12, fontWeight: FontWeight.bold, color: blackColor),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             value: controller.itemVariantList[index].selectedUnit,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.unitList.map((items) {
// //               return DropdownMenuItem(
// //                 value: items,
// //                 child: Text(items.unitname.toString()),
// //               );
// //             }).toList(),
// //             onChanged: (UnitListData? newValue) {
// //               controller.itemVariantList[index].selectedUnit = newValue;
// //               controller.itemVariantList[index].unit = newValue?.unitname;
// //               //  controller.setSelectUnitValue(newValue);
// //             },
// //           ),
// //         ),
// //         /*Text(
// //           item ?? '',
// //           style: const TextStyle().bold.copyWith(
// //               color: controller.selectedIndexValue == index
// //                   ? Colors.white
// //                   : medGreyColor,
// //               fontSize: 14),
// //         ),*/
// //       ),
// //     );
// //   }
// //
// //   Widget _qtyController2(ProductDetailsController controller, int index) {
// //     return Container(
// //       decoration: BoxDecoration(
// //           color: orangeColor.withValues(alpha:0.72),
// //           borderRadius: BorderRadius.circular(50)),
// //       padding: const EdgeInsets.all(1),
// //       margin: const EdgeInsets.symmetric(horizontal: 4),
// //       width: controller.itemVariantList[index].isTextField ?? false ? 105 : 65,
// //       child: Row(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           InkWell(
// //             onTap: controller.itemVariantList[index].isTextField ?? false
// //                 ? () {
// //                     if (controller.variantQuantityTextController.text != "0" &&
// //                         controller
// //                             .variantQuantityTextController.text.isNotEmpty) {
// //                       controller.variantQtyDecreaseFromTextField(index);
// //                     } else {
// //                       //controller.removeFromCart(index);
// //                     }
// //                   }
// //                 : () {
// //                     if (controller.itemVariantList[index].quantity! > 0) {
// //                       controller.variantProductQtyDecrease(index);
// //                     }
// //                   },
// //             child: const Icon(
// //               Icons.remove_circle,
// //               color: Colors.white,
// //               size: 19,
// //             ),
// //           ),
// //           controller.itemVariantList[index].isTextField ?? false
// //               ? ConstrainedBox(
// //                   constraints:
// //                       const BoxConstraints(maxWidth: 65, maxHeight: 30),
// //                   child: TextFormField(
// //                     maxLines: 1,
// //                     textAlign: TextAlign.center,
// //                     textAlignVertical: TextAlignVertical.bottom,
// //                     cursorColor: Colors.grey,
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       counterText: '',
// //                       contentPadding: const EdgeInsets.only(top: 5, bottom: 15),
// //                       hintText: '',
// //                       hintTextDirection: TextDirection.rtl,
// //                       /*hintStyle: const TextStyle(
// //                           fontSize: 12, height: 1.0, color: Colors.white),*/
// //                       fillColor: Colors.transparent,
// //                       filled: true,
// //                       border: InputBorder.none,
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                         borderSide: const BorderSide(
// //                           color: Colors.transparent,
// //                         ),
// //                       ),
// //                     ),
// //                     style: const TextStyle()
// //                         .bold
// //                         .copyWith(fontSize: 13, height: 1, color: Colors.white),
// //                     controller: controller.variantQuantityTextController,
// //                     focusNode: controller.variantQuantityTextFocus,
// //                     onChanged: (value) {
// //                       controller.onChangeVariantQuantityText(value, index);
// //                     },
// //                   ),
// //                 )
// //               : Expanded(
// //                   child: GestureDetector(
// //                     onTap: () {
// //                       controller.tapOnVariantQuantityText(index);
// //                     },
// //                     child: Text(
// //                       '${controller.itemVariantList[index].quantity?.toInt()}',
// //                       style: const TextStyle()
// //                           .bold
// //                           .bold
// //                           .copyWith(fontSize: 14, color: Colors.white),
// //                       textAlign: TextAlign.center,
// //                     ),
// //                   ),
// //                 ),
// //           InkWell(
// //             onTap: controller.itemVariantList[index].isTextField ?? false
// //                 ? () {
// //                     if (controller
// //                         .variantQuantityTextController.text.isNotEmpty) {
// //                       controller.variantQtyIncreaseFromTextField(index);
// //                     } else {
// //                       //controller.removeFromCart(index);
// //                     }
// //                   }
// //                 : () {
// //                     controller.variantProductQtyIncrease(index);
// //                   },
// //             child: const Icon(
// //               Icons.add_circle,
// //               color: Colors.white,
// //               size: 19,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget produCard(
// //       BuildContext context, int index, ProductDetailsController controller) {
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
// //       margin: const EdgeInsets.only(right: 12),
// //       elevation: 4,
// //       child: InkWell(
// //         onTap: () {
// //           controller.tapOnItemVariantCard(index);
// //         },
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             AppNetworkImage(
// //               image: controller.itemVariantList[index].itemimage ?? '',
// //               height: 65,
// //               // width: 130,
// //               fit: BoxFit.fill,
// //             ),
// //             const SizedBox(
// //               height: 15,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 3),
// //               child: Text(
// //                 controller.itemVariantList[index].itemname ?? '',
// //                 style: const TextStyle()
// //                     .medium
// //                     .copyWith(fontSize: 12, color: Colors.black),
// //                 textAlign: TextAlign.center,
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //             ),
// //             Container(
// //               padding: const EdgeInsets.symmetric(vertical: 12),
// //               child: Text('\u{20B9}${controller.itemVariantList[index].rate}',
// //                   style: const TextStyle()
// //                       .bold
// //                       .copyWith(fontSize: 18, color: purpleColor)),
// //             ),
// //             const SizedBox(
// //               height: 5,
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:digitalerp/response/related_product_response.dart';
// import 'package:digitalerp/response/unit_list_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_controller.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProductDetailsView extends StatelessWidget {
//   const ProductDetailsView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductDetailsController>(
//       init: ProductDetailsController(),
//       builder: (ctrl) => Scaffold(
//         backgroundColor: Colors.white,
//         body: ctrl.isBusy
//             ? const Center(child: CircularProgressIndicator(color: newBlueColor))
//             : Column(
//           children: [
//             SafeArea(
//               bottom: false,
//               child: MyAppBar(
//                 title: 'Detail',
//                 onBackTap: () => ctrl.backTap(),
//                 showCartIcon: true,
//                 onCartTap: () => ctrl.tapOnCart2(),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _imageCard(ctrl),
//                     Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _titleRow(ctrl),
//                           const SizedBox(height: 12),
//                           _stockRow(ctrl),
//                           const SizedBox(height: 8),
//                           Text(
//                             ctrl.productDetailsResponse?.itemDescription ?? '',
//                             style: const TextStyle(fontSize: 13, color: newTextSecondary, height: 1.5),
//                           ),
//                           const SizedBox(height: 20),
//                           if (ctrl.unitList.isNotEmpty) _unitSection(ctrl),
//                           const SizedBox(height: 20),
//                           _additionalInfo(),
//                           const SizedBox(height: 20),
//                           if (ctrl.itemVariantList.isNotEmpty) _relatedProducts(ctrl),
//                           const SizedBox(height: 100),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomSheet: ctrl.isBusy ? null : _addToCartSheet(ctrl),
//       ),
//     );
//   }
//
//   Widget _imageCard(ProductDetailsController ctrl) {
//     return Stack(
//       children: [
//         Container(
//           height: 260,
//           width: double.infinity,
//           color: newSurfaceColor,
//           child: AppNetworkImage(
//             image: ctrl.productDetailsResponse?.itemImage ?? '',
//             fit: BoxFit.contain,
//           ),
//         ),
//         Positioned(
//           top: 12, left: 12,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//             decoration: BoxDecoration(color: newBlueColor, borderRadius: BorderRadius.circular(6)),
//             child: const Text('30% OFF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
//           ),
//         ),
//         Positioned(
//           top: 12, right: 12,
//           child: Container(
//             width: 34, height: 34,
//             decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: newBorderColor)),
//             child: const Icon(Icons.favorite_border_rounded, size: 16, color: newBlueColor),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _titleRow(ProductDetailsController ctrl) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           ctrl.productDetailsResponse?.itemName ?? '',
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: newTextPrimary),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF59E0B).withValues(alpha:0.15),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Row(children: [
//                 Icon(Icons.star_rounded, size: 13, color: Color(0xFFF59E0B)),
//                 SizedBox(width: 3),
//                 Text('4.4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFF59E0B))),
//               ]),
//             ),
//             const SizedBox(width: 8),
//             const Text('1,800 Reviews', style: TextStyle(fontSize: 12, color: newTextSecondary)),
//             const Spacer(),
//             Text(
//               '₹${ctrl.productDetailsResponse?.rate?.toStringAsFixed(0) ?? '0'}',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: newBlueColor),
//             ),
//             const Text(' /unit', style: TextStyle(fontSize: 11, color: newTextSecondary)),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _stockRow(ProductDetailsController ctrl) {
//     final qty = ctrl.productDetailsResponse?.quantity?.toInt() ?? 0;
//     return Row(children: [
//       const Text('In Stock : ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
//       Text('$qty unit', style: const TextStyle(fontSize: 13, color: newGreenColor, fontWeight: FontWeight.w700)),
//     ]);
//   }
//
//   Widget _unitSection(ProductDetailsController ctrl) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Select Length', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
//         const SizedBox(height: 10),
//         Wrap(
//           spacing: 10, runSpacing: 10,
//           children: ctrl.unitList.asMap().entries.map((entry) {
//             final isSelected = ctrl.selectedIndexValue == entry.key;
//             return GestureDetector(
//               onTap: () { ctrl.tapOnCard(entry.key); ctrl.update(); },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.white : newSurfaceColor,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: isSelected ? newBlueColor : newBorderColor,
//                     width: isSelected ? 1.5 : 1,
//                   ),
//                 ),
//                 child: Text(
//                   entry.value.unitname ?? '',
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: isSelected ? newBlueColor : newTextPrimary,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
//
//   Widget _additionalInfo() {
//     const info = [
//       ['Material', 'High-quality Stainless Steel (Corrosion Resistant)'],
//       ['Grade', 'CI-115 (Machio Finish)'],
//       ['Finish', 'Smooth & Polished Surface'],
//       ['Usage', 'Construction, Plumbing, Industrial & Fabrication work'],
//     ];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Additional Information',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
//         const SizedBox(height: 10),
//         ...info.map((item) => Padding(
//           padding: const EdgeInsets.only(bottom: 6),
//           child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             const Text('• ', style: TextStyle(color: newTextSecondary)),
//             Expanded(
//               child: RichText(
//                 text: TextSpan(style: const TextStyle(fontSize: 13), children: [
//                   TextSpan(text: '${item[0]} : ',
//                       style: const TextStyle(fontWeight: FontWeight.w700, color: newTextPrimary)),
//                   TextSpan(text: item[1], style: const TextStyle(color: newTextSecondary)),
//                 ]),
//               ),
//             ),
//           ]),
//         )),
//       ],
//     );
//   }
//
//   Widget _relatedProducts(ProductDetailsController ctrl) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Related Products',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 180,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: ctrl.itemVariantList.length,
//             itemBuilder: (_, i) => _relatedCard(ctrl.itemVariantList[i]),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _relatedCard(RelatedProductList item) {
//     return Container(
//       width: 140,
//       margin: const EdgeInsets.only(right: 12),
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: newSurfaceColor,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Expanded(child: AppNetworkImage(image: item.itemimage ?? '', fit: BoxFit.contain)),
//         const SizedBox(height: 6),
//         Text(item.itemname ?? '',
//             style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: newTextPrimary),
//             maxLines: 2, overflow: TextOverflow.ellipsis),
//         const SizedBox(height: 4),
//         const Row(children: [
//           Icon(Icons.star_rounded, size: 12, color: Color(0xFFF59E0B)),
//           Text(' 4.4', style: TextStyle(fontSize: 11, color: newTextSecondary)),
//         ]),
//         Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: newBlueColor)),
//       ]),
//     );
//   }
//
//   Widget _addToCartSheet(ProductDetailsController ctrl) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: newBorderColor)),
//       ),
//       child: SafeArea(
//         top: false,
//         child: SizedBox(
//           width: double.infinity, height: 52,
//           child: ElevatedButton.icon(
//             onPressed: () => ctrl.addItem(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: newBlueColor,
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//             ),
//             icon: const Icon(Icons.shopping_cart_outlined, size: 20),
//             label: const Text('Add to Cart',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:digitalerp/response/related_product_response.dart';
import 'package:digitalerp/response/unit_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: Colors.white,
        body: ctrl.isBusy
            ? const Center(child: CircularProgressIndicator(color: newBlueColor))
            : Column(
          children: [
            SafeArea(
              bottom: false,
              child: MyAppBar(
                title: 'Detail',
                onBackTap: () => ctrl.backTap(),
                showCartIcon: true,
                onCartTap: () => ctrl.tapOnCart2(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _imageCard(ctrl),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _titleRow(ctrl),
                          const SizedBox(height: 12),
                          _stockRow(ctrl),
                          const SizedBox(height: 8),
                          Text(
                            ctrl.productDetailsResponse?.itemDescription ?? '',
                            style: const TextStyle(fontSize: 13, color: newTextSecondary, height: 1.5),
                          ),
                          const SizedBox(height: 20),
                          if (ctrl.unitList.isNotEmpty) _unitSection(ctrl),
                          const SizedBox(height: 20),
                          _additionalInfo(),
                          const SizedBox(height: 20),
                          if (ctrl.itemVariantList.isNotEmpty) _relatedProducts(ctrl),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: ctrl.isBusy ? null : _addToCartSheet(ctrl),
      ),
    );
  }

  Widget _imageCard(ProductDetailsController ctrl) {
    return Stack(
      children: [
        Container(
          height: 260,
          width: double.infinity,
          color: newSurfaceColor,
          child: AppNetworkImage(
            image: ctrl.productDetailsResponse?.itemImage ?? '',
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 12, left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: newBlueColor, borderRadius: BorderRadius.circular(6)),
            child: const Text('30% OFF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ),
        Positioned(
          top: 12, right: 12,
          child: Container(
            width: 34, height: 34,
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: newBorderColor)),
            child: const Icon(Icons.favorite_border_rounded, size: 16, color: newBlueColor),
          ),
        ),
      ],
    );
  }

  Widget _titleRow(ProductDetailsController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ctrl.productDetailsResponse?.itemName ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: newTextPrimary),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha:0.15),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(children: [
                Icon(Icons.star_rounded, size: 13, color: Color(0xFFF59E0B)),
                SizedBox(width: 3),
                Text('4.4', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFF59E0B))),
              ]),
            ),
            const SizedBox(width: 8),
            const Text('1,800 Reviews', style: TextStyle(fontSize: 12, color: newTextSecondary)),
            const Spacer(),
            Text(
              '₹${ctrl.productDetailsResponse?.rate?.toStringAsFixed(0) ?? '0'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: newBlueColor),
            ),
            const Text(' /unit', style: TextStyle(fontSize: 11, color: newTextSecondary)),
          ],
        ),
      ],
    );
  }

  Widget _stockRow(ProductDetailsController ctrl) {
    final qty = ctrl.productDetailsResponse?.quantity?.toInt() ?? 0;
    return Row(children: [
      const Text('Quantity : ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: newTextPrimary)),
      Text('$qty unit', style: const TextStyle(fontSize: 13, color: newGreenColor, fontWeight: FontWeight.w700)),
    ]);
  }

  Widget _unitSection(ProductDetailsController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Length', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10, runSpacing: 10,
          children: ctrl.unitList.asMap().entries.map((entry) {
            final isSelected = ctrl.selectedIndexValue == entry.key;
            return GestureDetector(
              onTap: () { ctrl.tapOnCard(entry.key); ctrl.update(); },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : newSurfaceColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? newBlueColor : newBorderColor,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Text(
                  entry.value.unitname ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? newBlueColor : newTextPrimary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _additionalInfo() {
    const info = [
      ['Material', 'High-quality Stainless Steel (Corrosion Resistant)'],
      ['Grade', 'CI-115 (Machio Finish)'],
      ['Finish', 'Smooth & Polished Surface'],
      ['Usage', 'Construction, Plumbing, Industrial & Fabrication work'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Additional Information',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
        const SizedBox(height: 10),
        ...info.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('• ', style: TextStyle(color: newTextSecondary)),
            Expanded(
              child: RichText(
                text: TextSpan(style: const TextStyle(fontSize: 13), children: [
                  TextSpan(text: '${item[0]} : ',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: newTextPrimary)),
                  TextSpan(text: item[1], style: const TextStyle(color: newTextSecondary)),
                ]),
              ),
            ),
          ]),
        )),
      ],
    );
  }

  Widget _relatedProducts(ProductDetailsController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Related Products',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ctrl.itemVariantList.length,
            itemBuilder: (_, i) => _relatedCard(ctrl.itemVariantList[i]),
          ),
        ),
      ],
    );
  }

  Widget _relatedCard(RelatedProductList item) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: AppNetworkImage(image: item.itemimage ?? '', fit: BoxFit.contain)),
        const SizedBox(height: 6),
        Text(item.itemname ?? '',
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: newTextPrimary),
            maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 4),
        const Row(children: [
          Icon(Icons.star_rounded, size: 12, color: Color(0xFFF59E0B)),
          Text(' 4.4', style: TextStyle(fontSize: 11, color: newTextSecondary)),
        ]),
        Text('₹${item.rate?.toStringAsFixed(0) ?? '0'}',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: newBlueColor)),
      ]),
    );
  }

  Widget _addToCartSheet(ProductDetailsController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: newBorderColor)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _qtySelector(ctrl),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () => ctrl.addItem(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: newBlueColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.shopping_cart_outlined, size: 20),
                  label: const Text('Add to Cart',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Quantity selector: − [ type here ] +  (type an exact value like 100)
  Widget _qtySelector(ProductDetailsController ctrl) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(color: newBorderColor),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sheetQtyBtn(Icons.remove, () {
            if (ctrl.quantityTextController.text.trim().isEmpty) {
              ctrl.quantityTextController.text = '1';
            }
            final q =
                int.tryParse(ctrl.quantityTextController.text.trim()) ?? 1;
            if (q > 1) ctrl.productQtyDecreaseFromTextField();
          }),
          SizedBox(
            width: 46,
            child: TextField(
              controller: ctrl.quantityTextController,
              focusNode: ctrl.quantityTextFocus,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: '1',
              ),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary),
              onChanged: (v) {
                if (v.trim().isNotEmpty) ctrl.onChangeQuantityText(v.trim());
              },
            ),
          ),
          _sheetQtyBtn(Icons.add, () {
            if (ctrl.quantityTextController.text.trim().isEmpty) {
              ctrl.quantityTextController.text = '0';
            }
            ctrl.productQtyIncreaseFromTextField();
          }),
        ],
      ),
    );
  }

  Widget _sheetQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 52,
        alignment: Alignment.center,
        child: Icon(icon, size: 20, color: newBlueColor),
      ),
    );
  }
}
