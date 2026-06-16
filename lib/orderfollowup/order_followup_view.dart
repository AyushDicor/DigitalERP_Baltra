import 'package:digitalerp/orderfollowup/orderFollowupController/order_followup_controller.dart';
import 'package:digitalerp/orderfollowup/order_followup_filter_screen.dart';
import 'package:digitalerp/orderfollowup/order_followup_history.dart';
import 'package:digitalerp/orderfollowup/orderfollowup_list_response.dart';
import 'package:digitalerp/screen/base/base_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screen/ui/fab/menu_fab.dart';

//  Design tokens
const Color _kWhite = Colors.white;
const Color _kBlue = purpleColor;
final Color _kBlueBg = purpleLightest;
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub = Color(0xFF64748B);
const Color _kDivider = Color(0xFFEFF2F7);
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
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _kTextPrimary)),
      ),
      if (onFilter != null)
        GestureDetector(
          onTap: onFilter,
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: _kBlueBg, borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.filter_list_sharp, color: _kBlue, size: 20),
          ),
        ),
    ]),
  );
}

Widget _infoBox(String label, String value) => Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: _kBlueBg,
          borderRadius: BorderRadius.circular(8),
          border: const Border(left: BorderSide(color: _kBlue, width: 3)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 11, color: _kTextSub)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _kTextPrimary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );

Widget _miniField(String label, String value) => Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 10, color: _kTextSub)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _kTextPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ]),
    );

Widget _vDivider() => Container(
    width: 1,
    height: 32,
    color: _kBorder,
    margin: const EdgeInsets.symmetric(horizontal: 8));


class OrderFollowupView extends StatelessWidget {
  const OrderFollowupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderFollowupController>(
      init: OrderFollowupController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar('Order Follow up',
                onFilter: () => Get.dialog(OrderFollowupFilterScreen())),
            Expanded(
              child: controller.isBusy
                  ? showLoader(color: _kBlue)
                  : (controller.orderFollowupListData?.isEmpty ?? true)
                      ? SizedBox(
                          height: Get.height * .4,
                          child: centerText('No Data Available'))
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          itemCount: controller.orderFollowupListData.length,
                          itemBuilder: (context, index) => _followupCard(
                            controller.orderFollowupListData.elementAt(index),
                            controller,
                          ),
                        ),
            ),
          ]),
        ),
        floatingActionButton: MenuFab(parentMenuId: 2387),
      ),
    );
  }

  Widget _followupCard(
      OrderFollowupListData data, OrderFollowupController controller) {
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
        //  Header: Party Name
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
          child: Row(
            children: [
              Expanded( // ✅ IMPORTANT
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Party Name',
                      style: TextStyle(fontSize: 11, color: _kTextSub),
                    ),
                    const SizedBox(height: 2),

                    Text(
                      data.partyname ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary,
                      ),
                      maxLines: 2, // ✅ prevents overflow
                      overflow: TextOverflow.ellipsis, // ✅ clean cut
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1, color: _kDivider),

        //  Contact No + WhatsApp + Call | Contact Name
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: Row(children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: purpleLightest,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      const Border(left: BorderSide(color: _kBlue, width: 3)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contact Number',
                          style: TextStyle(fontSize: 11, color: _kTextSub)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Expanded(
                          child: Text(data.contactno ?? 'N/A',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: newTextPrimary)),
                        ),
                        const SizedBox(width: 6),
                        // WhatsApp
                        GestureDetector(
                          onTap: () => _launchWhatsapp(data.contactno ?? ''),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: newGreenLightColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.chat,
                                color: newGreenColor, size: 15),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Call
                        GestureDetector(
                          onTap: () => _openDialPad(data.contactno ?? ''),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                                color: purpleLightest,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(Icons.phone,
                                color: purpleColor, size: 15),
                          ),
                        ),
                      ]),
                    ]),
              ),
            ),
            const SizedBox(width: 10),
            _infoBox('Contact Name', data.contactperson ?? 'N/A'),
          ]),
        ),

        //  Country | City | State | Last Order Date
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
          child: Row(children: [
            _miniField('Country', data.country ?? 'N/A'),
            _vDivider(),
            _miniField('City', data.city ?? 'N/A'),
            _vDivider(),
            _miniField('State', data.state ?? 'N/A'),
            _vDivider(),
            _miniField('Last Order Date', data.lastorderdate ?? 'N/A'),
          ]),
        ),

        //  Email | Follow up button
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 12, 12),
          child: Row(children: [
            const Icon(Icons.email_outlined, size: 13, color: _kTextSub),
            const SizedBox(width: 5),
            Expanded(
              child: Text(data.emailid ?? 'N/A',
                  style: const TextStyle(fontSize: 12, color: _kTextSub),
                  overflow: TextOverflow.ellipsis),
            ),
            GestureDetector(
              onTap: () {
                Get.to(OrderFollowupHistory(
                    followupId: data.followupid.toString()));
                controller.getOrderFollowupDetailsResponse(
                    data.followupid.toString());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    color: _kBlue, borderRadius: BorderRadius.circular(10)),
                child: const Text('Follow up',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _kWhite)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  void _launchWhatsapp(String number) async {
    final uri = Uri.parse('whatsapp://send?phone=$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ShowMessage.showSnackBar('', 'WhatsApp not installed');
    }
  }

  void _openDialPad(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
