// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/dialog_button.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/custom_dialogbox.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import 'list_filter_controller.dart';
//
// class ListFilterView extends StatefulWidget {
//   const ListFilterView({Key? key}) : super(key: key);
//
//   @override
//   State<ListFilterView> createState() => _ListFilterViewState();
// }
//
// class _ListFilterViewState extends State<ListFilterView> with TickerProviderStateMixin {
//   late final AnimationController _animationController =
//       AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ListFilterController>(
//       init: ListFilterController(),
//       builder: (controller) {
//         return Dialog(
//           child: _contentBox(context, controller),
//           backgroundColor: Colors.transparent,
//           insetPadding: EdgeInsets.zero,
//         );
//       },
//     );
//   }
//
//   Widget _contentBox(context, ListFilterController controller) {
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
//               shape: BoxShape.rectangle,
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(
//                 20,
//               ),
//             ),
//             margin: const EdgeInsets.only(top: 25),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Filter',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//                 _monthColumn(controller),
//                 _dateColumn(controller, context),
//                 const SizedBox(height: 35),
//                 DialogButton(
//                   onPress: () => controller.onApplyFilter(),
//                 ),
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
//   Widget _monthColumn(ListFilterController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               AppString.filterByDate,
//               style: const TextStyle().medium.copyWith(fontSize: 14),
//             ),
//             _switch(
//               context: context,
//               value: controller.isFilterByDate.value,
//               onChanged: (val) => controller.tapOnDateOrMonthSwitch(),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               AppString.filterByMonth,
//               style: const TextStyle().medium.copyWith(fontSize: 14),
//             ),
//             _switch(
//               context: context,
//               value: controller.isFilterByMonth.value,
//               onChanged: (val) => controller.tapOnDateOrMonthSwitch(),
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Obx(() {
//           return IgnorePointer(
//             ignoring: !(controller.isFilterByMonth.value),
//             child: ColorFiltered(
//               colorFilter: ColorFilter.mode(
//                 controller.isFilterByMonth.value ? Colors.transparent : lightGreyColor,
//                 BlendMode.saturation,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     AppString.month,
//                     style: const TextStyle().bold.copyWith(
//                           fontSize: 10,
//                           color: red2Color,
//                         ),
//                   ),
//                   _monthDropdown(controller),
//                 ],
//               ),
//             ),
//           );
//         })
//       ],
//     );
//   }
//
//   Widget _monthDropdown(ListFilterController controller) {
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
//         AppString.selectMonth,
//         style: const TextStyle().normal.copyWith(fontSize: 11, fontWeight: FontWeight.normal, color: msgTextColor),
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
//   Widget _switch({required BuildContext context, required bool value, required ValueChanged<bool> onChanged}) {
//     Animation _circleAnimation = AlignmentTween(
//             begin: value ? Alignment.centerRight : Alignment.centerLeft,
//             end: value ? Alignment.centerLeft : Alignment.centerRight)
//         .animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         return GestureDetector(
//           onTap: () {
//             if (_animationController.isCompleted) {
//               _animationController.reverse();
//             } else {
//               _animationController.forward();
//             }
//             value ? onChanged(true) : onChanged(false);
//           },
//           child: Container(
//             width: 53.0,
//             height: 28.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50.0),
//               gradient: _circleAnimation.value == Alignment.centerLeft
//                   ? customGradient(topColor: const Color(0xFFEEEEEE), bottomColor: const Color(0xFFEEEEEE))
//                   : customGradient(topColor: purpleColor, bottomColor: blueColor, opacity: 0.48),
//             ),
//             padding: const EdgeInsets.all(3),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Visibility(
//                   visible: _circleAnimation.value == Alignment.centerRight,
//                   child: const Padding(
//                     padding: EdgeInsets.only(left: 24.0, right: 0),
//                   ),
//                 ),
//                 Align(
//                   alignment: _circleAnimation.value,
//                   child: Container(
//                     width: 22.0,
//                     height: 22.0,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: customGradient(topColor: purpleColor, bottomColor: blueColor),
//                     ),
//                   ),
//                 ),
//                 Visibility(
//                   visible: _circleAnimation.value == Alignment.centerLeft,
//                   child: const Padding(
//                     padding: EdgeInsets.only(left: 0, right: 24.0),
//                     child: Text(
//                       '',
//                       style: TextStyle(color: Colors.transparent, fontWeight: FontWeight.w900, fontSize: 16.0),
//                     ),
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
//   Widget _dateColumn(ListFilterController controller, BuildContext context) {
//     return Obx(() {
//       return IgnorePointer(
//         ignoring: !(controller.isFilterByDate.value),
//         child: ColorFiltered(
//           colorFilter: ColorFilter.mode(
//             controller.isFilterByDate.value ? Colors.transparent : lightGreyColor,
//             BlendMode.saturation,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 20),
//               Text(
//                 AppString.date,
//                 style: const TextStyle().bold.copyWith(
//                       fontSize: 10,
//                       color: red2Color,
//                     ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _dateView(controller.firstDate, Get.width * .31, true, controller, context),
//                   _dateView(controller.lastDate, Get.width * .31, false, controller, context),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _dateView(
//     String value,
//     double width,
//     bool isFirst,
//     ListFilterController controller,
//     BuildContext context,
//   ) {
//     int currentYear = int.parse('${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     String date = isFirst ? controller.firstDate : controller.lastDate;
//     DateTime? initDate = date != AppString.dateTimeEmpty
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


import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/widget_helpers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../screen/base/base_controller.dart';
import '../../custom_dialogbox.dart';
import 'list_filter_controller.dart';

class ListFilterView extends StatelessWidget {
  const ListFilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListFilterController>(
      init: ListFilterController(),
      builder: (controller) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: _FilterSheet(controller: controller),
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final ListFilterController controller;
  const _FilterSheet({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
            decoration: const BoxDecoration(
              color: kAccentBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w700, color: kAccentText),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kBorder),
                    ),
                    child: const Icon(Icons.close_rounded, size: 16, color: kMuted),
                  ),
                ),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toggle row — filter by month
                Obx(() => _toggleRow(
                  label: 'Filter by month',
                  value: controller.isFilterByMonth.value,
                  onTap: controller.tapOnDateOrMonthSwitch,
                )),
                const SizedBox(height: 10),

                // Toggle row — filter by date
                Obx(() => _toggleRow(
                  label: 'Filter by date',
                  value: controller.isFilterByDate.value,
                  onTap: controller.tapOnDateOrMonthSwitch,
                )),
                const SizedBox(height: 20),

                // Month dropdown
                Obx(() => AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.isFilterByMonth.value ? 1.0 : 0.35,
                  child: IgnorePointer(
                    ignoring: !controller.isFilterByMonth.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel('Month'),
                        dropdownWrap(_monthDropdown(controller)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),

                // Date range
                Obx(() => AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: controller.isFilterByDate.value ? 1.0 : 0.35,
                  child: IgnorePointer(
                    ignoring: !controller.isFilterByDate.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel('Date range'),
                        Row(children: [
                          Expanded(
                            child: _dateTileSmall(
                              context,
                              label: 'From',
                              value: controller.firstDate,
                              onTap: () => _pickDate(context, controller, isFirst: true),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dateTileSmall(
                              context,
                              label: 'To',
                              value: controller.lastDate,
                              onTap: () => _pickDate(context, controller, isFirst: false),
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),

                // Apply button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.onApplyFilter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Apply filter',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleRow({
    required String label,
    required bool value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: value ? kAccentBg : kBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: value ? kAccent : kBorder, width: value ? 1.5 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: value ? kAccentText : kText,
              ),
            ),
            _pillSwitch(value),
          ],
        ),
      ),
    );
  }

  Widget _pillSwitch(bool value) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44,
      height: 24,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: value ? kAccent : kBorder,
        borderRadius: BorderRadius.circular(50),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _monthDropdown(ListFilterController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<MonthData?>(
        buttonHeight: 48,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        dropdownDecoration:
        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
        buttonDecoration: const BoxDecoration(color: Colors.transparent),
        dropdownMaxHeight: 200,
        isExpanded: true,
        hint: const Text('Select month',
            style: TextStyle(fontSize: 14, color: kHint)),
        value: controller.selectedMonthDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: kMuted, size: 22),
        items: controller.monthDropdownList.map((item) {
          return DropdownMenuItem<MonthData?>(
            value: item,
            child: Text(item.name,
                style: const TextStyle(fontSize: 14, color: kText)),
          );
        }).toList(),
        onChanged: controller.setSelectedMonthValue,
      ),
    );
  }

  Widget _dateTileSmall(
      BuildContext context, {
        required String label,
        required String value,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: kMuted,
                    letterSpacing: 0.6)),
            const SizedBox(height: 4),
            Row(children: [
              Expanded(
                child: Text(value,
                    style: const TextStyle(fontSize: 13, color: kText),
                    overflow: TextOverflow.ellipsis),
              ),
              const Icon(Icons.calendar_today_outlined, size: 13, color: kMuted),
            ]),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(
      BuildContext context,
      ListFilterController controller, {
        required bool isFirst,
      }) async {
    final int currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');

    final String existing = isFirst ? controller.firstDate : controller.lastDate;
    DateTime? initDate;
    if (existing != AppString.dateTimeEmpty) {
      try {
        initDate = DateTime.parse(
            formatDate(existing, AppString.ddMMyyyy, AppString.yyyyMMdd));
      } catch (_) {
        initDate = DateTime.now();
      }
    } else {
      initDate = DateTime.now();
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
      lastDate: AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
              primary: kAccent, onPrimary: Colors.white),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      final formatted = DateFormat(AppString.ddMMyyyy).format(picked);
      controller.setDate(formatted, isFirst);
    } else {
      if (kDebugMode) print('Date not selected');
    }
  }
}