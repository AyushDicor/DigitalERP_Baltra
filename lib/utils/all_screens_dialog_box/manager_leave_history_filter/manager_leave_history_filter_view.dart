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
// import 'manager_leave_history_filter_controller.dart';
//
// class ManagerLeaveHistoryFilterView extends StatefulWidget {
//   const ManagerLeaveHistoryFilterView({Key? key}) : super(key: key);
//
//   @override
//   State<ManagerLeaveHistoryFilterView> createState() => _ManagerLeaveHistoryFilterViewState();
// }
//
// class _ManagerLeaveHistoryFilterViewState extends State<ManagerLeaveHistoryFilterView> with TickerProviderStateMixin {
//   late final AnimationController _animationController =
//       AnimationController(vsync: this, duration: const Duration(milliseconds: 60));
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ManagerLeaveHistoryFilterController>(
//       init: ManagerLeaveHistoryFilterController(),
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
//   Widget _contentBox(context, ManagerLeaveHistoryFilterController controller) {
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
//                 _btn(context, controller)
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
//   Widget _monthColumn(ManagerLeaveHistoryFilterController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Filter by Date',
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
//               'Filter by Month',
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
//                     'Month',
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
//   Widget _monthDropdown(ManagerLeaveHistoryFilterController controller) {
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
//   Widget _dateColumn(ManagerLeaveHistoryFilterController controller, BuildContext context) {
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
//                 'Date',
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
//     ManagerLeaveHistoryFilterController controller,
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
//
//   Widget _btn(BuildContext context, ManagerLeaveHistoryFilterController controller) => Align(
//         alignment: Alignment.center,
//         child: Container(
//           height: 40,
//           decoration: ShapeDecoration(
//             shape: const StadiumBorder(),
//             gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
//           ),
//           child: MaterialButton(
//             onPressed: () {
//               controller.onApplyFilter();
//             },
//             shape: const StadiumBorder(),
//             padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
//             child: Text(
//               'Apply',
//               style: const TextStyle().bold.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       );
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/custom_dialogbox.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'manager_leave_history_filter_controller.dart';

class ManagerLeaveHistoryFilterView extends StatefulWidget {
  const ManagerLeaveHistoryFilterView({Key? key}) : super(key: key);

  @override
  State<ManagerLeaveHistoryFilterView> createState() =>
      _ManagerLeaveHistoryFilterViewState();
}

class _ManagerLeaveHistoryFilterViewState
    extends State<ManagerLeaveHistoryFilterView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerLeaveHistoryFilterController>(
      init: ManagerLeaveHistoryFilterController(),
      builder: (controller) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _BottomSheet(controller: controller),
          ),
        );
      },
    );
  }
}

class _BottomSheet extends StatefulWidget {
  final ManagerLeaveHistoryFilterController controller;
  const _BottomSheet({required this.controller});

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.filter_list_sharp,
                      color: Color(0xFF3D4ED8), size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close_rounded,
                        size: 20, color: Color(0xFF666666)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Filter toggles
            _filterToggleRow(
              label: 'Filter by Date',
              value: controller.isFilterByDate.value,
              onChanged: (_) => controller.tapOnDateOrMonthSwitch(),
            ),
            const SizedBox(height: 12),
            _filterToggleRow(
              label: 'Filter by Month',
              value: controller.isFilterByMonth.value,
              onChanged: (_) => controller.tapOnDateOrMonthSwitch(),
            ),
            const SizedBox(height: 20),

            // Month section
            Obx(() => IgnorePointer(
                  ignoring: !controller.isFilterByMonth.value,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: controller.isFilterByMonth.value ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionLabel(label: 'Month'),
                        const SizedBox(height: 8),
                        _monthDropdown(controller),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),

            // Date section
            Obx(() => IgnorePointer(
                  ignoring: !controller.isFilterByDate.value,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: controller.isFilterByDate.value ? 1.0 : 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _SectionLabel(label: 'Date Range'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _DateCard(
                                value: controller.firstDate,
                                isFirst: true,
                                controller: controller,
                                context: context,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _DateCard(
                                value: controller.lastDate,
                                isFirst: false,
                                controller: controller,
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                )),

            // Apply button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => controller.onApplyFilter(),
                icon: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3D4ED8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  Widget _filterToggleRow({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A2E),
          ),
        ),
        _NewSwitch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _monthDropdown(ManagerLeaveHistoryFilterController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<MonthData?>(
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        buttonDecoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8E9EF)),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE8E9EF)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        dropdownMaxHeight: 200,
        isExpanded: true,
        hint: const Text(
          'Select Month',
          style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        ),
        value: controller.selectedMonthDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF9E9E9E), size: 22),
        items: controller.monthDropdownList.map((items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items.name,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
            ),
          );
        }).toList(),
        onChanged: (MonthData? newValue) {
          controller.setSelectedMonthValue(newValue);
        },
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String value;
  final bool isFirst;
  final ManagerLeaveHistoryFilterController controller;
  final BuildContext context;

  const _DateCard({
    required this.value,
    required this.isFirst,
    required this.controller,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = int.parse(
        '${controller.homeController.currentUserData?.yearId?.split('-').first}');
    final date = isFirst ? controller.firstDate : controller.lastDate;
    final initDate = date != AppString.dateTimeEmpty
        ? DateTime.parse(
            formatDate(date, AppString.ddMMyyyy, AppString.yyyyMMdd))
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
          final formatted = DateFormat(AppString.ddMMyyyy).format(picked);
          controller.setDate(formatted, isFirst);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8E9EF)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 18, color: Color(0xFF3D4ED8)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value.isEmpty ? (isFirst ? 'From Date' : 'To Date') : value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: value.isEmpty
                      ? const Color(0xFF9E9E9E)
                      : const Color(0xFF1A1A2E),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  const _NewSwitch({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: value ? const Color(0xFF3D4ED8) : const Color(0xFFE0E0E0),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xFF888888),
      ),
    );
  }
}
