// import 'package:digitalerp/response/approved_or_rejected_leave_response.dart';
// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/leave_apply_view/leave_apply_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/custom_clipper.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class LeaveApplyView extends StatefulWidget {
//    LeaveApplyView({Key? key}) : super(key: key);
//
//
//   @override
//   State<LeaveApplyView> createState() => _LeaveApplyViewState();
// }
//
// class _LeaveApplyViewState extends State<LeaveApplyView> {
//   LeaveData? selectedLeave;
//    bool? isEdit;
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     selectedLeave = Get.arguments as LeaveData?;
//     print("SelectData => ${selectedLeave?.toJson()}");
//
//     final controller = Get.find<LeaveApplyController>();
//     // controller.getExecutiveDropdownList(
//     //   selectedForwardName: selectedLeave?.forwardperson,
//     // );
//
//     controller.fromDate = selectedLeave?.date!.split(' ').first?? AppString.dateTimeEmpty;
//     controller.toDate =  selectedLeave?.date!.split(' ').last ?? AppString.dateTimeEmpty;
//
//     controller.reasonController.text = selectedLeave?.reason.toString() ?? "";
//     controller.responsibleController.text = selectedLeave?.forwardperson.toString() ?? "";
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LeaveApplyController>(
//       init: LeaveApplyController(),
//       builder: (controller) => Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 bottom: 0,
//                 right: 0,
//                 left: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                   child: SafeArea(
//                     child: MyAppBar(title: 'Apply Leave', onBackTap: () => controller.backTap()),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.only(
//                       bottom: (MediaQuery.of(context).viewInsets.bottom > 0) ? 200 : 0, left: 20, right: 20),
//                   child: Column(
//                     children: [
//                       SizedBox(height: Get.height * 0.02),
//                       topContainerBox(controller),
//                       const SizedBox(height: 20),
//                       _applyBox(controller, context),
//                       const SizedBox(height: 30),
//                       // if(selectedLeave?.reason?.isNotEmpty==true)
//                       // _leaveHistoryBtn(controller),
//                       const SizedBox(height: 20),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget topContainerBox(LeaveApplyController controller) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: const LinearGradient(
//               colors: [blueColor, purpleColor],
//               stops: [0.01, 1],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter),
//           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))]),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10, bottom: 10),
//             child: Text(
//               'Leave status',
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
//               child:
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 15),
//
//                   // Row 1: Total Leaves | DottedLine | Remaining Leaves
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                        width: 80 ,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Total leaves',
//                               style: const TextStyle().bold.copyWith(
//                                 color: purpleColor,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               controller.attendanceController.attendanceSummaryData?[0].totalLeave?.toString() ?? 'N/A',
//                               style: const TextStyle().bold.copyWith(
//                                 color: Colors.black,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 25),
//                       DottedLine(
//                         // c: Axis.vertical,
//                         color: medGreyColor,
//                         height: 40,
//                         strokeWidth: 1.2,
//                         dottedLength: 4.0,
//                         space: 3.0,
//                       ),
//                       const SizedBox(width: 25),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Remaining leaves',
//                             style: const TextStyle().bold.copyWith(
//                               color: purpleColor,
//                               fontSize: 12,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             controller.attendanceController.attendanceSummaryData?[0].remainingTotalLeave?.toString() ?? 'N/A',
//                             style: const TextStyle().bold.copyWith(
//                               color: Colors.black,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 25),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Total EL',
//                             style: const TextStyle().bold.copyWith(
//                               color: purpleColor,
//                               fontSize: 12,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             controller.attendanceController.attendanceSummaryData?[0].totalel?.toString() ?? 'N/A',
//                             style: const TextStyle().bold.copyWith(
//                               color: Colors.black,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 35),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 50,left: 10),
//                         child: DottedLine(
//                           // direction: Axis.vertical,
//                           color: medGreyColor,
//                           height: 40,
//                           strokeWidth: 1.2,
//                           dottedLength: 4.0,
//                           space: 3.0,
//                         ),
//                       ),
//                       // const SizedBox(width: 25),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Total CL',
//                             style: const TextStyle().bold.copyWith(
//                               color: purpleColor,
//                               fontSize: 12,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             controller.attendanceController.attendanceSummaryData?[0].totalcl?.toString() ?? 'N/A',
//                             style: const TextStyle().bold.copyWith(
//                               color: Colors.black,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//                 ],
//               )
//
//
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _applyBox(LeaveApplyController controller, BuildContext context) {
//     return Container(
//       width: Get.width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//           boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))]),
//       padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//       child: Column(
//         children: [
//           Text(
//             'Select day',
//             style: const TextStyle().normal.copyWith(fontSize: 12, color: red2Color),
//           ),
//           _tabButton(controller),
//           _dateBox(controller, context),
//           TextFormField(
//             style: const TextStyle().normal.copyWith(
//                   color: darkGreenColor,
//                   fontSize: 16,
//                 ),
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.done,
//             controller: controller.reasonController,
//             focusNode: controller.reasonFocus,
//             maxLines: 6,
//             minLines: 3,
//             decoration: const InputDecoration().txtFieldStyle2(
//               hintText: 'Type...',
//               labelName: 'Leave Reason',
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextFormField(
//             style: const TextStyle().normal.copyWith(
//               color: darkGreenColor,
//               fontSize: 16,
//             ),
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.done,
//             controller: controller.responsibleController,
//             focusNode: controller.responsibleFocus,
//
//             decoration: const InputDecoration().txtFieldStyle2(
//               hintText: 'Type...',
//               labelName: 'Responsible Person(Replacement)',
//             ),
//           ),
//           // _forwardToDropDown(controller),
//           const SizedBox(height: 30),
//
//
//
//           Container(
//             height: 38,
//             decoration: const ShapeDecoration(shape: StadiumBorder(), gradient: gr2),
//             child: MaterialButton(
//               onPressed: () => controller.tapOnApply(),
//               padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//               shape: const StadiumBorder(),
//               child: Text(
//                 'Apply',
//                 style: const TextStyle().bold.copyWith(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _tabButton(LeaveApplyController controller) => Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(45),
//           color: leaveBoxColor,
//         ),
//         margin: const EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 35,
//                 decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: controller.selectedSegmentVal == 0
//                             ? [orangeColor, red2Color]
//                             : [Colors.transparent, Colors.transparent])),
//                 child: MaterialButton(
//                   onPressed: () => controller.setSegmentValue(0),
//                   shape: const StadiumBorder(),
//                   child: Text(
//                     '1 Day',
//                     style: const TextStyle().bold.copyWith(
//                         fontSize: 12, color: controller.selectedSegmentVal == 0 ? Colors.white : Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: 35,
//                 decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: controller.selectedSegmentVal == 1
//                             ? [orangeColor, red2Color]
//                             : [Colors.transparent, Colors.transparent])),
//                 child: MaterialButton(
//                   onPressed: () => controller.setSegmentValue(1),
//                   shape: const StadiumBorder(),
//                   child: Text(
//                     'More Days',
//                     style: const TextStyle().bold.copyWith(
//                         fontSize: 12, color: controller.selectedSegmentVal == 1 ? Colors.white : Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//
//   Widget _dateBox(LeaveApplyController controller, BuildContext context) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 15),
//           Text(
//             'Date',
//             style: const TextStyle().bold.copyWith(
//                   fontSize: 10,
//                   color: red2Color,
//                 ),
//           ),
//           const SizedBox(height: 5),
//           Row(
//             mainAxisAlignment:
//                 controller.selectedSegmentVal == 0 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
//             children: [
//               _dateView(controller.fromDate,
//                   controller.selectedSegmentVal == 0 ? Get.width * .775 : Get.width * .37,
//                   true, controller, context),
//               if (controller.selectedSegmentVal == 1)
//                 _dateView(controller.toDate, Get.width * .37, false, controller, context),
//             ],
//           ),
//           const SizedBox(height: 15)
//         ],
//       );
//
//   Widget _dateView(String value, double width, bool isFirst, LeaveApplyController controller, BuildContext context) =>
//       SizedBox(
//         width: width,
//         child: InkWell(
//           onTap: () async {
//             DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: controller.fromDate == AppString.dateTimeEmpty
//                     ? DateTime.now()
//                     : DateFormat(AppString.ddMMyyyy).parse(controller.fromDate).add(const Duration(days: 1)),
//                 firstDate: isFirst
//                     ? DateTime.now()
//                     : DateFormat(AppString.ddMMyyyy).parse(controller.fromDate).add(const Duration(days: 1)),
//                 lastDate: DateTime((DateTime.now().year + 1), 3, 31));
//
//             if (pickedDate != null) {
//               String formattedDate = DateFormat(AppString.ddMMyyyy).format(pickedDate);
//               if (isFirst) {
//                 controller.setDate(formattedDate, true);
//               } else {
//                 controller.setDate(formattedDate, false);
//               }
//             } else {
//               if (kDebugMode) {
//                 print('Date is not selected');
//               }
//             }
//           },
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(value, style: const TextStyle().normal),
//                   const SizedBox(width: 10),
//                   Image.asset(
//                     AppAssets.calendarIcon,
//                     width: 18,
//                     height: 18,
//                   )
//                 ],
//               ),
//               const SizedBox(height: 5),
//               const Divider(
//                 color: purpleColor,
//                 height: 2,
//               ),
//             ],
//           ),
//         ),
//       );
//
//   Widget _leaveHistoryBtn(LeaveApplyController controller) {
//     return TextButton(
//       onPressed: () {
//         controller.tapOnLeaveHistory();
//       },
//       child: Text(
//         'Leave history',
//         style: const TextStyle().bold.copyWith(fontSize: 14, color: purpleColor, decoration: TextDecoration.underline),
//       ),
//     );
//   }
//
//   // Widget _forwardToDropDown(LeaveApplyController controller) {
//   //   return GetBuilder<LeaveApplyController>(
//   //     builder: (_) {
//   //       return DropdownButtonHideUnderline(
//   //         child: DropdownButton2(
//   //           buttonHeight: Get.height * 0.0550,
//   //           buttonWidth: Get.width * 0.900,
//   //           buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
//   //           dropdownDecoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(15),
//   //             color: dropdownBoxColor,
//   //           ),
//   //           dropdownMaxHeight: 200,
//   //           buttonDecoration: BoxDecoration(
//   //             borderRadius: BorderRadius.circular(10),
//   //             color: dropdownBoxColor,
//   //             gradient: LinearGradient(
//   //               colors: [
//   //                 grBottomColor.withValues(alpha:0.2),
//   //                 grTopColor.withValues(alpha:0.2)
//   //               ],
//   //               begin: Alignment.topCenter,
//   //               end: Alignment.bottomCenter,
//   //             ),
//   //           ),
//   //           isExpanded: true,
//   //           hint: Text(
//   //             "Responsible Person To",
//   //             style: const TextStyle().normal,
//   //           ),
//   //           icon: Image.asset(
//   //             AppAssets.dropdownIcon,
//   //             width: 15,
//   //             height: 15,
//   //           ),
//   //           value: controller.selectedDropdownValue?.executiveId,
//   //           items: controller.executiveList?.map((items) {
//   //             return DropdownMenuItem(
//   //               value: items.executiveId,
//   //               child: Text(
//   //                 items.executiveName ?? '',
//   //                 style: const TextStyle().normal.copyWith(
//   //                   color: Colors.black,
//   //                   fontSize: 13,
//   //                 ),
//   //               ),
//   //             );
//   //           }).toList(),
//   //           onChanged: (newValue) {
//   //             final selected = controller.executiveList?.firstWhere(
//   //                   (e) => e.executiveId == newValue,
//   //             );
//   //             if (selected != null) {
//   //               controller.setSelectDropdownValue(selected);
//   //             }
//   //           },
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
//
// }

import 'package:digitalerp/screen/ui/home/attendance/leave_apply_view/leave_apply_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:digitalerp/response/approved_or_rejected_leave_response.dart';

class LeaveApplyView extends StatefulWidget {
  LeaveApplyView({Key? key}) : super(key: key);

  @override
  State<LeaveApplyView> createState() => _LeaveApplyViewState();
}

class _LeaveApplyViewState extends State<LeaveApplyView>
    with SingleTickerProviderStateMixin {
  LeaveData? selectedLeave;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  //  Tokens 
  static const Color _navy = Color(0xFF0A1628);
  static const Color _gold = Color(0xFFD4A843);
  static const Color _goldL = Color(0xFFEDC96A);
  static const Color _slate = Color(0xFF1E3A5F);
  static const Color _bg = Color(0xFFF7F9FC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _neutral = Color(0xFF64748B);
  static const Color _present = Color(0xFF22C55E);
  static const Color _border = Color(0xFFE2E8F0);

  @override
  void initState() {
    super.initState();
    selectedLeave = Get.arguments as LeaveData?;
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();

    final controller = Get.find<LeaveApplyController>();
    controller.fromDate =
        selectedLeave?.date?.split(' ').first ?? AppString.dateTimeEmpty;
    controller.toDate =
        selectedLeave?.date?.split(' ').last ?? AppString.dateTimeEmpty;
    controller.reasonController.text = selectedLeave?.reason?.toString() ?? '';
    controller.responsibleController.text =
        selectedLeave?.forwardperson?.toString() ?? '';
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveApplyController>(
      init: LeaveApplyController(),
      builder: (controller) => Scaffold(
        backgroundColor: _bg,
        body: FadeTransition(
          opacity: _fadeAnim,
          child: Column(
            children: [
              _buildHeader(controller),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    MediaQuery.of(context).viewInsets.bottom + 24,
                  ),
                  child: Column(
                    children: [
                      _leaveStatusCard(controller),
                      const SizedBox(height: 16),
                      _applyFormCard(controller, context),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  HEADER 
  Widget _buildHeader(LeaveApplyController controller) {
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
          child: Row(
            children: [
              GestureDetector(
                onTap: () => controller.backTap(),
                child: Container(
                  width: 38,
                  height: 38,
                  // decoration: BoxDecoration(
                  //   color: Colors.white.withValues(alpha: 0.08),
                  //   borderRadius: BorderRadius.circular(10),
                  //   border:
                  //       Border.all(color: Colors.white.withValues(alpha: 0.12)),
                  // ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedLeave != null ? 'Edit Leave' : 'Apply Leave',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3),
                  ),
                  Text('Submit your leave request',
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
                  color: _gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _gold.withValues(alpha: 0.4)),
                ),
                child: const Text('HR Portal',
                    style: TextStyle(
                        color: _goldL,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  LEAVE STATUS CARD 
  Widget _leaveStatusCard(LeaveApplyController controller) {
    final data = controller.attendanceController.attendanceSummaryData?[0];
    final stats = [
      _Stat('Total Leaves',NumberFormatter.format(data?.totalLeave)?? '—',
          newRedColor),
      _Stat('Remaining', NumberFormatter.format(data?.remainingTotalLeave) ?? '—',
          purpleColor),
      _Stat('Total EL', NumberFormatter.format(data?.totalel) ?? '—',
          newOrangeColor),
      _Stat('Total CL', NumberFormatter.format(data?.totalcl) ?? '—', _present),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: _navy.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          // Header strip
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
                const Icon(Icons.event_note_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: 8),
                const Text('Leave Balance',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                const Spacer(),
                const Text('Current Period',
                    style: TextStyle(color: _goldL, fontSize: 11)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: stats.asMap().entries.map((e) {
                final s = e.value;
                final i = e.key;
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: i < 3 ? 8 : 0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                      color: s.color.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: s.color.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(s.value,
                            style: TextStyle(
                                color: s.color,
                                fontSize: 20,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 3),
                        Text(s.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: _neutral,
                                fontSize: 9,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  //  APPLY FORM 
  Widget _applyFormCard(LeaveApplyController controller, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: _navy.withValues(alpha: 0.07),
              blurRadius: 20,
              offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              border: const Border(bottom: BorderSide(color: _border)),
            ),
            child: const Text('Leave Request Form',
                style: TextStyle(
                    color: _navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.2)),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day selector
                _label('Leave Duration'),
                const SizedBox(height: 8),
                _dayToggle(controller),
                const SizedBox(height: 16),

                // Date picker
                _label('Select Date'),
                const SizedBox(height: 8),
                _dateRow(controller, context),
                const SizedBox(height: 16),

                // Reason
                _label('Leave Reason'),
                const SizedBox(height: 8),
                _styledTextField(
                  controller: controller.reasonController,
                  focusNode: controller.reasonFocus,
                  hint: 'Describe the reason for leave...',
                  maxLines: 4,
                  minLines: 3,
                  action: TextInputAction.newline,
                ),
                const SizedBox(height: 16),

                // Responsible person
                _label('Responsible Person (Replacement)'),
                const SizedBox(height: 8),
                _styledTextField(
                  controller: controller.responsibleController,
                  focusNode: controller.responsibleFocus,
                  hint: 'Enter name of replacement person',
                  maxLines: 1,
                  minLines: 1,
                  action: TextInputAction.done,
                ),
                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => controller.tapOnApply(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [purpleColor, _slate],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
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
                          Icon(Icons.send_rounded,
                              color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text('Submit Request',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  letterSpacing: 0.4)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(text,
      style: const TextStyle(
          color: _navy,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.2));

  Widget _dayToggle(LeaveApplyController controller) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          _toggleBtn(controller, 0, '1 Day', Icons.calendar_today_rounded),
          _toggleBtn(controller, 1, 'Multiple Days', Icons.date_range_rounded),
        ],
      ),
    );
  }

  Widget _toggleBtn(
      LeaveApplyController controller, int val, String label, IconData icon) {
    final selected = controller.selectedSegmentVal == val;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setSegmentValue(val),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [purpleColor, _slate],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                : null,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected ? Colors.white : _neutral, size: 14),
              const SizedBox(width: 5),
              Text(label,
                  style: TextStyle(
                      color: selected ? Colors.white : _neutral,
                      fontSize: 12,
                      fontWeight:
                          selected ? FontWeight.w700 : FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateRow(LeaveApplyController controller, BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _datePicker(controller.fromDate, true, controller, context)),
        if (controller.selectedSegmentVal == 1) ...[
          const SizedBox(width: 10),
          Expanded(
              child:
                  _datePicker(controller.toDate, false, controller, context)),
        ],
      ],
    );
  }

  Widget _datePicker(String value, bool isFirst,
      LeaveApplyController controller, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: controller.fromDate == AppString.dateTimeEmpty
              ? DateTime.now()
              : DateFormat(AppString.ddMMyyyy)
                  .parse(controller.fromDate)
                  .add(Duration(days: isFirst ? 0 : 1)),
          firstDate: isFirst
              ? DateTime.now()
              : DateFormat(AppString.ddMMyyyy)
                  .parse(controller.fromDate)
                  .add(const Duration(days: 1)),
          lastDate: DateTime((DateTime.now().year + 1), 3, 31),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded, size: 16, color: _navy),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value.isEmpty || value == AppString.dateTimeEmpty
                    ? (isFirst ? 'From Date' : 'To Date')
                    : value,
                style: TextStyle(
                    color: value.isEmpty || value == AppString.dateTimeEmpty
                        ? _neutral
                        : _navy,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _styledTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required int maxLines,
    required int minLines,
    required TextInputAction action,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      minLines: minLines,
      textInputAction: action,
      style: const TextStyle(
          color: _navy, fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: _neutral, fontSize: 13),
        filled: true,
        fillColor: _bg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _navy, width: 1.5),
        ),
      ),
    );
  }
}

class _Stat {
  final String label;
  final String value;
  final Color color;
  const _Stat(this.label, this.value, this.color);
}
