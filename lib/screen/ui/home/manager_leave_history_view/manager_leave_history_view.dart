// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/manager_leave_history_view/manager_leave_history_controller.dart';
// import 'package:digitalerp/utils/all_screens_dialog_box/manager_leave_history_filter/manager_leave_history_filter_view.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/top_design.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ManagerLeaveHistoryView extends StatelessWidget {
//   const ManagerLeaveHistoryView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ManagerLeaveHistoryController>(
//       init: ManagerLeaveHistoryController(),
//       builder: (controller) {
//         return Visibility(
//           visible: false,
//           child: oldWay(controller, context),
//           replacement: newWay(controller, context),
//         );
//       },
//     );
//   }
//
//   Widget oldWay(controller, context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               bottom: 0,
//               right: 0,
//               left: 0,
//               child: Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.red,
//                     image: DecorationImage(image: AssetImage(AppAssets.dashboardBg), fit: BoxFit.fill)),
//                 child: SafeArea(
//                   child: MyAppBar(
//                     title: 'Manager Leave history',
//                     onBackTap: ()=>Get.back(),
//                     // onDrawerTap: () => controller.openDrawer(context),
//                     onFilterTap: () => Get.dialog(
//                       ///new way
//                       const ManagerLeaveHistoryFilterView(),
//
//                       ///old way
//                       // CustomDialogBox(type: managerLeaveHistoryFilter),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 0,
//               left: 0,
//               bottom: 0,
//               top: Get.height * 0.135,
//               child: controller.isBusy
//                   ? showLoader()
//                   : SingleChildScrollView(
//                       padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
//                       child: Column(
//                         children: [
//                           SizedBox(height: Get.height * 0.02),
//                           _executiveDropdown(controller),
//                           const SizedBox(height: 15),
//                           controller.isListLoading
//                               ? showLoader()
//                               : controller.pendingLeaveList.isEmpty
//                                   ? SizedBox(height: Get.height * .4, child: centerText('No Data found'))
//                                   : ListView.builder(
//                                       shrinkWrap: true,
//                                       padding: EdgeInsets.zero,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       itemCount: controller.pendingLeaveList.length,
//                                       itemBuilder: (context, index) {
//                                         return managerLeaveCard(controller, index, context);
//                                       },
//                                     ),
//                         ],
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget newWay(controller, context) {
//     return TopDesign(
//       appBar: MyAppBar(
//         title: 'Manager Leave history',
//         onBackTap: ()=>Get.back(),
//         // onDrawerTap: () => controller.openDrawer(context),
//         onFilterTap: () => Get.dialog(
//           ///new way
//           const ManagerLeaveHistoryFilterView(),
//
//           ///old way
//           // CustomDialogBox(type: managerLeaveHistoryFilter),
//         ),
//       ),
//       child: controller.isBusy
//           ? showLoader()
//           : SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
//               child: Column(
//                 children: [
//                   _executiveDropdown(controller),
//                   const SizedBox(height: 15),
//                   controller.isListLoading
//                       ? showLoader()
//                       : controller.pendingLeaveList.isEmpty
//                           ? SizedBox(height: Get.height * .4, child: centerText('No Data found'))
//                           : ListView.builder(
//                               shrinkWrap: true,
//                               padding: EdgeInsets.zero,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: controller.pendingLeaveList.length,
//                               itemBuilder: (context, index) {
//                                 return managerLeaveCard(controller, index, context);
//                               },
//                             ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget _executiveDropdown(ManagerLeaveHistoryController controller) {
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
//           'Select Executive Name',
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
//           controller.setSelectDropdownValue(newValue);
//         },
//       ),
//     );
//   }
//
//   Widget managerLeaveCard(ManagerLeaveHistoryController controller, int index, BuildContext context) {
//     var item = controller.pendingLeaveList[index];
//     bool isApproved = item.status == 'approved';
//     bool isPending = item.status == 'Pending';
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         color: progressAttendanceColor,
//       ),
//       margin: const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(15),
//                   bottom: Radius.circular(25),
//                 ),
//                 color: Colors.white),
//             padding: const EdgeInsets.symmetric(
//               vertical: 15,
//               horizontal: 25,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   item.title ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(
//                         color: Colors.black,
//                       ),
//                 ),
//                 Text(
//                   item.time ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(
//                         fontSize: 12,
//                         color: Colors.black,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 15),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.executivename ?? 'N/A',
//               style: const TextStyle().bold.copyWith(
//                     fontSize: 18,
//                     color: purpleColor,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               item.title == '1 Days Leave' ? item.date!.split(' ').first : item.date ?? 'N/A',
//               style: const TextStyle().bold.copyWith(
//                     fontSize: 18,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 25,
//               vertical: 15,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Leave Reason',
//                   style: const TextStyle().bold.copyWith(
//                         fontSize: 12,
//                         color: purpleColor,
//                       ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   item.reason ?? 'N/A',
//                   style: const TextStyle().bold.copyWith(
//                         color: Colors.black,
//                       ),
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
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(15),
//                       ),
//                       color: green3Color,
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 8,
//                       horizontal: 25,
//                     ),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       // onTap: () =>controller.leaveStatusUpdate(id: item.id.toString(), isApproved: true),
//                       onTap: () => showAlertDialog(
//                         context,
//                         controller,
//                         true,
//                         item.id.toString(),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(
//                             AppAssets.approvedCheckIcon,
//                             height: 11,
//                           ),
//                           Text(
//                             ' Approve',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomRight: Radius.circular(15),
//                       ),
//                       color: redColor,
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 8,
//                       horizontal: 25,
//                     ),
//                     alignment: Alignment.center,
//                     child: InkWell(
//                       // onTap: () =>controller.leaveStatusUpdate(id: item.id.toString(), isApproved: false),
//                       onTap: () => showAlertDialog(
//                         context,
//                         controller,
//                         false,
//                         item.id.toString(),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(AppAssets.closeIcon, height: 11),
//                           Text(
//                             ' Reject',
//                             style: const TextStyle().bold.copyWith(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
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
//                 borderRadius: const BorderRadius.vertical(
//                   bottom: Radius.circular(15),
//                 ),
//                 color: isApproved ? green3Color : redColor,
//               ),
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8,
//                 horizontal: 25,
//               ),
//               alignment: Alignment.center,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     isApproved ? AppAssets.approvedCheckIcon : AppAssets.closeIcon,
//                     height: 11,
//                   ),
//                   Text(
//                     isApproved ? ' Approved' : ' Rejected',
//                     style: const TextStyle().bold.copyWith(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                   ),
//                 ],
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   showAlertDialog(BuildContext context, ManagerLeaveHistoryController controller, bool isFromApprove, String id) {
//     Widget cancelButton = TextButton(
//       child: const Text('Cancel'),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//     Widget continueButton = TextButton(
//       child: Text(isFromApprove ? 'Approved' : 'Reject'),
//       onPressed: () {
//         Navigator.pop(context);
//         controller.leaveStatusUpdate(id: id, isApproved: isFromApprove ? true : false);
//       },
//     );
//     AlertDialog alertDialog = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       title: const Text('Confirmation'),
//       content: Text(
//         'Would you like to ${isFromApprove ? 'Approved' : 'Reject'} leave?',
//       ),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alertDialog;
//       },
//     );
//   }
// }

import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/manager_leave_history_view/manager_leave_history_controller.dart';
import 'package:digitalerp/utils/all_screens_dialog_box/manager_leave_history_filter/manager_leave_history_filter_view.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerLeaveHistoryView extends StatelessWidget {
  const ManagerLeaveHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagerLeaveHistoryController>(
      init: ManagerLeaveHistoryController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          shadowColor: const Color(0x12000000),
          surfaceTintColor: Colors.white,
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: newTextPrimary, size: 20),
          ),
          title: const Text('Leave History',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
          actions: [
            GestureDetector(
              onTap: () => Get.dialog(const ManagerLeaveHistoryFilterView()),
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.filter_list_rounded,
                    color: Color(0xFF5B5FC7), size: 20),
              ),
            ),
          ],
        ),
        body: controller.isBusy
            ? showLoader(color: newBlueColor)
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(children: [
                  // Executive dropdown
                  _executiveDropdown(controller),
                  const SizedBox(height: 16),

                  // Leave list
                  controller.isListLoading
                      ? showLoader(color: newBlueColor)
                      : controller.pendingLeaveList.isEmpty
                          ? SizedBox(
                              height: Get.height * .4,
                              child: centerText('No Data found'))
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: controller.pendingLeaveList.length,
                              itemBuilder: (ctx, i) =>
                                  _leaveCard(controller, i, ctx),
                            ),
                ]),
              ),
        floatingActionButton: MenuFab(parentMenuId: 2384),
      ),
    );
  }

  //  Executive dropdown 

  Widget _executiveDropdown(ManagerLeaveHistoryController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<ExecutiveDropdownData>(
        isExpanded: true,
        buttonHeight: 48,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
        buttonDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
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
        value: controller.selectedDropdownValue,
        hint: const Text('Select Executive Name',
            style: TextStyle(fontSize: 14, color: newTextSecondary)),
        icon: const Icon(Icons.keyboard_arrow_down_rounded,
            color: newTextSecondary, size: 20),
        items: controller.executiveList
            .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.executiveName.toString(),
                    style:
                        const TextStyle(fontSize: 14, color: newTextPrimary))))
            .toList(),
        onChanged: controller.setSelectDropdownValue,
      ),
    );
  }

  //  Leave card 

  Widget _leaveCard(ManagerLeaveHistoryController controller, int index,
      BuildContext context) {
    final item = controller.pendingLeaveList[index];
    final bool isPending = item.status == 'Pending';
    final bool isApproved = item.status == 'approved';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(children: [
        //  Header: title + time 
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F3FF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            border: Border(bottom: BorderSide(color: Color(0xFFE8ECF0))),
          ),
          child: Row(children: [
            Expanded(
              child: Text(item.title ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
            ),
            Text(item.time ?? 'N/A',
                style: const TextStyle(fontSize: 12, color: newTextSecondary)),
          ]),
        ),

        //  Body 
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Executive name
            Center(
              child: Text(item.executivename ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF5B5FC7))),
            ),
            const SizedBox(height: 6),
            // Date
            Center(
              child: Text(
                item.title == '1 Days Leave'
                    ? (item.date?.split(' ').first ?? 'N/A')
                    : item.date ?? 'N/A',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary),
              ),
            ),
            const SizedBox(height: 14),
            // Leave reason
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE8ECF0)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Leave Reason',
                        style: TextStyle(
                            fontSize: 11,
                            color: newTextSecondary,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    Text(item.reason ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: newTextPrimary)),
                  ]),
            ),
          ]),
        ),

        //  Action buttons 
        if (isPending)
          Row(children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showConfirmDialog(
                    context, controller, true, item.id.toString()),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFF27AE60),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(16)),
                  ),
                  alignment: Alignment.center,
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.check_circle_outline_rounded,
                        color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('Approve',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ]),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => _showConfirmDialog(
                    context, controller, false, item.id.toString()),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE74C3C),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(16)),
                  ),
                  alignment: Alignment.center,
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text('Reject',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ]),
                ),
              ),
            ),
          ])
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isApproved
                  ? const Color(0xFF27AE60)
                  : const Color(0xFFE74C3C),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            alignment: Alignment.center,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                  isApproved
                      ? Icons.check_circle_outline_rounded
                      : Icons.cancel_outlined,
                  color: Colors.white,
                  size: 18),
              const SizedBox(width: 6),
              Text(isApproved ? 'Approved' : 'Rejected',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ]),
          ),
      ]),
    );
  }

  void _showConfirmDialog(BuildContext context,
      ManagerLeaveHistoryController controller, bool isApprove, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Confirmation',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: newTextPrimary)),
        content: Text(
            'Would you like to ${isApprove ? 'approve' : 'reject'} this leave?',
            style: const TextStyle(fontSize: 13, color: newTextSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('Cancel', style: TextStyle(color: newTextSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              controller.leaveStatusUpdate(id: id, isApproved: isApprove);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isApprove ? const Color(0xFF27AE60) : const Color(0xFFE74C3C),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(isApprove ? 'Approve' : 'Reject',
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
