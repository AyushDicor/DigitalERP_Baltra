// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/cart/cart_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_bottom_button.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CartView extends StatelessWidget {
//   const CartView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(
//       init: CartController(),
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
//                       title: 'Cart',
//                       onBackTap: () => Get.back(/*result: controller.cartDeletedListItem*/),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.135,
//                   child: Visibility(
//                     visible: controller.cartList.isNotEmpty,
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 10),
//                           ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: controller.cartList.length,
//                             itemBuilder: (context, index) {
//                               // return index % 2 == 0
//                               return /*false
//                                     ? _orderCard(controller, index)
//                                     : */
//                                   _orderCard2(
//                                 controller,
//                                 index,
//                               );
//                             },
//                           ),
//                           const SizedBox(height: 60),
//                         ],
//                       ),
//                     ),
//                     replacement: Center(
//                         child: Text(
//                       'No Item in Cart',
//                       style: const TextStyle().normal.copyWith(
//                             fontSize: 20,
//                           ),
//                     )),
//                   )),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: AppBottomButton(
//                   onPressed: () => controller.tapOnProcess(),
//                   name: 'Proceed',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /*Widget _orderCard(CartController controller, int index) {
//     var item = controller.cartList[index];
//     return Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         Container(
//             margin: const EdgeInsets.only(top: 8, bottom: 8, right: 21),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 5)
//                 ]),
//             height: 106,
//             child: Row(
//               children: [
//                 Stack(
//                   alignment: Alignment.centerRight,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(right: 20),
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: index % 2 != 0
//                             ? customGradient(
//                                 topColor: greenColor, bottomColor: lightGreenColor, opacity: .34)
//                             : customGradient(
//                                 topColor: orangeColor, bottomColor: orangeColor, opacity: .34),
//                       ),
//                     ),
//                     CachedNetworkImage(
//                       imageUrl: item.productimage ?? '',
//                       fit: BoxFit.fill,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item.productname ?? '',
//                       style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       '\u{20B9}${item.itemrate?.toInt()}',
//                       style: const TextStyle().bold.copyWith(fontSize: 18, color: purpleColor),
//                     ),
//                     const SizedBox(height: 10),
//                     _qtyController(controller, index),
//                   ],
//                 )
//               ],
//             )),
//         GradientIconButton(
//           topColor: redColor,
//           bottomColor: redColor,
//           radius: 8,
//           vPadding: 12.5,
//           hPadding: 12.5,
//           onPressed: () {
//             controller.tapOnDelete(index);
//           },
//           icon: AppAssets.deleteIcon,
//         )
//       ],
//     );
//   }*/
//
//   Widget _orderCard2(
//     CartController controller,
//     int index,
//   ) {
//     var item = controller.cartList[index];
//     return Stack(
//       fit: StackFit.loose,
//       alignment: Alignment.centerRight,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(
//             top: 8,
//             bottom: 8,
//             right: 21,
//           ),
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black12,
//                 offset: Offset(0, 3),
//                 blurRadius: 5,
//               ),
//             ],
//           ),
//           // height: 160,
//           child: Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   AppNetworkImage(
//                     image: item.productimage ?? '',
//                     fit: BoxFit.cover,
//                     height: Get.height * .096,
//                     width: Get.width * .2,
//                   ),
//                   const SizedBox(height: 20),
//                   _qtyController(
//                     controller,
//                     index,
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 7),
//                     InkWell(
//                       onTap: () {
//                         controller.tapOnProduct(item.productid.toString());
//                       },
//                       child: Text(
//                         item.productname ?? '',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle().bold.copyWith(
//                               fontSize: 14,
//                               color: purpleColor,
//                             ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 10,
//                         top: 10,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '\u{20B9}${item.total?.toInt()}',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 18,
//                                   color: purpleColor,
//                                 ),
//                           ),
//                           const SizedBox(height: 15),
//                           Row(
//                             children: [
//                               txtView(
//                                 name: 'Unit',
//                                 value: item.unit.toString(),
//                               ),
//                               const SizedBox(width: 15),
//                               txtView(
//                                 name: 'Rate',
//                                 value: item.itemrate?.toStringAsFixed(2) ?? '0',
//                                 moneySign: true,
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         GradientIconButton(
//           topColor: redColor,
//           bottomColor: redColor,
//           radius: 8,
//           vPadding: 12.5,
//           hPadding: 12.5,
//           onPressed: () => _showDialog(
//             controller,
//             index,
//           ) /*controller.tapOnDelete(index)*/,
//           icon: AppAssets.deleteIcon,
//         )
//       ],
//     );
//   }
//
//   Widget _qtyController(
//     CartController controller,
//     int index,
//   ) {
//     var item = controller.cartList[index];
//     return Container(
//       decoration: BoxDecoration(
//         color: orangeColor.withValues(alpha:0.72),
//         borderRadius: BorderRadius.circular(50),
//       ),
//       padding: const EdgeInsets.all(1),
//       margin: const EdgeInsets.symmetric(
//         horizontal: 4,
//       ),
//       width: item.isTextField ?? false ? 105 : 72,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           InkWell(
//             onTap: () {
//               if (item.isTextField ?? false) {
//                 if (double.parse(controller.quantityTextController.text) > 0 &&
//                     controller.quantityTextController.text.isNotEmpty) {
//                   controller.productQtyDecreaseFromTextField(index);
//                 } else {
//                   _showDialog(
//                     controller,
//                     index,
//                   );
//                 }
//               } else {
//                 if ((item.quantity?.toInt() ?? 0) > 1) {
//                   controller.productQtyDecrease(index);
//                 } else {
//                   _showDialog(
//                     controller,
//                     index,
//                   );
//                   // controller.tapOnDelete(index);
//                 }
//               }
//             },
//             child: const Icon(
//               Icons.remove_circle,
//               color: Colors.white,
//               size: 19,
//             ),
//           ),
//           Visibility(
//             visible: item.isTextField ?? false,
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(
//                 maxWidth: 65,
//                 maxHeight: 28,
//               ),
//               child: TextFormField(
//                 maxLines: 1,
//                 textAlign: TextAlign.center,
//                 textAlignVertical: TextAlignVertical.bottom,
//                 cursorColor: Colors.grey,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   counterText: '',
//                   contentPadding: const EdgeInsets.only(
//                     top: 5,
//                     bottom: 15,
//                   ),
//                   hintText: '',
//                   hintTextDirection: TextDirection.rtl,
//                   // hintStyle: const TextStyle(
//                   //           fontSize: 12, height: 1.0, color: Colors.white),
//                   fillColor: Colors.transparent,
//                   filled: true,
//                   border: InputBorder.none,
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: const BorderSide(
//                       color: Colors.transparent,
//                     ),
//                   ),
//                 ),
//                 style: const TextStyle().bold.copyWith(
//                       fontSize: 13,
//                       height: 1,
//                       color: Colors.white,
//                     ),
//                 controller: controller.quantityTextController,
//                 focusNode: controller.quantityTextFocus,
//                 onFieldSubmitted: (value) {
//                   controller.onSubmitTextFieldQty(
//                     value,
//                     index,
//                   );
//                 },
//                 onChanged: (value) {
//                 //  controller.discountCalculate(value);
//                 },
//               ),
//             ),
//             replacement: Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   controller.tapOnQuantityText(index);
//                 },
//                 child: Text(
//                   '${item.quantity?.toInt()}',
//                   style: const TextStyle().bold.bold.copyWith(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               if (item.isTextField ?? false) {
//                 if (controller.quantityTextController.text.isNotEmpty) {
//                   controller.productQtyIncreaseFromTextField(index);
//                 } else {
//                   //_showDialog(controller, index);
//                 }
//               } else {
//                 controller.productQtyIncrease(index);
//               }
//             },
//             child: const Icon(
//               Icons.add_circle,
//               color: Colors.white,
//               size: 19,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget txtView({required String name, required String value, bool? moneySign}) {
//     return Column(
//       children: [
//         Text(
//           name,
//           style: const TextStyle().bold.copyWith(
//                 fontSize: 12,
//                 color: medGreyColor,
//               ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           moneySign ?? false ? '\u{20B9}$value' : value,
//           style: const TextStyle().bold.copyWith(
//                 color: Colors.black,
//               ),
//         )
//       ],
//     );
//   }
//
//   void _showDialog(CartController controller, int index) {
//     Get.defaultDialog(
//       title: 'Warning',
//       backgroundColor: Colors.white,
//       radius: 12,
//       textCancel: 'Cancel',
//       textConfirm: 'Delete',
//       middleText: 'Are you sure you want to delete item ?',
//       buttonColor: purpleColor,
//       confirmTextColor: Colors.white,
//       cancelTextColor: purpleColor,
//       onConfirm: () async {
//         Get.back();
//         controller.tapOnDelete(index);
//       },
//       onCancel: () {
//         //Get.back();
//       },
//     );
//   }
// }



import 'package:digitalerp/response/get_cart_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/cart/cart_controller.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(
            children: [
              //  App Bar 
              _AppBar(),

              //  Cart list or empty state 
              Expanded(
                child: controller.cartList.isEmpty
                    ? const Center(
                  child: Text(
                    'No Item in Cart',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF888888),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) =>
                      _CartCard(controller: controller, index: index),
                ),
              ),

              //  Summary + Place Order 
              if (controller.cartList.isNotEmpty)
                _OrderSummary(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

// 
// App Bar
// 
class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 20, color: Color(0xFF1A1A2E)),
            onPressed: () => Get.back(),
          ),
          const Text(
            'Cart',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ],
      ),
    );
  }
}

// 
// Cart Card
// 
class _CartCard extends StatelessWidget {
  final CartController controller;
  final int index;

  const _CartCard({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = controller.cartList[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Product image with optional discount badge 
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppNetworkImage(
                    image: item.productimage ?? '',
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                ),
                // Discount badge – show only when discount exists
                if ((item.discount ?? 0) > 0)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3D4ED8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        '${item.discount?.toInt()}% OFF',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            //  Details column 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Remove
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller
                              .tapOnProduct(item.productid.toString()),
                          child: Text(
                            item.productname ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A2E),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _showDeleteDialog(controller, index),
                        child: const Text(
                          'Remove',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE53935),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFE53935),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Text(
                    '\u20B9${item.total?.toInt()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  Text(
                    'per unit',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Qty controller
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _QtyController(
                          controller: controller, index: index),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(CartController controller, int index) {
    Get.defaultDialog(
      title: 'Warning',
      backgroundColor: Colors.white,
      radius: 12,
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      middleText: 'Are you sure you want to delete this item?',
      buttonColor: const Color(0xFF3D4ED8),
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF3D4ED8),
      onConfirm: () async {
        Get.back();
        controller.tapOnDelete(index);
      },
    );
  }
}

extension on GetCartListData {
  get discount => null
  ;
}

// 
// Quantity Controller
// 
class _QtyController extends StatelessWidget {
  final CartController controller;
  final int index;

  const _QtyController({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final item = controller.cartList[index];
    final isTextField = item.isTextField ?? false;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3D4ED8), width: 1.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus button
          GestureDetector(
            onTap: () {
              if (isTextField) {
                if (controller.quantityTextController.text.isNotEmpty &&
                    double.tryParse(
                        controller.quantityTextController.text) !=
                        null &&
                    double.parse(
                        controller.quantityTextController.text) >
                        0) {
                  controller.productQtyDecreaseFromTextField(index);
                } else {
                  _showDeleteDialog(controller, index);
                }
              } else {
                if ((item.quantity?.toInt() ?? 0) > 1) {
                  controller.productQtyDecrease(index);
                } else {
                  _showDeleteDialog(controller, index);
                }
              }
            },
            child: Container(
              width: 34,
              alignment: Alignment.center,
              child: const Icon(
                Icons.remove_rounded,
                size: 18,
                color: Color(0xFF3D4ED8),
              ),
            ),
          ),

          // Quantity display or text field
          Container(
            constraints: const BoxConstraints(minWidth: 28),
            alignment: Alignment.center,
            child: isTextField
                ? SizedBox(
              width: 48,
              child: TextFormField(
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  isDense: true,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
                controller: controller.quantityTextController,
                focusNode: controller.quantityTextFocus,
                onFieldSubmitted: (value) =>
                    controller.onSubmitTextFieldQty(value, index),
              ),
            )
                : GestureDetector(
              onTap: () => controller.tapOnQuantityText(index),
              child: Text(
                '${item.quantity?.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ),
          ),

          // Plus button (filled circle)
          GestureDetector(
            onTap: () {
              if (isTextField) {
                if (controller.quantityTextController.text.isNotEmpty) {
                  controller.productQtyIncreaseFromTextField(index);
                }
              } else {
                controller.productQtyIncrease(index);
              }
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Color(0xFF3D4ED8),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.add_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(CartController controller, int index) {
    Get.defaultDialog(
      title: 'Warning',
      backgroundColor: Colors.white,
      radius: 12,
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      middleText: 'Are you sure you want to delete this item?',
      buttonColor: const Color(0xFF3D4ED8),
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF3D4ED8),
      onConfirm: () async {
        Get.back();
        controller.tapOnDelete(index);
      },
    );
  }
}

// 
// Order Summary + Place Order
// 
class _OrderSummary extends StatelessWidget {
  final CartController controller;

  const _OrderSummary({required this.controller});

  @override
  Widget build(BuildContext context) {
    // Compute totals from cart list
    final subtotal = controller.cartList
        .fold<double>(0, (sum, item) => sum + (item.total ?? 0));
    const deliveryCharge = 0.0;
    final total = subtotal + deliveryCharge;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _summaryRow('Subtotal', '\u20B9${subtotal.toInt()}',
              bold: false),
          const SizedBox(height: 8),
          _summaryRow('Delivery charge',
              deliveryCharge == 0 ? '\u20B90' : '\u20B9${deliveryCharge.toInt()}',
              bold: false),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
          _summaryRow('Total', '\u20B9${total.toInt()}', bold: true),
          const SizedBox(height: 16),

          // Place Order button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => controller.tapOnProcess(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D4ED8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {required bool bold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: bold ? 16 : 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            color: bold ? const Color(0xFF1A1A2E) : const Color(0xFF888888),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 16 : 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            color: const Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}
