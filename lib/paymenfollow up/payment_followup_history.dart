// import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_details_response.dart';
// import 'package:digitalerp/paymenfollow%20up/paymentfollowup%20controller/payment_followup_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar.dart';
// import 'package:digitalerp/utils/show_message.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// class PaymentFollowupHistory extends StatelessWidget {
//   const PaymentFollowupHistory({super.key, required this.followupId }) ;
//   final String followupId;
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PaymentFollowupController>(
//         init: PaymentFollowupController(),
//         builder: (controller) {
//           return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Center(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     top: 0,
//                     left: 0,
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/dashboard_bg.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       child: SafeArea(
//                         child: MyAppBar(
//                           title: 'Payment Follow up History',
//                           onBackTap: () => Get.back(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       right: 0,
//                       left: 0,
//                       bottom: 0,
//                       top: Get.height * 0.200,
//                       child: SingleChildScrollView(
//                         child: Column(
//                             children: [
//                               controller.paymentFollowupDetailsData.isEmpty
//                                   ? const Center(child: CircularProgressIndicator())
//                                   :   paymentFollowCard(controller.paymentFollowupDetailsData[0]),
//                               SizedBox(height: Get.height * 0.010,),
//                               _remark(controller),
//                               SizedBox(height: Get.height * 0.030,),
//                               _dateView(controller, Get.context),
//                               SizedBox(height: Get.height * 0.050,),
//                               submitButton(controller),
//                               SizedBox(height: Get.height * 0.030,),
//                              paymentFollowupHistory(controller),
//
//                             ]),
//                       )
//
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   paymentFollowCard(PaymentFollowupDetailsData
//   data) {
//     return Padding(
//       padding:  const EdgeInsets.all(5.0),
//       child: Column(
//         children: [
//           Card(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             // color: Colors.white,
//             child: Container(
//               width: Get.width,
//               // height: Get.height * 0.270,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 3,
//                         offset: Offset(0, 3))
//                   ]),
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width:Get.width * 0.450,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Party Name",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.partyname ?? 'N/A',
//                                 style: const TextStyle().xstyle
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Entry No.",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.entryno ?? 'N/A',
//                                 style: const TextStyle().xstyle),
//                             const SizedBox(
//                               height: 7,
//                             ),
//                             Text(
//                               "Contact Number",
//                               style: const TextStyle().newstyle,
//                             ),
//                             SizedBox(height: Get.height * 0.00400,),
//                             Row(
//                               children: [
//                                 Text(
//                                   data.contactno ?? 'N/A',
//                                   style: const TextStyle().xstyle,
//                                 ),
//                                 InkWell(
//                                     onTap: (){},
//                                     child:Image.asset('assets/images/whatsapp.png',scale: 22,)
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Total Quantity",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.totalquantity ?? 'N/A',
//                                 style: const TextStyle().xstyle),
//
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width:Get.width * 0.355,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Contact Person",
//                               style: const TextStyle().newstyle,
//                             ),
//                             SizedBox(height: Get.height * 0.00400,),
//                             Text(
//                               data.contactperson ?? 'N/A',
//                               style: const TextStyle().xstyle,
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Entry Date",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.entrydate ?? 'N/A',
//                                 style: const TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "User Name",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.username ?? 'N/A',
//                                 style: const TextStyle().xstyle),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                                 "Balance Amount",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.deepOrange.shade400)),
//                             Text(
//                                 data.balanceamount ?? 'N/A',
//                                 style: const TextStyle().xstyle),
//
//
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
//
//   _remark(PaymentFollowupController controller) {
//     return customTextFieldText(hintText: 'Follow up Remark',
//         controller: controller.followupRemarkController,
//         focusNode: controller.followupRemarkFocusNode);
//   }
//
//   _dateView(PaymentFollowupController controller, context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Follow up date',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
//               SizedBox(width: Get.width * 0.170,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(controller.followupDate,
//                       style: const TextStyle().xstyle.copyWith(fontSize: 16)),
//                   SizedBox(width:Get.width * 0.050),
//                   InkWell(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: AppConst.calenderFirstDate,
//                           lastDate: AppConst.calenderLastDate);
//
//                       if (pickedDate != null) {
//                         String formattedDate =
//                         DateFormat(AppString.yyyyMMdd).format(pickedDate);
//                         controller.selectFollowupDate(formattedDate);
//                       } else {
//                         if (kDebugMode) {
//                           print('Date is not selected');
//                         }
//                       }
//                     },
//                     child: Image.asset(
//                       AppAssets.calendarIcon,
//                       width: 18,
//                       height: 18,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Divider(
//           endIndent: 25,
//           indent: 210,
//           color: Colors.black,
//           thickness: 1,
//         ),
//         SizedBox(height: Get.height * 0.020,),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Next Follow up date',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
//               SizedBox(width: Get.width * 0.100,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(controller.nextFollowupDate,
//                       style: const TextStyle().xstyle.copyWith(fontSize: 16)),
//                   SizedBox(width:Get.width * 0.050),
//                   InkWell(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: AppConst.calenderFirstDate,
//                           lastDate: AppConst.calenderLastDate);
//
//                       if (pickedDate != null) {
//                         String formattedDate =
//                         DateFormat(AppString.yyyyMMdd).format(pickedDate);
//                         controller.selectNextFollowupDate(formattedDate);
//                       } else {
//                         if (kDebugMode) {
//                           print('Date is not selected');
//                         }
//                       }
//                     },
//                     child: Image.asset(
//                       AppAssets.calendarIcon,
//                       width: 18,
//                       height: 18,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Divider(
//           endIndent: 23,
//           indent: 210,
//           color: Colors.black,
//           thickness: 1,
//         )
//       ],
//     );
//   }
//
//   Widget submitButton(PaymentFollowupController controller) {
//     return Container(
//       height: 38,
//       width: 120,
//       decoration: ShapeDecoration(
//         shape: const StadiumBorder(),
//         gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
//       ),
//       child: MaterialButton(
//         onPressed: () {
//           if(controller.followupRemarkController.text.tr.isEmpty){
//             ShowMessage.showSnackBar('', 'Please Type Remark');
//           }
//           else if(controller.followupDate == AppString.ddMMyyyy){
//             ShowMessage.showSnackBar('','Please Select Follow up Date');
//           }
//           else if(controller.nextFollowupDate == AppString.ddMMyyyy){
//             ShowMessage.showSnackBar('','Please Select Next Follow up Date');
//           }
//           else{
//             controller.getPaymentFollowupSaveApi(followupId.toString());
//           }
//           print("Payment Follow ID => $followupId");
//         },
//         shape: const StadiumBorder(),
//         child:
//         Text(
//           'Submit',
//           style: TextStyle(fontSize: 15, color: Colors.white),
//
//         ),
//       ),
//     );
//   }
//
//   Widget paymentFollowupHistory(PaymentFollowupController controller) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Container(
//         color: Colors.grey.shade100,
//         child: Column(
//           children: [
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.,
//               children: [
//                 Container(
//                     height: Get.height * 0.040,
//                     width: Get.height * 0.050,
//                     decoration: BoxDecoration(
//                         color: Colors.white
//                     ),
//                     child: Center(child: Text('S.No', style: TextStyle(
//                         fontSize: 11, fontWeight: FontWeight.bold)
//                     ))),
//                 SizedBox(width: Get.width * 0.020),
//                 Container(
//                     height: Get.height * 0.040,
//                     width: Get.width * 0.260,
//                     color: Colors.white,
//                     child: Center(child: Text('FollowupRemarks', style: TextStyle(
//                         fontSize: 11, fontWeight: FontWeight.bold)))),
//                 SizedBox(width: Get.width * 0.025),
//                 Container(
//                     height: Get.height * 0.040,
//                     width: Get.width * 0.220,
//                     color: Colors.white,
//                     child: Center(child: Text('Followup Date', style: TextStyle(
//                         fontSize: 11, fontWeight: FontWeight.bold)))),
//                 SizedBox(width: Get.width * 0.030),
//                 Container(
//                     height: Get.height * 0.040,
//                     width: Get.width * 0.275,
//                     color: Colors.white,
//                     child: Center(child: Text('NextFollowup Date', style: TextStyle(
//                         fontSize: 11, fontWeight: FontWeight.bold)))),
//                 SizedBox(width: Get.width * 0.005),
//
//               ],
//             ),
//             if(controller.paymentFollowupDetailsData.isNotEmpty)
//             ListView.builder(
//               padding: const EdgeInsets.only(top: 10),
//               // scrollDirection: Axis.vertical,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.paymentFollowupDetailsData.first.paymenthistory?.length??0,
//               itemBuilder: (context, index) {
//                 return historyDetails(controller.paymentFollowupDetailsData.first.paymenthistory![index]);
//               },
//
//             )
//             else
//               SizedBox()
//           ],
//         ),
//       ),
//
//
//     );
//   }
//
//   Widget historyDetails ( PaymentHistory data ){
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 // height: Get.height * 0.040,
//                 width: Get.height * 0.050,
//                 decoration: BoxDecoration(
//                     color: Colors.white
//                 ),
//                 child: Center(child: Text(
//                      data.sno ??'N/A',
//                     style: TextStyle(fontSize: 11,)
//                 ))),
//             SizedBox(width: Get.width * 0.010),
//             Container(
//                 // height: Get.height * 0.040,
//                 width: Get.width * 0.260,
//                 color: Colors.white,
//                 child: Center(
//                   child: Text(
//
//                     data.followupremarks??'N/A',
//                     style: TextStyle(fontSize: 11,),
//                   ),
//                 )),
//             SizedBox(width: Get.width * 0.010),
//             Container(
//                 // height: Get.height * 0.040,
//                 width: Get.width * 0.220,
//                 color: Colors.white,
//                 child: Center(child: Text(
//                     data.followupdate??'N/A',
//                     style: TextStyle(fontSize: 11,)))),
//             SizedBox(width: Get.width * 0.010),
//             Container(
//                 // height: Get.height * 0.040,
//                 width: Get.width * 0.275,
//                 color: Colors.white,
//                 child: Center(child: Text(
//                     data.nextfollowupdate??'N/A',
//                     style: TextStyle(fontSize: 11,)))),
//
//
//
//           ],
//         ),
//         Divider(
//           height: 10,
//           color: Colors.black,
//         )
//       ],
//     );
//   }
// }


import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_details_response.dart';
import 'package:digitalerp/paymenfollow%20up/paymentfollowup%20controller/payment_followup_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentFollowupHistory extends StatelessWidget {
  const PaymentFollowupHistory({super.key, required this.followupId});
  final String followupId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentFollowupController>(
      init: PaymentFollowupController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6FB),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              'Payment Follow up History',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          body: controller.paymentFollowupDetailsData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Detail Card
                _detailCard(controller.paymentFollowupDetailsData[0]),
                const SizedBox(height: 16),

                // Remark Field
                _sectionLabel('Follow up Remark'),
                const SizedBox(height: 8),
                _remarkField(controller),
                const SizedBox(height: 16),

                // Follow up Date
                _sectionLabel('Follow up Date'),
                const SizedBox(height: 8),
                _dateField(
                  value: controller.followupDate,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: AppConst.calenderFirstDate,
                      lastDate: AppConst.calenderLastDate,
                    );
                    if (pickedDate != null) {
                      controller.selectFollowupDate(
                        DateFormat(AppString.yyyyMMdd).format(pickedDate),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Next Follow up Date
                _sectionLabel('Next Follow up Date'),
                const SizedBox(height: 8),
                _dateField(
                  value: controller.nextFollowupDate,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: AppConst.calenderFirstDate,
                      lastDate: AppConst.calenderLastDate,
                    );
                    if (pickedDate != null) {
                      controller.selectNextFollowupDate(
                        DateFormat(AppString.yyyyMMdd).format(pickedDate),
                      );
                    }
                  },
                ),
                const SizedBox(height: 28),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.followupRemarkController.text.tr.isEmpty) {
                        ShowMessage.showSnackBar('', 'Please Type Remark');
                      } else if (controller.followupDate == AppString.ddMMyyyy) {
                        ShowMessage.showSnackBar('', 'Please Select Follow up Date');
                      } else if (controller.nextFollowupDate == AppString.ddMMyyyy) {
                        ShowMessage.showSnackBar('', 'Please Select Next Follow up Date');
                      } else {
                        controller.getPaymentFollowupSaveApi(followupId.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Follow up History Table
                _sectionLabel('Follow up History'),
                const SizedBox(height: 12),
                _historyTable(controller),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _detailCard(PaymentFollowupDetailsData data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Party Name
          Text('Party Name', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(height: 2),
          Text(
            data.partyname ?? 'N/A',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 14),

          // Info tiles grid
          Row(
            children: [
              Expanded(child: _infoBox('Contact No.', data.contactno ?? 'N/A')),
              const SizedBox(width: 10),
              Expanded(child: _infoBox('Contact Person', data.contactperson ?? 'N/A')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _infoBox('Email ID', data.username ?? 'N/A')),
              const SizedBox(width: 10),
              Expanded(child: _infoBox('Last Order Date', data.entrydate ?? 'N/A')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: purpleColor, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _remarkField(PaymentFollowupController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller.followupRemarkController,
        focusNode: controller.followupRemarkFocusNode,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Enter follow up remark...',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(14),
        ),
      ),
    );
  }

  Widget _dateField({required String value, required VoidCallback onTap}) {
    final bool isPlaceholder = value == AppString.ddMMyyyy;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: isPlaceholder ? Colors.grey.shade400 : Colors.black87,
                fontWeight: isPlaceholder ? FontWeight.normal : FontWeight.w600,
              ),
            ),
            Icon(Icons.calendar_today_outlined, color: Colors.grey.shade500, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _historyTable(PaymentFollowupController controller) {
    final history = controller.paymentFollowupDetailsData.isNotEmpty
        ? controller.paymentFollowupDetailsData.first.paymenthistory ?? []
        : [];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: purpleLightest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                _tableHeader('S.No', flex: 1),
                _tableHeader('Remarks', flex: 3),
                _tableHeader('Followup Date', flex: 3),
                _tableHeader('Next Date', flex: 3),
              ],
            ),
          ),

          // Table Rows
          if (history.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('No history available', style: TextStyle(color: Colors.grey)),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: history.length,
              separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey.shade100),
              itemBuilder: (context, index) => _tableRow(history[index]),
            ),
        ],
      ),
    );
  }

  Widget _tableHeader(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: purpleColor,
        ),
      ),
    );
  }

  Widget _tableRow(PaymentHistory data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.sno ?? 'N/A',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data.followupremarks ?? 'N/A',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: purpleColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data.followupdate ?? 'N/A',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              data.nextfollowupdate ?? 'N/A',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}