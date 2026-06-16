// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_edit/order_detail_edit_dialog.dart';
// import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/custom_clipper.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class OrderDetailView extends StatelessWidget {
//   const OrderDetailView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OrderDetailController>(
//       init: OrderDetailController(),
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
//                       color: Colors.red,
//                       image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                   child: SafeArea(child: MyAppBar(title: 'Order Details', onBackTap: () => controller.backTap())),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: controller.isBusy
//                         ? showLoader()
//                         : Column(
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               orderCard(controller),
//                               const SizedBox(height: 25),
//                               Column(
//                                 children: List.generate(controller.orderDetailData?.details?.length ?? 0,
//                                     (index) => productCard(controller, index)),
//                               ),
//                               const SizedBox(height: 15),
//                               statusView(controller),
//                               const SizedBox(height: 35),
//                               Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   if (controller.orderController.isManager)
//                                     GradientIconButton(
//                                       onPressed: () {
//                                         Get.dialog(
//                                           ///new way
//                                           OrderDetailEditDialog(),
//                                           ///old way
//                                           // CustomDialogBox(
//                                           //     type: orderDetailEdit),
//                                         ).then((value) => Future.delayed(const Duration(milliseconds: 200), () {
//                                               return controller.getOrderDetail();
//                                             }));
//                                       },
//                                       iconSize: 18,
//                                       radius: 30,
//                                       vPadding: 18,
//                                       hPadding: 18,
//                                       topColor: orangeColor,
//                                       bottomColor: red2Color,
//                                       icon: AppAssets.editIcon,
//                                       shadowColor: const Color(0xffFB9E61),
//                                       shadowRadius: 15,
//                                     ),
//                                   const SizedBox(
//                                     width: 20,
//                                   ),
//                                   Obx(
//                                     () => controller.isPressed.value
//                                         ? const Center(child: CircularProgressIndicator())
//                                         : GradientIconButton(
//                                             onPressed: () {
//                                               controller.getAndShareOrderDetailPdf();
//                                               /*Navigator.push(context, MaterialPageRoute(builder: (context)=>Dummy()),)*/
//                                             },
//                                             iconSize: 18,
//                                             radius: 30,
//                                             vPadding: 18,
//                                             hPadding: 18,
//                                             topColor: purpleColor,
//                                             bottomColor: blueColor,
//                                             icon: AppAssets.shareIcon,
//                                             shadowRadius: 15,
//                                           ),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 35),
//                             ],
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget orderCard(OrderDetailController controller) {
//     var item = controller.orderDetailData;
//     List<Color> color = [];
//     if (item?.orderstatus == 'Approved') {
//       color = [green3Color, green3Color];
//     } else if (item?.orderstatus == 'Rejected') {
//       color = [redColor, redColor];
//     } else {
//       color = grad2;
//     }
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         gradient: LinearGradient(
//             colors: color, begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: const [0.75, 1]),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Text(
//               item?.orderno ?? '',
//               style: const TextStyle().bold.copyWith(color: Colors.white),
//             ),
//           ),
//           ClipPath(
//             clipper: CustomClip(),
//             child: Container(
//               width: double.maxFinite,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.vertical(
//                   bottom: Radius.circular(10),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 // mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 25),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 9,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Order Date',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 item?.orderdate ?? '',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Executive',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 item?.executivename ?? '',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         DottedLine(
//                           color: Colors.grey,
//                           height: 60.0,
//                           strokeWidth: 1.2,
//                           dottedLength: 4.0,
//                           space: 2.0,
//                         ),
//                         Expanded(
//                           flex: 9,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text(
//                                 'Party Name',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 item?.partyname ?? '',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                                 textAlign: TextAlign.end,
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 'Amount',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 '\u{20B9}${item?.amount ?? 'N/A'}',
//                                 style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget productCard(OrderDetailController controller, int index) {
//     var item = controller.orderDetailData!.details![index];
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () {
//               Get.to(const ProductDetailsView(), arguments: item.productid.toString());
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               clipBehavior: Clip.antiAlias,
//               height: Get.height * .125,
//               width: Get.width * .20,
//               child: AppNetworkImage(
//                 image: item.productimage,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.productname ?? '',
//                   style: const TextStyle().bold.copyWith(color: purpleColor),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     textColumn('Qty', item.quantity.toString()),
//                     textColumn('Unit', item.unit.toString()),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Rate',
//                           style: const TextStyle().bold.copyWith(fontSize: 12, color: medGreyColor),
//                         ),
//                         const SizedBox(height: 8),
//                         FittedBox(
//                           child: Text(
//                             '\u{20B9} ${item.rate.toString()}',
//                             style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//                           ),
//                         ),
//                       ],
//                     ),
//                     // textColumn('Rate', '\u{20B9}${item.rate.toString()}'),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           'Amount',
//                           style: const TextStyle().bold.copyWith(fontSize: 12, color: medGreyColor),
//                         ),
//                         const SizedBox(height: 8),
//                         FittedBox(
//                           child: Text(
//                             '\u{20B9} ${item.amount.toString()}',
//                             style: const TextStyle().bold.copyWith(color: Colors.black, fontSize: 14),
//                           ),
//                         ),
//                       ],
//                     ),
//                     //textColumn('Amount', '\u{20B9}${item.amount.toString()}'),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget textColumn(String title, String subTitle) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           title,
//           style: const TextStyle().bold.copyWith(fontSize: 12, color: medGreyColor),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           subTitle,
//           style: const TextStyle().bold.copyWith(fontSize: 14, color: Colors.black),
//         )
//       ],
//     );
//   }
//
//   Widget statusView(OrderDetailController controller) {
//     return Container(
//       decoration: BoxDecoration(
//           border: Border.all(color: orangeColor, width: 1),
//           borderRadius: BorderRadius.circular(25),
//           color: Colors.transparent),
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
//       child: Text(
//         'Status ${controller.orderDetailData?.orderstatus ?? ''}',
//         style: const TextStyle().bold.copyWith(color: orangeColor),
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_detail/order_detail_edit/order_detail_edit_dialog.dart';
import 'package:digitalerp/screen/ui/home/order/select_category/product_list/product_details/product_details_view.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_constant_new.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      init: OrderDetailController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        resizeToAvoidBottomInset: false,
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
          title: const Text('Order Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ),
        body: controller.isBusy
            ? showLoader(color: newBlueColor)
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Order summary card 
                    _orderSummaryCard(controller),
                    const SizedBox(height: 20),

                    //  Products 
                    const Text('Products',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: newTextPrimary)),
                    const SizedBox(height: 10),
                    ...List.generate(
                      controller.orderDetailData?.details?.length ?? 0,
                      (i) => _productCard(controller, i),
                    ),
                    const SizedBox(height: 10),

                    //  Status badge 
                    Center(child: _statusBadge(controller)),
                    const SizedBox(height: 28),

                    //  Action buttons 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.orderController.isManager)
                          _actionButton(
                            icon: Icons.edit_outlined,
                            label: 'Edit',
                            color: const Color(0xFFF39C12),
                            bg: const Color(0xFFFFF4E0),
                            onTap: () => Get.dialog(OrderDetailEditDialog())
                                .then((_) => Future.delayed(
                                    const Duration(milliseconds: 200),
                                    controller.getOrderDetail)),
                          ),
                        if (controller.orderController.isManager)
                          const SizedBox(width: 16),
                        Obx(() => controller.isPressed.value
                            ? const SizedBox(
                                width: 52,
                                height: 52,
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: newBlueColor)))
                            : _actionButton(
                                icon: Icons.share_outlined,
                                label: 'Share',
                                color: const Color(0xFF5B5FC7),
                                bg: const Color(0xFFEEF0FF),
                                onTap: () =>
                                    controller.getAndShareOrderDetailPdf(),
                              )),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  //  Order summary card 

  Widget _orderSummaryCard(OrderDetailController controller) {
    final item = controller.orderDetailData;
    final status = item?.orderstatus ?? '';
    Color statusColor;
    Color statusBg;
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = const Color(0xFF27AE60);
        statusBg = const Color(0xFFE8F8EF);
        break;
      case 'rejected':
        statusColor = const Color(0xFFE74C3C);
        statusBg = const Color(0xFFFFECEA);
        break;
      default:
        statusColor = const Color(0xFFF39C12);
        statusBg = const Color(0xFFFFF4E0);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(children: [
        // Header with order number + status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F3FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            border: Border(bottom: BorderSide(color: Color(0xFFE8ECF0))),
          ),
          child: Row(children: [
            const Icon(Icons.receipt_long_outlined,
                color: Color(0xFF5B5FC7), size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(item?.orderno ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                  color: statusBg, borderRadius: BorderRadius.circular(20)),
              child: Text(status.isEmpty ? 'N/A' : status,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor)),
            ),
          ]),
        ),
        // Info grid
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _infoRow('Order Date', item?.orderdate ?? 'N/A'),
                  const SizedBox(height: 12),
                  _infoRow('Executive', item?.executivename ?? 'N/A'),
                ])),
            Container(
                width: 1,
                height: 60,
                color: const Color(0xFFEFF2F7),
                margin: const EdgeInsets.symmetric(horizontal: 16)),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  _infoRow('Party Name', item?.partyname ?? 'N/A'),
                  const SizedBox(height: 12),
                  _infoRow('Amount', '₹${item?.amount ?? 'N/A'}',
                      valueColor: const Color(0xFF27AE60)),
                ])),
          ]),
        ),
      ]),
    );
  }

  Widget _infoRow(String label, String value, {Color? valueColor}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 11,
              color: newTextSecondary,
              fontWeight: FontWeight.w400)),
      const SizedBox(height: 3),
      Text(value,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? newTextPrimary)),
    ]);
  }

  //  Product card 

  Widget _productCard(OrderDetailController controller, int index) {
    final item = controller.orderDetailData!.details![index];
    return GestureDetector(
      onTap: () => Get.to(const ProductDetailsView(),
          arguments: item.productid.toString()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 72,
              width: 72,
              child: AppNetworkImage(
                  image: item.productimage, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.productname ?? '',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statChip('Qty', item.quantity.toString()),
                  _statChip('Unit', item.unit.toString()),
                  _statChip('Rate', '₹${item.rate}'),
                  _statChip('Amount', '₹${item.amount}',
                      valueColor: const Color(0xFF27AE60)),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _statChip(String label, String value, {Color? valueColor}) {
    return Column(children: [
      Text(label,
          style: const TextStyle(
              fontSize: 10,
              color: newTextSecondary,
              fontWeight: FontWeight.w400)),
      const SizedBox(height: 3),
      Text(value,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor ?? newTextPrimary)),
    ]);
  }

  //  Status badge 

  Widget _statusBadge(OrderDetailController controller) {
    final status = controller.orderDetailData?.orderstatus ?? '';
    Color color;
    Color bg;
    switch (status.toLowerCase()) {
      case 'approved':
        color = const Color(0xFF27AE60);
        bg = const Color(0xFFE8F8EF);
        break;
      case 'rejected':
        color = const Color(0xFFE74C3C);
        bg = const Color(0xFFFFECEA);
        break;
      default:
        color = const Color(0xFFF39C12);
        bg = const Color(0xFFFFF4E0);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text('Status: $status',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: color)),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color bg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: color)),
        ]),
      ),
    );
  }
}
