// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/executive_attendance_list/executive_attendance_list_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/attendance_list_flter/attendance_list_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ExecutiveAttendanceListView extends StatelessWidget {
//   const ExecutiveAttendanceListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ExecutiveAttendanceListController>(
//       init: ExecutiveAttendanceListController(Get.arguments),
//       builder: (controller) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           drawer: Container(
//             color: Colors.red,
//             width: 200,
//             height: double.maxFinite,
//           ),
//           body: Center(
//             child: Stack(
//               children: [
//                 Positioned(
//                   top: 0,
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         color: Colors.red,
//                         image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                     child: SafeArea(
//                       child: MyAppBar(
//                         title: 'Attendance List',
//                         onBackTap: () => controller.backTap(),
//                         onFilterTap: () => Get.dialog(
//                           ///new way
//                           const AttendanceListFilterView(),
//
//                           /// old way
//                           // CustomDialogBox(type: attendanceListFilter),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.135,
//                   child: controller.dayList?.isEmpty ?? true
//                       ? centerText('No Data Found')
//                       : ListView.builder(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           shrinkWrap: true,
//                           itemCount: controller.dayList?.length,
//                           itemBuilder: (context, index) {
//                             return _attendanceCard(controller, index);
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _attendanceCard(ExecutiveAttendanceListController controller, int index) {
//     var item = controller.dayList![index];
//     bool isInProgress = item.outTime == null;
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(top: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: isInProgress ? gr1Opp : gr2),
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   formatDate(item.date.toString(), AppString.ddMMyyyy, 'MMMM'),
//                   style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 12),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   formatDate(item.date.toString(), AppString.ddMMyyyy, 'dd'),
//                   style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 18),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   formatDate(item.date.toString(), AppString.ddMMyyyy, 'yyyy'),
//                   style: const TextStyle().bold.copyWith(color: Colors.white, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.watch_later,
//                     color: isInProgress ? purpleColor : red2Color,
//                     size: 14,
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     'Time',
//                     style: const TextStyle().bold.copyWith(color: isInProgress ? purpleColor : red2Color, fontSize: 14),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 'In',
//                 style: const TextStyle().bold.copyWith(color: medGreyColor, fontSize: 12),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 item.inTime.toString(),
//                 style: const TextStyle().bold.copyWith(color: Colors.black),
//               ),
//             ],
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'In Progress...',
//                 style: const TextStyle().bold.copyWith(color: isInProgress ? Colors.black : Colors.white, fontSize: 10),
//               ),
//               const SizedBox(
//                 height: 9,
//               ),
//               Text(
//                 'Out',
//                 style: const TextStyle().bold.copyWith(color: medGreyColor, fontSize: 12),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 item.outTime ?? '    N/A     ',
//                 style: const TextStyle().bold.copyWith(color: Colors.black),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/executive_attendance_list/executive_attendance_list_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/attendance_list_flter/attendance_list_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//  Design tokens (shared) 
const Color _kCard = Colors.white;
const Color _kText = Color(0xFF1A1A2E);
const Color _kSub = Color(0xFF888888);
const Color _kBorder = Color(0xFFE8E8E8);

class ExecutiveAttendanceListView extends StatelessWidget {
  const ExecutiveAttendanceListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExecutiveAttendanceListController>(
      init: ExecutiveAttendanceListController(Get.arguments),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(
            children: [
              //  App Bar 
              Container(
                color: _kCard,
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.backTap(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: _kText, size: 22),
                    ),
                    Expanded(
                      child: Text(
                        'Attendance List',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _kText,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: purpleLightest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.tune,
                            color: purpleColor, size: 20),
                        onPressed: () =>
                            Get.dialog(const AttendanceListFilterView()),
                      ),
                    ),
                  ],
                ),
              ),

              //  List 
              Expanded(
                child: controller.dayList?.isEmpty ?? true
                    ? Center(
                        child: Text('No Data Found',
                            style: GoogleFonts.dmSans(color: _kSub)))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                        itemCount: controller.dayList?.length,
                        itemBuilder: (context, index) =>
                            _attendanceCard(controller, index),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _attendanceCard(
      ExecutiveAttendanceListController controller, int index) {
    final item = controller.dayList![index];
    final bool isInProgress = item.outTime == null;

    final String dateLabel = _formatDateLabel(item.date?.toString() ?? '');
    final String statusLabel = isInProgress ? 'In Progress' : 'Completed';
    final Color statusBg =
        isInProgress ? newOrangeLightColor : newGreenLightColor;
    final Color statusFg = isInProgress ? newOrangeColor : newGreenColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    dateLabel,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _kText,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(statusLabel,
                      style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusFg)),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: _kBorder),

          // Check in / out
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Row(
              children: [
                Expanded(
                  child: _checkBlock(
                    label: 'Check In',
                    time: item.inTime?.toString() ?? 'N/A',
                  ),
                ),
                Container(
                  width: 1,
                  height: 50,
                  color: _kBorder,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: _checkBlock(
                    label: 'Check Out',
                    time: item.outTime ?? (isInProgress ? '–' : 'N/A'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBlock({required String label, required String? time}) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: purpleColor, size: 20),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w600, color: _kText)),
            Text(
              time ?? 'N/A',  // ← add null fallback here
              style: GoogleFonts.dmSans(fontSize: 11, color: _kSub),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDateLabel(String raw) {
    try {
      final parts = raw.split('/');
      if (parts.length == 3) {
        final d = DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ];
        return '${days[d.weekday - 1]}, ${months[d.month - 1]} ${d.day}, ${d.year}';
      }
    } catch (_) {}
    return raw;
  }
}
