import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_constant_new.dart';
import '../issue_item_contoller/issue_item_contoller.dart';
import '../issue_item_response/issue_item_model.dart';
import '../issue_item_widgets.dart';

class IssueItemSourceScreen extends StatelessWidget {
  const IssueItemSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueItemEntryController>(builder: (ctrl) {
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            child: Column(children: [

              // ── Issue Header ─────────────────────────────────────────────
              IssCard(child: Column(children: [
                const IssSectionHead('Issue Header'),

                // Issue No (read-only) + Issue Date
                Row(children: [
                  Expanded(
                    child: IssField(
                      label: 'Issue No.',
                      controller: TextEditingController(text: ctrl.issueNo),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: IssField(
                      label: 'Issue Date',
                      controller: ctrl.issueDateCtrl,
                      readOnly: true,
                      onTap: () => ctrl.pickIssueDate(context),
                      suffix: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.calendar_today_outlined,
                            size: 18, color: newTextSecondary),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 10),

                // // Issue Type
                // IssSearchableDropdown<IssueItemDropdownOption>(
                //   label: 'Issue Type',
                //   value: ctrl.selectedIssueType,
                //   items: ctrl.issueTypeList,
                //   isLoading: ctrl.isLoadingIssueType,
                //   itemLabel: (o) => o.label,
                //   onChanged: ctrl.setIssueType,
                //   hint: 'Select issue type…',
                // ),
                // const SizedBox(height: 10),

                // Item Issue Type
                IssSearchableDropdown<IssueItemDropdownOption>(
                  label: 'Item Issue Type',
                  value: ctrl.selectedItemIssueType,
                  items: ctrl.itemIssueTypeList,
                  isLoading: ctrl.isLoadingItemIssueType,
                  itemLabel: (o) => o.label,
                  onChanged: ctrl.setItemIssueType,
                  hint: 'Select item issue type…',
                ),
                const SizedBox(height: 10),

                // Issue To
                IssSearchableDropdown<IssueItemDropdownOption>(
                  label: 'Issue To',
                  value: ctrl.selectedIssueTo,
                  items: ctrl.issueToList,
                  isLoading: ctrl.isLoadingIssueTo,
                  itemLabel: (o) => o.label,
                  onChanged: ctrl.setIssueTo,
                  hint: 'Select issue to…',
                ),
                const SizedBox(height: 10),

                // Issued By (read-only)
                IssField(
                  label: 'Issued By',
                  controller: TextEditingController(text: ctrl.issuedBy),
                  readOnly: true,
                ),
                const SizedBox(height: 10),

                // Bill No
                IssField(
                  label: 'Bill No.',
                  controller: ctrl.billNoCtrl,
                  hint: 'Enter bill number',
                ),
                const SizedBox(height: 10),

                // Godown
                IssSearchableDropdown<IssueItemDropdownOption>(
                  label: 'Godown',
                  value: ctrl.selectedGodown,
                  items: ctrl.godownList,
                  isLoading: ctrl.isLoadingGodown,
                  itemLabel: (o) => o.label,
                  onChanged: ctrl.setGodown,
                  hint: 'Select godown…',
                ),
                const SizedBox(height: 10),


                // Remarks
                IssField(
                  label: 'Remarks',
                  controller: ctrl.remarksCtrl,
                  hint: 'Optional remarks…',
                  minLines: 2,
                ),
              ])),

              // ── Source selection ─────────────────────────────────────────
              IssCard(child: Column(children: [
                IsseSectionHead(
                  'Select Item Source',
                  trailing: ctrl.isEditMode
                      ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: newOrangeLightColor,
                          borderRadius: BorderRadius.circular(6)),
                      child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.lock_outline_rounded,
                                size: 10, color: newOrangeColor),
                            SizedBox(width: 4),
                            Text('Locked in edit mode',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: newOrangeColor)),
                          ]))
                      : null,
                ),
                AbsorbPointer(
                  absorbing: ctrl.isEditMode,
                  child: Opacity(
                    opacity: ctrl.isEditMode ? 0.5 : 1.0,
                    child: Row(children: [
                      Expanded(
                        child: _sourceChip(
                          ctrl,
                          IssueItemSource.direct,
                          '🛒',
                          'Direct\nIssue',
                          'Manual entry',
                          newOrangeLightColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _sourceChip(
                          ctrl,
                          IssueItemSource.fromIndent,
                          '📋',
                          'From\nIndent',
                          'Against indent',
                          newBlueLightColor,
                        ),
                      ),
                    ]),
                  ),
                ),
              ])),
            ]),
          ),
        ),

        // ── Bottom CTA ───────────────────────────────────────────────────────
        _bottomCta(ctrl),
      ]);
    });
  }

  Widget _sourceChip(IssueItemEntryController ctrl, IssueItemSource type,
      String emoji, String title, String sub, Color iconBg) {
    final isSelected = ctrl.selectedSource == type;
    return GestureDetector(
      onTap: () => ctrl.setSource(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? newBlueLightColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? newBlueColor : newBorderColor,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
                color: iconBg, borderRadius: BorderRadius.circular(9)),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? newBlueColor : newTextPrimary)),
          Text(sub,
              style: const TextStyle(fontSize: 9, color: newTextSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }

  Widget _bottomCta(IssueItemEntryController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: newBorderColor)),
      ),
      child: SafeArea(
        top: false,
        child: IssPrimaryBtn(
          label: 'Continue → Add Items',
          icon: Icons.arrow_forward_rounded,
          onTap: ctrl.nextStep,
        ),
      ),
    );
  }
}