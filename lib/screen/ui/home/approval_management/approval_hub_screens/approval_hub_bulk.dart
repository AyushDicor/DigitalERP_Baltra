import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../approval_hub_controller/approval_hub_controller.dart';

class ApprovalHubBulk extends StatelessWidget {
  const ApprovalHubBulk({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(
      builder: (ctrl) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            _AppBar(ctrl: ctrl),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 100,
                ),
                child: Column(children: [
                  _SelectedCard(ctrl: ctrl),
                  _ActionsCard(ctrl: ctrl),
                  _SummaryCard(ctrl: ctrl),
                  _RemarkCard(ctrl: ctrl),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

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
                  // decoration: BoxDecoration(
                  //     color: newSurfaceColor,
                  //     borderRadius: BorderRadius.circular(18)),
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_back_ios_new,
                      size: 18, color: newTextPrimary))),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('Bulk Action',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary)),
                Text('${ctrl.selectionCount} items selected',
                    style:
                        const TextStyle(fontSize: 11, color: newTextSecondary)),
              ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius: BorderRadius.circular(9)),
            child: Text('${ctrl.selectionCount} selected',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newBlueColor)),
          ),
        ]),
      );
}

//  Selected items 
class _SelectedCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _SelectedCard({required this.ctrl});
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SecHead('Selected Items'),
          ...ctrl.selectedItems.map((item) => _SelItem(item: item, ctrl: ctrl)),
        ],
      ));
}

class _SelItem extends StatelessWidget {
  final ApprovalListData item;
  final ApprovalHubController ctrl;
  const _SelItem({required this.item, required this.ctrl});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: newBlueLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newBlueColor, width: 1.2)),
        child: Row(children: [
          Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: ctrl.catLightColor(item.documentname),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Text(ctrl.catEmoji(item.documentname),
                  style: const TextStyle(fontSize: 16))),
          const SizedBox(width: 9),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${item.documentname ?? ''} — ${item.documentno ?? ''}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(item.partyname ?? item.clintname ?? '',
                    style:
                        const TextStyle(fontSize: 10, color: newTextSecondary)),
              ])),
          if ((item.totalamount ?? '').isNotEmpty)
            Text('₹${item.totalamount}',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ctrl.catColor(item.documentname))),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => ctrl.toggleSelect(item),
            child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: newRedLightColor,
                    borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: const Icon(Icons.close_rounded,
                    size: 13, color: newRedColor)),
          ),
        ]),
      );
}

//  Bulk actions grid (matches HTML: 2-col top, 3-col bottom) 
class _ActionsCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _ActionsCard({required this.ctrl});
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SecHead('Apply to All Selected'),
          Row(children: [
            Expanded(
                child: _ActBtn(
                    action: ApprovalAction.approve,
                    label: 'Approve All',
                    onTap: () =>
                        _confirm(context, ctrl, ApprovalAction.approve))),
            const SizedBox(width: 8),
            Expanded(
                child: _ActBtn(
                    action: ApprovalAction.reject,
                    label: 'Reject All',
                    onTap: () =>
                        _confirm(context, ctrl, ApprovalAction.reject))),
          ]),
          // const SizedBox(height: 8),
          // Row(children: [
          //   Expanded(
          //       child: _ActBtn(
          //           action: ApprovalAction.hold,
          //           label: 'Hold All',
          //           onTap: () => _confirm(context, ctrl, ApprovalAction.hold))),
          //   const SizedBox(width: 8),
          //   Expanded(
          //       child: _ActBtn(
          //           action: ApprovalAction.revert,
          //           label: 'Revert',
          //           onTap: () =>
          //               _confirm(context, ctrl, ApprovalAction.revert))),
          //   const SizedBox(width: 8),
          //   Expanded(
          //       child: _ActBtn(
          //           action: ApprovalAction.forward,
          //           label: 'Forward',
          //           onTap: () {})),
          // ]),
        ],
      ));

  void _confirm(
      BuildContext ctx, ApprovalHubController ctrl, ApprovalAction action) {
    final remarkCtrl = TextEditingController();
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('${action.title} ${ctrl.selectionCount} Items?',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          const SizedBox(height: 8),
          Text(
              'This will ${action.label.toLowerCase()} all ${ctrl.selectionCount} selected approvals.',
              style: const TextStyle(fontSize: 13, color: newTextSecondary),
              textAlign: TextAlign.center),
          const SizedBox(height: 14),
          TextFormField(
            controller: remarkCtrl,
            minLines: 2,
            maxLines: 3,
            style: const TextStyle(fontSize: 13, color: newTextPrimary),
            decoration: InputDecoration(
              hintText: 'Add a common remark (optional)...',
              hintStyle: const TextStyle(color: newTextHint, fontSize: 12),
              filled: true,
              fillColor: newSurfaceColor,
              contentPadding: const EdgeInsets.all(10),
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
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: newBorderColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Cancel'),
            )),
            const SizedBox(width: 10),
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                Get.back();
                ctrl
                    .submitBulkAction(action, remarkCtrl.text)
                    .then((_) => Get.back());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: action.color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(action.title,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            )),
          ]),
        ]),
      ),
    ));
  }
}

class _ActBtn extends StatelessWidget {
  final ApprovalAction action;
  final String label;
  final VoidCallback onTap;
  const _ActBtn(
      {required this.action, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: action.bgColor,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: action.color.withValues(alpha: .25))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(action.emoji,
                style: TextStyle(fontSize: 22, color: action.color)),
            const SizedBox(height: 5),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: action.color),
                textAlign: TextAlign.center),
          ]),
        ),
      );
}

//  Summary card 
class _SummaryCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _SummaryCard({required this.ctrl});
  @override
  Widget build(BuildContext context) {
    double totalVal = 0;
    final types = <String>{};
    for (final item in ctrl.selectedItems) {
      totalVal +=
          double.tryParse((item.totalamount ?? '').replaceAll(',', '')) ?? 0;
      if (item.documentname != null) types.add(item.documentname!);
    }
    return _Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const _SecHead('Summary'),
      _SR('Total items', '${ctrl.selectionCount}'),
      _SR('Total value', '₹${totalVal.toStringAsFixed(0)}'),
      _SR('Types', types.join(', ')),
      _SR('Authority', '',
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
                color: newGreenLightColor,
                borderRadius: BorderRadius.circular(20)),
            child: const Text('✓ All within limit',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: newGreenColor)),
          )),
    ]));
  }
}

class _SR extends StatelessWidget {
  final String label, val;
  final Widget? trailing;
  const _SR(this.label, this.val, {this.trailing});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label,
              style: const TextStyle(fontSize: 12, color: newTextSecondary)),
          trailing ??
              Text(val,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
        ]),
      );
}

//  Common remark card 
class _RemarkCard extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _RemarkCard({required this.ctrl});
  @override
  Widget build(BuildContext context) => _Card(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SecHead('Common Remark (optional)'),
          TextFormField(
            controller: ctrl.remarkCtrl,
            minLines: 2,
            maxLines: 4,
            style: const TextStyle(fontSize: 13, color: newTextPrimary),
            decoration: InputDecoration(
              hintText:
                  'Add a remark that applies to all selected approvals...',
              hintStyle: const TextStyle(color: newTextHint, fontSize: 12),
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
        ],
      ));
}

//  Shared 
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
                  offset: const Offset(0, 2))
            ]),
        child: child,
      );
}

class _SecHead extends StatelessWidget {
  final String text;
  const _SecHead(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: newTextSecondary,
                letterSpacing: .6)),
      );
}
