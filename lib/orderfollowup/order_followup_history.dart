import 'package:digitalerp/orderfollowup/orderFollowupController/order_followup_controller.dart';
import 'package:digitalerp/orderfollowup/order_followup_details_response.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/show_message.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
//  Design tokens
const Color _kBg = Color(0xFFF5F6FA);
const Color _kWhite = Colors.white;
const Color _kBlue = purpleColor;
final Color _kBlueBg = purpleLightest;
const Color _kBorder = Color(0xFFE2E8F0);
const Color _kTextPrimary = Color(0xFF0F172A);
const Color _kTextSub = Color(0xFF64748B);
const Color _kTextHint = Color(0xFF94A3B8);
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

Widget _sectionLabel(String label) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: _kTextPrimary)),
    );

Widget _datePicker({
  required BuildContext context,
  required String value,
  required VoidCallback onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
            color: _kWhite,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: _kBorder)),
        child: Row(children: [
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 13, color: _kTextPrimary)),
          ),
          const Icon(Icons.calendar_today_outlined, size: 15, color: _kTextSub),
        ]),
      ),
    );

class OrderFollowupHistory extends StatelessWidget {
  final String followupId;
  const OrderFollowupHistory({super.key, required this.followupId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderFollowupController>(
      init: OrderFollowupController(),
      builder: (controller) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Column(children: [
            _appBar('Order Follow up History'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detail card
                      controller.orderFollowupDetailsData.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(color: _kBlue))
                          : _detailCard(controller.orderFollowupDetailsData[0]),

                      const SizedBox(height: 16),

                      // Remark field
                      _sectionLabel('Follow up Remark'),
                      Container(
                        decoration: BoxDecoration(
                            color: _kWhite,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: _kBorder)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        child: TextFormField(
                          controller: controller.followupRemarkController,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14, color: _kTextPrimary),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter follow up remark...',
                            hintStyle:
                                TextStyle(color: _kTextHint, fontSize: 14),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Date pickers
                      _sectionLabel('Follow up Date'),
                      _datePicker(
                        context: context,
                        value: controller.followupDate,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: AppConst.calenderFirstDate,
                            lastDate: AppConst.calenderLastDate,
                            builder: (ctx, child) => Theme(
                              data: Theme.of(ctx).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: _kBlue, onPrimary: Colors.white),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) {
                            controller.selectFollowupDate(
                                DateFormat(AppString.yyyyMMdd).format(picked));
                          }
                        },
                      ),

                      const SizedBox(height: 14),

                      _sectionLabel('Next Follow up Date'),
                      _datePicker(
                        context: context,
                        value: controller.nextFollowupDate,
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: AppConst.calenderFirstDate,
                            lastDate: AppConst.calenderLastDate,
                            builder: (ctx, child) => Theme(
                              data: Theme.of(ctx).copyWith(
                                colorScheme: const ColorScheme.light(
                                    primary: _kBlue, onPrimary: Colors.white),
                              ),
                              child: child!,
                            ),
                          );
                          if (picked != null) {
                            controller.selectNextFollowupDate(
                                DateFormat(AppString.yyyyMMdd).format(picked));
                          }
                        },
                      ),

                      const SizedBox(height: 24),

                      // Submit button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.followupRemarkController.text
                                .trim()
                                .isEmpty) {
                              ShowMessage.showSnackBar(
                                  '', 'Please Type Remark');
                            } else if (controller.followupDate ==
                                AppString.ddMMyyyy) {
                              ShowMessage.showSnackBar(
                                  '', 'Please Select Follow up Date');
                            } else if (controller.nextFollowupDate ==
                                AppString.ddMMyyyy) {
                              ShowMessage.showSnackBar(
                                  '', 'Please Select Next Follow up Date');
                            } else {
                              controller
                                  .getOrderFollowupSaveResponse(followupId);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _kBlue,
                            foregroundColor: _kWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // History table
                      if (controller.orderFollowupDetailsData.isNotEmpty) ...[
                        _sectionLabel('Follow up History'),
                        _historyTable(controller),
                      ],
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _detailCard(OrderFollowupDetailsData data) {
    return Container(
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
      child: Column(children: [
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
                        color: _kTextPrimary,
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
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          child: Row(children: [
            _infoBox('Contact No.', data.contactno ?? 'N/A'),
            const SizedBox(width: 10),
            _infoBox('Contact Person', data.contactperson ?? 'N/A'),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
          child: Row(children: [
            _infoBox('Email ID', data.emailid ?? 'N/A'),
            const SizedBox(width: 10),
            _infoBox('Last Order Date', data.lastorderdate ?? 'N/A'),
          ]),
        ),
      ]),
    );
  }

  Widget _historyTable(OrderFollowupController controller) {
    final history =
        controller.orderFollowupDetailsData.first.orderhistory ?? [];
    return Container(
      decoration: BoxDecoration(
          color: _kWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder)),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(_kBlueBg),
          headingTextStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: _kBlue),
          dataTextStyle: const TextStyle(fontSize: 12, color: _kTextSub),
          columnSpacing: 20,
          horizontalMargin: 16,
          dividerThickness: 1,
          columns: const [
            DataColumn(label: Text('S.No')),
            DataColumn(label: Text('Followup Remarks')),
            DataColumn(label: Text('Followup Date')),
            DataColumn(label: Text('Next Followup Date')),
          ],
          rows: history
              .map((d) => DataRow(cells: [
                    DataCell(Text(d.sno ?? 'N/A',
                        style: const TextStyle(color: _kTextPrimary))),
                    DataCell(Text(d.followupremarks ?? 'N/A')),
                    DataCell(Text(d.followupdate ?? 'N/A')),
                    DataCell(Text(d.nextfollowupdate ?? 'N/A')),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
