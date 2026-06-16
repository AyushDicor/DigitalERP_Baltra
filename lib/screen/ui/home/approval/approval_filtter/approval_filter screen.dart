// //
// //
// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_model.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// // import 'package:digitalerp/screen/ui/home/home_controller.dart';
// // import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
// // import 'package:digitalerp/utils/app_assets.dart';
// // import 'package:digitalerp/utils/app_constant.dart';
// // import 'package:digitalerp/utils/show_message.dart';
// // import 'package:dropdown_button2/dropdown_button2.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:intl/intl.dart';
// //
// // class ApprovalFilterScreen extends StatelessWidget {
// //   HomeController homeController = Get.find<HomeController>();
// //   String firstDate = AppString.dateTimeEmpty;
// //   String lastDate = AppString.dateTimeEmpty;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<ApprovalFilterController>(
// //       init: ApprovalFilterController(),
// //       builder: (controller) {
// //         return DialogBgWidget(
// //           onApplyOrDoneButtonTap: () {
// //             final DateTime? fromDate = controller.firstDateInDate ??
// //                 _parseDdMmYyyy(controller.firstDate);
// //             final DateTime? toDate =
// //                 controller.lastDateInDate ?? _parseDdMmYyyy(controller.lastDate);
// //
// //             if (fromDate == null || toDate == null) {
// //               ShowMessage.showSnackBar(AppString.pleaseCheckTxt,
// //                   "From date and to date must be required");
// //               return;
// //             }
// //
// //             if (fromDate.isBefore(toDate) || fromDate.isAtSameMomentAs(toDate)) {
// //               Navigator.pop(
// //                 context, ApprovalFilterModels(
// //                   documentName: controller.selectedDocument,
// //                   status: controller.selectedstatus,
// //                   client: controller.selectedClient,
// //                   vendor: controller.selectedvendor,
// //                   item: controller.selectedItemList,
// //                   startDate: fromDate,
// //                   endDate: toDate,
// //                 ),
// //               );
// //             } else {
// //               ShowMessage.showSnackBar(
// //                   AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
// //             }
// //           },
// //           children: [
// //             _dateColumn(controller, context),
// //             _documentDropdown(controller),
// //             _statusDropdown(controller),
// //             _clientDropdown(controller),
// //             _vendorDropdown(controller),
// //             _itemDropdown(controller)
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _documentDropdown(ApprovalFilterController controller) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2<DocumentData> (
// //             buttonHeight: 40,
// //             buttonPadding:
// //             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: LinearGradient(
// //                 colors: [
// //                   grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: true,
// //             hint: Text(
// //               "Doc.Name",
// //               style: const TextStyle().newstyle.copyWith(
// //                 // fontSize: 15,
// //                 // fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //               // overflow: TextOverflow.ellipsis,
// //             ),
// //             value: controller.selectedDocument,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.filterDocumentData.map(
// //                   (items) {
// //                 return DropdownMenuItem(
// //                   value: items,
// //                   child: Text(
// //                     items.documentname ?? '',
// //                   ),
// //                 );
// //               },
// //             ).toList(),
// //             onChanged: (newValue){
// //               controller.onChangedDocumentDataValue(newValue);
// //               controller.update();
// //             },
// //             // onChanged: (newValue) => controller.onChangedDocumentDataValue(
// //             //     controller.filterDocumentData
// //             //         .firstWhere((element) => element.documentname == newValue)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   _statusDropdown(ApprovalFilterController controller) {
// //     final uniqueStatusById = <num?, StatusListData>{};
// //     for (final status in controller.filterStatusListData) {
// //       uniqueStatusById.putIfAbsent(status.statusid, () => status);
// //     }
// //     final uniqueStatuses = uniqueStatusById.values.toList();
// //     final selectedStatusId = controller.selectedstatus?.statusid;
// //     final hasValidSelection = selectedStatusId != null &&
// //         uniqueStatuses
// //                 .where((StatusListData item) => item.statusid == selectedStatusId)
// //                 .length ==
// //             1;
// //
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2<num?>(
// //               buttonHeight: 40,
// //               buttonPadding:
// //               const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //               dropdownDecoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(15),
// //                 color: dropdownBoxColor,
// //               ),
// //               dropdownMaxHeight: 200,
// //               buttonDecoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10),
// //                 color: dropdownBoxColor,
// //                 gradient: LinearGradient(
// //                   colors: [
// //                     grBottomColor.withValues(alpha:0.2),
// //                     grTopColor.withValues(alpha:0.2)
// //                   ],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //               ),
// //               isExpanded: true,
// //               hint: Text(
// //                 "Status",
// //                 style: const TextStyle().newstyle.copyWith(
// //                   // fontSize: 11,
// //                   // fontWeight: FontWeight.normal,
// //                   color: Colors.black,
// //                 ),
// //                 overflow: TextOverflow.ellipsis,
// //               ),
// //               value: hasValidSelection ? selectedStatusId : null,
// //               icon: Image.asset(
// //                 AppAssets.dropdownIcon,
// //                 width: 15,
// //                 height: 15,
// //               ),
// //               items: uniqueStatuses.map(
// //                     (StatusListData items) {
// //                   return DropdownMenuItem<num?>(
// //                     value: items.statusid,
// //                     child: Text(
// //                       items.statusname ?? '',
// //                       // controller.filterStatusListData.map(
// //                       //   (items) {
// //                       //     return DropdownMenuItem(
// //                       //       value: items.statusid,
// //                       //       child: Text(
// //                       //         items.statusname.toString(),
// //                     ),
// //                   );
// //                 },
// //
// //
// //               ).toList(),
// //               onChanged: (newValue) {
// //                 final selected = uniqueStatuses
// //                     .where((StatusListData item) => item.statusid == newValue)
// //                     .toList();
// //                 if (selected.isEmpty) return;
// //                 controller.onChangedStatusListValue(selected.first);
// //                 controller.update();
// //               }
// //             // (newValue) => controller.onChangedStatusListValue(
// //             // controller.filterStatusListData
// //             //     .firstWhere((element) => element.statusid == newValue)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _clientDropdown(ApprovalFilterController controller) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //             buttonHeight: 40,
// //             buttonPadding:
// //             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: LinearGradient(
// //                 colors: [
// //                   grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: true,
// //             hint: Text(
// //               "Client",
// //               style: const TextStyle().newstyle.copyWith(
// //                 // fontSize: 11,
// //                 // fontWeight: FontWeight.normal,
// //                 color: Colors.black,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             value: controller.selectedClient?.clientid,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.filterClientListData.map(
// //                   (items) {
// //                 return DropdownMenuItem(
// //                   value: items.clientid,
// //                   child: Text(
// //                     items.clientname.toString(),
// //                   ),
// //                 );
// //               },
// //             ).toList(),
// //             onChanged: (newValue) => controller.onChangedClientListValue(
// //                 controller.filterClientListData
// //                     .firstWhere((element) => element.clientid == newValue)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _vendorDropdown(ApprovalFilterController controller) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //             buttonHeight: 40,
// //             buttonPadding:
// //             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: LinearGradient(
// //                 colors: [
// //                   grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: true,
// //             hint: Text(
// //               "Vendor",
// //               style: const TextStyle().newstyle.copyWith(
// //                 // fontSize: 11,
// //                 // fontWeight: FontWeight.normal,
// //                 color: Colors.black,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             value: controller.selectedvendor?.vendorid,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.filterVendorListData.map(
// //                   (items) {
// //                 return DropdownMenuItem(
// //                   value: items.vendorid,
// //                   child: Text(
// //                     items.vendorname.toString(),
// //                   ),
// //                 );
// //               },
// //             ).toList(),
// //             onChanged: (newValue) => controller.onChangedVendorListValue(
// //                 controller.filterVendorListData
// //                     .firstWhere((element) => element.vendorid == newValue)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _itemDropdown(ApprovalFilterController controller) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 25),
// //         DropdownButtonHideUnderline(
// //           child: DropdownButton2(
// //             buttonHeight: 40,
// //             buttonPadding:
// //             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
// //             dropdownDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(15),
// //               color: dropdownBoxColor,
// //             ),
// //             dropdownMaxHeight: 200,
// //             buttonDecoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(10),
// //               color: dropdownBoxColor,
// //               gradient: LinearGradient(
// //                 colors: [
// //                   grBottomColor.withValues(alpha:0.2),
// //                   grTopColor.withValues(alpha:0.2)
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //             isExpanded: true,
// //             hint: Text(
// //               "Item",
// //               style: const TextStyle().newstyle.copyWith(
// //                 // fontSize: 11,
// //                 // fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             value: controller.selectedItemList?.itemid,
// //             icon: Image.asset(
// //               AppAssets.dropdownIcon,
// //               width: 15,
// //               height: 15,
// //             ),
// //             items: controller.filterItemListData.map(
// //                   (items) {
// //                 return DropdownMenuItem(
// //                   value: items.itemid,
// //                   child: Text(
// //                     items.itemname.toString(),
// //                   ),
// //                 );
// //               },
// //             ).toList(),
// //             onChanged: (newValue) => controller.onChangedItemValue(controller
// //                 .filterItemListData
// //                 .firstWhere((element) => element.itemid == newValue)),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _dateColumn(
// //       ApprovalFilterController controller,
// //       BuildContext context,
// //       ) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 20),
// //         Row(
// //           children: [
// //             const SizedBox(width: 5),
// //             Text(
// //               'FromDate',
// //               style: const TextStyle().bold.copyWith(
// //                 fontSize: 15,
// //                 color: red2Color,
// //               ),
// //             ),
// //             const SizedBox(
// //               width: 60,
// //             ),
// //             Text(
// //               'To Date',
// //               style: const TextStyle().bold.copyWith(
// //                 fontSize: 15,
// //                 color: red2Color,
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 10),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             _dateView(controller.firstDate, Get.width * .31, true, controller, context),
// //             _dateView(controller.lastDate, Get.width * .31, false, controller,context),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _dateView(
// //       String value,
// //       double width,
// //       bool isFirst,
// //       ApprovalFilterController controller,
// //       BuildContext context,
// //       ) {
// //     int currentYear = int.parse(
// //         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
// //     String date = isFirst ?
// //     controller.firstDate : controller.lastDate;
// //     DateTime initDate =
// //     date != AppString.dateTimeEmpty
// //         ? DateTime.parse(
// //         formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd)
// //     )
// //         : DateTime.now();
// //     return InkWell(
// //       onTap: () async {
// //         DateTime? pickedDate = await showDatePicker(
// //             context: context,
// //             initialDate: initDate,
// //             firstDate: DateTime(currentYear),
// //             lastDate: DateTime.now()
// //         );
// //
// //         if (pickedDate != null) {
// //           String formattedDate =
// //           DateFormat(AppString.ddMMyyyy).format(pickedDate);
// //           if (isFirst) {
// //             controller.setDate(formattedDate, true);
// //             controller.setDateByDate(pickedDate, true);
// //           } else {
// //             controller.setDate(formattedDate, false);
// //             controller.setDateByDate(pickedDate, false);
// //           }
// //         } else {
// //           if (kDebugMode) {
// //             print('Date is not selected');
// //           }
// //         }
// //       },
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 5),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Text(value, style: const TextStyle().medium),
// //                 const SizedBox(width: 10),
// //                 Image.asset(
// //                   AppAssets.calendarIcon,
// //                   width: 18,
// //                   height: 18,
// //                 )
// //               ],
// //             ),
// //           ),
// //           SizedBox(
// //             width: Get.width * .31,
// //             child: const Divider(
// //               color: purpleColor,
// //               thickness: 1,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   dateValidate() {
// //     if (firstDate == AppString.dateTimeEmpty) {
// //       ShowMessage.showSnackBar(
// //           AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
// //       return false;
// //     } else if (lastDate == AppString.dateTimeEmpty) {
// //       ShowMessage.showSnackBar(
// //           AppString.pleaseCheckTxt, AppString.selectToDateTxt);
// //       return false;
// //     } else if (DateFormat(AppString.ddMMyyyy)
// //         .parse(lastDate)
// //         .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
// //       ShowMessage.showSnackBar(
// //           AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
// //       return false;
// //     }
// //   }
// //
// //   DateTime? _parseDdMmYyyy(String value) {
// //     if (value == AppString.dateTimeEmpty) return null;
// //     try {
// //       return DateFormat(AppString.ddMMyyyy).parse(value);
// //     } catch (_) {
// //       return null;
// //     }
// //   }
// // }
//
//
//
//
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_model.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../base/base_controller.dart';
// import '../../home_controller.dart';
//
// class ApprovalFilterScreen extends StatelessWidget {
//   HomeController homeController = Get.find<HomeController>();
//   String firstDate = AppString.dateTimeEmpty;
//   String lastDate = AppString.dateTimeEmpty;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApprovalFilterController>(
//       init: ApprovalFilterController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF5F6FA),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 // App Bar
//                 Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 12),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: const Icon(Icons.arrow_back_ios_new,
//                             color: newTextPrimary, size: 22),
//                       ),
//                       const SizedBox(width: 12),
//                       const Expanded(
//                         child: Text(
//                           'Filter',
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w700,
//                               color: newTextPrimary),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 // Filter body
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Date row
//                         _dateRow(controller, context),
//                         const SizedBox(height: 12),
//
//                         // Dropdowns
//                         _filterDropdown(
//                           hint: 'Doc. N0.',
//                           child: _docNoDropdown(controller),
//                         ),
//                         const SizedBox(height: 10),
//                         _filterDropdown(
//                           hint: 'Doc. Name',
//                           child: _docNameDropdown(controller),
//                         ),
//                         const SizedBox(height: 10),
//                         _filterDropdown(
//                           hint: 'Party Name',
//                           child: _partyNameDropdown(controller),
//                         ),
//                         const SizedBox(height: 10),
//                         _filterDropdown(
//                           hint: 'Site Name',
//                           child: _siteNameDropdown(controller),
//                         ),
//                         const SizedBox(height: 10),
//                         _filterDropdown(
//                           hint: 'Executive Name',
//                           child: _executiveNameDropdown(controller),
//                         ),
//                         const SizedBox(height: 10),
//                         _filterDropdown(
//                           hint: 'Amount',
//                           child: _amountDropdown(controller),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Bottom buttons
//                 Container(
//                   color: Colors.white,
//                   padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () {
//                             // Reset all filters
//                             controller.update();
//                           },
//                           style: OutlinedButton.styleFrom(
//                             foregroundColor: newBlueColor,
//                             side: const BorderSide(
//                                 color: newBlueColor, width: 1.5),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           child: const Text('Reset',
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600)),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         flex: 2,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             final DateTime? fromDate =
//                                 controller.firstDateInDate ??
//                                     _parseDdMmYyyy(controller.firstDate);
//                             final DateTime? toDate =
//                                 controller.lastDateInDate ??
//                                     _parseDdMmYyyy(controller.lastDate);
//
//                             if (fromDate == null || toDate == null) {
//                               ShowMessage.showSnackBar(
//                                   AppString.pleaseCheckTxt,
//                                   "From date and to date must be required");
//                               return;
//                             }
//
//                             if (fromDate.isBefore(toDate) ||
//                                 fromDate.isAtSameMomentAs(toDate)) {
//                               Navigator.pop(
//                                 context,
//                                 ApprovalFilterModels(
//                                   documentName:
//                                   controller.selectedDocument,
//                                   status: controller.selectedstatus,
//                                   client: controller.selectedClient,
//                                   vendor: controller.selectedvendor,
//                                   item: controller.selectedItemList,
//                                   startDate: fromDate,
//                                   endDate: toDate,
//                                 ),
//                               );
//                             } else {
//                               ShowMessage.showSnackBar(
//                                   AppString.pleaseCheckTxt,
//                                   AppString.dateGreaterThanFromTxt);
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: newBlueColor,
//                             foregroundColor: Colors.white,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           child: const Text('Apply',
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _dateRow(ApprovalFilterController controller, BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//             child:
//             _datePicker(controller, context, isFirst: true)),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Text('to',
//               style: TextStyle(
//                   fontSize: 14,
//                   color: newTextSecondary,
//                   fontWeight: FontWeight.w400)),
//         ),
//         Expanded(
//             child:
//             _datePicker(controller, context, isFirst: false)),
//       ],
//     );
//   }
//
//   Widget _datePicker(
//       ApprovalFilterController controller,
//       BuildContext context, {
//         required bool isFirst,
//       }) {
//     final value =
//     isFirst ? controller.firstDate : controller.lastDate;
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//
//     String date = isFirst ? controller.firstDate : controller.lastDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//         formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//
//     return GestureDetector(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: initDate,
//           firstDate: DateTime(currentYear),
//           lastDate: DateTime.now(),
//           builder: (context, child) {
//             return Theme(
//               data: Theme.of(context).copyWith(
//                 colorScheme: const ColorScheme.light(
//                   primary: newBlueColor,
//                   onPrimary: Colors.white,
//                   onSurface: newTextPrimary,
//                 ),
//               ),
//               child: child!,
//             );
//           },
//         );
//         if (pickedDate != null) {
//           String formatted =
//           DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           controller.setDate(formatted, isFirst);
//           controller.setDateByDate(pickedDate, isFirst);
//         }
//       },
//       child: Container(
//         padding:
//         const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: newBorderColor),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 value == AppString.dateTimeEmpty
//                     ? 'DD/MM/YYYY'
//                     : value,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: value == AppString.dateTimeEmpty
//                       ? newTextHint
//                       : newTextPrimary,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             const Icon(Icons.calendar_today_outlined,
//                 size: 16, color: newTextSecondary),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _filterDropdown({required String hint, required Widget child}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: newBorderColor),
//       ),
//       child: child,
//     );
//   }
//
//   //  Individual dropdown builders
//
//   Widget _docNoDropdown(ApprovalFilterController controller) {
//     // Reuse document dropdown as Doc No — adjust to your actual model field
//     return _genericDropdownRow('Doc. N0.');
//   }
//
//   Widget _docNameDropdown(ApprovalFilterController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<DocumentData>(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Doc. Name',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: controller.selectedDocument,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: controller.filterDocumentData.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items.documentname ?? '',
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextPrimary)),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.onChangedDocumentDataValue(newValue);
//           controller.update();
//         },
//       ),
//     );
//   }
//
//   Widget _partyNameDropdown(ApprovalFilterController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Party Name',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: controller.selectedClient?.clientid,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: controller.filterClientListData.map((items) {
//           return DropdownMenuItem(
//             value: items.clientid,
//             child: Text(items.clientname.toString(),
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextPrimary)),
//           );
//         }).toList(),
//         onChanged: (newValue) => controller.onChangedClientListValue(
//             controller.filterClientListData
//                 .firstWhere((e) => e.clientid == newValue)),
//       ),
//     );
//   }
//
//   Widget _siteNameDropdown(ApprovalFilterController controller) {
//     // Map to vendor as "Site Name" — adjust to your actual model
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Site Name',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: controller.selectedvendor?.vendorid,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: controller.filterVendorListData.map((items) {
//           return DropdownMenuItem(
//             value: items.vendorid,
//             child: Text(items.vendorname.toString(),
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextPrimary)),
//           );
//         }).toList(),
//         onChanged: (newValue) => controller.onChangedVendorListValue(
//             controller.filterVendorListData
//                 .firstWhere((e) => e.vendorid == newValue)),
//       ),
//     );
//   }
//
//   Widget _executiveNameDropdown(ApprovalFilterController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.transparent,
//         ),
//         isExpanded: true,
//         hint: const Text('Executive Name',
//             style: TextStyle(fontSize: 14, color: newTextHint)),
//         value: controller.selectedItemList?.itemid,
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: newTextSecondary, size: 22),
//         items: controller.filterItemListData.map((items) {
//           return DropdownMenuItem(
//             value: items.itemid,
//             child: Text(items.itemname.toString(),
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextPrimary)),
//           );
//         }).toList(),
//         onChanged: (newValue) => controller.onChangedItemValue(
//             controller.filterItemListData
//                 .firstWhere((e) => e.itemid == newValue)),
//       ),
//     );
//   }
//
//   Widget _amountDropdown(ApprovalFilterController controller) {
//     return _genericDropdownRow('Amount');
//   }
//
//   // Generic placeholder row for fields not yet wired
//   Widget _genericDropdownRow(String hint) {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(hint,
//                 style: const TextStyle(
//                     fontSize: 14, color: newTextHint)),
//           ),
//           const Icon(Icons.keyboard_arrow_down_rounded,
//               color: newTextSecondary, size: 22),
//         ],
//       ),
//     );
//   }
//
//   DateTime? _parseDdMmYyyy(String value) {
//     if (value == AppString.dateTimeEmpty) return null;
//     try {
//       return DateFormat(AppString.ddMMyyyy).parse(value);
//     } catch (_) {
//       return null;
//     }
//   }
// }