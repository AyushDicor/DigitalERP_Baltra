// // ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
//
// import 'package:another_xlider/another_xlider.dart';
// import 'package:another_xlider/models/handler.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class OrderDetailEditDialog extends StatelessWidget {
//   OrderDetailEditDialog({
//     Key? key,
//   }) : super(key: key);
//   final OrderDetailController orderDetailController =
//       Get.find<OrderDetailController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OrderDetailController>(
//       assignId: true,
//       builder: (controller) {
//         return Dialog(
//           child: _contentBox(context),
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//         );
//       },
//     );
//   }
//
//   Widget _contentBox(context) {
//     return Container(
//       height: Get.height,
//       width: Get.width,
//       decoration: BoxDecoration(
//         gradient: customGradient(
//           topColor: purpleColor,
//           bottomColor: blueColor,
//           opacity: 0.20,
//         ),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       alignment: Alignment.center,
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20)),
//             margin: const EdgeInsets.only(top: 25),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Edit Status',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//                 _editView(),
//                 const SizedBox(height: 35),
//                 _btn(context),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 8,
//             child: InkWell(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Image.asset(
//                 AppAssets.coloredCloseIcon,
//                 height: 50,
//                 width: 50,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   FlutterSliderHandler customHandler() {
//     return FlutterSliderHandler(
//       child: Container(
//         height: 26,
//         width: 26,
//         decoration: BoxDecoration(
//           gradient: gr2,
//           shape: BoxShape.circle,
//           boxShadow: const [
//             BoxShadow(color: purpleColor, spreadRadius: 0.05, blurRadius: 10)
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _statusDropdown() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(
//             buttonHeight: 40,
//             buttonPadding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: dropdownBoxColor,
//             ),
//             dropdownMaxHeight: 200,
//             buttonDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: dropdownBoxColor,
//               gradient: LinearGradient(
//                 colors: [
//                   grBottomColor.withValues(alpha:0.2),
//                   grTopColor.withValues(alpha:0.2)
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             isExpanded: true,
//             hint: Text(
//               'Select status',
//               style: const TextStyle().normal.copyWith(
//                   fontSize: 11,
//                   fontWeight: FontWeight.normal,
//                   color: msgTextColor),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: orderDetailController.selectedStatusValue,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: orderDetailController.statusList.map((items) {
//               return DropdownMenuItem<String>(
//                 value: items,
//                 child: Text(items),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               orderDetailController.setSelectedStatusValue(newValue);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _editView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _txt(
//             title: 'Client name',
//             subtitle:
//                 orderDetailController.partyBalanceDetailData?.clientname ??
//                     'N/A'),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _txt(
//                 title: 'Credit Limit',
//                 subtitle: orderDetailController
//                         .partyBalanceDetailData?.creditlimit
//                         .toString() ??
//                     'N/A'),
//             _txt(
//                 title: 'Previous Balance ',
//                 subtitle: orderDetailController
//                         .partyBalanceDetailData?.previousbalance
//                         .toString() ??
//                     'N/A'),
//           ],
//         ),
//         _txt(
//             title: 'Remark',
//             subtitle:
//                 orderDetailController.partyBalanceDetailData?.remark ?? 'N/A'),
//         const SizedBox(height: 25),
//         Text(
//           'Status',
//           style:
//               const TextStyle().normal.copyWith(fontSize: 12, color: red2Color),
//         ),
//         _statusDropdown()
//       ],
//     );
//   }
//
//   Widget _txt({required String title, required String subtitle}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 25),
//         Text(
//           title,
//           style:
//               const TextStyle().normal.copyWith(fontSize: 12, color: red2Color),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           subtitle,
//           style: const TextStyle().normal,
//         ),
//       ],
//     );
//   }
//
//   Widget _btn(BuildContext context) => Align(
//         alignment: Alignment.center,
//         child: Container(
//           height: 40,
//           decoration: ShapeDecoration(
//             shape: const StadiumBorder(),
//             gradient:
//                 customGradient(topColor: orangeColor, bottomColor: red2Color),
//           ),
//           child: MaterialButton(
//             onPressed: () {
//               if (orderDetailController.selectedStatusValue?.isNotEmpty ??
//                   false) {
//                 orderDetailController.updateOrderStatusApi(
//                     orderDetailController.selectedStatusValue ?? '');
//                 Get.back();
//               } else {
//                 ShowMessage.showSnackBar(
//                     AppString.pleaseCheckTxt, AppString.selectStatusTxt);
//               }
//             },
//             shape: const StadiumBorder(),
//             padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
//             child: Text(
//               'Done',
//               style: const TextStyle().bold.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       );
// }


// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/handler.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailEditDialog extends StatelessWidget {
  OrderDetailEditDialog({
    Key? key,
  }) : super(key: key);
  final OrderDetailController orderDetailController =
  Get.find<OrderDetailController>();

  // Local UI tokens.
  static const _ink = Color(0xFF0F172A);
  static const _labelColor = Color(0xFF94A3B8);
  static const _tileFill = Color(0xFFF6F7FB);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      assignId: true,
      builder: (controller) {
        return Dialog(
          child: _contentBox(context),
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  Widget _contentBox(context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: customGradient(
          topColor: purpleColor,
          bottomColor: blueColor,
          opacity: 0.20,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      // Center handles placement properly instead of relying on default
      // Stack alignment, so the card is reliably centered on any screen.
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Status',
                      style: const TextStyle()
                          .bold
                          .copyWith(color: _ink, fontSize: 17),
                    ),
                    const SizedBox(height: 18),
                    _editView(),
                    const SizedBox(height: 28),
                    _btn(context),
                  ],
                ),
              ),

              // Close button now sits on the card's own corner instead of
              // floating loosely relative to the whole screen.
              Positioned(
                top: -14,
                right: -14,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.close_rounded,
                        size: 20, color: purpleColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlutterSliderHandler customHandler() {
    return FlutterSliderHandler(
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          gradient: gr2,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: purpleColor, spreadRadius: 0.05, blurRadius: 10)
          ],
        ),
      ),
    );
  }

  Widget _statusDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        buttonHeight: 44,
        buttonPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: dropdownBoxColor,
        ),
        dropdownMaxHeight: 200,
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _tileFill,
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        isExpanded: true,
        hint: Text(
          'Select status',
          style: const TextStyle()
              .normal
              .copyWith(fontSize: 13, fontWeight: FontWeight.normal, color: msgTextColor),
          overflow: TextOverflow.ellipsis,
        ),
        value: orderDetailController.selectedStatusValue,
        icon: Image.asset(
          AppAssets.dropdownIcon,
          width: 15,
          height: 15,
        ),
        items: orderDetailController.statusList.map((items) {
          return DropdownMenuItem<String>(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (newValue) {
          orderDetailController.setSelectedStatusValue(newValue);
        },
      ),
    );
  }

  Widget _editView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tile(
          title: 'Client name',
          subtitle:
          orderDetailController.partyBalanceDetailData?.clientname ??
              'N/A',
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _tile(
                title: 'Credit Limit',
                subtitle: orderDetailController
                    .partyBalanceDetailData?.creditlimit
                    .toString() ??
                    'N/A',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _tile(
                title: 'Previous Balance',
                subtitle: orderDetailController
                    .partyBalanceDetailData?.previousbalance
                    .toString() ??
                    'N/A',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _tile(
          title: 'Remark',
          subtitle:
          orderDetailController.partyBalanceDetailData?.remark ?? 'N/A',
        ),
        const SizedBox(height: 20),
        Text(
          'STATUS',
          style: const TextStyle()
              .bold
              .copyWith(fontSize: 11, color: _labelColor, letterSpacing: 0.5),
        ),
        const SizedBox(height: 8),
        _statusDropdown(),
      ],
    );
  }

  Widget _tile({required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _tileFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle().bold.copyWith(
                fontSize: 10.5, color: _labelColor, letterSpacing: 0.4),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle()
                .bold
                .copyWith(fontSize: 14, color: _ink),
          ),
        ],
      ),
    );
  }

  Widget _btn(BuildContext context) => Align(
    alignment: Alignment.center,
    child: Container(
      height: 46,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: purpleColor,
      ),
      child: MaterialButton(
        onPressed: () {
          if (orderDetailController.selectedStatusValue?.isNotEmpty ??
              false) {
            orderDetailController.updateOrderStatusApi(
                orderDetailController.selectedStatusValue ?? '');
            Get.back();
          } else {
            ShowMessage.showSnackBar(
                AppString.pleaseCheckTxt, AppString.selectStatusTxt);
          }
        },
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
        child: Text(
          'Done',
          style: const TextStyle().bold.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}