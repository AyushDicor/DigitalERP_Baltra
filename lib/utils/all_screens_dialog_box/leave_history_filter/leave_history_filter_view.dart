// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/custom_dialogbox.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import 'leave_history_filter_controller.dart';
//
// // class LeaveHistoryFilterView extends StatefulWidget {
// //   const LeaveHistoryFilterView({Key? key}) : super(key: key);
// //
// //   @override
// //   State<LeaveHistoryFilterView> createState() => _LeaveHistoryFilterViewState();
// // }
// //
// // class _LeaveHistoryFilterViewState extends State<LeaveHistoryFilterView> with TickerProviderStateMixin {
// //   late final AnimationController _animationController =
// //       AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<LeaveHistoryFilterController>(
// //       init: LeaveHistoryFilterController(),
// //       builder: (controller) {
// //         return Dialog(
// //           child: _contentBox(context, controller),
// //           backgroundColor: Colors.transparent,
// //           insetPadding: EdgeInsets.zero,
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _contentBox(context, LeaveHistoryFilterController controller) {
// //     return Container(
// //       height: Get.height,
// //       width: Get.width,
// //       decoration: BoxDecoration(
// //         gradient: customGradient(
// //           topColor: purpleColor,
// //           bottomColor: blueColor,
// //           opacity: 0.20,
// //         ),
// //       ),
// //       padding: const EdgeInsets.symmetric(horizontal: 25),
// //       alignment: Alignment.center,
// //       child: Stack(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
// //             decoration: BoxDecoration(
// //               shape: BoxShape.rectangle,
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(
// //                 20,
// //               ),
// //             ),
// //             margin: const EdgeInsets.only(top: 25),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Filter',
// //                   style: const TextStyle().bold.copyWith(color: Colors.black),
// //                 ),
// //                 _monthColumn(controller),
// //                 _dateColumn(controller, context),
// //                 const SizedBox(height: 35),
// //                 _btn(context, controller)
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             top: 0,
// //             right: 8,
// //             child: InkWell(
// //               onTap: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Image.asset(
// //                 AppAssets.coloredCloseIcon,
// //                 height: 50,
// //                 width: 50,
// //                 fit: BoxFit.fill,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _monthColumn(LeaveHistoryFilterController controller) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         const SizedBox(height: 10),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text(
// //               'Filter by Date',
// //               style: const TextStyle().medium.copyWith(fontSize: 14),
// //             ),
// //             _switch(
// //               context: context,
// //               value: controller.isFilterByDate.value,
// //               onChanged: (val) => controller.tapOnDateSwitch(),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 10),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Text(
// //               'Filter by Month',
// //               style: const TextStyle().medium.copyWith(fontSize: 14),
// //             ),
// //             _switch(
// //               context: context,
// //               value: controller.isFilterByMonth.value,
// //               onChanged: (val) => controller.tapOnMonthSwitch(),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 20),
// //         Obx(() {
// //           return IgnorePointer(
// //             ignoring: !(controller.isFilterByMonth.value),
// //             child: ColorFiltered(
// //               colorFilter: ColorFilter.mode(
// //                 controller.isFilterByMonth.value ? Colors.transparent : lightGreyColor,
// //                 BlendMode.saturation,
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Text(
// //                     'Month',
// //                     style: const TextStyle().bold.copyWith(
// //                           fontSize: 10,
// //                           color: red2Color,
// //                         ),
// //                   ),
// //                   _monthDropdown(controller),
// //                 ],
// //               ),
// //             ),
// //           );
// //         })
// //       ],
// //     );
// //   }
// //
// //   Widget _monthDropdown(LeaveHistoryFilterController controller) {
// //     return DropdownButton2<MonthData?>(
// //       buttonHeight: 40,
// //       underline: const Divider(
// //         color: purpleColor,
// //         height: 2,
// //         thickness: 1,
// //       ),
// //       buttonPadding: const EdgeInsets.symmetric(horizontal: 5),
// //       dropdownDecoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(15),
// //         color: dropdownBoxColor,
// //       ),
// //       dropdownMaxHeight: 200,
// //       buttonDecoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(10),
// //         color: Colors.transparent,
// //       ),
// //       isExpanded: true,
// //       hint: Text(
// //         'Select month',
// //         style: const TextStyle().normal.copyWith(fontSize: 11, fontWeight: FontWeight.normal, color: msgTextColor),
// //         overflow: TextOverflow.ellipsis,
// //       ),
// //       value: controller.selectedMonthDropdownValue,
// //       icon: Image.asset(
// //         AppAssets.dropdownIcon,
// //         width: 15,
// //         height: 15,
// //       ),
// //       items: controller.monthDropdownList.map((items) {
// //         return DropdownMenuItem(
// //           value: items,
// //           child: Text(items.name),
// //         );
// //       }).toList(),
// //       onChanged: (MonthData? newValue) {
// //         controller.setSelectedMonthValue(newValue);
// //       },
// //     );
// //   }
// //
// //   Widget _switch({required BuildContext context, required bool value, required ValueChanged<bool> onChanged}) {
// //     Animation _circleAnimation = AlignmentTween(
// //             begin: value ? Alignment.centerRight : Alignment.centerLeft,
// //             end: value ? Alignment.centerLeft : Alignment.centerRight)
// //         .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
// //     return AnimatedBuilder(
// //       animation: _animationController,
// //       builder: (context, child) {
// //         return GestureDetector(
// //           onTap: () {
// //             if (_animationController.isCompleted) {
// //               _animationController.reverse();
// //             } else {
// //               _animationController.forward();
// //             }
// //             value ? onChanged(true) : onChanged(false);
// //           },
// //           child: Container(
// //             width: 53.0,
// //             height: 28.0,
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(50.0),
// //               gradient: _circleAnimation.value == Alignment.centerLeft
// //                   ? customGradient(topColor: const Color(0xFFEEEEEE), bottomColor: const Color(0xFFEEEEEE))
// //                   : customGradient(topColor: purpleColor, bottomColor: blueColor, opacity: 0.48),
// //             ),
// //             padding: const EdgeInsets.all(3),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Visibility(
// //                   visible: _circleAnimation.value == Alignment.centerRight,
// //                   child: const Padding(
// //                     padding: EdgeInsets.only(left: 24.0, right: 0),
// //                   ),
// //                 ),
// //                 Align(
// //                   alignment: _circleAnimation.value,
// //                   child: Container(
// //                     width: 22.0,
// //                     height: 22.0,
// //                     decoration: BoxDecoration(
// //                       shape: BoxShape.circle,
// //                       gradient: customGradient(topColor: purpleColor, bottomColor: blueColor),
// //                     ),
// //                   ),
// //                 ),
// //                 Visibility(
// //                   visible: _circleAnimation.value == Alignment.centerLeft,
// //                   child: const Padding(
// //                     padding: EdgeInsets.only(left: 0, right: 24.0),
// //                     child: Text(
// //                       '',
// //                       style: TextStyle(color: Colors.transparent, fontWeight: FontWeight.w900, fontSize: 16.0),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //
// //
// //
// //
// //   Widget _dateColumn(LeaveHistoryFilterController controller, BuildContext context) {
// //     return Obx(() {
// //       return IgnorePointer(
// //         ignoring: !(controller.isFilterByDate.value),
// //         child: ColorFiltered(
// //           colorFilter: ColorFilter.mode(
// //             controller.isFilterByDate.value ? Colors.transparent : lightGreyColor,
// //             BlendMode.saturation,
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               const SizedBox(height: 20),
// //               Text(
// //                 'Date',
// //                 style: const TextStyle().bold.copyWith(
// //                       fontSize: 10,
// //                       color: red2Color,
// //                     ),
// //               ),
// //               const SizedBox(height: 5),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   _dateView(controller.firstDate, Get.width * .31, true, controller, context),
// //                   _dateView(controller.lastDate, Get.width * .31, false, controller, context),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     });
// //   }
// //
// //   Widget _dateView(
// //     String value,
// //     double width,
// //     bool isFirst,
// //     LeaveHistoryFilterController controller,
// //     BuildContext context,
// //   ) {
// //     int currentYear = int.parse('${controller.homeController.currentUserData?.yearId?.split('-').first}');
// //     String date = isFirst ? controller.firstDate : controller.lastDate;
// //     DateTime? initDate = date != AppString.dateTimeEmpty
// //         ? DateTime.parse(formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
// //         : DateTime.now();
// //     return InkWell(
// //       onTap: () async {
// //         DateTime? pickedDate = await showDatePicker(
// //           context: context,
// //           initialDate: initDate,
// //           firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
// //           lastDate: AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
// //         );
// //
// //         if (pickedDate != null) {
// //           String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
// //           if (isFirst) {
// //             controller.setDate(formattedDate, true);
// //           } else {
// //             controller.setDate(formattedDate, false);
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
// //   Widget _btn(BuildContext context, LeaveHistoryFilterController controller) => Align(
// //         alignment: Alignment.center,
// //         child: Container(
// //           height: 40,
// //           decoration: ShapeDecoration(
// //             shape: const StadiumBorder(),
// //             gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
// //           ),
// //           child: MaterialButton(
// //             onPressed: () {
// //               controller.onApplyFilter();
// //             },
// //             shape: const StadiumBorder(),
// //             padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
// //             child: Text(
// //               'Apply',
// //               style: const TextStyle().bold.copyWith(color: Colors.white),
// //             ),
// //           ),
// //         ),
// //       );
// // }
//
// class LeaveHistoryFilterView extends StatelessWidget {
//   const LeaveHistoryFilterView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LeaveHistoryFilterController>(
//       init: LeaveHistoryFilterController(),
//       builder: (controller) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//           child: _contentBox(context, controller),
//         );
//       },
//     );
//   }
//
//   Widget _contentBox(
//       BuildContext context, LeaveHistoryFilterController controller) {
//     return Container(
//       height: Get.height,
//       width: Get.width,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//         purpleColor,
//         blueColor,
//       ])),
//       padding: const EdgeInsets.symmetric(horizontal: 25),
//       alignment: Alignment.center,
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
//             margin: const EdgeInsets.only(top: 25),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Filter',
//                     style:
//                         const TextStyle().bold.copyWith(color: Colors.black)),
//                 const SizedBox(height: 10),
//                 Obx(() => _switchRow(
//                       context,
//                       title: 'Filter by Date',
//                       value: controller.isFilterByDate.value,
//                       onChanged: (_) => controller.tapOnDateSwitch(),
//                     )),
//                 Obx(() => _switchRow(
//                       context,
//                       title: 'Filter by Month',
//                       value: controller.isFilterByMonth.value,
//                       onChanged: (_) => controller.tapOnMonthSwitch(),
//                     )),
//                 const SizedBox(height: 20),
//                 _monthSection(controller),
//                 _dateSection(controller, context),
//                 const SizedBox(height: 35),
//                 _btn(context, controller),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             right: 8,
//             child: InkWell(
//               onTap: () => Navigator.of(context).pop(),
//               child: Image.asset(AppAssets.coloredCloseIcon,
//                   height: 50, width: 50),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _switchRow(BuildContext context,
//       {required String title,
//       required bool value,
//       required ValueChanged<bool> onChanged}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: const TextStyle().medium.copyWith(fontSize: 14)),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: customSwitch(
//             value: value,
//             onChanged: (_) => onChanged(true),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _monthSection(LeaveHistoryFilterController controller) {
//     return Obx(() {
//       return IgnorePointer(
//         ignoring: !controller.isFilterByMonth.value,
//         child: ColorFiltered(
//           colorFilter: ColorFilter.mode(
//             controller.isFilterByMonth.value
//                 ? Colors.transparent
//                 : lightGreyColor,
//             BlendMode.saturation,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Month',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 10, color: red2Color)),
//               _monthDropdown(controller),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _monthDropdown(LeaveHistoryFilterController controller) {
//     return DropdownButton2<MonthData?>(
//       buttonHeight: 40,
//       underline: const Divider(
//         color: purpleColor,
//         height: 2,
//         thickness: 1,
//       ),
//       buttonPadding: const EdgeInsets.symmetric(horizontal: 5),
//       dropdownDecoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: dropdownBoxColor,
//       ),
//       dropdownMaxHeight: 200,
//       buttonDecoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.transparent,
//       ),
//       isExpanded: true,
//       hint: Text(
//         'Select month',
//         style: const TextStyle().normal.copyWith(
//             fontSize: 11, fontWeight: FontWeight.normal, color: msgTextColor),
//         overflow: TextOverflow.ellipsis,
//       ),
//       value: controller.selectedMonthDropdownValue,
//       icon: Image.asset(
//         AppAssets.dropdownIcon,
//         width: 15,
//         height: 15,
//       ),
//       items: controller.monthDropdownList.map((items) {
//         return DropdownMenuItem(
//           value: items,
//           child: Text(items.name),
//         );
//       }).toList(),
//       onChanged: (MonthData? newValue) {
//         controller.setSelectedMonthValue(newValue);
//       },
//     );
//   }
//
//   Widget _dateSection(
//       LeaveHistoryFilterController controller, BuildContext context) {
//     return Obx(() {
//       return IgnorePointer(
//         ignoring: !controller.isFilterByDate.value,
//         child: ColorFiltered(
//           colorFilter: ColorFilter.mode(
//             controller.isFilterByDate.value
//                 ? Colors.transparent
//                 : lightGreyColor,
//             BlendMode.saturation,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               Text('Date',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 10, color: red2Color)),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _datePickerField(controller.firstDate, Get.width * .31, true,
//                       controller, context),
//                   _datePickerField(controller.lastDate, Get.width * .31, false,
//                       controller, context),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _datePickerField(
//     String value,
//     double width,
//     bool isFirst,
//     LeaveHistoryFilterController controller,
//     BuildContext context,
//   ) {
//     int currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ? controller.firstDate : controller.lastDate;
//     DateTime initDate = date != AppString.dateTimeEmpty
//         ? DateTime.parse(
//             formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//
//     return InkWell(
//       onTap: () async {
//         DateTime? pickedDate = await showDatePicker(
//           context: context,
//           initialDate: initDate,
//           firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
//           lastDate:
//               AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
//         );
//
//         if (pickedDate != null) {
//           String formatted = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//           controller.setDate(formatted, isFirst);
//         }
//       },
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(value, style: const TextStyle().medium),
//                 const SizedBox(width: 10),
//                 Image.asset(AppAssets.calendarIcon, width: 18, height: 18),
//               ],
//             ),
//           ),
//           SizedBox(
//             width: width,
//             child: const Divider(color: purpleColor, thickness: 1),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _btn(BuildContext context, LeaveHistoryFilterController controller) {
//     return Align(
//       alignment: Alignment.center,
//       child: Container(
//         height: 40,
//         decoration: ShapeDecoration(
//           shape: const StadiumBorder(),
//           gradient:
//               customGradient(topColor: orangeColor, bottomColor: red2Color),
//         ),
//         child: MaterialButton(
//           onPressed: controller.onApplyFilter,
//           shape: const StadiumBorder(),
//           padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
//           child: Text('Apply',
//               style: const TextStyle().bold.copyWith(color: Colors.white)),
//         ),
//       ),
//     );
//   }
//
//   Widget customSwitch({
//     required bool value,
//     required ValueChanged<bool> onChanged,
//   }) {
//     return GestureDetector(
//       onTap: () => onChanged(!value),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: 50,
//         height: 28,
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           gradient: value
//               ? LinearGradient(
//                   colors: [purpleColor, blueColor.withValues(alpha:0.6)],
//                 )
//               : LinearGradient(
//                   colors: [Colors.grey.shade400, Colors.grey.shade300],
//                 ),
//         ),
//         child: Align(
//           alignment: value ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             width: 22,
//             height: 22,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 2,
//                   offset: Offset(0, 2),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/custom_dialogbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../screen/base/base_controller.dart';

import 'leave_history_filter_controller.dart';

class LeaveHistoryFilterView extends StatelessWidget {
  const LeaveHistoryFilterView({super.key});

  static const Color _navy = Color(0xFF0A1628);
  static const Color _bg = Color(0xFFF7F9FC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _neutral = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveHistoryFilterController>(
      init: LeaveHistoryFilterController(),
      builder: (controller) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: _sheet(context, controller),
      ),
    );
  }

  Widget _sheet(BuildContext context, LeaveHistoryFilterController controller) {
    return Container(
      color: Colors.black.withValues(alpha: 0.45),
      width: Get.width,
      height: Get.height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: Get.width,
          decoration: const BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: _border, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: purpleLightest,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.filter_list_sharp,
                          color: purpleColor, size: 18),
                    ),
                    const SizedBox(width: 12),
                    const Text('Filter Leave History',
                        style: TextStyle(
                            color: _navy,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: _bg,
                          shape: BoxShape.circle,
                          border: Border.all(color: _border),
                        ),
                        child: const Icon(Icons.close_rounded,
                            size: 16, color: _neutral),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: _border),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => _toggleRow(
                          'Filter by Month',
                          Icons.calendar_view_month_rounded,
                          controller.isFilterByMonth.value,
                          () => controller.tapOnMonthSwitch(),
                        )),
                    const SizedBox(height: 12),
                    Obx(() => _toggleRow(
                          'Filter by Date Range',
                          Icons.date_range_rounded,
                          controller.isFilterByDate.value,
                          () => controller.tapOnDateSwitch(),
                        )),
                    const SizedBox(height: 20),
                    Obx(() => AnimatedCrossFade(
                          duration: const Duration(milliseconds: 200),
                          crossFadeState: controller.isFilterByMonth.value
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: _monthDropdownCard(controller),
                          secondChild: const SizedBox.shrink(),
                        )),
                    Obx(() => AnimatedCrossFade(
                          duration: const Duration(milliseconds: 200),
                          crossFadeState: controller.isFilterByDate.value
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: _dateRangeCard(controller, context),
                          secondChild: const SizedBox.shrink(),
                        )),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => controller.onApplyFilter(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: purpleColor,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                  color: _navy.withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 5)),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_rounded,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Apply Filter',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom + 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toggleRow(String label, IconData icon, bool val, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: val ? _navy.withValues(alpha: 0.05) : _bg,
          borderRadius: BorderRadius.circular(18),
          border:
              Border.all(color: val ? _navy.withValues(alpha: 0.3) : _border),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color:
                    val ? _navy.withValues(alpha: 0.1) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: val ? _navy : _neutral, size: 16),
            ),
            const SizedBox(width: 12),
            Text(label,
                style: TextStyle(
                    color: val ? _navy : _neutral,
                    fontSize: 13,
                    fontWeight: val ? FontWeight.w600 : FontWeight.w400)),
            const Spacer(),
            _neatSwitch(val),
          ],
        ),
      ),
    );
  }

  Widget _neatSwitch(bool val) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44,
      height: 24,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: val ? _navy : Colors.grey.shade300,
      ),
      child: Align(
        alignment: val ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
          ),
        ),
      ),
    );
  }

  Widget _monthDropdownCard(LeaveHistoryFilterController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Month',
              style: TextStyle(
                  color: _neutral,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3)),
          DropdownButtonHideUnderline(
            child: DropdownButton2<MonthData?>(
              buttonHeight: 40,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 0),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: _surface,
              ),
              dropdownMaxHeight: 200,
              isExpanded: true,
              hint: Text('Select month',
                  style: TextStyle(
                      color: _neutral.withValues(alpha: 0.6), fontSize: 13)),
              value: controller.selectedMonthDropdownValue,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: _navy, size: 20),
              items: controller.monthDropdownList.map((items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items.name,
                      style: const TextStyle(
                          color: _navy,
                          fontSize: 13,
                          fontWeight: FontWeight.w500)),
                );
              }).toList(),
              onChanged: (MonthData? newValue) =>
                  controller.setSelectedMonthValue(newValue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateRangeCard(
      LeaveHistoryFilterController controller, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date Range',
              style: TextStyle(
                  color: _neutral,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _dateTile(
                      controller.firstDate, true, controller, context)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(width: 20, height: 1, color: _border),
              ),
              Expanded(
                  child: _dateTile(
                      controller.lastDate, false, controller, context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateTile(String value, bool isFirst,
      LeaveHistoryFilterController controller, BuildContext context) {
    int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
    String date = isFirst ? controller.firstDate : controller.lastDate;
    DateTime initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
            formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
        : DateTime.now();

    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initDate,
          firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
          lastDate:
              AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
          builder: (ctx, child) => Theme(
            data: Theme.of(ctx).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: _navy, onPrimary: Colors.white),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          controller.setDate(
              DateFormat(AppString.ddMMyyyy).format(picked), isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded, size: 14, color: _navy),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                value.isEmpty || value == AppString.dateTimeEmpty
                    ? (isFirst ? 'From' : 'To')
                    : value,
                style: TextStyle(
                    color: value.isEmpty || value == AppString.dateTimeEmpty
                        ? _neutral
                        : _navy,
                    fontSize: 11,
                    fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
