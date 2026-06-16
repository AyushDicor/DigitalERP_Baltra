// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/attendance_list/attendance_list_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/attendance_list_flter/attendance_list_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/custom_clipper.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AttendanceListView extends StatelessWidget {
//   const AttendanceListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AttendanceListController>(
//       init: AttendanceListController(Get.arguments),
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
//                           /// old code
//                           // const CustomDialogBox(type: attendanceListFilter),
//                           /// new code
//                           const AttendanceListFilterView(),
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
//                       : SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               _attendanceBox(controller),
//                               const SizedBox(height: 10),
//                               ListView.builder(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: controller.dayList?.length,
//                                 itemBuilder: (context, index) {
//                                   return _attendanceCard(controller, index);
//                                 },
//                               ),
//                             ],
//                           ),
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
//   Widget _attendanceBox(AttendanceListController controller) {
//     return Container(
//       width: Get.width * .9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         gradient: const LinearGradient(
//             colors: grad1, begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0, 0.4]),
//         boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 4)],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, bottom: 10),
//             child: Text(
//               // controller.attendanceSummaryData?[0].month ?? 'N/A',
//               'N/A',
//               style: const TextStyle().bold.copyWith(color: Colors.white),
//             ),
//           ),
//           ClipPath(
//             clipper: CustomClip(),
//             child: Container(
//               width: double.maxFinite,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 15,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         children: [
//                           Text(
//                             'Total Present',
//                             style: const TextStyle().bold.copyWith(
//                                   color: purpleColor,
//                                   fontSize: 12,
//                                 ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             // controller.attendanceSummaryData?[0].present.toString() ?? 'N/A',
//                             'N/A',
//                             style: const TextStyle().bold.copyWith(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                 ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 25,
//                       ),
//                       DottedLine(
//                         color: Colors.grey,
//                         height: 35.0,
//                         strokeWidth: 1.25,
//                         dottedLength: 5.0,
//                         space: 2.0,
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             'Total Absent',
//                             style: const TextStyle().bold.copyWith(
//                                   color: purpleColor,
//                                   fontSize: 12,
//                                 ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             // controller.attendanceSummaryData?[0].absent.toString() ?? 'N/A',
//                             'N/A',
//                             style: const TextStyle().bold.copyWith(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _attendanceCard(AttendanceListController controller, int index) {
//     var item = controller.dayList![index];
//     bool isInProgress = item.outTime == null;
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(top: 10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AppNetworkImage(
//                 height: 70,
//                 width: 80,
//                 image: item.photo,
//               ),
//               RotatedBox(
//                 quarterTurns: 3,
//                 child: _batteryIndicator(
//                   int.parse(item.batterylevel?.toString() ?? '0'),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.watch_later,
//                         color: isInProgress ? purpleColor : red2Color,
//                         size: 14,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         'Time',
//                         style: const TextStyle().bold.copyWith(color: isInProgress ? purpleColor : red2Color, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'In',
//                     style: const TextStyle().bold.copyWith(color: medGreyColor, fontSize: 12),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     item.inTime ?? '    N/A     ',
//                     style: const TextStyle().bold.copyWith(color: Colors.black),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'In Progress...',
//                     style: const TextStyle().bold.copyWith(color: isInProgress ? Colors.black : Colors.white, fontSize: 10),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     'Out',
//                     style: const TextStyle().bold.copyWith(color: medGreyColor, fontSize: 12),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     item.outTime ?? '  N/A   ',
//                     style: const TextStyle().bold.copyWith(color: Colors.black),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 10,),
//
//           Padding(
//             padding: const EdgeInsets.only(left: 65),
//             child: Center(
//               child: Text(
//                 item.date.toString(),
//                 style: const TextStyle().bold.copyWith(color: Colors.black, fontSize: 16),
//               ),
//             ),
//           ),
//           Padding(
//             padding:  EdgeInsets.only(left:Get.width*0.42,top: 10,bottom: 5),
//             child: Center(
//               child: Text(
//                 item.location??"",
//                 style: const TextStyle().bold.copyWith(color: Colors.black, fontSize: 13),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _batteryIndicator(int level) {
//     level = level.clamp(0, 100);
//
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 40,   // similar to size:20 * ratio:2
//           height: 16,
//           padding: EdgeInsets.all(2),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 1.5),
//             borderRadius: BorderRadius.circular(3),
//           ),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               width: (level / 100) * 36, // inner width
//               decoration: BoxDecoration(
//                 color: level > 20 ? Colors.green : Colors.red,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 4),
//         Text(
//           "$level%",
//           style: TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }
//
//
//
// }


import 'package:digitalerp/screen/ui/home/attendance/attendance_list/attendance_list_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/attendance_list_flter/attendance_list_filter_view.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceListView extends StatelessWidget {
  const AttendanceListView({Key? key}) : super(key: key);

  static const Color _navy    = Color(0xFF0A1628);
  static const Color _navyMid = Color(0xFF0F2044);
  static const Color _gold    = Color(0xFFD4A843);
  static const Color _goldL   = Color(0xFFEDC96A);
  static const Color _slate   = Color(0xFF1E3A5F);
  static const Color _bg      = Color(0xFFF7F9FC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _neutral = Color(0xFF64748B);
  static const Color _present = Color(0xFF22C55E);
  static const Color _absent  = Color(0xFFEF4444);
  static const Color _border  = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceListController>(
      init: AttendanceListController(Get.arguments),
      builder: (controller) => Scaffold(
        backgroundColor: _bg,
        body: Column(
          children: [
            _buildHeader(controller),
            Expanded(
              child: controller.dayList?.isEmpty ?? true
                  ? _buildEmpty()
                  : _buildList(controller),
            ),
          ],
        ),
      ),
    );
  }

  //  HEADER 
  Widget _buildHeader(AttendanceListController controller) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [purpleColor, _slate],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.backTap(),
                    child: Container(
                      width: 38,
                      height: 38,
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Attendance List',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                      Text('Detailed daily records',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha:0.5),
                              fontSize: 11)),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.dialog(const AttendanceListFilterView()),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: purpleLightest,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: purpleColor.withValues(alpha:0.4)),
                      ),
                      child: const Icon(Icons.filter_list_sharp,
                          color: purpleColor, size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Summary mini strip
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha:0.06),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      color: Colors.white.withValues(alpha:0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _summaryItem('Total Days',
                        controller.dayList?.length.toString() ?? '0',
                        Colors.white),
                    _vDivider(),
                    _summaryItem(
                        'Present',
                        controller.dayList
                            ?.where((d) =>
                        d.outTime?.isNotEmpty == true)
                            .length
                            .toString() ??
                            '0',
                        _present),
                    _vDivider(),
                    _summaryItem(
                        'In Progress',
                        controller.dayList
                            ?.where((d) =>
                        d.outTime == null ||
                            d.outTime!.isEmpty)
                            .length
                            .toString() ??
                            '0',
                        const Color(0xFFF59E0B)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w800)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                color: Colors.white.withValues(alpha:0.5),
                fontSize: 10,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _vDivider() => Container(
      height: 30,
      width: 1,
      color: Colors.white.withValues(alpha:0.15));

  //  LIST 
  Widget _buildList(AttendanceListController controller) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: controller.dayList?.length ?? 0,
      itemBuilder: (_, i) => _attendanceCard(controller, i),
    );
  }

  Widget _attendanceCard(AttendanceListController controller, int index) {
    final item = controller.dayList![index];
    final bool inProgress =
        item.outTime == null || item.outTime!.isEmpty;
    final Color accent =
    inProgress ? const Color(0xFFF59E0B) : _present;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          // Left accent
          Container(
            width: 4,
            height: 100,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(16)),
            ),
          ),
          // Photo
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppNetworkImage(
                  height: 66, width: 66, image: item.photo),
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.date?.toString() ?? '',
                      style: const TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _timeChip('IN', item.inTime ?? 'N/A', _present),
                      const SizedBox(width: 6),
                      _timeChip(
                          'OUT',
                          inProgress ? 'N/A' : item.outTime!,
                          inProgress
                              ? const Color(0xFFF59E0B)
                              : _absent),
                    ],
                  ),
                  if (inProgress) ...[
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                                color: Color(0xFFF59E0B),
                                shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('In Progress',
                            style: TextStyle(
                                color: Color(0xFFF59E0B),
                                fontSize: 10,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 6),
                  if (item.location?.isNotEmpty == true)
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            size: 10, color: _neutral),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            item.location ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: _neutral,
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          // Battery
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _batteryWidget(
                int.tryParse(
                    item.batterylevel?.toString() ?? '0') ??
                    0),
          ),
        ],
      ),
    );
  }

  Widget _timeChip(String label, String value, Color color) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label ',
              style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w700)),
          Text(value,
              style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _batteryWidget(int level) {
    final color = level > 50
        ? _present
        : level > 20
        ? const Color(0xFFF59E0B)
        : _absent;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Container(
            width: 28,
            height: 12,
            decoration: BoxDecoration(
              border: Border.all(color: _neutral, width: 1.2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Stack(children: [
              FractionallySizedBox(
                widthFactor: level.clamp(0, 100) / 100,
                child: Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 3),
        Text('$level%',
            style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildEmpty() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.event_busy_rounded,
            size: 48,
            color: _neutral.withValues(alpha:0.35)),
        const SizedBox(height: 12),
        const Text('No records found',
            style: TextStyle(color: _neutral, fontSize: 14)),
        const SizedBox(height: 4),
        const Text('Try adjusting the filter',
            style: TextStyle(color: _neutral, fontSize: 12)),
      ],
    ),
  );
}