// import 'package:digitalerp/app_routes/app_routes.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/leave_history_filter/leave_history_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LeaveHistoryView extends StatelessWidget {
//   const LeaveHistoryView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LeaveHistoryController>(
//       init: LeaveHistoryController(),
//       builder: (controller) {
//         return Scaffold(
//           resizeToAvoidBottomInset: false,
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: purpleColor,
//             onPressed: () {
//               Get.toNamed(AppRoutes.leaveApply);
//             },
//             child: Icon(Icons.add),
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
//                         image: DecorationImage(
//                             image: AssetImage(AppAssets.dashboardBg),
//                             fit: BoxFit.fill)),
//                     child: SafeArea(
//                       child: MyAppBar(
//                           title: 'Leave history',
//                           onBackTap: () => controller.backTap(),
//                           onFilterTap: () {
//                             Get.dialog(
//                               ///new way
//                               const LeaveHistoryFilterView(),
//
//                               ///old way
//                               //  CustomDialogBox(type: leaveHistoryFilter),
//                             );
//                           }),
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
//                       : controller.leaveHistoryList.isEmpty
//                           ? centerText('No Data found')
//                           : SingleChildScrollView(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: Get.height * 0.02),
//                                   // if (controller.isManager) _executiveDropdown(controller),
//                                   ListView.builder(
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.zero,
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     itemCount:
//                                         controller.leaveHistoryList.length,
//                                     itemBuilder: (context, index) {
//                                       return leaveCard(
//                                           controller, index, context);
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
//   Widget leaveCard(
//       LeaveHistoryController controller, int index, BuildContext context) {
//     var item = controller.leaveHistoryList[index];
//     bool isApproved = item.status == 'approved';
//     bool isPending = item.status == 'Pending';
//
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: progressAttendanceColor,
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//                 bottomRight: Radius.circular(25),
//                 bottomLeft: Radius.circular(25),
//               ),
//               color: Colors.white,
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     item.title ?? 'N/A',
//                     style: const TextStyle().bold.copyWith(color: Colors.black),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Text(
//                   item.time ?? 'N/A',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 12, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.title == '1 Days Leave'
//                   ? item.date?.split(' ').first ?? 'N/A'
//                   : item.date ?? 'N/A',
//               style: const TextStyle()
//                   .bold
//                   .copyWith(fontSize: 18, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Leave Reason',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         item.reason ?? 'N/A',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(color: Colors.black),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Reject Reason',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(fontSize: 12, color: purpleColor),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         item.rejectreason?.isNotEmpty == true
//                             ? item.rejectreason!
//                             : 'N/A',
//                         style: const TextStyle()
//                             .bold
//                             .copyWith(color: Colors.black),
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Responsible Person',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 12, color: purpleColor),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   item.forwardperson?.isNotEmpty == true
//                       ? item.forwardperson!
//                       : 'N/A',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 bottomRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15),
//               ),
//               color: isPending
//                   ? purpleColor
//                   : isApproved
//                       ? green3Color
//                       : redColor,
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (!isPending)
//                   Image.asset(
//                     isApproved
//                         ? AppAssets.approvedCheckIcon
//                         : AppAssets.closeIcon,
//                     height: 14,
//                   ),
//                 const SizedBox(width: 8),
//                 Text(
//                   isPending
//                       ? 'Pending'
//                       : isApproved
//                           ? ' Approved'
//                           : ' Rejected',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 16, color: Colors.white),
//                 ),
//                 const SizedBox(width: 15),
//                 InkWell(
//                   onTap: () {
//                     Get.toNamed(
//                       AppRoutes.leaveApply,
//                       arguments: controller.leaveHistoryList[index],
//                     );
//                   },
//                   child: const Icon(Icons.edit, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget managerLeaveCard(LeaveHistoryController controller, int index) {
//     var item = controller.pendingLeaveList[index];
//     bool isApproved = item.status == 'approved';
//     bool isPending = item.status == 'Pending';
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: progressAttendanceColor),
//       margin: const EdgeInsets.symmetric(vertical: 10),
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
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 12, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 15),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.date ?? 'N/A',
//               style: const TextStyle()
//                   .bold
//                   .copyWith(fontSize: 18, color: Colors.black),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Leave Reason',
//                   style: const TextStyle()
//                       .bold
//                       .copyWith(fontSize: 12, color: purpleColor),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   item.reason ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           if (isPending)
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(15),
//                         ),
//                         color: green3Color),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       onTap: () => controller.leaveStatusUpdate(
//                           id: item.id.toString(), isApproved: true),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppAssets.approvedCheckIcon, height: 11),
//                           Text(
//                             ' Approve',
//                             style: const TextStyle()
//                                 .bold
//                                 .copyWith(fontSize: 18, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           bottomRight: Radius.circular(15),
//                         ),
//                         color: redColor),
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       onTap: () => controller.leaveStatusUpdate(
//                           id: item.id.toString(), isApproved: false),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppAssets.closeIcon, height: 11),
//                           Text(
//                             ' Reject',
//                             style: const TextStyle()
//                                 .bold
//                                 .copyWith(fontSize: 18, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           if (!isPending)
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15),
//                   ),
//                   color: isApproved ? green3Color : redColor),
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//               alignment: Alignment.center,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                       isApproved
//                           ? AppAssets.approvedCheckIcon
//                           : AppAssets.closeIcon,
//                       height: 11),
//                   Text(
//                     isApproved ? ' Approved' : ' Rejected',
//                     style: const TextStyle()
//                         .bold
//                         .copyWith(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }
//
// /*
//   Widget _executiveDropdown(LeaveHistoryController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<ExecutiveDropdownData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: dropdownBoxColor,
//         ),
//         dropdownElevation: 4,
//         buttonDecoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
//         isExpanded: true,
//         hint: Text(
//           'Select Item',
//           style: const TextStyle().normal,
//         ),
//         value: controller.selectedDropdownValue,
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.executiveList.map((items) {
//           return DropdownMenuItem(
//             value: items,
//             child: Text(items.executiveName.toString()),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setSelectDropdownValue(newValue!);
//         },
//       ),
//     );
//   }
// */
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/leave_history_filter/leave_history_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveHistoryView extends StatelessWidget {
  const LeaveHistoryView({Key? key}) : super(key: key);

  //  Tokens 
  static const Color _navy    = Color(0xFF0A1628);
  static const Color _bg      = Color(0xFFF7F9FC);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _neutral = Color(0xFF64748B);
  static const Color _present = newGreenColor;
  static const Color _absent  = newRedColor;
  static const Color _border  = Color(0xFFE2E8F0);
  static const Color _pending = Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveHistoryController>(
      init: LeaveHistoryController(),
      builder: (controller) => Scaffold(
        backgroundColor: _bg,
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          shape:
          const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
          elevation: 4,
          onPressed: () => Get.toNamed(AppRoutes.leaveApply),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: Column(
          children: [
            _buildHeader(controller),
            Expanded(
              child: controller.isBusy
                  ? _buildLoader()
                  : controller.leaveHistoryList.isEmpty
                  ? _buildEmpty()
                  : _buildList(controller, context),
            ),
          ],
        ),
      ),
    );
  }

  //  HEADER 
  Widget _buildHeader(LeaveHistoryController controller) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000), // soft shadow
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                      Icons.arrow_back_ios_new_rounded, size: 20),
                  color: Colors.black87,
                  onPressed: () => controller.backTap(),
                ),
                Expanded(
                  child: Text('Leave History',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1A1D2E),
                        letterSpacing: -0.3
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: purpleLight,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.filter_list_sharp,
                        size: 20),
                    color: purpleColor,
                    onPressed: () => Get.dialog(const LeaveHistoryFilterView()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   decoration: const BoxDecoration(
    //     color: whiteColor,
    //     boxShadow: [
    //       BoxShadow(
    //         color: Color(0x0F000000)  ,
    //         blurRadius: 12,
    //         offset: const Offset(0, 3),
    //       ),
    //     ],
    //   ),
    //   child: SafeArea(
    //     bottom: false,
    //     child: Padding(
    //       padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
    //       child: Row(
    //         children: [
    //           GestureDetector(
    //             onTap: () => controller.backTap(),
    //             child: Container(
    //               width: 38,
    //               height: 38,
    //               // decoration: BoxDecoration(
    //               //   color: Colors.white.withValues(alpha:0.08),
    //               //   borderRadius: BorderRadius.circular(10),
    //               //   border: Border.all(
    //               //       color: Colors.white.withValues(alpha:0.12)),
    //               // ),
    //               child: const Icon(Icons.arrow_back_ios_new_rounded,
    //                   color: blackColor, size: 16),
    //             ),
    //           ),
    //           const SizedBox(width: 14),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               const Text('Leave History',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 18,
    //                       fontWeight: FontWeight.w700,
    //                       letterSpacing: 0.3)),
    //               Text('All submitted requests',
    //                   style: TextStyle(
    //                       color: Colors.white.withValues(alpha:0.5),
    //                       fontSize: 11)),
    //             ],
    //           ),
    //           const Spacer(),
    //           GestureDetector(
    //             onTap: () => Get.dialog(const LeaveHistoryFilterView()),
    //             child: Container(
    //               width: 38,
    //               height: 38,
    //               decoration: BoxDecoration(
    //                 color: _gold.withValues(alpha:0.15),
    //                 borderRadius: BorderRadius.circular(18),
    //                 border: Border.all(color: _gold.withValues(alpha:0.4)),
    //               ),
    //               child: const Icon(Icons.filter_list_sharp,
    //                   color: _goldL, size: 18),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  //  LIST 
  Widget _buildList(
      LeaveHistoryController controller, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      itemCount: controller.leaveHistoryList.length,
      itemBuilder: (_, i) => leaveCard(controller, i, context),
    );
  }

  Widget leaveCard(
      LeaveHistoryController controller, int index, BuildContext context) {
    final item = controller.leaveHistoryList[index];
    final bool isApproved = item.status == 'approved';
    final bool isPending = item.status == 'Pending';

    final Color statusColor = isPending
        ? _pending
        : isApproved
        ? _present
        : _absent;
    final String statusLabel =
    isPending ? 'Pending' : isApproved ? 'Approved' : 'Rejected';
    final IconData statusIcon = isPending
        ? Icons.hourglass_top_rounded
        : isApproved
        ? Icons.check_circle_rounded
        : Icons.cancel_rounded;

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
          //  Card header 
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha:0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 18),
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
                              fontSize: 11,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: statusColor.withValues(alpha:0.3)),
                  ),
                  child: Text(statusLabel,
                      style: TextStyle(
                          color: statusColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),

          //  Date bar 
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 8, horizontal: 16),
            color: statusColor.withValues(alpha:0.05),
            child: Row(
              children: [
                Icon(Icons.calendar_month_rounded,
                    size: 13, color: statusColor),
                const SizedBox(width: 5),
                Text(
                  item.title == '1 Days Leave'
                      ? (item.date?.split(' ').first ?? 'N/A')
                      : (item.date ?? 'N/A'),
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          //  Body 
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: _infoBlock('Leave Reason',
                        item.reason ?? 'N/A')),
                const SizedBox(width: 12),
                Expanded(
                    child: _infoBlock('Reject Reason',
                        item.rejectreason?.isNotEmpty == true
                            ? item.rejectreason!
                            : 'N/A')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: _infoBlock('Responsible Person',
                item.forwardperson?.isNotEmpty == true
                    ? item.forwardperson!
                    : 'N/A'),
          ),

          //  Footer 
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16)),
              border: Border(top: BorderSide(color: _border)),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Icon(statusIcon, size: 14, color: statusColor),
                const SizedBox(width: 5),
                Text(statusLabel,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.leaveApply,
                      arguments:
                      controller.leaveHistoryList[index]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(8),
                      border:
                      Border.all(color: _navy.withValues(alpha:0.2)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit_rounded,
                            size: 12, color: _navy),
                        SizedBox(width: 4),
                        Text('Edit',
                            style: TextStyle(
                                color: _navy,
                                fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ],
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

  Widget _infoBlock(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: _neutral,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3)),
        const SizedBox(height: 3),
        Text(value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: _navy,
                fontSize: 12,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildLoader() => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(color: _navy, strokeWidth: 2),
        SizedBox(height: 12),
        Text('Loading history...',
            style: TextStyle(color: _neutral, fontSize: 13)),
      ],
    ),
  );

  Widget _buildEmpty() => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.history_toggle_off_rounded,
            size: 48,
            color: _neutral.withValues(alpha:0.35)),
        const SizedBox(height: 12),
        const Text('No leave requests found',
            style: TextStyle(color: _neutral, fontSize: 14)),
        const SizedBox(height: 4),
        const Text('Tap + to submit a new request',
            style: TextStyle(
                color: _neutral, fontSize: 12)),
      ],
    ),
  );
}