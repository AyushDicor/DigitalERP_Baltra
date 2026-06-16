// import 'package:digitalerp/response/area_data_response.dart';
// import 'package:digitalerp/response/city_data_response.dart';
// import 'package:digitalerp/response/executive_list_response.dart';
// import 'package:digitalerp/response/state_data_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_bg_widget.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import 'visit_plan_filter_controller.dart';
//
// class VisitPlanFilterView extends StatelessWidget {
//   const VisitPlanFilterView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       GetBuilder<VisitPlanFilterController>(
//       init: VisitPlanFilterController(),
//       builder: (controller) {
//         ///mew way
//         return DialogBgWidget(
//           onApplyOrDoneButtonTap: () => controller.onApplyFilter(),
//           children: [
//             _dateColumn(controller, context),
//             _executiveDropdown(controller),
//             _stateDropdown(controller),
//             _cityDropdown(controller),
//             _areaDropdown(controller),
//           ],
//         );
//
//         /// oldWay
//         /*
//         return Dialog(
//           child: _contentBox(context, controller),
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//         );
//          */
//       },
//     );
//   }
//   //
//   // Widget _contentBox(
//   //   context,
//   //   VisitPlanFilterController controller,
//   // ) {
//   //   return Container(
//   //     height: Get.height,
//   //     width: Get.width,
//   //     decoration: BoxDecoration(
//   //       gradient: customGradient(
//   //         topColor: purpleColor,
//   //         bottomColor: blueColor,
//   //         opacity: 0.20,
//   //       ),
//   //     ),
//   //     padding: const EdgeInsets.symmetric(horizontal: 25),
//   //     alignment: Alignment.center,
//   //     child: Stack(
//   //       children: [
//   //         Container(
//   //           padding: const EdgeInsets.symmetric(
//   //             horizontal: 25,
//   //             vertical: 40,
//   //           ),
//   //           decoration: BoxDecoration(
//   //             shape: BoxShape.rectangle,
//   //             color: Colors.white,
//   //             borderRadius: BorderRadius.circular(20),
//   //           ),
//   //           margin: const EdgeInsets.only(
//   //             top: 25,
//   //           ),
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text(
//   //                 'Filter',
//   //                 style: const TextStyle().bold.copyWith(
//   //                       color: Colors.black,
//   //                     ),
//   //               ),
//   //               _dateColumn(controller, context),
//   //               _executiveDropdown(controller),
//   //               _stateDropdown(controller),
//   //               _cityDropdown(controller),
//   //               _areaDropdown(controller),
//   //               const SizedBox(height: 35),
//   //               DialogButton(
//   //                 onPress: () => controller.onApplyFilter(),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         Positioned(
//   //           top: 0,
//   //           right: 8,
//   //           child: InkWell(
//   //             onTap: () {
//   //               Navigator.of(context).pop();
//   //             },
//   //             child: Image.asset(
//   //               AppAssets.coloredCloseIcon,
//   //               height: 50,
//   //               width: 50,
//   //               fit: BoxFit.fill,
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _dateColumn(
//     VisitPlanFilterController controller,
//     BuildContext context,) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 20),
//         Text(
//           AppString.date,
//           style: const TextStyle().bold.copyWith(
//                 fontSize: 10,
//                 color: red2Color,
//               ),
//         ),
//         const SizedBox(height: 5),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _dateView(controller.firstDate, Get.width * .31, true, controller, context),
//             _dateView(controller.lastDate, Get.width * .31, false, controller, context),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _executiveDropdown(VisitPlanFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<ExecutiveList>(
//             buttonHeight: 40,
//             buttonPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: dropdownBoxColor,
//             ),
//             dropdownMaxHeight: 200,
//             buttonDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: dropdownBoxColor,
//               gradient: LinearGradient(
//                 colors: [grBottomColor.withValues(alpha:0.2), grTopColor.withValues(alpha:0.2)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             isExpanded: true,
//             hint: Text(
//               AppString.selectExecutiveName,
//               style: const TextStyle().normal.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.normal,
//                     color: msgTextColor,
//                   ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: controller.selectedExecutive,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: controller.filterExecutiveList.map(
//               (items) {
//                 return DropdownMenuItem<ExecutiveList>(
//                   value: items,
//                   child: Text(
//                     items.executivename.toString(),
//                   ),
//                 );
//               },
//             ).toList(),
//             onChanged: (newValue) => controller.onChangedExecutiveListValue(newValue),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _stateDropdown(VisitPlanFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<StateDataList>(
//             buttonHeight: 40,
//             buttonPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
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
//                   orangeColor.withValues(alpha:0.2),
//                   red2Color.withValues(alpha:0.2),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             isExpanded: true,
//             hint: Text(
//               AppString.selectState,
//               style: const TextStyle().normal.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.normal,
//                     color: msgTextColor,
//                   ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: controller.selectedState,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: controller.filterStateList.map((items) {
//               return DropdownMenuItem<StateDataList>(
//                 value: items,
//                 child: Text(items.statename.toString()),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.onChangedStateListValue(newValue);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _cityDropdown(VisitPlanFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<CityDataList>(
//             buttonHeight: 40,
//             buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
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
//                   yellowColor.withValues(alpha:0.2),
//                   yellowColor.withValues(alpha:0.2),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             isExpanded: true,
//             hint: Text(
//               AppString.selectCity,
//               style: const TextStyle().normal.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.normal,
//                     color: msgTextColor,
//                   ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: controller.selectedCity,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: controller.filterCityList.map((items) {
//               return DropdownMenuItem<CityDataList>(
//                 value: items,
//                 child: Text(items.cityname.toString()),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.onChangedCityListValue(newValue);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _areaDropdown(VisitPlanFilterController controller) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 25),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2<AreaDataList>(
//             buttonHeight: 40,
//             buttonPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//             ),
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
//                   orangeColor.withValues(alpha:0.2),
//                   red2Color.withValues(alpha:0.2),
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             isExpanded: true,
//             hint: Text(
//               AppString.selectArea,
//               style: const TextStyle().normal.copyWith(
//                     fontSize: 11,
//                     fontWeight: FontWeight.normal,
//                     color: msgTextColor,
//                   ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             value: controller.selectedArea,
//             icon: Image.asset(
//               AppAssets.dropdownIcon,
//               width: 15,
//               height: 15,
//             ),
//             items: controller.filterAreaList.map((items) {
//               return DropdownMenuItem<AreaDataList>(
//                 value: items,
//                 child: Text(items.areaname.toString()),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               controller.onChangedAreaListValue(newValue);
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _dateView(
//     String value,
//     double width,
//     bool isFirst,
//     VisitPlanFilterController controller,
//     BuildContext context,
//       ) {
//     int currentYear = int.parse('${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ? controller.firstDate : controller.lastDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: initDate,
//           firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
//           lastDate: AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
//         );
//
//         if (pickedDate != null) {
//           String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           if (isFirst) {
//             controller.setDate(formattedDate, true);
//           } else {
//             controller.setDate(formattedDate, false);
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
// }

import 'package:digitalerp/response/area_data_response.dart';
import 'package:digitalerp/response/city_data_response.dart';
import 'package:digitalerp/response/executive_list_response.dart';
import 'package:digitalerp/response/state_data_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'visit_plan_filter_controller.dart';

class VisitPlanFilterView extends StatelessWidget {
  const VisitPlanFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VisitPlanFilterController>(
      init: VisitPlanFilterController(),
      builder: (controller) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withValues(alpha: 0.45),
            child: GestureDetector(
              onTap: () {}, // prevent dismiss on sheet tap
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
                        //  Handle 
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

                        //  Header 
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

                        //  Date Range 
                        _sectionLabel('Date Range'),
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

                        //  Executive 
                        _sectionLabel('Executive Name'),
                        const SizedBox(height: 6),
                        _executiveDropdown(controller),
                        const SizedBox(height: 14),

                        //  State 
                        _sectionLabel('State'),
                        const SizedBox(height: 6),
                        _stateDropdown(controller),
                        const SizedBox(height: 14),

                        //  City 
                        _sectionLabel('City'),
                        const SizedBox(height: 6),
                        _cityDropdown(controller),
                        const SizedBox(height: 14),

                        //  Area 
                        _sectionLabel('Area'),
                        const SizedBox(height: 6),
                        _areaDropdown(controller),
                        const SizedBox(height: 26),

                        //  Apply button 
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.onApplyFilter(),
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
    );
  }

  Widget _sectionLabel(String label) => Text(label,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: newTextSecondary));

  //  Date tile 

  Widget _dateTile(String value, bool isFirst,
      VisitPlanFilterController controller, BuildContext context) {
    final currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
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
          firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
          lastDate:
              AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
        );
        if (picked != null) {
          controller.setDate(
              DateFormat(AppString.ddMMyyyy).format(picked), isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            ),
          ),
        ]),
      ),
    );
  }

  //  Generic styled dropdown 

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

  Widget _executiveDropdown(VisitPlanFilterController c) =>
      _styledDropdown<ExecutiveList>(
        value: c.selectedExecutive,
        hint: AppString.selectExecutiveName,
        items: c.filterExecutiveList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.executivename.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: c.onChangedExecutiveListValue,
      );

  Widget _stateDropdown(VisitPlanFilterController c) =>
      _styledDropdown<StateDataList>(
        value: c.selectedState,
        hint: AppString.selectState,
        items: c.filterStateList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.statename.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: c.onChangedStateListValue,
      );

  Widget _cityDropdown(VisitPlanFilterController c) =>
      _styledDropdown<CityDataList>(
        value: c.selectedCity,
        hint: AppString.selectCity,
        items: c.filterCityList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.cityname.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: c.onChangedCityListValue,
      );

  Widget _areaDropdown(VisitPlanFilterController c) =>
      _styledDropdown<AreaDataList>(
        value: c.selectedArea,
        hint: AppString.selectArea,
        items: c.filterAreaList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.areaname.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: c.onChangedAreaListValue,
      );
}
