// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ExecutiveApprovedOrRejectedLeaveView extends StatelessWidget {
//   const ExecutiveApprovedOrRejectedLeaveView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ExecutiveApproveOrRejectedLeavesController>(
//       init: ExecutiveApproveOrRejectedLeavesController(ModalRoute.of(context)!.settings.arguments as bool),
//       builder: (controller) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
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
//                         image: DecorationImage(
//                             image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                     child: SafeArea(
//                       child: MyAppBar(
//                           title:
//                               controller.getIsApprovedLeave ? 'Approved Leave' : 'Rejected Leave',
//                           onBackTap: () => controller.backTap()),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.135,
//                   child: controller.isBusy
//                       ? showLoader()
//                       : controller.leaveList.isEmpty
//                           ? centerText('No Data found')
//                           : SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   ListView.builder(
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.zero,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemCount:
//                                         controller.leaveList.length,
//                                     itemBuilder: (context, index) {
//                                       return card(controller, index);
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget card(ExecutiveApproveOrRejectedLeavesController controller, int index) {
//     var item = controller.leaveList[index];
//     return Container(
//       decoration:
//           BoxDecoration(borderRadius: BorderRadius.circular(15), color: progressAttendanceColor),
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                   bottomRight: Radius.circular(25),
//                   bottomLeft: Radius.circular(25),
//                 ),
//                 color: Colors.white),
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   item.title ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//                 Text(
//                   item.time ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 15),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.title == '1 Days Leave' ? item.date!.split(' ').first : item.date ?? 'N/A',
//               style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.black),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Leave Reason',
//                   style: const TextStyle().bold.copyWith(fontSize: 12, color: purpleColor),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   item.reason ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(15),
//                   bottomLeft: Radius.circular(15),
//                 ),
//                 color: controller.getIsApprovedLeave ? green3Color : redColor),
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//             alignment: Alignment.center,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                     controller.getIsApprovedLeave ? AppAssets.approvedCheckIcon : AppAssets.closeIcon,
//                     height: 11),
//                 Text(
//                   controller.getIsApprovedLeave ? ' Approved' : ' Rejected',
//                   style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//  Design tokens 
const Color _kBg = Color(0xFFF5F6FA);
const Color _kCard = Colors.white;
const Color _kBlue = Color(0xFF4169E1);
const Color _kGreen = Color(0xFF2E7D32);
const Color _kGreenBg = Color(0xFFE8F5E9);
const Color _kRed = Color(0xFFC62828);
const Color _kRedBg = Color(0xFFFFEBEE);
const Color _kText = Color(0xFF1A1A2E);
const Color _kSub = Color(0xFF888888);
const Color _kBorder = Color(0xFFE8E8E8);

class ExecutiveApprovedOrRejectedLeaveView extends StatelessWidget {
  const ExecutiveApprovedOrRejectedLeaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExecutiveApproveOrRejectedLeavesController>(
      init: ExecutiveApproveOrRejectedLeavesController(
          ModalRoute.of(context)!.settings.arguments as bool),
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
                      icon:
                          const Icon(Icons.arrow_back_ios_new, color: _kText, size: 22),
                    ),
                    Expanded(
                      child: Text(
                        controller.getIsApprovedLeave
                            ? 'Approved Leave'
                            : 'Rejected Leave',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _kText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //  Body 
              Expanded(
                child: controller.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: _kBlue))
                    : controller.leaveList.isEmpty
                        ? Center(
                            child: Text('No Data found',
                                style: GoogleFonts.dmSans(color: _kSub)))
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                            itemCount: controller.leaveList.length,
                            itemBuilder: (context, index) =>
                                _leaveCard(controller, index),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _leaveCard(
      ExecutiveApproveOrRejectedLeavesController controller, int index) {
    final item = controller.leaveList[index];
    final bool isApproved = controller.getIsApprovedLeave;

    final Color statusBg = isApproved ? _kGreenBg : _kRedBg;
    final Color statusFg = isApproved ? _kGreen : _kRed;
    final String statusLabel = isApproved ? 'Approved' : 'Rejected';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Header 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _kBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title ?? 'N/A',
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _kText,
                    ),
                  ),
                ),
                Text(
                  item.time ?? '',
                  style: GoogleFonts.dmSans(fontSize: 12, color: _kSub),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: _kBorder),

          //  Date 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 14, color: _kBlue),
                const SizedBox(width: 6),
                Text(
                  item.title == '1 Days Leave'
                      ? (item.date?.split(' ').first ?? 'N/A')
                      : item.date ?? 'N/A',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _kText,
                  ),
                ),
              ],
            ),
          ),

          //  Reason 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Reason',
                    style: GoogleFonts.dmSans(fontSize: 11, color: _kSub)),
                const SizedBox(height: 4),
                Text(
                  item.reason ?? 'N/A',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _kText,
                  ),
                ),
              ],
            ),
          ),

          //  Status footer 
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              statusLabel,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: statusFg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
