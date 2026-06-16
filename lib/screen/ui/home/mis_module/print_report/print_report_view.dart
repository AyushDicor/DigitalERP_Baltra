// import 'package:digitalerp/response/get_account_register_ledger_resp.dart';
// import 'package:digitalerp/utils/date_widget.dart';
// import 'package:digitalerp/utils/gradient_icon_app_button.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'print_report_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:digitalerp/utils/app_assets.dart';
//
// class PrintReportView extends StatelessWidget {
//   const PrintReportView({Key? key, required this.reportType}) : super(key: key);
//   final String reportType;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PrintReportController>(
//       init: PrintReportController(reportType),
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
//                       title: controller.title,
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
//                               if (reportType == ReportType.accountRegister) ...[
//                                 _legerDropdown(controller),
//                                 const SizedBox(height: 15),
//                                 _legerTypeDropdown(controller),
//                                 const SizedBox(height: 30)
//                               ],
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectFromDate,
//                                       title: 'From date',
//                                       onSelectDate: controller.setSelectedFromDate,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 15),
//                                   Expanded(
//                                     child: AppDateWidget(
//                                       value: controller.selectToDate,
//                                       title: 'To Date',
//                                       onSelectDate: controller.setSelectedToDate,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 30),
//                               const SizedBox(height: 40),
//                               GradientIconButton(
//                                 onPressed: controller.onShare,
//                                 iconSize: 18,
//                                 radius: 30,
//                                 vPadding: 18,
//                                 hPadding: 18,
//                                 topColor: purpleColor,
//                                 bottomColor: blueColor,
//                                 icon: AppAssets.shareIcon,
//                                 shadowRadius: 15,
//                               ),
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
//   Widget _legerDropdown(PrintReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<GetAccountRegisterLedgerData>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedExecutive,
//         hint: Text(
//           'Leger',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.executiveList.map((items) {
//           return DropdownMenuItem<GetAccountRegisterLedgerData>(
//             value: items,
//             child: Text(items.ledgername ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.setSelectedExecutiveValue(newValue);
//         },
//       ),
//     );
//   }
//
//   Widget _legerTypeDropdown(PrintReportController controller) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         buttonHeight: 40,
//         buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
//         dropdownDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: dropdownBoxColor,
//         ),
//         buttonDecoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           gradient: blueDropdownGr,
//         ),
//         isExpanded: true,
//         value: controller.selectedLegerType,
//         hint: Text(
//           'Leger Type',
//           style: const TextStyle().normal.copyWith(fontSize: 14),
//           overflow: TextOverflow.ellipsis,
//         ),
//         icon: Image.asset(
//           AppAssets.dropdownIcon,
//           width: 15,
//           height: 15,
//         ),
//         items: controller.legerTypeList.map((items) {
//           return DropdownMenuItem<String>(
//             value: items,
//             child: Text(items ?? ''),
//           );
//         }).toList(),
//         onChanged: (newValue) {
//           controller.seLegerTypeValue(newValue);
//         },
//       ),
//     );
//   }
// }

import 'package:digitalerp/response/get_account_register_ledger_resp.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/date_widget.dart';
import 'package:digitalerp/utils/my_app_bar_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../fab/menu_fab.dart';
import 'print_report_controller.dart';

class PrintReportView extends StatelessWidget {
  const PrintReportView({Key? key, required this.reportType}) : super(key: key);
  final String reportType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrintReportController>(
      init: PrintReportController(reportType),
      builder: (controller) => Scaffold(
        backgroundColor: lightGreyColor,
        body: Column(
          children: [
            MyAppBar(
              title: controller.title,
              onBackTap: () => controller.backTap(),
            ),
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
                          _filterCard(controller),
                          const SizedBox(height: 24),
                          _shareButton(controller),
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

  Widget _filterCard(PrintReportController controller) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: newBorderColor),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 5)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (reportType == ReportType.accountRegister) ...[
            _label('Ledger'),
            const SizedBox(height: 8),
            _dropdown<GetAccountRegisterLedgerData>(
              value: controller.selectedExecutive,
              hint: 'Select Ledger',
              items: controller.executiveList
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.ledgername ?? '',
                          style: const TextStyle(
                              color: newTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))))
                  .toList(),
              onChanged: controller.setSelectedExecutiveValue,
            ),
            const SizedBox(height: 16),
            _label('Ledger Type'),
            const SizedBox(height: 8),
            _dropdown<String>(
              value: controller.selectedLegerType,
              hint: 'Select Ledger Type',
              items: controller.legerTypeList
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e ?? '',
                          style: const TextStyle(
                              color: newTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500))))
                  .toList(),
              onChanged: controller.seLegerTypeValue,
            ),
            const SizedBox(height: 16),
          ],
          _label('Date Range'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _dateBox(
                      value: controller.selectFromDate,
                      title: 'From Date',
                      onSelect: controller.setSelectedFromDate)),
              const SizedBox(width: 12),
              Expanded(
                  child: _dateBox(
                      value: controller.selectToDate,
                      title: 'To Date',
                      onSelect: controller.setSelectedToDate)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shareButton(PrintReportController controller) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: controller.onShare,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: purpleColor.withValues(alpha: 0.3),
                  blurRadius: 14,
                  offset: const Offset(0, 6)),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share_rounded, color: Colors.white, size: 18),
              SizedBox(width: 10),
              Text('Generate & Share Report',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Text(t,
      style: const TextStyle(
          color: newTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3));

  Widget _dropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) =>
      DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: newBorderColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2))
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: DropdownButton2<T>(
            buttonHeight: 46,
            buttonPadding: EdgeInsets.zero,
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: whiteColor),
            dropdownMaxHeight: Get.height * .35,
            isExpanded: true,
            value: value,
            hint: Text(hint,
                style: const TextStyle(
                    color: newTextHint,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: purpleColor, size: 22),
            items: items,
            onChanged: onChanged,
          ),
        ),
      );

  Widget _dateBox(
          {required String value,
          required String title,
          required Function(String) onSelect}) =>
      Container(
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child:
            AppDateWidget(value: value, title: title, onSelectDate: onSelect),
      );
}
