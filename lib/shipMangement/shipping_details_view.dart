//
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
// import 'package:digitalerp/shipMangement/shipping_details_filter_screen.dart';
// import 'package:digitalerp/shipMangement/shipping_details_list_response.dart';
// import 'package:digitalerp/shipMangement/update_shipment_view.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ShippingDetailsView extends StatefulWidget {
//   const ShippingDetailsView({Key? key}) : super(key: key);
//
//   @override
//   State<ShippingDetailsView> createState() => _ShippingDetailsViewState();
// }
//
// class _ShippingDetailsViewState extends State<ShippingDetailsView> {
//   String firstDate = AppString.dateTimeEmpty;
//   String lastDate = AppString.dateTimeEmpty;
//
//   @override
//   Widget build(BuildContext context){
//     return GetBuilder<ShipManagementController>(
//         init: ShipManagementController(),
//         builder: (controller){
//       return Scaffold(
//         resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/dashboard_bg.png'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: MyAppBar(
//                     title: 'Shipping Details',
//                     onBackTap: () => Get.back(),
//                     onFilterTap: ()=> {
//                       controller.  getShippingStatusApi(),
//                        controller. getPartyDropdown(),
//                       Get.dialog(ShippingDetailsFilterScreen())},
//                   ),
//                 ),
//               ),
//             ),
//
//             Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.160,
//                 child: SingleChildScrollView(
//                   child: Column(
//                       children: [
//
//                          controller.shippingDetailsListData.isEmpty
//                             ? SizedBox(
//                             height: Get.height * .4,
//                             child: centerText(
//                                 'Shipping Details Not found'))
//                             : ListView.builder(
//                             shrinkWrap: true,
//                             padding: EdgeInsets.zero,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: controller.shippingDetailsListData.length,
//                             itemBuilder: (context, index) =>
//                                 _shippingDetailCard(controller.shippingDetailsListData.elementAt(index),controller)
//                         ),
//                       ]),
//                 )
//
//             ),
//           ],
//         ),
//       ),
//     );
//     });
//   }
//
//   _shippingDetailCard( ShippingDetailsListData shippingData, ShipManagementController controller) {
//     return Padding(
//       padding:  const EdgeInsets.all(5.0),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         // color: Colors.white,
//         child: InkWell(
//           onTap: () {
//             controller.getShippingStatusApi();
//                controller.getUpdateShipmentValueApi(shippingData.id.toString());
//              Get.to(UpdateShipmentView(
//                id: shippingData.id.toString(),
//                // selectShippingDetailsListData: shippingData,
//                 ));
//              if (kDebugMode) {
//                print(shippingData.id);
//              }
//             },
//           child: Container(
//             width: Get.width,
//             // height: Get.height * 0.270,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 3,
//                       offset: Offset(0, 3))
//                 ]),
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: Get.width * 0.40,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Party Name",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepOrange.shade400)),
//                           Text(
//                                shippingData.partyname?? 'N/A',
//                               style: const TextStyle().xstyle
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             "Delivered To",
//                             style: const TextStyle().newstyle,
//                           ),
//                           Text(
//                             shippingData.deliveredto??'N/A',
//                             style: const TextStyle().xstyle,
//                           ),
//                           SizedBox(height: 7,),
//                           Text("Entry No.",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepOrange.shade400)),
//                           Text(
//                               shippingData.entryno ?? 'N/A',
//                               style: const TextStyle().xstyle),
//                           SizedBox(height: 7,),
//                           Row(
//                             children: [
//                               Text(
//                                 "Update Status",
//                                 style: const TextStyle().newstyle,
//                               ),
//                               SizedBox(width: Get.width * 0.020,),
//                               InkWell(
//                                 child: Icon(Icons.update,
//                                   color: Colors.blueAccent),
//                               )
//                             ],
//                           ),
//
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.35,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           Text(
//                             "Entry Date",
//                             style: const TextStyle().newstyle,
//                           ),
//                           Text(
//                               shippingData.entrydate?? 'N/A',
//                             overflow: TextOverflow.visible,
//                             softWrap: false,
//                             maxLines: 2,
//                             style: const TextStyle().xstyle,
//                           ),
//                           const SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             "Shipping Address",
//                             style: const TextStyle().newstyle,
//                           ),
//                           Text(
//                              shippingData.shippingaddress?? 'N/A',
//                             style: const TextStyle().xstyle,
//                           ),
//                           const SizedBox(
//                             height: 7,
//                           ),
//                           Text(
//                             "Dispatch Status",
//                             style: const TextStyle().newstyle,
//                           ),
//                           Text(
//                              shippingData.dispatchstatus?? 'N/A',
//                             style: const TextStyle().xstyle,
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 255,
//                         top: 10,
//                       ),
//
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }




import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
import 'package:digitalerp/shipMangement/shipping_details_filter_screen.dart';
import 'package:digitalerp/shipMangement/shipping_details_list_response.dart';
import 'package:digitalerp/shipMangement/update_shipment_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screen/ui/fab/menu_fab.dart';
import '../utils/app_constant_new.dart';

class ShippingDetailsView extends StatefulWidget {
  const ShippingDetailsView({Key? key}) : super(key: key);
  @override
  State<ShippingDetailsView> createState() => _ShippingDetailsViewState();
}

class _ShippingDetailsViewState extends State<ShippingDetailsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipManagementController>(
      init: ShipManagementController(),
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
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Shipping Details',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
          actions: [
            GestureDetector(
              onTap: () {
                controller.getShippingStatusApi();
                controller.getPartyDropdown();
                Get.dialog(ShippingDetailsFilterScreen());
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.filter_list_rounded,
                    color: Color(0xFF5B5FC7), size: 20),
              ),
            ),
          ],
        ),

        body: controller.shippingDetailsListData.isEmpty
            ? _emptyState()
            : ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          itemCount: controller.shippingDetailsListData.length,
          itemBuilder: (ctx, i) => _shippingCard(
              controller.shippingDetailsListData.elementAt(i),
              controller),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2378),
      ),
    );
  }

  Widget _emptyState() => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 80, height: 80,
        decoration: BoxDecoration(
            color: const Color(0xFFEEF0FF),
            borderRadius: BorderRadius.circular(40)),
        child: const Icon(Icons.local_shipping_outlined,
            size: 38, color: Color(0xFF5B5FC7)),
      ),
      const SizedBox(height: 16),
      const Text('No Shipping Details',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: newTextPrimary)),
      const SizedBox(height: 6),
      const Text('Shipping details not found.',
          style: TextStyle(fontSize: 13, color: newTextSecondary)),
    ]),
  );

  Widget _shippingCard(ShippingDetailsListData data,
      ShipManagementController controller) {
    final status = data.dispatchstatus ?? '';
    final statusColor = _statusColor(status);
    final statusBg = _statusBg(status);

    return GestureDetector(
      onTap: () {
        controller.getShippingStatusApi();
        controller.getUpdateShipmentValueApi(data.id.toString());
        Get.to(UpdateShipmentView(id: data.id.toString()));
        if (kDebugMode) print(data.id);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10, offset: const Offset(0, 3))
          ],
        ),
        child: Column(children: [
          // Header: party + status
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.business_outlined,
                    color: Color(0xFF5B5FC7), size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Party Name',
                    style: TextStyle(fontSize: 11, color: newTextSecondary)),
                const SizedBox(height: 2),
                Text(data.partyname ?? 'N/A',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700, color: newTextPrimary)),
              ])),
              // Dispatch status pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                    color: statusBg, borderRadius: BorderRadius.circular(20)),
                child: Text(status.isEmpty ? 'N/A' : status,
                    style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600, color: statusColor)),
              ),
            ]),
          ),
          const Divider(height: 1, color: Color(0xFFEFF2F7)),
          // Info grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _infoItem(Icons.tag_outlined, 'Entry No.', data.entryno ?? 'N/A'),
                const SizedBox(height: 10),
                _infoItem(Icons.place_outlined, 'Delivered To', data.deliveredto ?? 'N/A'),
              ])),
              Container(width: 1, height: 60,
                  color: const Color(0xFFEFF2F7),
                  margin: const EdgeInsets.symmetric(horizontal: 12)),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _infoItem(Icons.calendar_today_outlined, 'Entry Date', data.entrydate ?? 'N/A'),
                const SizedBox(height: 10),
                _infoItem(Icons.home_outlined, 'Ship Address', data.shippingaddress ?? 'N/A'),
              ])),
            ]),
          ),
          // Update status row
          Container(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Row(children: [
              const Icon(Icons.update_outlined, size: 16, color: newBlueColor),
              const SizedBox(width: 6),
              const Text('Update Status',
                  style: TextStyle(fontSize: 13, color: newBlueColor,
                      fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: newTextSecondary),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 13, color: newTextSecondary),
      const SizedBox(width: 5),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 10, color: newTextSecondary)),
        const SizedBox(height: 1),
        Text(value,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: newTextPrimary),
            maxLines: 1, overflow: TextOverflow.ellipsis),
      ])),
    ]);
  }

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'delivered': return const Color(0xFF27AE60);
      case 'pending':   return const Color(0xFFF39C12);
      case 'cancelled': return const Color(0xFFE74C3C);
      default:          return newTextSecondary;
    }
  }

  Color _statusBg(String s) {
    switch (s.toLowerCase()) {
      case 'delivered': return const Color(0xFFE8F8EF);
      case 'pending':   return const Color(0xFFFFF4E0);
      case 'cancelled': return const Color(0xFFFFECEA);
      default:          return const Color(0xFFF0F3FF);
    }
  }
}
