// import 'package:digitalerp/response/get_executive_dropdown_response.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'attendance_report_controller.dart';
// import 'package:digitalerp/utils/date_widget.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/solid_app_button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:digitalerp/utils/app_assets.dart';
//
// class AttendanceReportView extends StatelessWidget {
//   const AttendanceReportView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AttendanceReportController>(
//       init: AttendanceReportController(),
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
//                     image: DecorationImage(
//                       image: AssetImage(AppAssets.dashboardBg),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: AppString.attendanceReport,
//                       onBackTap: () => controller.backTap(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 right: 0,
//                 left: 0,
//                 bottom: 0,
//                 top: Get.height * 0.135,
//                 child: controller.isBusy
//                     ? showLoader()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                             children: [
//                               SizedBox(height: Get.height * 0.02),
//                               // const SizedBox(height: 30),
//                               _dropdownExecutive(controller),
//                               // const SizedBox(height: 15),
//                               const SizedBox(height: 30),
//                               AppDateWidget(
//                                 value: controller.dateMonth,
//                                 title: 'Date/Month',
//                                 onSelectDate: controller.setDateMonth,
//                               ),
//                               const SizedBox(height: 30),
//                               SolidAppButton(
//                                 onPressed: controller.onSearch,
//                                 name: 'Search',
//                                 topColor: orangeColor,
//                                 bottomColor: red2Color,
//                                 textSize: 16,
//                                 hPadding: 30,
//                               ),
//                               const SizedBox(height: 20),
//                               ListView.builder(
//                                 // itemCount: 5,
//                                 padding: EdgeInsets.zero,
//                                 itemCount: controller.attendanceReportList.length ?? 0,
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   var item = controller.attendanceReportList[index];
//                                   return CommonItem(
//                                     isCardShow: true,
//                                     data: [
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.empName,
//                                         leftValue: item.name,
//                                         rightTitle: AppString.workingDays,
//                                         rightValue: item.workingdays,
//                                       ),
//                                       CommonItemRowModel(
//                                         leftTitle: AppString.presentDays,
//                                         leftValue: item.presentdays,
//                                         rightTitle: AppString.absentDays,
//                                         rightValue: item.absentdays,
//                                       ),
//                                       // CommonItemRowModel(
//                                       //   leftTitle: AppString.deliveredTo,
//                                       //   leftValue: item.deliveredto,
//                                       //   rightTitle: AppString.status,
//                                       //   rightValue: item.shippingstatus,
//                                       // ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dropdownExecutive(AttendanceReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<ExecutiveDropdownData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration:
//             BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: blueDropdownGr),
//         isExpanded: true,
//         value: controller.selectedExecutiveValue,
//         hint: Text(
//           AppString.executiveName,
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.executiveDropdownList?.map(
//           (items) {
//             return DropdownMenuItem<ExecutiveDropdownData>(
//               value: items,
//               child: Text(items.executiveName.toString()),
//             );
//           },
//         ).toList(),
//         onChanged: (newValue) {
//           controller.setExecutiveValue(newValue);
//         },
//         dropdownMaxHeight: Get.height * .35,
//       ),
//     );
//   }
// }

import 'package:digitalerp/response/get_executive_dropdown_response.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../fab/menu_fab.dart';
import 'attendance_report_controller.dart';

class AttendanceReportView extends StatelessWidget {
  const AttendanceReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceReportController>(
      init: AttendanceReportController(),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        body: Column(
          children: [
            //  AppBar 
            MyAppBar(
              title: AppString.attendanceReport,
              onBackTap: () => controller.backTap(),
            ),

            //  Body 
            Expanded(
              child: controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: purpleColor, strokeWidth: 2))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //  Filter card 
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: newBorderColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Label
                                _fieldLabel('Executive Name'),
                                const SizedBox(height: 8),
                                _executiveDropdown(controller),
                                const SizedBox(height: 16),
                                _fieldLabel('Date / Month'),
                                const SizedBox(height: 8),
                                _dateCard(controller),
                                const SizedBox(height: 20),
                                _searchButton(controller),
                              ],
                            ),
                          ),

                          //  Results 
                          const SizedBox(height: 24),
                          _sectionTitle('Results'),
                          const SizedBox(height: 12),

                          if (controller.attendanceReportList.isEmpty)
                            _emptyState()
                          else
                            ...List.generate(
                              controller.attendanceReportList.length,
                              (i) => _reportCard(
                                  controller.attendanceReportList[i]),
                            ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  //  Section title 
  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: newTextPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  //  Field label 
  Widget _fieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: newTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  //  Executive dropdown 
  Widget _executiveDropdown(AttendanceReportController controller) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButton2<ExecutiveDropdownData>(
          buttonHeight: 46,
          buttonPadding: EdgeInsets.zero,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          dropdownMaxHeight: Get.height * .35,
          isExpanded: true,
          value: controller.selectedExecutiveValue,
          hint: Text(
            AppString.executiveName,
            style: const TextStyle(
              color: newTextHint,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: purpleColor,
            size: 22,
          ),
          items: controller.executiveDropdownList?.map((items) {
            return DropdownMenuItem<ExecutiveDropdownData>(
              value: items,
              child: Text(
                items.executiveName.toString(),
                style: const TextStyle(
                  color: newTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) => controller.setExecutiveValue(newValue),
        ),
      ),
    );
  }

  //  Date picker row 
  Widget _dateCard(AttendanceReportController controller) {
    return Container(
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: AppDateWidget(
        value: controller.dateMonth,
        title: 'Date/Month',
        onSelectDate: controller.setDateMonth,
      ),
    );
  }

  //  Search button 
  Widget _searchButton(AttendanceReportController controller) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: controller.onSearch,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: purpleColor.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Report card 
  Widget _reportCard(dynamic item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          //  Card header 
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: newBlueLightColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.person_outline_rounded,
                    color: newBlueColor, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.name?.toString() ?? 'N/A',
                    style: const TextStyle(
                      color: newTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //  Stats row 
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _statTile(
                  label: AppString.workingDays,
                  value: item.workingdays?.toString() ?? '—',
                  color: newBlueColor,
                  bgColor: newBlueLightColor,
                  icon: Icons.calendar_month_rounded,
                ),
                const SizedBox(width: 10),
                _statTile(
                  label: AppString.presentDays,
                  value: item.presentdays?.toString() ?? '—',
                  color: newGreenColor,
                  bgColor: newGreenLightColor,
                  icon: Icons.check_circle_outline_rounded,
                ),
                const SizedBox(width: 10),
                _statTile(
                  label: AppString.absentDays,
                  value: item.absentdays?.toString() ?? '—',
                  color: newRedColor,
                  bgColor: newRedLightColor,
                  icon: Icons.cancel_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statTile({
    required String label,
    required String value,
    required Color color,
    required Color bgColor,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: newTextSecondary,
                fontSize: 9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(
        children: [
          Icon(Icons.assignment_outlined,
              size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            "No attendance records found",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
