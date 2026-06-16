// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/custom_clipper.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class OrderView extends StatelessWidget {
//   const OrderView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return GetBuilder<OrderController>(
//       init: OrderController(),
//       builder: (controller){
//         print("===>${controller.executiveList}");
//         return  Scaffold(
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
//                       image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill),
//                     ),
//                     child: SafeArea(
//                       child: MyAppBar(
//                         title: 'Order',
//                         onBackTap: ()=>Get.back(),
//                         // onDrawerTap: () => controller.openDrawer(context),
//                         onFilterTap: () =>
//                             Get.dialog(const OrderFilterDialogBox() /*CustomDialogBox(type: orderFilter)*/),
//                         showCartIcon: true,
//                         onCartTap: () => controller.onCartTap(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.135,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: controller.isBusy
//                         ? SizedBox(
//                       height: Get.height * .4,
//                       child: showLoader(),
//                     )
//                         : Column(
//                       children: [
//                         if (controller.isManager) _managerView(controller),
//                         // controller.isManager?_managerView(controller): _executiveView(controller),
//                         _segmentButton(controller),
//                         controller.isListLoading
//                             ? SizedBox(
//                           height: Get.height * .4,
//                           child: showLoader(),
//                         )
//                             : controller.executiveOrderList?.isEmpty ?? true
//                             ? SizedBox(
//                           height: Get.height * .4,
//                           child: centerText('No order '),
//                         )
//                             : ListView.builder(
//                           shrinkWrap: true,
//                           padding: EdgeInsets.zero,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: controller.executiveOrderList?.length,
//                           itemBuilder: (context, index) {
//                             print("===>Code ${controller.executiveOrderList?.length}");
//
//                             return orderCard(controller, index);
//                           },
//                         ),
//                         const SizedBox(height: 60),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 18,
//                   bottom: 95,
//                   child: GradientIconButton(onPressed: () => controller.tapOnAdd(), radius: 10, vPadding: 20),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }
//
//   Widget orderCard(OrderController controller, int index) {
//     var item = controller.executiveOrderList?[index];
//     Color color = controller.selectedSegmentVal == 0
//         ? orangeColor
//         : controller.selectedSegmentVal == 1
//             ? green3Color
//             : redColor;
//     return InkWell(
//       onTap: () => controller.tapOnCard(item!.orderid.toString()),
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: color,
//             boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)]),
//         margin: const EdgeInsets.symmetric(vertical: 10),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Text(
//                 item?.orderno ?? 'N/A',
//                 style: const TextStyle().bold.copyWith(color: Colors.white),
//               ),
//             ),
//             ClipPath(
//               clipper: CustomClip(),
//               child: Container(
//                 width: double.maxFinite,
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.vertical(
//                     bottom: Radius.circular(10),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             flex: 9,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 _txtView(title: 'Order Date', value: item?.orderdate ?? 'N/A', color: color),
//                                 const SizedBox(height: 10),
//                                 _txtView(title: 'Executive', value: item?.executivename ?? 'N/A', color: color),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           DottedLine(
//                             color: Colors.grey,
//                             height: 60.0,
//                             strokeWidth: 1.2,
//                             dottedLength: 5.0,
//                             space: 2.0,
//                           ),
//                           Expanded(
//                             flex: 9,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 _txtView(
//                                     title: 'Party Name', value: item?.partyname ?? 'N/A', color: color, isLeft: false),
//                                 const SizedBox(height: 10),
//                                 _txtView(
//                                     title: 'Amount',
//                                     value: '\u{20B9} ${item?.amount}',
//                                     color: color,
//                                     isLeft: false,
//                                     isAmount: true),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25),
//                       child: _txtView2(title: 'Order Status', value: item?.orderstatus ?? 'N/A', color: color),
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _executiveView(OrderController controller) {
//     return Container(
//       alignment: Alignment.centerLeft,
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
//       child: Text(
//         controller.selectedExecutiveDropdownValue?.executiveName.toString() ?? '',
//         style: const TextStyle().bold,
//       ),
//     );
//   }
//
//   Widget _managerView(OrderController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(height: Get.height * 0.02),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             buttonHeight: 40,
//             buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: dropdownBoxColor,
//             ),
//             buttonDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: dropdownBoxColor,
//                 gradient: customGradient(topColor: grBottomColor, bottomColor: grTopColor, opacity: 0.09)),
//             isExpanded: true,
//             hint: Text(
//               'Select Executive',
//               style: const TextStyle().normal,
//             ),
//             value: controller.selectedExecutiveDropdownValue,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: controller.executiveList.map((items) {
//               return DropdownMenuItem(
//                 value: items,
//                 child: Text(
//                     items.executiveName.toString()),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.setSelectedExecutiveNameDropdownValue(newValue);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _segmentButton(OrderController controller) => Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(45),
//           color: white2Color,
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 35,
//                 decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: controller.selectedSegmentVal == 0
//                             ? [orangeColor, red2Color]
//                             : [Colors.transparent, Colors.transparent])),
//                 child: MaterialButton(
//                   shape: const StadiumBorder(),
//                   onPressed: () => controller.setSegmentValue(0),
//                   child: Text(
//                     'Pending',
//                     style: const TextStyle().bold.copyWith(
//                         fontSize: 12, color: controller.selectedSegmentVal == 0 ? Colors.white : Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: 35,
//                 decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: controller.selectedSegmentVal == 1
//                             ? [green3Color, green3Color]
//                             : [Colors.transparent, Colors.transparent])),
//                 child: MaterialButton(
//                   shape: const StadiumBorder(),
//                   onPressed: () => controller.setSegmentValue(1),
//                   child: FittedBox(
//                     child: Text(
//                       'Approved',
//                       style: const TextStyle().bold.copyWith(
//                           fontSize: 12, color: controller.selectedSegmentVal == 1 ? Colors.white : Colors.black),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: 35,
//                 decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: controller.selectedSegmentVal == 2
//                             ? [redColor, redColor]
//                             : [Colors.transparent, Colors.transparent])),
//                 child: MaterialButton(
//                   shape: const StadiumBorder(),
//                   onPressed: () => controller.setSegmentValue(2),
//                   child: Text(
//                     'Rejected',
//                     style: const TextStyle().bold.copyWith(
//                         fontSize: 12, color: controller.selectedSegmentVal == 2 ? Colors.white : Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _txtView({required String title, required String value, required Color color, bool? isLeft, bool? isAmount}) {
//     return Column(
//       crossAxisAlignment: isLeft ?? true ? CrossAxisAlignment.start : CrossAxisAlignment.end,
//       children: [
//         Text(
//           title,
//           style: const TextStyle().bold.copyWith(fontSize: 12, color: color),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           value,
//           style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//           textAlign: isLeft ?? true ? TextAlign.start : TextAlign.end,
//         ),
//       ],
//     );
//   }
//
//   Widget _txtView2({required String title, required String value, required Color color, bool? isLeft, bool? isAmount}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           '$title:',
//           style: const TextStyle().bold.copyWith(fontSize: 12, color: color),
//         ),
//         const SizedBox(width: 5),
//         Text(
//           value,
//           style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//           textAlign: isLeft ?? true ? TextAlign.start : TextAlign.end,
//         ),
//       ],
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/custom_clipper.dart';
import 'package:digitalerp/utils/dottedline.dart';
import 'package:digitalerp/utils/gradient_icon_app_button.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fab/menu_fab.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: newSurfaceColor,
          resizeToAvoidBottomInset: false,

          /// ✅ FIXED FAB (perfect spacing)
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 70,
            ),
            child: GradientIconButton(
              onPressed: () => controller.tapOnAdd(),
              radius: 10,
              vPadding: 16,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: MenuFabBody(
              parentMenuId: 2378, // e.g. 2409 or whatever showed in debug
              bottomPadding: 90, // match your GradientIconButton's bottom offset
              child: Column(
            children: [
              SafeArea(
                bottom: false,
                child: MyAppBar(
                  title: 'Order',
                  onBackTap: () => Get.back(),
                  onFilterTap: () => Get.dialog(const OrderFilterDialogBox()),
                  showCartIcon: true,
                  onCartTap: () => controller.onCartTap(),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: controller.isBusy
                      ? SizedBox(
                          height: Get.height * .4,
                          child: showLoader(),
                        )
                      : Column(
                          children: [
                            if (controller.isManager) _managerView(controller),
                            _segmentButton(controller),
                            controller.isListLoading
                                ? SizedBox(
                                    height: Get.height * .4,
                                    child: showLoader(),
                                  )
                                : controller.executiveOrderList?.isEmpty ?? true
                                    ? _emptyState()
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                                .executiveOrderList?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return orderCard(controller, index);
                                        },
                                      ),
                            const SizedBox(height: 120),
                          ],
                        ),
                ),
              ),
            ],
          ),
            ),
        );
      },
    );
  }

  // ================= EMPTY STATE =================

  Widget _emptyState() {
    return SizedBox(
      height: Get.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.receipt_long_outlined, size: 60, color: newTextHint),
          SizedBox(height: 10),
          Text(
            "No Orders Found",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: newTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ================= ORDER CARD =================

  Widget orderCard(OrderController controller, int index) {
    var item = controller.executiveOrderList?[index];

    Color statusColor = controller.selectedSegmentVal == 0
        ? newOrangeColor
        : controller.selectedSegmentVal == 1
            ? newGreenColor
            : newRedColor;

    return InkWell(
      onTap: () => controller.tapOnCard(item!.orderid.toString()),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(
                  item?.orderno ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _txt("Order Date", item?.orderdate)),
                      Expanded(
                          child: _txt("Executive", item?.executivename,
                              isRight: true)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(child: _txt("Party", item?.partyname)),
                      Expanded(
                          child: _txt("₹ Amount", item?.amount.toString(),
                              isRight: true)),
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

  // ================= DROPDOWN =================

  Widget _managerView(OrderController controller) {
    return Column(
      children: [
        const SizedBox(height: 16),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            buttonHeight: 44,
            buttonDecoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: newBorderColor),
            ),
            isExpanded: true,
            hint: const Text("Select Executive"),
            value: controller.selectedExecutiveDropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: controller.executiveList.map((items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items.executiveName.toString()),
              );
            }).toList(),
            onChanged: controller.setSelectedExecutiveNameDropdownValue,
          ),
        ),
      ],
    );
  }

  // ================= SEGMENT =================

  Widget _segmentButton(OrderController controller) {
    final titles = ["Pending", "Approved", "Rejected"];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: newBorderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(3, (index) {
          final isSelected = controller.selectedSegmentVal == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setSegmentValue(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? newBlueColor : newTextSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ================= TEXT =================

  Widget _txt(String title, String? value, {bool isRight = false}) {
    return Column(
      crossAxisAlignment:
          isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: newTextSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value ?? 'N/A',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: newTextPrimary,
          ),
        ),
      ],
    );
  }
}
