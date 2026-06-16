// import 'dart:convert';
//
// import 'dart:io';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
// import 'package:digitalerp/shipMangement/update_shipping_value_response.dart';
//
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'shipping_details_list_response.dart';
//
// class UpdateShipmentView extends StatefulWidget {
//   UpdateShipmentView({
//     super.key,
//     required this.id,
//     // required this.selectShippingDetailsListData,
//   });
//
//   String id;
//   // ShippingDetailsListData selectShippingDetailsListData;
//
//   @override
//   State<UpdateShipmentView> createState() => _UpdateShipmentViewState();
// }
//
// class _UpdateShipmentViewState extends State<UpdateShipmentView> {
//   XFile? pickedFile;
//   bool isSelect = false;
//   final ShipManagementController _controller = Get.find<ShipManagementController>();
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _controller.getUpdateShipmentValueApi(widget.id.toString());
//       // assignValueInController();
//     });
//
//     super.initState();
//   }
//
//   // void assignValueInController() {
//   //   print(
//   //       'Shipping Addres :=> ${widget.selectShippingDetailsListData.shippingaddress}');
//   //
//   //   _controller.shippingAddressController.text =
//   //       widget.selectShippingDetailsListData.shippingaddress.toString();
//   //   _controller.deliveredController.text =
//   //       widget.selectShippingDetailsListData.deliveredto.toString();
//   //
//   //   print(
//   //       'Status id => ${widget.selectShippingDetailsListData.dispatchstatus}');
//   //   _controller.selectShippingStatusData?.statusname =
//   //       widget.selectShippingDetailsListData.dispatchstatus;
//   //
//   //   _controller.selectShippingStatusData=_controller.shippingStatusData.firstWhere(
//   //         (element) =>
//   //     element.statusname ==
//   //         widget.selectShippingDetailsListData.dispatchstatus,
//   //     orElse: () => ShippingStatusData(),
//   //   );
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context ) {
//     return GetBuilder<ShipManagementController>(
//         init: ShipManagementController(),
//         builder: (controller,) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Center(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/dashboard_bg.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: MyAppBar(
//                           title: 'Update Shipment',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     left: 0,
//                     bottom: 0,
//                     top: Get.height * 0.150,
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.only(
//                           bottom: (MediaQuery.of(context).viewInsets.bottom > 0)
//                               ? 200
//                               : 0,
//                           left: 20,
//                           right: 20),
//                       child: Column(
//                         children: [
//                           controller.updateShippingValueData.isEmpty
//                           ? CircularProgressIndicator()
//                          : _addShipDetails(controller,controller.updateShippingValueData[0]),
//                           SizedBox(height: Get.height * 0.05),
//                           // submitButton(controller),
//                           SizedBox(height: Get.height * 0.03),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget _addShipDetails(ShipManagementController controller, UpdateShippingValueData data) {
//
//     return Column(
//       children: [
//         Container(
//           height: Get.height * 0.200,
//           width: Get.width * 0.900,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 grBottomColor.withValues(alpha:0.2),
//                 grTopColor.withValues(alpha:0.2)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child:  Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Shipping Address :=> ${data.shippingaddress.toString()}',style: TextStyle().newstyle.copyWith(color: Colors.black)),
//           )
//           // TextFormField(
//           //     maxLines: null,
//           //     controller: controller.shippingAddressController,
//           //     // textInputAction: TextInputAction.done,
//           //     focusNode: controller.shippingAddressFocus,
//           //     // onChanged: (value) {
//           //     //   controller.selectShippingStatusData;
//           //     // },
//           //     style: TextStyle().newstyle.copyWith(
//           //           color: Colors.black,
//           //         ),
//           //     decoration: InputDecoration()
//           //         .textFieldStylenew(
//           //         hintText:
//           //         'Shipping Address'
//           //     )),
//         ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             buttonHeight: Get.height * 0.0600,
//             buttonWidth: Get.width * 0.900,
//             buttonPadding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
//             hint: Text( 'Shipping Status : => ${ data.shippingstatus.toString()}',
//               // 'Shipping Status',
//               style: TextStyle().newstyle.copyWith(color: Colors.black),
//               // overflow: TextOverflow.ellipsis,
//             ),
//             // icon: Image.asset(
//             //   AppAssets.dropdownIcon,
//             //   width: 15,
//             //   height: 15,
//             // ),
//             // value: controller.selectShippingStatusData?.statusid,
//             items:[]
//             // controller.shippingStatusData.map(
//             //   (items) {
//             //     return DropdownMenuItem(
//             //       value: items.statusid,
//             //       child: Text(
//             //         items.statusname.toString(),
//             //         style: TextStyle().newstyle.copyWith(color: Colors.black),
//             //       ),
//             //     );
//             //   },
//             // ).toList(),
//             // onChanged: (newValue) => controller.setSelectShippingStatusDropdown(
//             //     controller.shippingStatusData
//             //         .firstWhere((element) => element.statusid == newValue)),
//           ),
//         ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         Container(child: customText(text: 'Delivered to: => ${data.deliveredto.toString()}')),
//         // customTextFieldText(
//         //   controller: controller.deliveredController,
//         //   focusNode: controller.deliveredFocus,
//         //   hintText: 'Delivered to',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         customText(
//             text: 'Transport Name :=>${data.transportname.toString()}'),
//         // customTextFieldText(
//         //   controller: controller.transportNameController,
//         //   focusNode: controller.transportNameFocus,
//         //   hintText: 'Transport Name',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         customText(text: 'GR.No :=>${ data.grno.toString()}'),
//         // customTextFieldText(
//         //   controller: controller.grNoController,
//         //   focusNode: controller.grNoFocus,
//         //   hintText: 'GR.No.',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//          customText(
//              text: 'Vehicle No :=>${data.vehicleno.toString()}'),
//         // customTextFieldText(
//         //   controller: controller.vehicleNoController,
//         //   focusNode: controller.vehicleNoFocus,
//         //   hintText: 'Vehicle No.',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         customText(text: 'Eway bill No:=> ${data.ewaybillno.toString()}'),
//         // customTextFieldText(
//         //   controller: controller.ewaybillNoController,
//         //   focusNode: controller.ewaybillNoFocus,
//         //   hintText: 'Eway bill No.',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         customText(text: 'Delivery Type :=>${data.deliveredto.toString()} '),
//         // customTextFieldText(
//         //   controller: controller.deliveryTypeController,
//         //   focusNode: controller.deliveryTypeFocus,
//         //   hintText: 'Delivery Type',
//         // ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         Container(
//           height: Get.height * 0.150,
//           width: Get.width * 0.900,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 grBottomColor.withValues(alpha:0.2),
//                 grTopColor.withValues(alpha:0.2)
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Text ('Shipping Note :=>${(data.shippingnote.toString())}',style: TextStyle().newstyle.copyWith(color: Colors.black),),
//           )
//           // TextFormField(
//           //     controller: controller.shippingNoteController,
//           //     textInputAction: TextInputAction.done,
//           //     focusNode: controller.shippingNoteFocus,
//           //     // onChanged: (value) {
//           //     //   controller.onSearchTextChanged(value);
//           //     // },
//           //     style: TextStyle().newstyle.copyWith(
//           //           color: Colors.black,
//           //         ),
//           //     decoration: InputDecoration()
//           //         .textFieldStylenew(hintText: 'Shipping Note')),
//         ),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         Container(
//             height: Get.height * 0.100,
//             width: Get.width * 0.900,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   grBottomColor.withValues(alpha:0.2),
//                   grTopColor.withValues(alpha:0.2)
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Text(
//                     'Shipping Doc',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   InkWell(
//                     onTap: () => _showImageDialog(controller),
//                     child: Container(
//                       height: Get.height * 0.04,
//                       width: Get.width * 0.23,
//                       color: Colors.white,
//                       child: Center(
//                           child: Text(
//                         'Choose File',
//                         style: TextStyle(fontSize: 15),
//                       )),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   pickedFile == null
//                       ? Container(
//                           height: Get.height * 0.05,
//                           width: Get.width * 0.25,
//                           // color: Colors.white,
//                           child: Center(
//                             child: Text(
//                               'No File Chosen',
//                               style: TextStyle(fontSize: 10),
//                             ),
//                           ),
//                         )
//                       : Container(
//                           height: Get.height * 0.06,
//                           width: Get.width * 0.3,
//                           // color: Colors.white,
//                           child: Center(
//                             child: Text(
//                               controller.selectedImageFileNames.value,
//                               style: TextStyle(fontSize: 10),
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             )),
//         SizedBox(
//           height: Get.height * 0.0100,
//         ),
//         Container(
//             height: Get.height * 0.080,
//             width: Get.width * 0.900,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   grBottomColor.withValues(alpha:0.2),
//                   grTopColor.withValues(alpha:0.2)
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'View File',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   InkWell(
//                     onTap: () {
//                      launchUrl(Uri.parse(data.document.toString()),mode: LaunchMode.externalApplication);
//                     },
//                     child: Image.asset('assets/images/view-files.png',color: Colors.blue,height: 30,),
//                   ),
//                 ],
//               ),
//             )),
//       ],
//     );
//   }
//
//
//   // Widget submitButton(ShipManagementController controller) {
//   //   return Container(
//   //     height: 38,
//   //     width: 120,
//   //     decoration: ShapeDecoration(
//   //       shape: const StadiumBorder(),
//   //       gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
//   //     ),
//   //     child: MaterialButton(
//   //       onPressed: () {
//   //         controller.getUpdateShipmentApi(widget.id.toString());
//   //       },
//   //       shape: const StadiumBorder(),
//   //       child: Text(
//   //         'Submit',
//   //         style: TextStyle(fontSize: 15, color: Colors.white),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   _showImageDialog(ShipManagementController value) {
//     return Get.defaultDialog(
//       title: 'Choose Option',
//       radius: 8,
//       titleStyle: const TextStyle().newstyle,
//       content: Column(
//         children: [
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.gallery, value);
//             },
//             child: Text(
//               'Select Image From Gallery',
//               style: const TextStyle().normal,
//             ),
//           ),
//           SizedBox(height: Get.height * .02),
//           InkWell(
//             onTap: () {
//               _getImage(ImageSource.camera, value);
//             },
//             child: Text(
//               'Take picture',
//               style: const TextStyle().normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _getImage(ImageSource source, ShipManagementController value) async {
//     Get.back();
//     pickedFile = await value.pickers.pickImage(
//       source: source,
//       imageQuality: 65,
//     );
//     if (pickedFile != null) {
//       var file = File(pickedFile!.path);
//       value.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
//       value.selectedImageFileNames.value = file.path.split('/').last;
//       value.setSelectedImages(file.path);
//     }
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
import 'package:digitalerp/shipMangement/update_shipping_value_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_constant_new.dart';

class UpdateShipmentView extends StatefulWidget {
  UpdateShipmentView({super.key, required this.id});
  final String id;
  @override
  State<UpdateShipmentView> createState() => _UpdateShipmentViewState();
}

class _UpdateShipmentViewState extends State<UpdateShipmentView> {
  XFile? pickedFile;
  final ShipManagementController _controller =
      Get.find<ShipManagementController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _controller.getUpdateShipmentValueApi(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipManagementController>(
      init: ShipManagementController(),
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
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Update Shipment',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ),
        body: controller.updateShippingValueData.isEmpty
            ? showLoader(color: newBlueColor)
            : SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 30,
                ),
                child: _shipDetails(
                    controller, controller.updateShippingValueData[0]),
              ),
      ),
    );
  }

  Widget _shipDetails(
      ShipManagementController controller, UpdateShippingValueData data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Shipping address card
      _infoCard('Shipping Address', Icons.home_outlined,
          data.shippingaddress ?? 'N/A'),
      const SizedBox(height: 12),

      // Shipping status info row
      _infoCard('Shipping Status', Icons.local_shipping_outlined,
          data.shippingstatus ?? 'N/A'),
      const SizedBox(height: 12),

      // Details grid
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8ECF0)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          _detailRow('Delivered To', data.deliveredto ?? 'N/A'),
          _divider(),
          _detailRow('Transport Name', data.transportname ?? 'N/A'),
          _divider(),
          _detailRow('GR No.', data.grno ?? 'N/A'),
          _divider(),
          _detailRow('Vehicle No.', data.vehicleno ?? 'N/A'),
          _divider(),
          _detailRow('E-way Bill No.', data.ewaybillno ?? 'N/A'),
          _divider(),
          _detailRow('Delivery Type', data.deliveredto ?? 'N/A'),
        ]),
      ),
      const SizedBox(height: 12),

      // Shipping note
      _infoCard(
          'Shipping Note', Icons.note_outlined, data.shippingnote ?? 'N/A',
          multiline: true),
      const SizedBox(height: 12),

      // Shipping doc + upload + view
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8ECF0)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Shipping Document',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
          const SizedBox(height: 12),
          Row(children: [
            // Choose file
            GestureDetector(
              onTap: () => _showImageDialog(controller),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(children: [
                  Icon(Icons.attach_file_rounded,
                      size: 16, color: Color(0xFF5B5FC7)),
                  SizedBox(width: 6),
                  Text('Choose File',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5B5FC7))),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                pickedFile == null
                    ? 'No file chosen'
                    : controller.selectedImageFileNames.value,
                style: const TextStyle(fontSize: 12, color: newTextSecondary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
          const SizedBox(height: 12),
          // View file
          GestureDetector(
            onTap: () => launchUrl(Uri.parse(data.document ?? ''),
                mode: LaunchMode.externalApplication),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8EF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.visibility_outlined,
                    size: 16, color: Color(0xFF27AE60)),
                SizedBox(width: 6),
                Text('View Document',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF27AE60))),
              ]),
            ),
          ),
        ]),
      ),
    ]);
  }

  Widget _infoCard(String label, IconData icon, String value,
      {bool multiline = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF0)),
      ),
      child: Row(
          crossAxisAlignment:
              multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: const Color(0xFF5B5FC7), size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(label,
                      style: const TextStyle(
                          fontSize: 11, color: newTextSecondary)),
                  const SizedBox(height: 3),
                  Text(value,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: newTextPrimary)),
                ])),
          ]),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Expanded(
            child: Text(label,
                style: const TextStyle(fontSize: 13, color: newTextSecondary))),
        Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: newTextPrimary)),
      ]),
    );
  }

  Widget _divider() => const Divider(height: 1, color: Color(0xFFEFF2F7));

  void _showImageDialog(ShipManagementController ctrl) {
    Get.defaultDialog(
      title: 'Choose Option',
      radius: 12,
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: newTextPrimary),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          leading:
              const Icon(Icons.photo_library_outlined, color: newBlueColor),
          title: const Text('Gallery',
              style: TextStyle(fontSize: 14, color: newTextPrimary)),
          onTap: () {
            Get.back();
            _getImage(ImageSource.gallery, ctrl);
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt_outlined, color: newBlueColor),
          title: const Text('Camera',
              style: TextStyle(fontSize: 14, color: newTextPrimary)),
          onTap: () {
            Get.back();
            _getImage(ImageSource.camera, ctrl);
          },
        ),
      ]),
    );
  }

  Future<void> _getImage(ImageSource src, ShipManagementController ctrl) async {
    pickedFile = await ctrl.pickers.pickImage(source: src, imageQuality: 65);
    if (pickedFile != null) {
      final file = File(pickedFile!.path);
      ctrl.selectedImageBase64.value = base64.encode(file.readAsBytesSync());
      ctrl.selectedImageFileNames.value = file.path.split('/').last;
      ctrl.setSelectedImages(file.path);
      setState(() {});
    }
  }
}
