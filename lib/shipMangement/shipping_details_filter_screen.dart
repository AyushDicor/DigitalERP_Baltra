// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class ShippingDetailsFilterScreen extends StatelessWidget {
//   HomeController homeController = Get.find<HomeController>();
//   String firstDate = AppString.dateTimeEmpty;
//   String lastDate = AppString.dateTimeEmpty;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       builder: ( ShipManagementController  controller) {
//         return DialogBgWidget(
//           onApplyOrDoneButtonTap: () {
//             if(
//             controller.selectShippingStatusData == null || controller.selectShippingStatusData!.statusname!.isEmpty){
//               ShowMessage.showSnackBar('', 'Please Select Status');
//             } else if(
//             controller.selectPartyDropdown == null || controller.selectPartyDropdown!.partyname!.isEmpty){
//               ShowMessage.showSnackBar('', 'Please Select Party');
//             }
//             else {
//               controller.getShippingDetailsListApi();
//               Get.back();
//             }
//             // Get.back();
//           },
//           // onApplyOrDoneButtonTap: () {
//           //   if ((controller.firstDateInDate != null &&
//           //       controller.lastDateInDate == null) ||
//           //       (controller.firstDateInDate == null &&
//           //           controller.lastDateInDate != null )) {
//           //     ShowMessage.showSnackBar(AppString.pleaseCheckTxt,
//           //         "From date and to date must be required");
//           //     return;
//           //   }
//           //   if(firstDate == AppString.dateTimeEmpty || lastDate ==AppString.dateTimeEmpty){}
//           //   if (controller.firstDateInDate!
//           //       .isBefore(controller.lastDateInDate!) ||
//           //       controller.firstDateInDate!
//           //           .isAtSameMomentAs(controller.lastDateInDate!)) {
//           //     Navigator.pop(
//           //       context,
//           //       ApprovalFilterModels(
//           //         documentName: controller.selectedDocument,
//           //         status: controller.selectedstatus,
//           //         client: controller.selectedClient,
//           //         vendor: controller.selectedvendor,
//           //         item: controller.selectedItemList,
//           //         startDate: controller.firstDateInDate,
//           //         endDate: controller.lastDateInDate,
//           //       ),
//           //     );
//           //   } else {
//           //     ShowMessage.showSnackBar(
//           //         AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
//           //   }
//           // },
//           children: [
//             _dateColumn(controller, context),
//             const SizedBox(height: 25),
//             shippingStatusDropDown(controller),
//             const SizedBox(height: 15),
//             _executiveDropDown(controller)
//                   ],
//         );
//       },
//     );
//   }
//
//   Widget shippingStatusDropDown(ShipManagementController controller)
//   {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0550,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding:
//         const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint:
//         Text(
//           "Shipping Status",
//           style: const TextStyle().newstyle.copyWith(
//             color: Colors.black,
//           ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value:  controller.selectShippingStatusData?.statusid,
//         items: controller.shippingStatusData.map(
//               (items) {
//             return DropdownMenuItem(
//               value: items.statusid,
//               child: Text(
//                 items.statusname.toString(),
//                 style: TextStyle().newstyle.copyWith(color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged:(newValue) => controller.setSelectShippingStatusDropdown(controller
//             .shippingStatusData
//             .firstWhere((element) => element.statusid == newValue)),
//         // items: controller.filterDocumentData.map(
//         //       (items) {
//         //     return DropdownMenuItem(
//         //       value: items,
//         //       child: Text(
//         //         items.documentname ?? '',
//         //       ),
//         //     );
//         //   },
//         // ).toList(),
//         // onChanged: (newValue){
//         //   controller.onChangedDocumentDataValue(newValue);
//         //   controller.update();
//         // },
//       ),
//     );
//   }
//
//
//   Widget _executiveDropDown(ShipManagementController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         buttonHeight: Get.height * 0.0550,
//         buttonWidth: Get.width * 0.900,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownMaxHeight: 200,
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//           gradient: LinearGradient(
//             colors: [
//               grBottomColor.withValues(alpha:0.2),
//               grTopColor.withValues(alpha:0.2)
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         isExpanded: true,
//         hint: Text(
//           "Select Party",
//           style: const TextStyle().newstyle.copyWith(
//             color: Colors.black,
//           ),
//           // overflow: TextOverflow.ellipsis,
//         ),
//         // value: controller.selectedDocument,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         value: controller.selectPartyDropdown?.partyid,
//         items: controller.partyDropdown.map(
//               (items) {
//             return DropdownMenuItem(
//               value: items.partyid,
//               child: Text(
//                 items.partyname.toString(),
//                 style: TextStyle().newstyle.copyWith(color: Colors.black),
//               ),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) => controller.setSelectPartyDropdownValue(
//             controller.partyDropdown
//                 .firstWhere((element) => element.partyid == newValue)),
//         // items: controller.filterDocumentData.map(
//         //       (items) {
//         //     return DropdownMenuItem(
//         //       value: items,
//         //       child: Text(
//         //         items.documentname ?? '',
//         //       ),
//         //     );
//         //   },
//         // ).toList(),
//         // onChanged: (newValue){
//         //   controller.onChangedDocumentDataValue(newValue);
//         //   controller.update();
//         // },
//       ),
//     );
//   }
//
//
//
//   Widget _dateColumn(
//       ShipManagementController controller,
//       BuildContext context,
//       ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 20),
//         Row(
//           children: [
//             const SizedBox(width: 5),
//             Text(
//               'FromDate',
//               style: const TextStyle().bold.copyWith(
//                 fontSize: 15,
//                 color: red2Color,
//               ),
//             ),
//             const SizedBox(
//               width: 60,
//             ),
//             Text(
//               'To Date',
//               style: const TextStyle().bold.copyWith(
//                 fontSize: 15,
//                 color: red2Color,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _dateView(controller.firstDate, Get.width * .31, true, controller,
//                 context),
//             _dateView(controller.lastDate, Get.width * .31, false, controller,
//                 context),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _dateView(
//       String value,
//       double width,
//       bool isFirst,
//       ShipManagementController controller,
//       BuildContext context,
//       ) {
//     int currentYear = int.parse(
//         controller.homeController.currentUserData?.yearId?.split('-').first ?? '0');
//     String date = isFirst ? controller.firstDate : controller.lastDate;
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
//           SizedBox(
//             width: Get.width * .31,
//             child: const Divider(
//               color: purpleColor,
//               thickness: 1,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   dateValidate() {
//     if (firstDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.selectFromDateTxt);
//       return false;
//     } else if (lastDate == AppString.dateTimeEmpty) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.selectToDateTxt);
//       return false;
//     } else if (DateFormat(AppString.ddMMyyyy)
//         .parse(lastDate)
//         .isBefore(DateFormat(AppString.ddMMyyyy).parse(firstDate))) {
//       ShowMessage.showSnackBar(
//           AppString.pleaseCheckTxt, AppString.dateGreaterThanFromTxt);
//       return false;
//     }
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/shipMangement/ship%20management%20controller/ship_management_controller.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../utils/app_constant_new.dart';

class ShippingDetailsFilterScreen extends StatelessWidget {
  ShippingDetailsFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipManagementController>(
      builder: (controller) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        // ✅ Material wraps the entire dialog content — fixes DropdownButton2 error
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withValues(alpha: 0.45),
              child: GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Handle
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 14),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDDE1E9),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          // Header
                          Row(children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF0FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.filter_list_rounded,
                                  color: Color(0xFF5B5FC7), size: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text('Filter',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: newTextPrimary)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F6FA),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.close_rounded,
                                    color: newTextSecondary, size: 18),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 20),

                          // Date range
                          _label('Date Range'),
                          const SizedBox(height: 8),
                          Row(children: [
                            Expanded(
                                child: _dateTile(controller.firstDate, true,
                                    controller, context)),
                            const SizedBox(width: 12),
                            Expanded(
                                child: _dateTile(controller.lastDate, false,
                                    controller, context)),
                          ]),
                          const SizedBox(height: 18),

                          // Shipping status
                          _label('Shipping Status'),
                          const SizedBox(height: 6),
                          _shippingStatusDropdown(controller),
                          const SizedBox(height: 14),

                          // Party
                          _label('Party'),
                          const SizedBox(height: 6),
                          _partyDropdown(controller),
                          const SizedBox(height: 26),

                          // Apply button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (controller.selectShippingStatusData ==
                                        null ||
                                    (controller.selectShippingStatusData
                                            ?.statusname?.isEmpty ??
                                        true)) {
                                  ShowMessage.showSnackBar(
                                      '', 'Please Select Status');
                                } else if (controller.selectPartyDropdown ==
                                        null ||
                                    (controller.selectPartyDropdown?.partyname
                                            ?.isEmpty ??
                                        true)) {
                                  ShowMessage.showSnackBar(
                                      '', 'Please Select Party');
                                } else {
                                  controller.getShippingDetailsListApi();
                                  Get.back();
                                }
                              },
                              icon: const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 20),
                              label: const Text('Apply Filter',
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: newTextSecondary));

  Widget _dateTile(String value, bool isFirst,
      ShipManagementController controller, BuildContext context) {
    final currentYear = int.parse(
        controller.homeController.currentUserData?.yearId?.split('-').first ??
            '0');
    final dateStr = isFirst ? controller.firstDate : controller.lastDate;
    final initDate = dateStr != AppString.dateTimeEmpty
        ? DateTime.parse(
            formatDate(dateStr, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: DateTime(currentYear),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          final formatted = DateFormat(AppString.ddMMyyyy).format(picked);
          controller.setDate(formatted, isFirst);
          controller.setDateByDate(picked, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Row(children: [
          Icon(Icons.calendar_today_outlined,
              size: 16, color: value.isEmpty ? newTextSecondary : newBlueColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? (isFirst ? 'From Date' : 'To Date') : value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: value.isEmpty ? newTextSecondary : newTextPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _styledDropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        buttonHeight: 48,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        buttonDecoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        value: value,
        hint: Text(hint,
            style: const TextStyle(fontSize: 14, color: newTextSecondary)),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 20),
        items: items,
        onChanged: onChanged,
      ),
    );
  }

  Widget _shippingStatusDropdown(ShipManagementController c) =>
      _styledDropdown<dynamic>(
        value: c.selectShippingStatusData?.statusid,
        hint: 'Shipping Status',
        items: c.shippingStatusData
            .map((e) => DropdownMenuItem(
                value: e.statusid,
                child: Text(e.statusname.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: (v) => c.setSelectShippingStatusDropdown(
            c.shippingStatusData.firstWhere((e) => e.statusid == v)),
      );

  Widget _partyDropdown(ShipManagementController c) => _styledDropdown<dynamic>(
        value: c.selectPartyDropdown?.partyid,
        hint: 'Select Party',
        items: c.partyDropdown
            .map((e) => DropdownMenuItem(
                value: e.partyid,
                child: Text(e.partyname.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: (v) => c.setSelectPartyDropdownValue(
            c.partyDropdown.firstWhere((e) => e.partyid == v)),
      );
}
