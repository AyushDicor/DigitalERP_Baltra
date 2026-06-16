import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../approval_hub_controller/approval_hub_controller.dart';
import 'approval_hub_dashboard.dart';
import 'approval_hub_list.dart';

class ApprovalHubAction extends StatelessWidget {
  const ApprovalHubAction({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(builder: (ctrl) {
      final isReimbursement = ctrl.currentItem?.approvalType
              ?.toLowerCase()
              .contains('reimbursement') ??
          false;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            _AppBar(ctrl: ctrl),
            Expanded(
              child: ctrl.actionSuccess
                  ? _SuccessView(ctrl: ctrl)
                  : SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: 14,
                        right: 14,
                        top: 12,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                      ),
                      child: Column(children: [
                        _ItemSummary(ctrl: ctrl),
                        if (!isReimbursement) _QuickActionsCard(ctrl: ctrl),
                        ReimbursementItemsCard(ctrl: ctrl),
                        _RemarkCard(ctrl: ctrl),
                        if (!isReimbursement) _PartialCard(ctrl: ctrl),
                      ]),
                    ),
            ),
            if (!ctrl.actionSuccess) _BottomBar(ctrl: ctrl),
          ]),
        ),
      );
    });
  }
}

class ReimbursementItemsCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const ReimbursementItemsCard({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    // Guard: only render for Reimbursement approval type
    final type = ctrl.currentItem?.approvalType ?? '';
    if (!type.toLowerCase().contains('reimbursement')) return const SizedBox();

    final items = ctrl.approvalReimbursementItems;
    if (items.isEmpty) return const SizedBox();

    return _RCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _RSecHead('REIMBURSEMENT ITEMS'),
          ...items.map((item) => _LineItemTile(item: item, ctrl: ctrl)),
          const Divider(color: newBorderColor, height: 1),
          const SizedBox(height: 10),
          _TotalRow(ctrl: ctrl),
        ],
      ),
    );
  }
}

class _LineItemTile extends StatefulWidget {
  final ApprovalReimbursementItem item;
  final ApprovalHubController ctrl;
  const _LineItemTile({required this.item, required this.ctrl});

  @override
  State<_LineItemTile> createState() => _LineItemTileState();
}

class _LineItemTileState extends State<_LineItemTile> {
  late final TextEditingController _amtCtrl;

  @override
  void initState() {
    super.initState();
    _amtCtrl = TextEditingController(
      text: widget.item.processAmount.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    _amtCtrl.dispose();
    super.dispose();
  }

  Color _statusColor(ApprovalItemStatus s) {
    switch (s) {
      case ApprovalItemStatus.approve:
        return newGreenColor;
      case ApprovalItemStatus.reject:
        return newRedColor;
      case ApprovalItemStatus.onHold:
        return const Color(0xFFF59E0B);
      case ApprovalItemStatus.pending:
        return newTextSecondary;
      case ApprovalItemStatus.verify: // ← ADD
        return const Color(0xFF0EA5E9); // blue
    }
  }

  Color _statusBg(ApprovalItemStatus s) {
    switch (s) {
      case ApprovalItemStatus.approve:
        return newGreenLightColor;
      case ApprovalItemStatus.reject:
        return const Color(0xFFFFEDED);
      case ApprovalItemStatus.onHold:
        return const Color(0xFFFEF3C7);
      case ApprovalItemStatus.pending:
        return newSurfaceColor;
      case ApprovalItemStatus.verify: // ← ADD
        return const Color(0xFFE0F2FE); // light blue
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Header: SNO + category + live status chip
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: newBlueLightColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${item.sno}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.expenseCategory,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      item.reimbursementType,
                      style: const TextStyle(
                          fontSize: 10, color: newTextSecondary),
                    ),
                  ],
                ),
              ),
              // Live status chip — updates as dropdown changes
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _statusBg(item.status),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.status.label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: _statusColor(item.status),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //  Description
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: newBorderColor),
            ),
            child: Text(
              item.description,
              style: const TextStyle(fontSize: 11, color: newTextPrimary),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 8),

          //  Request amt (read-only) + Process amt (editable)
          Row(
            children: [
              Expanded(
                child: _LabeledBox(
                  label: 'Request Amt',
                  child: Text(
                    '₹${item.requestAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LabeledBox(
                      label: 'Process Amt',
                      highlightBorder: true,
                      child: TextFormField(
                        controller: _amtCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: newBlueColor,
                        ),
                        decoration: const InputDecoration(
                          prefixText: '₹',
                          prefixStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: newBlueColor,
                          ),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (val) {
                          final entered = double.tryParse(val.trim()) ?? 0.0;
                          // ✅ Cap at requestAmount — cannot exceed what was asked
                          final capped = entered > item.requestAmount
                              ? item.requestAmount
                              : entered;
                          if (capped != entered) {
                            // Correct the field text if user typed more than allowed
                            _amtCtrl.text = capped.toStringAsFixed(0);
                            _amtCtrl.selection = TextSelection.collapsed(
                              offset: _amtCtrl.text.length,
                            );
                          }
                          item.processAmount = capped;
                          widget.ctrl.update(); // recompute total in _TotalRow
                        },
                      ),
                    ),
                    // ✅ Live hint showing the max allowed
                    Padding(
                      padding: const EdgeInsets.only(top: 3, left: 2),
                      child: Text(
                        'Max ₹${item.requestAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 8,
                          color: newTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          //  Files + Status dropdown
          Row(
            children: [
              _FileIconBtn(
                label: 'Ref File',
                url: item.referenceFileUrl,
                icon: Icons.file_present_rounded,
                color: newBlueColor,
              ),
              const SizedBox(width: 8),
              // _FileIconBtn(
              //   label: 'Receipt',
              //   url: item.receiptFileUrl,
              //   icon: Icons.receipt_long_rounded,
              //   color: newGreenColor,
              // ),
              const Spacer(),
              _StatusDropdown(
                current: item.status,
                statusColor: _statusColor,
                allowedStatuses:
                    widget.ctrl.allowedItemStatuses, // ← pass from controller
                onChanged: (s) {
                  setState(() => item.status = s);
                  widget.ctrl.update();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//  File icon button

class _FileIcon extends StatelessWidget {
  final String label;
  final String? url;
  final IconData icon;
  final Color color;
  const _FileIcon({
    required this.label,
    required this.url,
    required this.icon,
    required this.color,
  });

  Future<void> _open() async {
    if (url == null || url!.isEmpty) return;
    final uri = Uri.parse(url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = url != null && url!.isNotEmpty;
    return GestureDetector(
      onTap: hasFile ? _open : null,
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: hasFile ? color.withValues(alpha: 0.1) : newSurfaceColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasFile ? color.withValues(alpha: 0.4) : newBorderColor,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 16,
              color: hasFile ? color : newTextHint,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              color: hasFile ? color : newTextHint,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

//  Total row

//  App bar
class _AppBar extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _AppBar({required this.ctrl});
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Row(children: [
          GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: newTextPrimary))),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('Take Action',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary)),
                Text(ctrl.currentItem?.documentNo ?? '',
                    style:
                        const TextStyle(fontSize: 11, color: newTextSecondary)),
              ])),
        ]),
      );
}

//  Item summary card
class _ItemSummary extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _ItemSummary({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final item = ctrl.currentItem;
    if (item == null) return const SizedBox();

    final isReimbursement =
        item.approvalType?.toLowerCase().contains('reimbursement') ?? false;

    // ✅ For reimbursement: sum of all processAmounts (live); else use item.amount
    final displayAmount = isReimbursement
        ? ctrl.approvalReimbursementItems
            .fold<double>(0.0, (sum, i) => sum + i.processAmount)
        : (item.amount ?? 0).toDouble();

    final requestedAmount = isReimbursement
        ? ctrl.approvalReimbursementItems
            .fold<double>(0.0, (sum, i) => sum + i.requestAmount)
        : (item.amount ?? 0).toDouble();

    final amountColor = ctrl.catColor(item.approvalType);

    return _Card(
      child: Row(children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: ctrl.catLightColor(item.approvalType),
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: Text(ctrl.catEmoji(item.approvalType),
              style: const TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.approvalType ?? ''} — ${item.documentNo ?? ''}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary,
                ),
              ),
              Text(
                item.siteName ?? item.requestedBy ?? '',
                style: const TextStyle(fontSize: 11, color: newTextSecondary),
              ),
            ],
          ),
        ),
        // ✅ Dynamic amount column
        if (displayAmount > 0 || isReimbursement)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${displayAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: amountColor,
                ),
              ),
              // ✅ Show original requested amount as subtitle for reimbursement
              if (isReimbursement && displayAmount != requestedAmount)
                Text(
                  'of ₹${requestedAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 9,
                    color: newTextSecondary,
                  ),
                ),
            ],
          ),
      ]),
    );
  }
}

//  Quick actions (6-tile grid, matches HTML exactly)
class _QuickActionsCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _QuickActionsCard({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final status = (ctrl.currentItem?.status ?? '').toLowerCase();
    final isApproved = status == 'approved' || status == 'approve';

    // ✅ If already approved — only show Disapprove (when eligible)
    // If not approved — show Approve + Reject + Disapprove (when eligible)
    final actions = [
      if (!isApproved) ApprovalAction.approve,
      if (!isApproved && ctrl.showReject) ApprovalAction.reject,
      if (ctrl.showDisapprove) ApprovalAction.disapprove,
    ];

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecHead('Quick Actions'),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.25,
            children: actions.map((a) {
              final isPicked = ctrl.pickedAction == a;
              return GestureDetector(
                onTap: () => ctrl.pickAction(a),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: a.bgColor,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: isPicked ? a.color : a.bgColor,
                      width: isPicked ? 2 : 1,
                    ),
                    boxShadow: isPicked
                        ? [BoxShadow(
                        color: a.color.withValues(alpha: .25),
                        blurRadius: 8)]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(a.emoji, style: const TextStyle(fontSize: 22)),
                      const SizedBox(height: 5),
                      Text(a.title,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: a.color)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

//  Remark card
class _RemarkCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _RemarkCard({required this.ctrl});
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecHead('Remark / Comment'),
          TextFormField(
            controller: ctrl.remarkCtrl,
            minLines: 3,
            maxLines: 5,
            style: const TextStyle(fontSize: 13, color: newTextPrimary),
            decoration: InputDecoration(
              hintText: 'Enter reason, conditions, or notes...',
              hintStyle: const TextStyle(color: newTextHint, fontSize: 13),
              filled: true,
              fillColor: newSurfaceColor,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: newBorderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: newBorderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: newBlueColor, width: 1.5)),
            ),
          ),
          const SizedBox(height: 9),
          // Wrap(spacing: 7, children: [
          //   _RemarkChip(
          //       '✓ Approve',
          //       () => ctrl.setRemark(
          //           'Approved. Invoice verified and all details match.')),
          //   _RemarkChip(
          //       '✕ Reject',
          //       () => ctrl.setRemark(
          //           'Rejected due to incorrect details. Please revise and resubmit.')),
          //   // _RemarkChip(
          //   //     '⏸ Hold',
          //   //     () => ctrl
          //   //         .setRemark('Placed on hold pending vendor clarification.')),
          //   // _RemarkChip(
          //   //     '↩ Revert',
          //   //     () => ctrl
          //   //         .setRemark('Please revise and resubmit with corrections.')),
          // ]),
        ],
      ));
}

class _RemarkChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _RemarkChip(this.label, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: newBlueLightColor, borderRadius: BorderRadius.circular(8)),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: newBlueColor)),
        ),
      );
}

//  Forward / delegate card
class _ForwardCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _ForwardCard({required this.ctrl});

  @override
  Widget build(BuildContext context) => _Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SecHead('Forward / Escalate To'),
            ctrl.forwardOptions.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: newSurfaceColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: newBorderColor)),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ForwardOption>(
                        isExpanded: true,
                        value: ctrl.forwardTo,
                        hint: const Text(
                          'Select person to escalate to...',
                          style: TextStyle(color: newTextHint, fontSize: 13),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: newTextSecondary),
                        style: const TextStyle(
                            fontSize: 13, color: newTextPrimary),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        items: ctrl.forwardOptions
                            .map((opt) => DropdownMenuItem<ForwardOption>(
                                  value: opt,
                                  child: Text(opt.name),
                                ))
                            .toList(),
                        onChanged: (ForwardOption? v) {
                          ctrl.forwardTo = v;
                          ctrl.update();
                        },
                      ),
                    ),
                  ),
          ],
        ),
      );
}

//  Partial approval card
class _PartialCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _PartialCard({required this.ctrl});
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Partial Approval',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: newTextPrimary)),
                  Text('Approve a specific amount only',
                      style: TextStyle(fontSize: 10, color: newTextSecondary)),
                ]),
            Switch.adaptive(
                value: ctrl.partialApproval,
                onChanged: ctrl.togglePartial,
                activeThumbColor: newBlueColor),
          ]),
          if (ctrl.partialApproval) ...[
            const SizedBox(height: 10),
            TextFormField(
              controller: ctrl.partialCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary),
              onChanged: (val) {
                // trigger rebuild to show/hide error
                ctrl.update();
              },
              decoration: InputDecoration(
                labelText: 'Partial amount to approve',
                // ✅ show inline error if value exceeds requested amount
                errorText: () {
                  final entered = double.tryParse(ctrl.partialCtrl.text.trim());
                  final max = ctrl.currentItem?.amount;
                  if (entered != null && max != null && entered > max) {
                    return 'Cannot exceed requested amount ₹$max';
                  }
                  return null;
                }(),
                filled: true,
                fillColor: newSurfaceColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: newBorderColor)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: newBorderColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: newBlueColor, width: 1.5)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: newRedColor, width: 1.5)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: newRedColor, width: 1.5)),
              ),
            ),
          ],
        ],
      ));
}

//  Bottom bar
class _BottomBar extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _BottomBar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final isReimbursement = ctrl.currentItem?.approvalType
            ?.toLowerCase()
            .contains('reimbursement') ??
        false;

    Color btnColor = newBlueColor;
    String btnLabel =
        isReimbursement ? 'Submit Reimbursement' : 'Confirm Action';
    if (!isReimbursement && ctrl.pickedAction != null) {
      btnColor = ctrl.pickedAction!.color;
      btnLabel = 'Confirm ${ctrl.pickedAction!.label}';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: SafeArea(
          top: false,
          child: Row(children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                    foregroundColor: newTextSecondary,
                    side: const BorderSide(color: newBorderColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('Back',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: ctrl.isBusy ? null : ctrl.submitAction,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: ctrl.isBusy
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5))
                      : Text(btnLabel,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800)),
                )),
          ])),
    );
  }
}

//  Success screen
class _SuccessView extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _SuccessView({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final action = ctrl.pickedAction;
    final color = action?.color ?? newGreenColor;
    final bgCol = action?.bgColor ?? newGreenLightColor;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: bgCol, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(action?.emoji ?? '✓',
                style: TextStyle(fontSize: 32, color: color))),
        const SizedBox(height: 18),
        const Text('Action Successful!',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: newTextPrimary)),
        const SizedBox(height: 6),
        Text(ctrl.actionResultMsg,
            style: const TextStyle(fontSize: 13, color: newTextSecondary),
            textAlign: TextAlign.center),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: newSurfaceColor, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            _ssRow('Document',
                '${ctrl.currentItem?.approvalType ?? ''} — ${ctrl.currentItem?.documentNo ?? ''}'),
            _ssRow('Status', ctrl.actionResultMsg),
            _ssRow('Remark',
                ctrl.remarkCtrl.text.isNotEmpty ? ctrl.remarkCtrl.text : '—'),
          ]),
        ),
        const SizedBox(height: 22),

        //  Back to Hub → ApprovalHubDashboard
        SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Get.back(); // close Action
                Get.back(); // close Detail
                Get.back(); // close List → lands on Dashboard
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: newBlueColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Back to Hub',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
            )),
        const SizedBox(height: 10),

        //  Next Approval → ApprovalHubList
        SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton(
              onPressed: () {
                Get.back(); // close Action
                Get.back(); // close Detail
              },
              style: OutlinedButton.styleFrom(
                  foregroundColor: newTextSecondary,
                  side: const BorderSide(color: newBorderColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Next Approval',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
            )),
      ]),
    );
  }

  Widget _ssRow(String label, String val) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: newTextSecondary)),
          Expanded(
              child: Text(val,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
        ]),
      );
}

//  Shared helpers
class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: child,
      );
}

class _SecHead extends StatelessWidget {
  final String text;
  const _SecHead(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: newTextSecondary,
            letterSpacing: .6,
          ),
        ),
      );
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _InfoChip({
    required this.label,
    required this.value,
    required this.valueColor,
  });
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 9, color: newTextSecondary)),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: newBorderColor),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ),
        ],
      );
}

class _LabeledBox extends StatelessWidget {
  final String label;
  final Widget child;
  final bool highlightBorder;
  const _LabeledBox({
    required this.label,
    required this.child,
    this.highlightBorder = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 9, color: newTextSecondary)),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: highlightBorder ? newBlueLightColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: highlightBorder
                    ? newBlueColor.withValues(alpha: 0.35)
                    : newBorderColor,
              ),
            ),
            child: child,
          ),
        ],
      );
}

class _FileIconBtn extends StatelessWidget {
  final String label;
  final String? url;
  final IconData icon;
  final Color color;
  const _FileIconBtn({
    required this.label,
    required this.url,
    required this.icon,
    required this.color,
  });

  Future<void> _open() async {
    if (url == null || url!.isEmpty) return;
    final uri = Uri.parse(url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasFile = url != null && url!.isNotEmpty;
    return GestureDetector(
      onTap: hasFile ? _open : null,
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: hasFile ? color.withValues(alpha: 0.1) : newSurfaceColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasFile ? color.withValues(alpha: 0.4) : newBorderColor,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 16, color: hasFile ? color : newTextHint),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: hasFile ? color : newTextHint,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  final ApprovalItemStatus current;
  final Color Function(ApprovalItemStatus) statusColor;
  final ValueChanged<ApprovalItemStatus> onChanged;
  final List<ApprovalItemStatus> allowedStatuses; // ← ADD

  const _StatusDropdown({
    required this.current,
    required this.statusColor,
    required this.onChanged,
    required this.allowedStatuses, // ← ADD
  });

  @override
  Widget build(BuildContext context) => Container(
        height: 34,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: newBorderColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<ApprovalItemStatus>(
            // ← Safety: if current not in allowed list, default to first
            value: allowedStatuses.contains(current)
                ? current
                : allowedStatuses.first,
            isDense: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                size: 16, color: newTextSecondary),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            items: allowedStatuses // ← use filtered list, not all values
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      s.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: statusColor(s),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
        ),
      );
}

class _TotalRow extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _TotalRow({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final total = ctrl.approvalReimbursementItems
        .fold<double>(0.0, (sum, i) => sum + i.processAmount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Process Amount',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: newTextPrimary,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: newBlueLightColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '₹${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: newBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _RCard extends StatelessWidget {
  final Widget child;
  const _RCard({required this.child});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: child,
      );
}

class _RSecHead extends StatelessWidget {
  final String text;
  const _RSecHead(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: newTextSecondary,
            letterSpacing: .6,
          ),
        ),
      );
}
