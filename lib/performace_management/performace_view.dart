//
// import 'package:digitalerp/performace_management/perfomace_list_response.dart';
// import 'package:digitalerp/performace_management/performace_controller.dart';
// import 'package:digitalerp/performace_management/performance_filter_screen.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PerformanceView extends StatelessWidget {
//   const PerformanceView({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PerformanceController>(
//       init: PerformanceController(),
//       builder: (controller){
//         return Scaffold(
//     body: Center(
//       child: Stack(
//         children: [
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/dashboard_bg.png'),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               child: SafeArea(
//                 child: MyAppBar(
//                   title: 'Performance',
//                   onBackTap: () => Get.back(),
//                   onFilterTap: () => Get.dialog(PerformanceFilterScreen()),
//                   showApprovalIcon: false,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: Get.height * 0.150,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 children: [
//                   controller.performanceData.isEmpty
//                   ? Center(child: showLoader())
//                   : ListView.builder(
//                       shrinkWrap: true,
//                       padding: EdgeInsets.zero,
//                       physics:  const NeverScrollableScrollPhysics(),
//                       itemCount:controller.performanceData.length,
//                       itemBuilder: (context,index)=> performanceView(controller.performanceData.elementAt(index))
//                       )
//
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );});
//   }
//
//   Widget performanceView(PerformanceData data){
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Container(
//           width: Get.width * 0.90,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 blurRadius: 5.0,
//               )
//             ],
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 20, left: 20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Text('ExecutiveName :', style: TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//                          data.executivename?? 'N/A',
//                         style: TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Sales Target :', style: TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//                         data.salestarget ??  'N/A',
//                         style: const TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Total Sales :', style: const TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//                          data.totalsales ??  'N/A',
//                         style: TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Total Billed Amount :',
//                         style: TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//                          data.totalbilledamt?? 'N/A',
//                         style: TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Total Collected Amount :',
//                         style: TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//                          data.totalcollectedamt ?? 'N/A',
//                         style: TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('Total Achieve % :', style: const TextStyle().newstyle),
//                     SizedBox(
//                       width: Get.width * 0.030,
//                       height: Get.height * 0.050,
//                     ),
//                     Expanded(
//                       child: Text(
//
//                         data.totalachive.toString(),
//                         style: TextStyle().xstyle,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//


import 'package:digitalerp/performace_management/perfomace_list_response.dart';
import 'package:digitalerp/performace_management/performace_controller.dart';
import 'package:digitalerp/performace_management/performance_filter_screen.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';

//  Design tokens 
const Color _kBg          = Color(0xFFF5F6FA);
const Color _kWhite       = Colors.white;
const Color _kBlue        = purpleColor;
final Color _kBlueBg      = purpleLightest;
const Color _kBorder      = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub     = Color(0xFF64748B);
const Color _kTextHint    = Color(0xFF94A3B8);
const Color _kDivider     = Color(0xFFEFF2F7);
const Color _kGreen       = Color(0xFF10B981);
const Color _kGreenBg     = Color(0xFFD1FAE5);
const Color _kOrange      = Color(0xFFF59E0B);
const Color _kOrangeBg    = Color(0xFFFEF3C7);
const Color _kRed         = Color(0xFFEF4444);

//  Shared helpers 
Widget _appBar(String title, {VoidCallback? onFilter}) {
  return Container(
    color: _kWhite,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(children: [
      GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back_ios_new, color: _kTextPrimary, size: 22),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: _kTextPrimary)),
      ),
      if (onFilter != null)
        GestureDetector(
          onTap: onFilter,
          child: Container(
            height: 40, width: 40,
            decoration: BoxDecoration(
                color: _kBlueBg, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.filter_list_sharp, color: _kBlue, size: 20),
          ),
        ),
    ]),
  );
}

Widget _styledDropdown({required Widget child}) => Container(
  decoration: BoxDecoration(
      color: _kWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _kBorder)),
  child: child,
);

Widget _sectionLabel(String label) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Text(label,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary)),
);

DropdownButton2 _buildDropdown2<T>({
  required String hint,
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required void Function(T?) onChanged,
}) =>
    DropdownButton2<T>(
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 14),
      dropdownDecoration:
      BoxDecoration(borderRadius: BorderRadius.circular(18), color: _kWhite),
      dropdownMaxHeight: 220,
      buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18), color: Colors.transparent),
      isExpanded: true,
      hint: Text(hint,
          style: const TextStyle(fontSize: 14, color: _kTextHint)),
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded,
          color: _kTextSub, size: 22),
      items: items,
      onChanged: onChanged,
    );

class PerformanceView extends StatelessWidget {
  const PerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerformanceController>(
      init: PerformanceController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar('Performance',
                onFilter: () => Get.dialog(PerformanceFilterScreen())),
            Expanded(
              child: controller.performanceData.isEmpty
                  ? showLoader(color: _kBlue)
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                itemCount: controller.performanceData.length,
                itemBuilder: (context, index) =>
                    _performanceCard(controller.performanceData[index]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _performanceCard(PerformanceData data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: _kWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Executive Name',
                  style: TextStyle(fontSize: 11, color: _kTextSub)),
              const SizedBox(height: 2),
              Text(data.executivename ?? 'N/A',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _kTextPrimary)),
            ]),
            const Spacer(),
            // Achieve % badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                  color: _kGreenBg,
                  borderRadius: BorderRadius.circular(20)),
              child: Text('${data.totalachive ?? 0}%',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: _kGreen)),
            ),
          ]),
        ),

        const Divider(height: 1, color: _kDivider),

        // Metrics grid
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
          child: Column(children: [
            Row(children: [
              _metricBox('Sales Target', data.salestarget ?? 'N/A', _kBlue, _kBlueBg),
              const SizedBox(width: 10),
              _metricBox('Total Sales', data.totalsales ?? 'N/A', _kGreen, _kGreenBg),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              _metricBox('Billed Amount', data.totalbilledamt ?? 'N/A', _kOrange, _kOrangeBg),
              const SizedBox(width: 10),
              _metricBox('Collected Amount', data.totalcollectedamt ?? 'N/A', _kRed, Color(0xFFFEE2E2)),
            ]),
          ]),
        ),
      ]),
    );
  }

  Widget _metricBox(String label, String value, Color color, Color bg) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border(left: BorderSide(color: color, width: 3))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label,
                style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.8))),
            const SizedBox(height: 2),
            Text(value,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700, color: color)),
          ]),
        ),
      );
}