// import 'dart:convert';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/attendance_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/leave_apply_view/leave_apply_controller.dart';
// import 'package:digitalerp/screen/ui/setup/setup_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_network_image.dart';
// import 'package:digitalerp/utils/custom_clipper.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:battery_plus/battery_plus.dart';
//
//
// class AttendanceView extends StatelessWidget {
//   AttendanceView({super.key});
//
//   final ImagePicker picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     final bottomInset = MediaQuery.of(context).viewPadding.bottom;
//
//     return GetBuilder<AttendanceController>(
//       init: AttendanceController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(AppAssets.dashboardBg),
//                         fit: BoxFit.fill)),
//                 child: SafeArea(
//                   child: MyAppBar(
//                       title: 'Attendance',
//                       // onBackTap: ()=>Get.back(),
//                       onDrawerTap: () => controller.openDrawer(context)),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 0,
//               left: 0,
//               top: Get.height * 0.105,
//               bottom: bottomInset, // ✅ FIX
//               child: controller.isBusy
//                   ? const Center(
//                       child: CircularProgressIndicator(color: purpleColor),
//                     )
//                   : controller.attendanceSummaryData?.isNotEmpty ?? true
//                       ? SingleChildScrollView(
//                           padding: EdgeInsets.only(
//                             bottom: 60 + bottomInset, // ✅ FIX
//                           ),
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: Get.height * 0.025),
//                                     markAttendanceBox(controller),
//                                     const SizedBox(height: 10),
//                                     if (controller.attendanceSummaryData?[0]
//                                             .details?.isNotEmpty ??
//                                         false)
//                                       ListView.builder(
//                                         padding: EdgeInsets.zero,
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemCount: (controller
//                                                     .attendanceSummaryData![0]
//                                                     .details!
//                                                     .length >
//                                                 2)
//                                             ? 2
//                                             : controller
//                                                 .attendanceSummaryData?[0]
//                                                 .details
//                                                 ?.length,
//                                         itemBuilder: (context, index) {
//                                           return attendanceCloseCard(
//                                               controller, index);
//                                         },
//                                       ),
//                                     if (controller.attendanceSummaryData?[0] !=
//                                             null &&
//                                         controller.attendanceSummaryData![0]
//                                                 .details !=
//                                             null &&
//                                         controller.attendanceSummaryData![0]
//                                                 .details!.length >
//                                             2)
//                                       Align(
//                                         alignment: Alignment.topRight,
//                                         child: TextButton(
//                                           onPressed: () =>
//                                               controller.tapOnSeeMore(),
//                                           child: Text(
//                                             'See More',
//                                             style: const TextStyle()
//                                                 .bold
//                                                 .copyWith(
//                                                   fontSize: 14,
//                                                   color: red2Color,
//                                                   decoration:
//                                                       TextDecoration.underline,
//                                                 ),
//                                           ),
//                                         ),
//                                       ),
//                                     const SizedBox(height: 25),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: List.generate(
//                                         4,
//                                         (index) =>
//                                             _leavesCard(controller, index),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 25),
//                                   ],
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: applyleaveButton(controller),
//                               ),
//                               const SizedBox(height: 30),
//                             ],
//                           ),
//                         )
//                       : centerText('No Data found'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget applyleaveButton(AttendanceController controller) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: gr2,
//         borderRadius: BorderRadius.horizontal(left: Radius.circular(25)),
//       ),
//       child: MaterialButton(
//         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.horizontal(left: Radius.circular(25))),
//         onPressed: () {
//           Get.put(LeaveApplyController());
//           controller.tapOnApplyLeave();
//         },
//         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
//         child: Text(
//           'Apply Leave ',
//           style: const TextStyle().bold.copyWith(color: Colors.white),
//         ),
//       ),
//     );
//   }
//
//   Widget markAttendanceBox(AttendanceController controller) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: Get.width * .9,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             gradient: const LinearGradient(
//                 colors: grad1,
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0, 0.4]),
//             boxShadow: const [
//               BoxShadow(
//                   color: Colors.black12, offset: Offset(0, 4), blurRadius: 4)
//             ],
//           ),
//           margin: const EdgeInsets.only(bottom: 20),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: Text(
//                   controller.attendanceSummaryData?[0].month ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(color: Colors.white),
//                 ),
//               ),
//               ClipPath(
//                 clipper: CustomClip(),
//                 child: Container(
//                   width: double.maxFinite,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 'Total Present',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: purpleColor,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 controller.attendanceSummaryData?[0].present
//                                         .toString() ??
//                                     'N/A',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             width: 25,
//                           ),
//                           DottedLine(
//                             color: Colors.grey,
//                             height: 35.0,
//                             strokeWidth: 1.25,
//                             dottedLength: 5.0,
//                             space: 2.0,
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 'Total Absent',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: purpleColor,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 controller.attendanceSummaryData?[0].absent
//                                         .toString() ??
//                                     'N/A',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 'Total CL',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: purpleColor,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 (controller.attendanceSummaryData?[0].totalcl ??
//                                         0)
//                                     .toString(),
//                                 style: const TextStyle().bold.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             width: 25,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 20, right: 10),
//                             child: DottedLine(
//                               color: Colors.grey,
//                               height: 35.0,
//                               strokeWidth: 1.25,
//                               dottedLength: 5.0,
//                               space: 2.0,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Column(
//                             // crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Total EL',
//                                 style: const TextStyle().bold.copyWith(
//                                       color: purpleColor,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 (controller.attendanceSummaryData?[0].totalel ??
//                                         0)
//                                     .toString(),
//                                 style: const TextStyle().bold.copyWith(
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           bottom: 0,
//           child: controller.isBtnShow
//               ? InkWell(
//                   onTap: () async {
//                     // if (controller.isAttendanceMarked!=true ) {
//                     await _getImage(ImageSource.camera, controller);
//                     controller.tapOnMarkAttendance();
//
//                     // if (controller.selectedImage.value.isNotEmpty) {
//                     //   // final imageFile = File(controller.selectedImage.value);
//                     //   // print('-=======${imageFile}');
//                     //   controller.tapOnMarkAttendance(); // Use the image
//                     // }
//                     // }
//                   },
//                   child: Container(
//                     // width: 200,
//                     decoration: BoxDecoration(
//                       gradient: controller.enableBtn
//                           ? gr2
//                           : customGradient(
//                               topColor: medGreyColor,
//                               bottomColor: medGreyColor),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 15, vertical: 10),
//                     alignment: Alignment.center,
//                     child: Text(
//                       controller.isAttendanceMarked
//                           ? 'Day Close'
//                           : 'Mark Attendance',
//                       // maxLines: 1,
//                       style:
//                           const TextStyle().bold.copyWith(color: Colors.white),
//                     ),
//                   ),
//                 )
//               : showLoader(),
//         )
//       ],
//     );
//   }
//
//   Widget attendanceBox(AttendanceController controller, int index) {
//     var item = controller.attendanceSummaryData?[0].details?[index];
//     bool isInProgress = index == -1;
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: isInProgress ? progressAttendanceColor : red2Color),
//       margin: const EdgeInsets.only(top: 20),
//       child: Column(
//         children: [
//           Container(
//             width: Get.width,
//             height: 50,
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//               color: Colors.white,
//             ),
//             padding:
//                 const EdgeInsets.only(left: 26, top: 10, right: 23, bottom: 10),
//             // alignment: Alignment.center,
//             child: Row(
//               mainAxisAlignment: isInProgress
//                   ? MainAxisAlignment.spaceBetween
//                   : MainAxisAlignment.center,
//               children: [
//                 Text(
//                   item?.date.toString() ?? '',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(color: Colors.black, fontSize: 14),
//                 ),
//                 if (isInProgress)
//                   Text(
//                     'In Progress...',
//                     style: const TextStyle()
//                         .bold
//                         .copyWith(color: Colors.black, fontSize: 14),
//                   )
//               ],
//             ),
//           ),
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 26, top: 10, right: 23, bottom: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.watch_later,
//                         color: isInProgress ? Colors.black : Colors.white,
//                         size: 14,
//                       ),
//                       const SizedBox(width: 5),
//                       Text(
//                         'Time',
//                         style: const TextStyle().bold.copyWith(
//                             color: isInProgress ? Colors.black : Colors.white,
//                             fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'In',
//                       style: const TextStyle().bold.copyWith(
//                           color: isInProgress ? Colors.black : Colors.white,
//                           fontSize: 12),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       item?.inTime ?? '    N/A     ',
//                       style: const TextStyle().bold.copyWith(
//                           color: isInProgress ? Colors.black : Colors.white),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       'Out',
//                       style: const TextStyle().bold.copyWith(
//                           color: isInProgress ? Colors.black : Colors.white,
//                           fontSize: 12),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       item?.outTime ?? '    N/A     ',
//                       style: const TextStyle().bold.copyWith(
//                           color: isInProgress ? Colors.black : Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget attendanceCloseCard(AttendanceController controller, int index) {
//     var item = controller.attendanceSummaryData![0].details![index];
//     bool isInProgress = item.outTime == null;
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15), color: Colors.white),
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
//                 child: batteryWidget(
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
//                         style: const TextStyle().bold.copyWith(
//                             color: isInProgress ? purpleColor : red2Color,
//                             fontSize: 14),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'In',
//                     style: const TextStyle()
//                         .bold
//                         .copyWith(color: medGreyColor, fontSize: 12),
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
//                     style: const TextStyle().bold.copyWith(
//                         color: isInProgress ? Colors.black : Colors.white,
//                         fontSize: 10),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     'Out',
//                     style: const TextStyle()
//                         .bold
//                         .copyWith(color: medGreyColor, fontSize: 12),
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
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 80),
//             child: Center(
//               child: Text(
//                 item.date.toString(),
//                 style: const TextStyle()
//                     .bold
//                     .copyWith(color: Colors.black, fontSize: 16),
//               ),
//             ),
//           ),
//           Padding(
//             padding:
//                 EdgeInsets.only(left: Get.width * 0.42, top: 10, bottom: 5),
//             child: Center(
//               child: Text(
//                 item.location.toString(),
//                 style: const TextStyle()
//                     .bold
//                     .copyWith(color: Colors.black, fontSize: 13),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _leavesCard(AttendanceController controller, int index) {
//     var item = controller.attendanceSummaryData?[0];
//     Color color = index == 0
//         ? blueColor
//         : index == 1
//             ? purpleColor
//             : index == 2
//                 ? orangeColor
//                 : red2Color;
//     String name = index == 0
//         ? 'Total\nLeave'
//         : index == 1
//             ? 'Remaining\nLeave'
//             : index == 2
//                 ? 'Approved\nLeave'
//                 : 'Rejected\nLeave';
//     String value = index == 0
//         ? item?.totalLeave.toString() ?? 'N/A'
//         : index == 1
//             ? item?.remainingTotalLeave.toString() ?? 'N/A'
//             : index == 2
//                 ? item?.approveLeave.toString() ?? 'N/A'
//                 : item?.rejectLeave.toString() ?? 'N/A';
//     return InkWell(
//       onTap: () {
//         if (index ==
//             2 /* && item?.approveLeave != 0 && item?.approveLeave != null */) {
//           controller.tapOnApprovedLeave();
//         } else if (index ==
//             3 /*&& item?.rejectLeave != 0 && item?.approveLeave != null*/) {
//           controller.tapOnRejectedLeave();
//         }
//       },
//       child: SizedBox(
//         width: Get.width * .22,
//         child: Column(
//           children: [
//             Container(
//               width: Get.width * .18,
//               height: Get.width * .18,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: color.withValues(alpha:0.22),
//               ),
//               margin: const EdgeInsets.only(bottom: 10),
//               child: Center(
//                 child: Text(
//                   value,
//                   //index,
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 20, color: color),
//                 ),
//               ),
//             ),
//             Text(
//               name,
//               maxLines: 2,
//               softWrap: true,
//               style:
//                   const TextStyle().normal.copyWith(fontSize: 12, color: color),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget batteryWidget(int level) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 40,
//           height: 16,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black, width: 1.5),
//             borderRadius: BorderRadius.circular(3),
//           ),
//           child: Stack(
//             children: [
//               FractionallySizedBox(
//                 widthFactor: (level.clamp(0, 100)) / 100,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: level > 20 ? Colors.green : Colors.red,
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//             ],
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
//   Future<void> _getImage(
//       ImageSource source, AttendanceController controller) async {
//     Get.back(); // Close bottom sheet or dialog, if used
//
//     final pickedFile = await controller.picker.pickImage(
//       source: source,
//       imageQuality: 65,
//     );
//
//     if (pickedFile != null) {
//       final file = File(pickedFile.path);
//
//       controller.selectedImageBase64.value =
//           base64.encode(file.readAsBytesSync());
//       controller.selectedImageFileName.value = file.path.split('/').last;
//       controller
//           .setSelectedImage(file.path); // This should update selectedImagePath
//     }
//   }
// }
import 'dart:convert';
import 'dart:async';
import 'package:digitalerp/screen/ui/home/attendance/attendance_controller.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_apply_view/leave_apply_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class AttendanceView extends StatefulWidget {
  AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView>
    with TickerProviderStateMixin {
  late Timer _clockTimer;
  String _timeString = '';
  String _dateString = '';
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  static const Color _navy = Color(0xFF0A1628);
  static const Color _gold = Color(0xFFD4A843);
  static const Color _goldLight = Color(0xFFEDC96A);
  static const Color _slate = Color(0xFF1E3A5F);
  static const Color _cardBg = Color(0xFFF7F9FC);
  static const Color _present = Color(0xFF22C55E);
  static const Color _absent = Color(0xFFEF4444);
  static const Color _neutral = Color(0xFF64748B);
  static const Color _surface = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    _updateTime();
    _clockTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _slideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _fadeController.forward();
    _slideController.forward();
  }

  void _updateTime() {
    final now = DateTime.now();
    final h = now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    final ampm = h >= 12 ? 'PM' : 'AM';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
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
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    if (mounted) {
      setState(() {
        _timeString = '$hour12:$m:$s $ampm';
        _dateString =
            '${days[now.weekday % 7]}, ${now.day} ${months[now.month - 1]} ${now.year}';
      });
    }
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // 
  //  CAMERA PERMISSION FIX
  // 
  Future<void> _getImage(
      ImageSource source, AttendanceController controller) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedFile = await controller.picker.pickImage(
        source: source,
        imageQuality: 65,
      );
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        controller.selectedImageBase64.value =
            base64.encode(file.readAsBytesSync());
        controller.selectedImageFileName.value = file.path.split('/').last;
        controller.setSelectedImage(file.path);
      }
    } else if (status.isPermanentlyDenied) {
      Get.snackbar(
        'Camera Permission Required',
        'Please enable camera access in app settings to mark attendance.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: _navy,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        mainButton: TextButton(
          onPressed: () => openAppSettings(),
          child: const Text('OPEN SETTINGS',
              style: TextStyle(color: _goldLight, fontWeight: FontWeight.w700)),
        ),
      );
    } else {
      Get.snackbar(
        'Camera Access Denied',
        'Camera permission is needed to capture your attendance photo.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: _absent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;
    return GetBuilder<AttendanceController>(
      init: AttendanceController(),
      builder: (controller) => Scaffold(
        backgroundColor: _cardBg,
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: Column(
              children: [
                _buildHeader(controller),
                Expanded(
                  child: controller.isBusy
                      ? _buildLoader()
                      : controller.attendanceSummaryData?.isNotEmpty ?? true
                          ? _buildBody(controller, bottomInset)
                          : _buildEmpty(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AttendanceController controller) {
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.openDrawer(context),
                    child: Container(
                      width: 38, height: 38,
                      // decoration: BoxDecoration(
                      //   color: Colors.white.withValues(alpha:0.08),
                      //   borderRadius: BorderRadius.circular(10),
                      //   border: Border.all(color: Colors.white.withValues(alpha:0.12)),
                      // ),
                      child: const Icon(Icons.menu_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Attendance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3)),
                      Text('Track your presence',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _navy.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _gold.withValues(alpha: 0.4)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              color: _gold, shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      Text(
                        controller.attendanceSummaryData?[0].month
                                ?.split(' ')
                                .first ??
                            'Live',
                        style: const TextStyle(
                            color: _goldLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_timeString,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.5)),
                          const SizedBox(height: 3),
                          Text(_dateString,
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _miniPill(
                            '${controller.attendanceSummaryData?[0].present ?? 0}',
                            'Present',
                            _present),
                        const SizedBox(height: 6),
                        _miniPill(
                            '${controller.attendanceSummaryData?[0].absent ?? 0}',
                            'Absent',
                            _absent),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniPill(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _navy.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 10,
                fontWeight: FontWeight.w500)),
      ]),
    );
  }

  Widget _buildBody(AttendanceController controller, double bottomInset) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 80 + bottomInset),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _markAttendanceCard(controller),
          const SizedBox(height: 20),
          _sectionTitle('Leave Overview'),
          const SizedBox(height: 12),
          _leaveOverviewRow(controller),
          const SizedBox(height: 20),
          if (controller.attendanceSummaryData?[0].details?.isNotEmpty ??
              false) ...[
            _sectionTitle('Recent Records'),
            const SizedBox(height: 12),
            ...List.generate(
              (controller.attendanceSummaryData![0].details!.length > 2)
                  ? 2
                  : controller.attendanceSummaryData![0].details!.length,
              (i) => _attendanceCard(controller, i),
            ),
            if ((controller.attendanceSummaryData![0].details?.length ?? 0) > 2)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => controller.tapOnSeeMore(),
                  icon: const Icon(Icons.arrow_forward_rounded,
                      size: 14, color: _navy),
                  label: const Text('View All',
                      style: TextStyle(
                          color: _navy,
                          fontSize: 13,
                          fontWeight: FontWeight.w600)),
                ),
              ),
          ],
          const SizedBox(height: 16),
          _applyLeaveButton(controller),
        ],
      ),
    );
  }

  Widget _markAttendanceCard(AttendanceController controller) {
    final summary = controller.attendanceSummaryData;
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: _navy.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [purpleColor, _slate],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                const Text('Monthly Summary',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.3)),
                const Spacer(),
                Text(controller.attendanceSummaryData?[0].month ?? '',
                    style: const TextStyle(
                        color: _goldLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              children: [
                _statBlock(
                  'Present',
                  NumberFormatter.format(summary != null && summary.isNotEmpty
                      ? summary[0].present
                      : 0),
                  _present,
                ),
                _vertDivider(),
                _statBlock(
                  'Absent',
                  NumberFormatter.format(summary != null && summary.isNotEmpty
                      ? summary[0].absent
                      : 0),
                  _absent,
                ),
                _vertDivider(),
                _statBlock(
                  'CL',
                  NumberFormatter.format(summary != null && summary.isNotEmpty
                      ? summary[0].totalcl
                      : 0),
                  Colors.purple,
                ),
                _vertDivider(),
                _statBlock(
                  'EL',
                  NumberFormatter.format(
                    summary != null && summary.isNotEmpty
                        ? summary[0].totalel
                        : 0,
                  ),
                  const Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: controller.isBtnShow
                ? GestureDetector(
                    onTap: () async {
                      await _getImage(ImageSource.camera, controller);
                      // Only proceed if image was captured
                      if (controller.selectedImageBase64.value.isNotEmpty) {
                        controller.tapOnMarkAttendance();
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: controller.enableBtn
                            ? const LinearGradient(
                                colors: [purpleColor, _slate],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)
                            : LinearGradient(colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade400
                              ]),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: controller.enableBtn
                            ? [
                                BoxShadow(
                                    color: _navy.withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 5))
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.isAttendanceMarked
                                ? Icons.logout_rounded
                                : Icons.fingerprint_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            controller.isAttendanceMarked
                                ? 'Day Close'
                                : 'Mark Attendance',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                letterSpacing: 0.4),
                          ),
                        ],
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: _navy, strokeWidth: 2)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _statBlock(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _neutral, fontSize: 10, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _vertDivider() =>
      Container(height: 36, width: 1, color: Colors.grey.shade200);

  Widget _leaveOverviewRow(AttendanceController controller) {
    final item = controller.attendanceSummaryData?[0];
    final leaves = [
      _LeaveData(
        'Total Leave',
        NumberFormatter.format(item?.totalLeave),
        const Color(0xFF3B82F6),
        Icons.event_note_rounded,
      ),
      _LeaveData(
        'Remaining',
        NumberFormatter.format(item?.remainingTotalLeave),
        const Color(0xFF8B5CF6),
        Icons.hourglass_top_rounded,
      ),
      _LeaveData(
        'Approved',
        NumberFormatter.format(item?.approveLeave),
        _present,
        Icons.check_circle_rounded,
      ),
      _LeaveData(
        'Rejected',
        NumberFormatter.format(item?.rejectLeave),
        _absent,
        Icons.cancel_rounded,
      ),
    ];
    return Row(
      children: leaves.asMap().entries.map((e) {
        final d = e.value;
        final idx = e.key;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (idx == 2) controller.tapOnApprovedLeave();
              if (idx == 3) controller.tapOnRejectedLeave();
            },
            child: Container(
              margin: EdgeInsets.only(right: idx < 3 ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: d.color.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                      color: d.color.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: d.color.withValues(alpha: 0.12),
                        shape: BoxShape.circle),
                    child: Icon(d.icon, color: d.color, size: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(d.value,
                      style: TextStyle(
                          color: d.color,
                          fontSize: 18,
                          fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(d.label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: _neutral,
                          fontSize: 9,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _attendanceCard(AttendanceController controller, int index) {
    final item = controller.attendanceSummaryData![0].details![index];
    final bool inProgress = item.outTime == null || item.outTime!.isEmpty;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 90,
            decoration: BoxDecoration(
              color: inProgress ? const Color(0xFFF59E0B) : _present,
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppNetworkImage(height: 66, width: 66, image: item.photo),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.date ?? '',
                      style: const TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w700,
                          fontSize: 13)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _timeChip('IN', item.inTime ?? 'N/A', _present),
                      const SizedBox(width: 8),
                      _timeChip(
                          'OUT',
                          item.outTime?.isNotEmpty == true
                              ? item.outTime!
                              : 'N/A',
                          inProgress ? const Color(0xFFF59E0B) : _absent),
                    ],
                  ),
                  if (inProgress) ...[
                    const SizedBox(height: 5),
                    const Text('In Progress...',
                        style: TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _batteryWidget(
                int.tryParse(item.batterylevel?.toString() ?? '0') ?? 0),
          ),
        ],
      ),
    );
  }

  Widget _timeChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('$label ',
            style: TextStyle(
                color: color, fontSize: 9, fontWeight: FontWeight.w700)),
        Text(value,
            style: TextStyle(
                color: color, fontSize: 10, fontWeight: FontWeight.w600)),
      ]),
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
                borderRadius: BorderRadius.circular(3)),
            child: Stack(children: [
              FractionallySizedBox(
                widthFactor: level.clamp(0, 100) / 100,
                child: Container(
                    decoration: BoxDecoration(
                        color: color, borderRadius: BorderRadius.circular(2))),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 3),
        Text('$level%',
            style: TextStyle(
                color: color, fontSize: 9, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _applyLeaveButton(AttendanceController controller) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Get.put(LeaveApplyController());
          controller.tapOnApplyLeave();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: _navy.withValues(alpha: 0.25)),
            borderRadius: BorderRadius.circular(14),
            color: _navy.withValues(alpha: 0.04),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.edit_calendar_rounded, color: _navy, size: 18),
              SizedBox(width: 8),
              Text('Apply for Leave',
                  style: TextStyle(
                      color: _navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
                color: _gold, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                color: _navy,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.2)),
      ],
    );
  }

  Widget _buildLoader() => const Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CircularProgressIndicator(color: _navy, strokeWidth: 2),
          SizedBox(height: 12),
          Text('Loading attendance...',
              style: TextStyle(color: _neutral, fontSize: 13)),
        ]),
      );

  Widget _buildEmpty() => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.event_busy_rounded,
              size: 48, color: _neutral.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          const Text('No attendance data found',
              style: TextStyle(color: _neutral, fontSize: 14)),
        ]),
      );
}

class _LeaveData {
  final String label, value;
  final Color color;
  final IconData icon;
  const _LeaveData(this.label, this.value, this.color, this.icon);
}
