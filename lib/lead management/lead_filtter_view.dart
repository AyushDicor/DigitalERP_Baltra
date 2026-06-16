//
//
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/documentname_responce.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filtter_responce/status_list_responce.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
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
// class LeadFilterScreen extends StatelessWidget {
//   HomeController homeController = Get.find<HomeController>();
//   String firstDate = AppString.dateTimeEmpty;
//   String lastDate = AppString.dateTimeEmpty;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApprovalFilterController>(
//       init: ApprovalFilterController(),
//       builder: (controller) {
//         return DialogBgWidget(
//           onApplyOrDoneButtonTap: () {},
//           // {
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
//             _documentDropdown(controller),
//             _statusDropdown(controller),
//             _clientDropdown(controller),
//             _vendorDropdown(controller),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _documentDropdown(ApprovalFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<DocumentData> (
//             buttonHeight: 40,
//             buttonPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
//               "Lead Type",
//               style: const TextStyle().newstyle.copyWith(
//                 // fontSize: 15,
//                 // fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               // overflow: TextOverflow.ellipsis,
//             ),
//             // value: controller.selectedDocument,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items:[],
//             // controller.filterDocumentData.map(
//             //       (items) {
//             //     return DropdownMenuItem(
//             //       value: items,
//             //       child: Text(
//             //         items.documentname ?? '',
//             //       ),
//             //     );
//             //   },
//             // ).toList(),
//             // onChanged: (newValue){
//             //   controller.onChangedDocumentDataValue(newValue);
//             //   controller.update();
//             // },
//             // onChanged: (newValue) => controller.onChangedDocumentDataValue(
//             //     controller.filterDocumentData
//             //         .firstWhere((element) => element.documentname == newValue)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   _statusDropdown(ApprovalFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<StatusListData>(
//               buttonHeight: 40,
//               buttonPadding:
//               const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//               dropdownDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: dropdownBoxColor,
//               ),
//               dropdownMaxHeight: 200,
//               buttonDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: dropdownBoxColor,
//                 gradient: LinearGradient(
//                   colors: [
//                     grBottomColor.withValues(alpha:0.2),
//                     grTopColor.withValues(alpha:0.2)
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               isExpanded: true,
//               hint: Text(
//                 "Company",
//                 style: const TextStyle().newstyle.copyWith(
//                   // fontSize: 11,
//                   // fontWeight: FontWeight.normal,
//                   color: Colors.black,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               value: controller.selectedstatus,
//               icon: Image.asset(
//                 AppAssets.dropdownIcon,
//                 width: 15,
//                 height: 15,
//               ),
//               items:[],
//             // controller.filterStatusListData.map(
//               //       (items) {
//               //     return DropdownMenuItem(
//               //       value: items,
//               //       child: Text(
//               //         items.statusname ?? '',
//               //         // controller.filterStatusListData.map(
//               //         //   (items) {
//               //         //     return DropdownMenuItem(
//               //         //       value: items.statusid,
//               //         //       child: Text(
//               //         //         items.statusname.toString(),
//               //       ),
//               //     );
//               //   },
//               // ).toList(),
//               // onChanged: (newValue) {
//               //   controller.onChangedStatusListValue(newValue);
//               //   controller.update();
//               // }
//             // (newValue) => controller.onChangedStatusListValue(
//             // controller.filterStatusListData
//             //     .firstWhere((element) => element.statusid == newValue)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _clientDropdown(ApprovalFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             buttonHeight: 40,
//             buttonPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
//               "Status",
//               style: const TextStyle().newstyle.copyWith(
//                 // fontSize: 11,
//                 // fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: controller.selectedClient?.clientid,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items:[],
//             // controller.filterClientListData.map(
//             //       (items) {
//             //     return DropdownMenuItem(
//             //       value: items.clientid,
//             //       child: Text(
//             //         items.clientname.toString(),
//             //       ),
//             //     );
//             //   },
//             // ).toList(),
//             // onChanged: (newValue) => controller.onChangedClientListValue(
//             //     controller.filterClientListData
//             //         .firstWhere((element) => element.clientid == newValue)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _vendorDropdown(ApprovalFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             buttonHeight: 40,
//             buttonPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
//               "Handler",
//               style: const TextStyle().newstyle.copyWith(
//                 // fontSize: 11,
//                 // fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             // value: controller.selectedvendor?.vendorid,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: [],
//             // controller.filterVendorListData.map((items) {
//             //     return DropdownMenuItem(
//             //       value: items.vendorid,
//             //       child: Text(
//             //         items.vendorname.toString(),
//             //       ),
//             //     );
//             //   },
//             // ).toList(),
//             // onChanged: (newValue) => controller.onChangedVendorListValue(
//             //     controller.filterVendorListData
//             //         .firstWhere((element) => element.vendorid == newValue)),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget _dateColumn(
//       ApprovalFilterController controller,
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
//             _dateView(controller.firstDate, Get.width * .31, true, controller, context),
//             _dateView(controller.lastDate, Get.width * .31, false, controller,context),
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
//       ApprovalFilterController controller,
//       BuildContext context,
//       ) {
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ?
//     controller.firstDate : controller.lastDate;
//     DateTime initDate =
//     date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//         formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd)
//     )
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//             context: context,
//             initialDate: initDate,
//             firstDate: DateTime(currentYear),
//             lastDate: DateTime.now()
//         );
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

import 'package:digitalerp/lead%20management/lead%20management%20controller/lead_management_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_filtter/approval_filter_controller.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//  Design tokens 
const Color _kPrimary       = purpleColor;
const Color _kBg            = Color(0xFFF6F7FB);
const Color _kSurface       = Colors.white;
const Color _kBorder        = Color(0xFFE4E7F0);
const Color _kTextPrimary   = Color(0xFF111827);
const Color _kTextSecondary = Color(0xFF6B7280);
const Color _kTextHint      = Color(0xFFB0B8C8);
const Color _kCardShadow    = Color(0x0A000000);

//  Filter chip row 
class _FilterDropdown extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FilterDropdown({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: _kTextSecondary),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kTextSecondary,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: _kSurface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Select $label',
                  style: const TextStyle(fontSize: 14, color: _kTextHint),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: _kTextSecondary, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

//  Date range picker tile 
class _DatePickerTile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DatePickerTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != AppString.dateTimeEmpty;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _kTextSecondary,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: hasValue ? _kPrimary.withValues(alpha:0.5) : _kBorder,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: hasValue ? _kPrimary : _kTextSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hasValue ? value : 'DD/MM/YYYY',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                        hasValue ? FontWeight.w600 : FontWeight.w400,
                        color: hasValue ? _kTextPrimary : _kTextHint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  Main screen 
class LeadFilterScreen extends StatelessWidget {
  LeadFilterScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalFilterController>(
      init: ApprovalFilterController(),
      builder: (controller) => Scaffold(
        backgroundColor: _kBg,
        appBar: AppBar(
          backgroundColor: _kSurface,
          elevation: 0,
          scrolledUnderElevation: 1,
          shadowColor: _kBorder,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kBorder),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: _kTextPrimary, size: 16),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Filter Leads',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _kTextPrimary,
                ),
              ),
              Text(
                'Narrow down your results',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: _kTextSecondary,
                ),
              ),
            ],
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Date range card 
                    _filterCard(
                      title: 'Date Range',
                      icon: Icons.date_range_outlined,
                      iconColor: _kPrimary,
                      child: _dateRangeRow(controller, context),
                    ),
                    const SizedBox(height: 14),

                    //  Filters card 
                    _filterCard(
                      title: 'Filter Options',
                      icon: Icons.tune_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      child: Column(
                        children: const [
                          _FilterDropdown(
                            label: 'Lead Type',
                            icon: Icons.label_outline_rounded,
                          ),
                          SizedBox(height: 14),
                          _FilterDropdown(
                            label: 'Company',
                            icon: Icons.business_outlined,
                          ),
                          SizedBox(height: 14),
                          _FilterDropdown(
                            label: 'Status',
                            icon: Icons.flag_outlined,
                          ),
                          SizedBox(height: 14),
                          _FilterDropdown(
                            label: 'Handler',
                            icon: Icons.person_outline_rounded,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            //  Bottom action bar 
            Container(
              decoration: const BoxDecoration(
                color: _kSurface,
                border: Border(top: BorderSide(color: _kBorder)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: Row(
                children: [
                  // Reset button
                  SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.restart_alt_rounded,
                          size: 16, color: _kTextSecondary),
                      label: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _kTextSecondary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        side: const BorderSide(color: _kBorder),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Apply button
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.check_rounded,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _kPrimary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _kSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
        boxShadow: const [
          BoxShadow(color: _kCardShadow, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha:0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 17),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kTextPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: _kBorder),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _dateRangeRow(
      ApprovalFilterController controller, BuildContext context) {
    final int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');

    return Row(
      children: [
        _DatePickerTile(
          label: 'FROM DATE',
          value: controller.firstDate,
          onTap: () async {
            final String date = controller.firstDate;
            final DateTime initDate = date != AppString.dateTimeEmpty
                ? DateTime.parse(
                formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
                : DateTime.now();

            final picked = await showDatePicker(
              context: context,
              initialDate: initDate,
              firstDate: DateTime(currentYear),
              lastDate: DateTime.now(),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: _kPrimary,
                    onPrimary: Colors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              final fmt = DateFormat(AppString.ddMMyyyy).format(picked);
              controller.setDate(fmt, true);
              controller.setDateByDate(picked, true);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
          child: Container(
            width: 24,
            height: 2,
            color: _kBorder,
          ),
        ),
        _DatePickerTile(
          label: 'TO DATE',
          value: controller.lastDate,
          onTap: () async {
            final String date = controller.lastDate;
            final DateTime initDate = date != AppString.dateTimeEmpty
                ? DateTime.parse(
                formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
                : DateTime.now();

            final picked = await showDatePicker(
              context: context,
              initialDate: initDate,
              firstDate: DateTime(currentYear),
              lastDate: DateTime.now(),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: _kPrimary,
                    onPrimary: Colors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              final fmt = DateFormat(AppString.ddMMyyyy).format(picked);
              controller.setDate(fmt, false);
              controller.setDateByDate(picked, false);
            }
          },
        ),
      ],
    );
  }
}