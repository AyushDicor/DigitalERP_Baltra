// import 'package:digitalerp/paymenfollow%20up/payment_followup_filter_screen.dart';
// import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_list_response.dart';
// import 'package:digitalerp/paymenfollow%20up/paymentfollowup%20controller/payment_followup_controller.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'payment_followup_history.dart';
//
// class PaymentFollowupView extends StatefulWidget {
//   const PaymentFollowupView({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentFollowupView> createState() => _PaymentFollowupViewState();
// }
//
// class _PaymentFollowupViewState extends State<PaymentFollowupView> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<PaymentFollowupController>(
//         init: PaymentFollowupController(),
//         builder: (controller){
//       return Scaffold(
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
//                       title: 'Payment Follow up',
//                       onFilterTap: ()=>Get.dialog(PaymentFollowupFilterScreen()),
//                       onBackTap: () => Get.back(),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 0,
//                   top: Get.height * 0.200,
//                   child: SingleChildScrollView(
//                     child: Column(
//                         children: [
//                           controller.isListLoading
//                           ? showLoader()
//                           : controller.paymentFollowupListData.isEmpty
//                           ? SizedBox(child: centerText(' Data Not Available'),)
//                           :ListView.builder(
//                               shrinkWrap: true,
//                               padding: EdgeInsets.zero,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: controller.paymentFollowupListData.length,
//                               itemBuilder: (context, index) =>
//                                   paymentFollowCard(controller.paymentFollowupListData.elementAt(index),controller)
//
//                           ),
//                         ]),
//                   )
//
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//   paymentFollowCard(PaymentFollowupListData data, PaymentFollowupController controller) {
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
//                                 style: TextStyle().xstyle
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
//                                    data.contactno ?? 'N/A',
//                                   style: const TextStyle().xstyle,
//                                 ),
//                                 SizedBox(width: 5,),
//                                 InkWell(
//                                     onTap: (){
//                                       _launchWhatsapp(data.contactno.toString());
//                                     },
//                                     child:Image.asset('assets/images/whatsapp.png',scale: 19,)
//                                 ),
//                                 SizedBox(width: 10,),
//                                 InkWell(
//                                     onTap: (){
//                                       openDialPad(data.contactno.toString());
//                                     },
//                                     child:Image.asset('assets/images/call-icon.png',scale: 27,)
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
//                                data.totalquantity ?? 'N/A',
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
//                              data.contactperson ?? 'N/A',
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
//                                data.entrydate ?? 'N/A',
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
//                                data.username ?? 'N/A',
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
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           left: 255,
//                           top: 10,
//                         ),
//
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: Get.height * 0.00600,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding:  EdgeInsets.only(right: 20),
//                 child: Container(
//                   height: 33,
//                   // width: 120,
//                   decoration: ShapeDecoration(
//                     shape: const StadiumBorder(),
//                     gradient: customGradient(topColor: orangeColor, bottomColor: red2Color),
//                   ),
//                   child: MaterialButton(
//                     onPressed: (){
//                       Get.to( PaymentFollowupHistory(followupId: data.followupid.toString(),));
//                       controller.getPaymentFollowupDetailsApi(data.followupid.toString());
//
//                     },
//                     shape: const StadiumBorder(),
//                     child:  Text(
//                       'Follow up',
//                       style:  TextStyle(fontSize: 15,color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: Get.height * 0.0100,),
//
//         ],
//       ),
//     );
//   }
//
//
//   _launchWhatsapp(String whatsappNumber) async {
//     var whatsapp = whatsappNumber;
//     var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp");
//     if (await canLaunchUrl(whatsappAndroid)) {
//       await launchUrl(whatsappAndroid);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("WhatsApp is not installed on the device"),
//         ),
//       );
//     }
//   }
//
//   openDialPad(String phoneNumber) async {
//     Uri url = Uri(scheme: "tel", path: phoneNumber);
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       print("Can't open dial pad.");
//     }
//   }
//
// }

import 'package:digitalerp/paymenfollow%20up/payment_followup_filter_screen.dart';
import 'package:digitalerp/paymenfollow%20up/payment_followup_response/payment_followup_list_response.dart';
import 'package:digitalerp/paymenfollow%20up/paymentfollowup%20controller/payment_followup_controller.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screen/ui/fab/menu_fab.dart';
import 'payment_followup_history.dart';

class PaymentFollowupView extends StatefulWidget {
  const PaymentFollowupView({Key? key}) : super(key: key);

  @override
  State<PaymentFollowupView> createState() => _PaymentFollowupViewState();
}

class _PaymentFollowupViewState extends State<PaymentFollowupView> {
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
              'Payment Follow up',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => Get.dialog(PaymentFollowupFilterScreen()),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: purpleLightest, borderRadius: BorderRadius.circular(18)),
                  child: const Icon(Icons.filter_list_sharp, color: purpleColor, size: 20),
                ),
              ),
            ],
          ),
          body: controller.isListLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.paymentFollowupListData.isEmpty
                  ? Center(
                      child: Text(
                        'Data Not Available',
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      itemCount: controller.paymentFollowupListData.length,
                      itemBuilder: (context, index) => _paymentFollowCard(
                        controller.paymentFollowupListData.elementAt(index),
                        controller,
                      ),
                    ),
          floatingActionButton: MenuFab(parentMenuId: 2387),
        );
      },
    );
  }

  Widget _paymentFollowCard(
      PaymentFollowupListData data, PaymentFollowupController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Party Name header
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.business,
                      color: purpleColor, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Party Name',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500),
                      ),
                      Text(
                        data.partyname ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 14),

            // Info Grid
            Row(
              children: [
                Expanded(
                  child: _infoTile('Entry No.', data.entryno ?? 'N/A'),
                ),
                Expanded(
                  child: _infoTile('Entry Date', data.entrydate ?? 'N/A'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child:
                      _infoTile('Contact Person', data.contactperson ?? 'N/A'),
                ),
                Expanded(
                  child: _infoTile('User Name', data.username ?? 'N/A'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child:
                      _infoTile('Total Quantity', data.totalquantity ?? 'N/A'),
                ),
                Expanded(
                  child:
                      _infoTile('Balance Amount', data.balanceamount ?? 'N/A'),
                ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 14),

            // Contact row + Follow up button
            Row(
              children: [
                // Contact number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Number',
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade500),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            data.contactno ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () =>
                                _launchWhatsapp(data.contactno.toString()),
                            child: Image.asset(
                              'assets/images/whatsapp.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => openDialPad(data.contactno.toString()),
                            child: Image.asset(
                              'assets/images/call-icon.png',
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Follow up button
                ElevatedButton(
                  onPressed: () {
                    Get.to(PaymentFollowupHistory(
                        followupId: data.followupid.toString()));
                    controller.getPaymentFollowupDetailsApi(
                        data.followupid.toString());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Follow up',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  _launchWhatsapp(String whatsappNumber) async {
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsappNumber");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("WhatsApp is not installed on the device")),
      );
    }
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
