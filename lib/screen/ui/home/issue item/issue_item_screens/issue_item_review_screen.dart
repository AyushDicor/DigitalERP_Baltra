import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/app_constant_new.dart';
import '../issue_item_contoller/issue_item_contoller.dart';
import '../issue_item_widgets.dart';

class IssueItemReviewScreen extends StatelessWidget {
  const IssueItemReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueItemEntryController>(builder: (ctrl) {
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            child: Column(children: [

              // ── Header summary ───────────────────────────────────────────
              IssCard(child: Column(children: [
                const IssSectionHead('Issue Summary'),
                _row('Issue No.',     ctrl.issueNo),
                _row('Issue Date',    ctrl.issueDateCtrl.text),
                _row('Issue Type',    ctrl.selectedIssueType?.label ?? '—'),
                _row('Issue To',      ctrl.selectedIssueTo?.label   ?? '—'),
                _row('Issued By',     ctrl.issuedBy),
                _row('Godown',        ctrl.selectedGodown?.label    ?? '—'),
                if (ctrl.billNoCtrl.text.isNotEmpty)
                  _row('Bill No.',    ctrl.billNoCtrl.text),
                if (ctrl.selectedItemIssueType != null)
                  _row('Item Issue Type', ctrl.selectedItemIssueType!.label),
                if (ctrl.remarksCtrl.text.isNotEmpty)
                  _row('Remarks',     ctrl.remarksCtrl.text),
              ])),

              // ── Items ────────────────────────────────────────────────────
              IssCard(
                padding: EdgeInsets.zero,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                    child: IssSectionHead(
                      'Items (${ctrl.itemLines.length})',
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ctrl.itemLines.length,
                    separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: newBorderColor),
                    itemBuilder: (_, i) {
                      final item = ctrl.itemLines[i];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                        child: Row(children: [
                          Container(
                            width: 26, height: 26,
                            decoration: BoxDecoration(
                                color: newBlueLightColor,
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: newBlueColor)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(item.itemName,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: newTextPrimary)),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${item.qty.toStringAsFixed(2)} ${item.unitName}  ·  '
                                        '₹${item.rate.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 11,
                                        color: newTextSecondary),
                                  ),
                                ]),
                          ),
                          Text('₹${item.amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: newBlueColor)),
                        ]),
                      );
                    },
                  ),
                  // Totals
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                        color: newSurfaceColor,
                        border: Border(
                            top: BorderSide(color: newBorderColor))),
                    child: Column(children: [
                      _totalRow('Total Qty',
                          ctrl.totalQty.toStringAsFixed(2)),
                      const SizedBox(height: 6),
                      _totalRow('Total Amount',
                          '₹${ctrl.totalAmount.toStringAsFixed(2)}'),
                      const Divider(height: 16, color: newBorderColor),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Grand Total',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: newTextPrimary)),
                          Text(
                            '₹${ctrl.grandTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: newBlueColor),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ]),
              ),

              // ── Review remarks ───────────────────────────────────────────
              IssCard(child: Column(children: [
                const IssSectionHead('Final Remarks'),
                IssField(
                  label: 'Remarks',
                  controller: ctrl.reviewRemarksCtrl,
                  hint: 'Any final notes before submission…',
                  minLines: 3,
                ),
              ])),
            ]),
          ),
        ),

        // ── Submit button ────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: newBorderColor))),
          child: SafeArea(
            top: false,
            child: ctrl.isBusy
                ? const Center(
                child: CircularProgressIndicator(color: newBlueColor))
                : IssPrimaryBtn(
              label: ctrl.isEditMode
                  ? 'Update Issue Item'
                  : 'Submit Issue Item',
              icon: Icons.check_circle_outline_rounded,
              color: newGreenColor,
              onTap: ctrl.submitIssueItem,
            ),
          ),
        ),
      ]);
    });
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 12, color: newTextSecondary)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
          ),
        ]),
  );

  Widget _totalRow(String l, String v) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l,
            style:
            const TextStyle(fontSize: 12, color: newTextSecondary)),
        Text(v,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: newTextPrimary)),
      ]);
}