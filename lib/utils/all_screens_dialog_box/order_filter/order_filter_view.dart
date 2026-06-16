// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_controller.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../app_constant_new.dart';
//
// class OrderFilterDialogBox extends StatelessWidget {
//   const OrderFilterDialogBox({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OrderFilterController>(
//       init: OrderFilterController(),
//       builder: (controller) {
//         return _BottomSheetContent(controller: controller);
//       },
//     );
//   }
// }
//
// class _BottomSheetContent extends StatelessWidget {
//   final OrderFilterController controller;
//   const _BottomSheetContent({required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Drag handle
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE0E0E0),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Header row
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEEF0FF),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.filter_list_sharp,
//                     color: Color(0xFF3D4ED8), size: 20),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 'Filter',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF1A1A2E),
//                 ),
//               ),
//               const Spacer(),
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Icon(Icons.close_rounded,
//                       size: 20, color: Color(0xFF666666)),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 24),
//
//           // Date Range
//           const _SectionLabel(label: 'Date Range'),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: _DateCard(
//                   value: controller.firstDate,
//                   isFirst: true,
//                   controller: controller,
//                   context: context,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: _DateCard(
//                   value: controller.lastDate,
//                   isFirst: false,
//                   controller: controller,
//                   context: context,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//
//           // Executive Name dropdown (hidden for customers)
//           Visibility(
//             visible: !(controller.homeController.isCustomer ?? true),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const _SectionLabel(label: 'Executive Name'),
//                 const SizedBox(height: 8),
//                 _executiveDropdown(controller),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           // Apply Filter button
//           SizedBox(
//             width: double.infinity,
//             height: 52,
//             child: ElevatedButton.icon(
//               onPressed: () => controller.onApplyFilter(),
//               icon: const Icon(Icons.check_rounded,
//                   color: Colors.white, size: 20),
//               label: const Text(
//                 'Apply Filter',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF3D4ED8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 elevation: 0,
//               ),
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
//         ],
//       ),
//     );
//   }
//
//   Widget _executiveDropdown(OrderFilterController c) {
//     final orderCtrl = c.orderController;
//     return _styledDropdown(
//       value: orderCtrl.selectedExecutiveDropdownValue,
//       hint: AppString.selectExecutiveName,
//       items: (orderCtrl.executiveList ?? [])
//           .map((e) => DropdownMenuItem(
//           value: e,
//           child: Text(
//             e.executiveName?.toString() ?? '',
//             style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A2E)),
//           )))
//           .toList(),
//       onChanged: (val) {
//         orderCtrl.selectedExecutiveDropdownValue = val;
//         c.update();
//       },
//     );
//   }
//
//   Widget _styledDropdown({
//     required dynamic value,
//     required String hint,
//     required List<DropdownMenuItem> items,
//     required ValueChanged onChanged,
//   }) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2(
//         isExpanded: true,
//         buttonHeight: 50,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
//         buttonDecoration: BoxDecoration(
//           color: const Color(0xFFF5F6FA),
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: const Color(0xFFE8E9EF)),
//         ),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           color: Colors.white,
//           border: Border.all(color: const Color(0xFFE8E9EF)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.08),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         dropdownMaxHeight: 220,
//         value: value,
//         hint: Text(
//           hint,
//           style: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
//         ),
//         icon: const Icon(Icons.keyboard_arrow_down_rounded,
//             color: Color(0xFF9E9E9E), size: 22),
//         items: items,
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
//
// class _DateCard extends StatelessWidget {
//   final String value;
//   final bool isFirst;
//   final OrderFilterController controller;
//   final BuildContext context;
//
//   const _DateCard({
//     required this.value,
//     required this.isFirst,
//     required this.controller,
//     required this.context,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final currentYear = int.parse(
//         '${controller.homeController.currentUserData?.yearId?.split('-').first}');
//     final dateStr = isFirst ? controller.firstDate : controller.lastDate;
//     final initDate = dateStr != AppString.dateTimeEmpty
//         ? DateTime.parse(
//         formatDate(dateStr, AppString.ddMMyyyy, AppString.yyyyMMdd))
//         : DateTime.now();
//
//     return GestureDetector(
//       onTap: () async {
//         final picked = await showDatePicker(
//           context: context,
//           initialDate: initDate,
//           firstDate:
//           AppConst.calenderFirstDate ?? DateTime(currentYear, 4, 1),
//           lastDate:
//           AppConst.calenderLastDate ?? DateTime(currentYear + 1, 3, 31),
//         );
//         if (picked != null) {
//           controller.setDate(
//               DateFormat(AppString.ddMMyyyy).format(picked), isFirst);
//         }
//       },
//       child: Container(
//         padding:
//         const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//         decoration: BoxDecoration(
//           color: const Color(0xFFF5F6FA),
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: const Color(0xFFE8E9EF)),
//         ),
//         child: Row(
//           children: [
//             const Icon(Icons.calendar_today_outlined,
//                 size: 18, color: Color(0xFF3D4ED8)),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 value.isEmpty
//                     ? (isFirst ? 'From Date' : 'To Date')
//                     : value,
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: value.isEmpty
//                       ? const Color(0xFF9E9E9E)
//                       : const Color(0xFF1A1A2E),
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: const TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.w500,
//         color: Color(0xFF888888),
//       ),
//     );
//   }
// }
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/order_filter/order_filter_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_constant_new.dart';

class OrderFilterDialogBox extends StatelessWidget {
  const OrderFilterDialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderFilterController>(
      init: OrderFilterController(),
      builder: (controller) {
        // ✅ FIX: Dialog must be wrapped in Material so DropdownButton2
        // can find a Material ancestor via LookupBoundary.
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Material(
            // ← required ancestor
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => Get.back(), // tap outside = dismiss
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.45),
                child: GestureDetector(
                  onTap: () {}, // prevent sheet tap from dismissing
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 14),
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
                                child: const Icon(Icons.filter_list_sharp,
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
                                  child: _DateTile(
                                      value: controller.firstDate,
                                      isFirst: true,
                                      controller: controller,
                                      context: context)),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: _DateTile(
                                      value: controller.lastDate,
                                      isFirst: false,
                                      controller: controller,
                                      context: context)),
                            ]),
                            const SizedBox(height: 18),

                            // Executive dropdown (hidden for customer)
                            Visibility(
                              visible: !(controller.homeController.isCustomer ??
                                  true),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _label('Executive Name'),
                                  const SizedBox(height: 6),
                                  _executiveDropdown(controller),
                                  const SizedBox(height: 18),
                                ],
                              ),
                            ),

                            // Apply button
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
                            SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom),
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
      },
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: newTextSecondary));

  Widget _executiveDropdown(OrderFilterController c) {
    final orderCtrl = c.orderController;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
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
        value: orderCtrl.selectedExecutiveDropdownValue,
        hint: const Text(AppString.selectExecutiveName,
            style: TextStyle(fontSize: 14, color: newTextSecondary)),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 20),
        items: (orderCtrl.executiveList ?? [])
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.executiveName?.toString() ?? '',
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: (val) {
          orderCtrl.selectedExecutiveDropdownValue = val;
          c.update();
        },
      ),
    );
  }
}

//  Date tile widget 

class _DateTile extends StatelessWidget {
  final String value;
  final bool isFirst;
  final OrderFilterController controller;
  final BuildContext context;
  const _DateTile({
    required this.value,
    required this.isFirst,
    required this.controller,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
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
}
