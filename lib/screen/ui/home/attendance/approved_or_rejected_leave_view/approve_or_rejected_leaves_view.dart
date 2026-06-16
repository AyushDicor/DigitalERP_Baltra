// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ApprovedOrRejectedLeaveView extends StatelessWidget {
//   const ApprovedOrRejectedLeaveView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ApproveOrRejectedLeavesController>(
//       init: ApproveOrRejectedLeavesController(ModalRoute.of(context)!.settings.arguments as bool),
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
//   Widget card(ApproveOrRejectedLeavesController controller, int index) {
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




import 'package:digitalerp/screen/ui/home/attendance/approved_or_rejected_leave_view/approve_or_rejected_leaves_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovedOrRejectedLeaveView extends StatelessWidget {
  const ApprovedOrRejectedLeaveView({Key? key}) : super(key: key);

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
    return GetBuilder<ApproveOrRejectedLeavesController>(
      init: ApproveOrRejectedLeavesController(
          ModalRoute.of(context)!.settings.arguments as bool),
      builder: (controller) {
        final isApproved = controller.getIsApprovedLeave;
        final accentColor = isApproved ? _present : _absent;

        return Scaffold(
          backgroundColor: _bg,
          body: Column(
            children: [
              _buildHeader(controller, isApproved, accentColor),
              Expanded(
                child: controller.isBusy
                    ? _buildLoader()
                    : controller.leaveList.isEmpty
                    ? _buildEmpty(isApproved)
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  itemCount: controller.leaveList.length,
                  itemBuilder: (_, i) =>
                      card(controller, i, isApproved, accentColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(ApproveOrRejectedLeavesController controller,
      bool isApproved, Color accentColor) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [_navy, _navyMid],
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
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.white.withValues(alpha:0.12)),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white, size: 16),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isApproved ? 'Approved Leaves' : 'Rejected Leaves',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3),
                  ),
                  Text('Leave request outcomes',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha:0.5),
                          fontSize: 11)),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha:0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: accentColor.withValues(alpha:0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isApproved
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: accentColor,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isApproved ? 'Approved' : 'Rejected',
                      style: TextStyle(
                          color: accentColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
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

  Widget card(ApproveOrRejectedLeavesController controller, int index,
      bool isApproved, Color accentColor) {
    final item = controller.leaveList[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isApproved
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: accentColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title ?? 'Leave Request',
                          style: const TextStyle(
                              color: _navy,
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                      Text(item.time ?? '',
                          style: const TextStyle(
                              color: _neutral,
                              fontSize: 11)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: accentColor.withValues(alpha:0.3)),
                  ),
                  child: Text(
                    isApproved ? 'Approved' : 'Rejected',
                    style: TextStyle(
                        color: accentColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),

          // Date bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            color: accentColor.withValues(alpha:0.05),
            child: Row(
              children: [
                Icon(Icons.calendar_month_rounded,
                    size: 13, color: accentColor),
                const SizedBox(width: 5),
                Text(
                  item.title == '1 Days Leave'
                      ? (item.date?.split(' ').first ?? 'N/A')
                      : (item.date ?? 'N/A'),
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // Reason
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Leave Reason',
                    style: TextStyle(
                        color: _neutral,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3)),
                const SizedBox(height: 4),
                Text(item.reason ?? 'N/A',
                    style: const TextStyle(
                        color: _navy,
                        fontSize: 13,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          // Footer
          Container(
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha:0.06),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16)),
              border: const Border(top: BorderSide(color: _border)),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(
                  isApproved
                      ? Icons.check_circle_outline_rounded
                      : Icons.highlight_off_rounded,
                  color: accentColor,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  isApproved
                      ? 'Leave has been approved'
                      : 'Leave has been rejected',
                  style: TextStyle(
                      color: accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoader() => const Center(
      child: CircularProgressIndicator(color: _navy, strokeWidth: 2));

  Widget _buildEmpty(bool isApproved) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isApproved
              ? Icons.check_circle_outline_rounded
              : Icons.cancel_outlined,
          size: 48,
          color: _neutral.withValues(alpha:0.35),
        ),
        const SizedBox(height: 12),
        Text(
          isApproved
              ? 'No approved leaves found'
              : 'No rejected leaves found',
          style: const TextStyle(color: _neutral, fontSize: 14),
        ),
      ],
    ),
  );
}
