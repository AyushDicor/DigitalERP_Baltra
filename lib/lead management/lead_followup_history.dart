// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
//
// class LeadFolloupHistory extends StatefulWidget {
//   const LeadFolloupHistory({Key? key}) : super(key: key);
//
//   @override
//   State<LeadFolloupHistory> createState() => _LeadFolloupHistoryState();
// }
//
// class _LeadFolloupHistoryState extends State<LeadFolloupHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 0,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/dashboard_bg.png'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//                 child: SafeArea(
//                   child: MyAppBar(
//                     title: 'Follow up History',
//                     onBackTap: () => Get.back(),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: 0,
//               left: 0,
//               bottom: 0,
//               top: Get.height * 0.250,
//               child: SingleChildScrollView(
//                 child:
//                 Container(
//                 decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                 colors: [
//                 grBottomColor.withValues(alpha:0.2),
//                 grTopColor.withValues(alpha:0.2)]
//                 )
//                 ),
//                   child: Column(
//                     children: [
//                       followuppart(),
//                       // ListView.builder(
//                       //   scrollDirection: Axis.vertical,
//                       //   shrinkWrap: true,
//                       //   physics: NeverScrollableScrollPhysics(),
//                       //   itemCount: 5,
//                       //   itemBuilder: (context,index){
//                       //     return followuppartdetail();
//                       //   },
//                       //
//                       // )
//
//                     ],
//                   )
//                 ),
//               ),
//             ),
//           ],
//
//         ),
//       ),
//     );
//   }
//   Widget followuppart (){
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 height: Get.height * 0.040,
//                   width: Get.height * 0.040,
//                   decoration: BoxDecoration(
//                       color: Colors.white
//                   ),
//                   child: Center(child: Text('S.No',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)
//                   ))),
//               SizedBox(width:Get.width * 0.005),
//
//               Container(
//                 height: Get.height * 0.040,
//                 width: Get.width * 0.145,
//                 color: Colors.white,
//                 child: Center(
//                   child: Text('Entry Date', style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
//                   ),
//                 )),
//               SizedBox(width:Get.width * 0.005),
//               Container(
//                   height: Get.height * 0.040,
//                   width: Get.width * 0.145,
//                   color: Colors.white,
//                   child: Center(child: Text('Remarks',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)))),
//               SizedBox(width:Get.width * 0.005),
//               Container(
//                   height: Get.height * 0.040,
//                   width: Get.width * 0.145,
//                   color: Colors.white,
//                   child: Center(child: Text('Purpose',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)))),
//               SizedBox(width:Get.width * 0.005),
//               Container(
//                   height: Get.height * 0.040,
//                   width: Get.width * 0.140,
//                 color: Colors.white,
//                   child: Center(child: Text('Status',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)))),
//               SizedBox(width:Get.width * 0.005),
//               Container(
//                   height: Get.height * 0.040,
//                   width: Get.width * 0.140,
//                   color: Colors.white,
//                   child: Center(child: Text('Follow up Date',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)))),
//               SizedBox(width:Get.width * 0.005),
//               Container(
//                   height: Get.height * 0.040,
//                   width: Get.width * 0.145,
//                   color: Colors.white,
//                   child: Center(child: Text('Follow up Time',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)))),
//             ],
//           ),
//           ListView.builder(
//             padding: EdgeInsets.only(top: 10),
//             // scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: 5,
//             itemBuilder: (context,index){
//               return Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.height * 0.040,
//                         decoration: BoxDecoration(
//                             color: Colors.white
//                         ),
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)
//                         ))),
//
//                     SizedBox(width:Get.width * 0.005),
//
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.145,
//                         color: Colors.white,
//                         child: Center(
//                           child: Text('N/A',
//                             style: TextStyle(fontSize: 11,),
//                           ),
//                         )),
//                     SizedBox(width:Get.width * 0.005),
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.145,
//                         color: Colors.white,
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)))),
//                     SizedBox(width:Get.width * 0.005),
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.145,
//                         color: Colors.white,
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)))),
//                     SizedBox(width:Get.width * 0.005),
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.140,
//                         color: Colors.white,
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)))),
//                     SizedBox(width:Get.width * 0.005),
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.140,
//                         color: Colors.white,
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)))),
//                     SizedBox(width:Get.width * 0.005),
//                     Container(
//                         height: Get.height * 0.040,
//                         width: Get.width * 0.145,
//                         color: Colors.white,
//                         child: Center(child: Text('N/A',
//                             style: TextStyle(fontSize: 11,)))),
//                   ],
//                 ),
//               );
//             },
//
//           )
//         ],
//       ),
//
//
//     );
//   }
// }

import 'package:digitalerp/lead%20management/lead%20management%20controller/lead_management_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//  Design tokens 
const Color _kPrimary       = Color(0xFF4361EE);
const Color _kPrimaryLight  = Color(0xFFEEF1FF);
const Color _kBg            = Color(0xFFF6F7FB);
const Color _kSurface       = Colors.white;
const Color _kBorder        = Color(0xFFE4E7F0);
const Color _kTextPrimary   = Color(0xFF111827);
const Color _kTextSecondary = Color(0xFF6B7280);
const Color _kCardShadow    = Color(0x0A000000);
const Color _kRowAlt        = Color(0xFFF8F9FF);
const Color _kGreen         = Color(0xFF10B981);
const Color _kGreenLight    = Color(0xFFD1FAE5);
const Color _kOrange        = Color(0xFFF59E0B);
const Color _kOrangeLight   = Color(0xFFFEF3C7);
const Color _kRed           = Color(0xFFEF4444);
const Color _kRedLight      = Color(0xFFFEE2E2);

//  Column config 
class _Col {
  final String title;
  final double width;
  const _Col(this.title, this.width);
}

const List<_Col> _cols = [
  _Col('S.No', 50),
  _Col('Entry Date', 95),
  _Col('Remarks', 120),
  _Col('Purpose', 100),
  _Col('Status', 90),
  _Col('Followup Date', 100),
  _Col('Followup Time', 100),
];

//  Status badge 
Widget _statusBadge(String status) {
  Color bg, fg;
  switch (status.toLowerCase()) {
    case 'closed':
      bg = _kGreenLight; fg = _kGreen; break;
    case 'pending':
      bg = _kOrangeLight; fg = _kOrange; break;
    case 'open':
      bg = _kPrimaryLight; fg = _kPrimary; break;
    default:
      bg = const Color(0xFFF1F1F1); fg = _kTextSecondary;
  }
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(6)),
    child: Text(status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg)),
  );
}

class LeadFolloupHistory extends StatefulWidget {
  const LeadFolloupHistory({Key? key}) : super(key: key);
  @override
  State<LeadFolloupHistory> createState() => _LeadFolloupHistoryState();
}

class _LeadFolloupHistoryState extends State<LeadFolloupHistory> {
  // Replace with real data from controller
  final List<Map<String, String>> _rows = List.generate(
    5,
        (i) => {
      'sno': '${i + 1}',
      'entryDate': 'N/A',
      'remarks': 'N/A',
      'purpose': 'N/A',
      'status': 'N/A',
      'followupDate': 'N/A',
      'followupTime': 'N/A',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: _kBorder,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: _kBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _kBorder)),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: _kTextPrimary, size: 16),
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text('Follow up History',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: _kTextPrimary)),
          Text('All past followup records',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: _kTextSecondary)),
        ]),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          //  Summary chips 
          Row(children: [
            _summaryChip('Total', '${_rows.length}', _kPrimary, _kPrimaryLight),
            const SizedBox(width: 8),
            _summaryChip('Closed', '0', _kGreen, _kGreenLight),
            const SizedBox(width: 8),
            _summaryChip('Pending', '0', _kOrange, _kOrangeLight),
          ]),
          const SizedBox(height: 16),

          //  Table card 
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _kSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _kBorder),
                boxShadow: const [
                  BoxShadow(
                      color: _kCardShadow,
                      blurRadius: 12,
                      offset: Offset(0, 4))
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(children: [

                // Header row
                Container(
                  color: _kPrimaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: _cols
                            .map((c) => SizedBox(
                          width: c.width,
                          child: Text(c.title,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _kPrimary),
                              textAlign: TextAlign.center),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 1, color: _kBorder),

                // Data rows
                Expanded(
                  child: _rows.isEmpty
                      ? _emptyState()
                      : ListView.separated(
                    itemCount: _rows.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: _kBorder),
                    itemBuilder: (ctx, i) {
                      final row = _rows[i];
                      final isEven = i % 2 == 0;
                      return Container(
                        color: isEven ? _kSurface : _kRowAlt,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12),
                            child: Row(children: [
                              _cell(row['sno']!, _cols[0].width,
                                  bold: true, color: _kPrimary),
                              _cell(row['entryDate']!, _cols[1].width),
                              _cell(row['remarks']!, _cols[2].width,
                                  align: TextAlign.left),
                              _cell(row['purpose']!, _cols[3].width),
                              // Status with badge
                              SizedBox(
                                width: _cols[4].width,
                                child: Center(
                                    child: _statusBadge(
                                        row['status']!)),
                              ),
                              _cell(row['followupDate']!, _cols[5].width),
                              _cell(row['followupTime']!, _cols[6].width),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _cell(String text, double width,
      {bool bold = false,
        Color? color,
        TextAlign align = TextAlign.center}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          color: color ?? _kTextSecondary,
        ),
      ),
    );
  }

  Widget _summaryChip(
      String label, String count, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Text(count,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w800, color: fg)),
        const SizedBox(width: 5),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: fg)),
      ]),
    );
  }

  Widget _emptyState() => Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: const [
      Icon(Icons.history_toggle_off_rounded,
          size: 40, color: _kTextSecondary),
      SizedBox(height: 10),
      Text('No followup records',
          style:
          TextStyle(fontSize: 14, color: _kTextSecondary)),
    ]),
  );
}
