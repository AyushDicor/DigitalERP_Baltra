// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/leave_history_filter/leave_history_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
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
//                               padding: const EdgeInsets.symmetric(horizontal: 20),
//                               child: Column(
//                                 children: [
//                                   SizedBox(height: Get.height * 0.02),
//                                   if (controller.isManager) _executiveDropdown(controller),
//                                   ListView.builder(
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.zero,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemCount: controller.leaveHistoryList.length,
//                                     itemBuilder: (context, index) {
//                                       return leaveCard(controller, index);
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
//         buttonDecoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
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
//
//   Widget leaveCard(LeaveHistoryController controller, int index) {
//     var item = controller.leaveHistoryList[index];
//     bool isApproved = item.status == 'approved';
//     bool isPending = item.status == 'Pending';
//     //bool isRejected = item.status == 'reject';
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: progressAttendanceColor),
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
//                 color: isPending
//                     ? purpleColor
//                     : isApproved
//                         ? green3Color
//                         : redColor),
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//             alignment: Alignment.center,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (!isPending) Image.asset(isApproved ? AppAssets.approvedCheckIcon : AppAssets.closeIcon, height: 11),
//                 Text(
//                   isPending
//                       ? 'Pending'
//                       : isApproved
//                           ? ' Approved'
//                           : ' Rejected',
//                   style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.white),
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
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: progressAttendanceColor),
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
//                   style: const TextStyle().bold.copyWith(fontSize: 12, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 15),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.date ?? 'N/A',
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
//                     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       onTap: () => controller.leaveStatusUpdate(id: item.id.toString(), isApproved: true),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppAssets.approvedCheckIcon, height: 11),
//                           Text(
//                             ' Approve',
//                             style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.white),
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
//                     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       onTap: () => controller.leaveStatusUpdate(id: item.id.toString(), isApproved: false),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppAssets.closeIcon, height: 11),
//                           Text(
//                             ' Reject',
//                             style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.white),
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
//                   Image.asset(isApproved ? AppAssets.approvedCheckIcon : AppAssets.closeIcon, height: 11),
//                   Text(
//                     isApproved ? ' Approved' : ' Rejected',
//                     style: const TextStyle().bold.copyWith(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             )
//         ],
//       ),
//     );
//   }
// }


import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/home/attendance/leave_history_view/leave_history_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/leave_history_filter/leave_history_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

//  Design tokens 
const Color _kBg      = Color(0xFFF5F6FA);
const Color _kCard    = Colors.white;
const Color _kBlue    = Color(0xFF4169E1);
const Color _kBlueBg  = Color(0xFFEEF2FF);
const Color _kGreen   = Color(0xFF2E7D32);
const Color _kGreenBg = Color(0xFFE8F5E9);
const Color _kOrange  = Color(0xFFE65100);
const Color _kOrangeBg = Color(0xFFFFF3E0);
const Color _kRed     = Color(0xFFC62828);
const Color _kRedBg   = Color(0xFFFFEBEE);
const Color _kText    = Color(0xFF1A1A2E);
const Color _kSub     = Color(0xFF888888);
const Color _kBorder  = Color(0xFFE8E8E8);

class LeaveHistoryView extends StatelessWidget {
  const LeaveHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LeaveHistoryController>(
      init: LeaveHistoryController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(
            children: [
              //  App Bar 
              Container(
                color: _kCard,
                padding: const EdgeInsets.symmetric(
                    horizontal: 4, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => controller.backTap(),
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: _kText, size: 22),
                    ),
                    Expanded(
                      child: Text(
                        'Leave History',
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
                            color: _kBlue, size: 20),
                        onPressed: () =>
                            Get.dialog(const LeaveHistoryFilterView()),
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
                    : controller.leaveHistoryList.isEmpty
                    ? Center(
                    child: Text('No Data found',
                        style:
                        GoogleFonts.dmSans(color: _kSub)))
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                      16, 16, 16, 32),
                  itemCount:
                  controller.leaveHistoryList.length +
                      (controller.isManager ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (controller.isManager && index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _executiveDropdown(controller),
                      );
                    }
                    final listIndex = controller.isManager
                        ? index - 1
                        : index;
                    return _leaveCard(
                        controller, listIndex);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Executive dropdown 
  Widget _executiveDropdown(LeaveHistoryController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ExecutiveDropdownData>(
        buttonHeight: 48,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _kCard,
          border: Border.all(color: _kBorder),
        ),
        dropdownElevation: 4,
        isExpanded: true,
        hint: Text('Select Executive',
            style: GoogleFonts.dmSans(color: _kSub, fontSize: 14)),
        value: controller.selectedDropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down,
            color: _kSub, size: 22),
        items: controller.executiveList.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item.executiveName.toString(),
                style: GoogleFonts.dmSans(
                    fontSize: 14, color: _kText)),
          );
        }).toList(),
        onChanged: (v) => controller.setSelectDropdownValue(v!),
      ),
    );
  }

  //  Leave card 
  Widget _leaveCard(LeaveHistoryController controller, int index) {
    final item      = controller.leaveHistoryList[index];
    final bool isApproved = item.status == 'approved';
    final bool isPending  = item.status == 'Pending';

    Color statusBg, statusFg;
    String statusLabel;
    if (isPending) {
      statusBg    = _kOrangeBg;
      statusFg    = _kOrange;
      statusLabel = 'Pending';
    } else if (isApproved) {
      statusBg    = _kGreenBg;
      statusFg    = _kGreen;
      statusLabel = 'Approved';
    } else {
      statusBg    = _kRedBg;
      statusFg    = _kRed;
      statusLabel = 'Rejected';
    }

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
          //  Card header: title + time 
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
                  style: GoogleFonts.dmSans(
                      fontSize: 12, color: _kSub),
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

          //  Leave reason 
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Reason',
                    style: GoogleFonts.dmSans(
                        fontSize: 11, color: _kSub)),
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

  //  Manager leave card (with approve/reject buttons) 
  Widget _managerLeaveCard(
      LeaveHistoryController controller, int index) {
    final item     = controller.pendingLeaveList[index];
    final bool isApproved = item.status == 'approved';
    final bool isPending  = item.status == 'Pending';

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
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Container(
                  width: 4, height: 20,
                  decoration: BoxDecoration(
                      color: _kBlue,
                      borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(item.title ?? 'N/A',
                      style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _kText)),
                ),
                Text(item.time ?? '',
                    style:
                    GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
              ],
            ),
          ),
          Divider(height: 1, color: _kBorder),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 14, color: _kBlue),
                const SizedBox(width: 6),
                Text(item.date ?? 'N/A',
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _kText)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Reason',
                    style: GoogleFonts.dmSans(
                        fontSize: 11, color: _kSub)),
                const SizedBox(height: 4),
                Text(item.reason ?? 'N/A',
                    style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _kText)),
              ],
            ),
          ),
          if (isPending)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.leaveStatusUpdate(
                        id: item.id.toString(), isApproved: true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: _kGreenBg,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Approve',
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _kGreen)),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.leaveStatusUpdate(
                        id: item.id.toString(), isApproved: false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: _kRedBg,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text('Reject',
                          style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: _kRed)),
                    ),
                  ),
                ),
              ],
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isApproved ? _kGreenBg : _kRedBg,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                isApproved ? 'Approved' : 'Rejected',
                style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isApproved ? _kGreen : _kRed),
              ),
            ),
        ],
      ),
    );
  }
}