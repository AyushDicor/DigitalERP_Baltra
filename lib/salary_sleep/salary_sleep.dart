// import 'dart:developer';
//
// import 'package:digitalerp/salary_sleep/salary_sleep_controller/salary_sleep_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/items.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class SalarySleep extends StatefulWidget {
//   const SalarySleep({Key? key}) : super(key: key);
//
//   @override
//   State<SalarySleep> createState() => _SalarySleepState();
// }
//
// class _SalarySleepState extends State<SalarySleep> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SalarySleepController>(
//         init: SalarySleepController(),
//         builder: (controller){
//       return  Scaffold(
//         body: Center(
//           child: Stack(
//             children: [
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/dashboard_bg.png'),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   child: SafeArea(
//                     child: MyAppBar(
//                       title: 'Salary Sleep',
//                       onBackTap: () => Get.back(),
//                       showApprovalIcon: false,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: Get.height * 0.150,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: [
//                       controller.isBusy
//                           ? Center(child: SizedBox(
//                           height: MediaQuery.of(context).size.height*0.4,
//                           child: showLoader()))
//                           :  controller.salarySleepData.isEmpty|| controller.salarySleepData==null
//                           ? centerText("No Data Found")
//                           : ListView.builder(
//                           shrinkWrap: true,
//                           padding: EdgeInsets.zero,
//                           physics:  const NeverScrollableScrollPhysics(),
//                           itemCount:controller.salarySleepData.length,
//                           itemBuilder: (context,index)=> performanceView(controller,index)
//                       )
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget performanceView( SalarySleepController controller,int index){
//     var data= controller.salarySleepData[index];
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
//             padding: EdgeInsets.only(top: 5, left: 5),
//             child: Column(
//               children: [
//                 CommonItem(
//                   data: [
//                     CommonItemRowModel(
//                       leftTitle: "Month",
//                       leftValue: data.month??"N/A",
//                       rightTitle: "Total Payable",
//                       rightValue:data.netsalary??"N/A",
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(right: 15,bottom: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text('PDF',style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                       ),),
//                       InkWell(
//                         onTap: () async {
//                           final link = data.urlname.toString();
//                           log("Link = $link");
//                           launchUrl(Uri.parse(link),mode: LaunchMode.externalApplication);
//                         },
//                         child: Image(
//                           image: const AssetImage('assets/images/pdf.png'),
//                           height: Get.height * 0.0310,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//old code commented
import 'dart:developer';
import 'package:digitalerp/salary_sleep/salary_sleep_controller/salary_sleep_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_constant_new.dart';

class SalarySleep extends StatefulWidget {
  const SalarySleep({Key? key}) : super(key: key);
  @override
  State<SalarySleep> createState() => _SalarySleepState();
}

class _SalarySleepState extends State<SalarySleep> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalarySleepController>(
      init: SalarySleepController(),
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
          title: const Text('Salary Slip',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ),
        body: controller.isBusy
            ? showLoader(color: newBlueColor)
            : (controller.salarySleepData.isEmpty)
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color(0xFFEEF0FF),
                          borderRadius: BorderRadius.circular(40)),
                      child: const Icon(Icons.receipt_outlined,
                          size: 38, color: Color(0xFF5B5FC7)),
                    ),
                    const SizedBox(height: 16),
                    const Text('No Salary Slips',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: newTextPrimary)),
                    const SizedBox(height: 6),
                    const Text('No data found.',
                        style:
                            TextStyle(fontSize: 13, color: newTextSecondary)),
                  ]))
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: controller.salarySleepData.length,
                    itemBuilder: (ctx, i) => _salaryCard(controller, i),
                  ),
        floatingActionButton: MenuFab(parentMenuId: 2383),
      ),
    );
  }

  Widget _salaryCard(SalarySleepController controller, int index) {
    final data = controller.salarySleepData[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        // Month icon
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF0FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.calendar_today_outlined,
              color: Color(0xFF5B5FC7), size: 22),
        ),
        const SizedBox(width: 14),
        // Month + amount
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Month',
              style: TextStyle(
                  fontSize: 11,
                  color: newTextSecondary,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 2),
          Text(data.month ?? 'N/A',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary)),
        ])),
        // Net salary
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Text('Net Payable',
              style: TextStyle(
                  fontSize: 11,
                  color: newTextSecondary,
                  fontWeight: FontWeight.w400)),
          const SizedBox(height: 2),
          Text('₹${data.netsalary ?? 'N/A'}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF27AE60))),
        ]),
        const SizedBox(width: 14),
        // PDF button
        GestureDetector(
          onTap: () async {
            final link = data.urlname.toString();
            log('Link = $link');
            launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECEA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/pdf.png'),
            ),
          ),
        ),
      ]),
    );
  }
}
