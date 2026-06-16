import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mrn_controller/mrn_controller.dart';
import '../mrn_response/mrn_models.dart';
import '../mrn_widgets.dart';

class MrnSourceScreen extends StatelessWidget {
  const MrnSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MrnController>(builder: (ctrl) {
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            child: Column(children: [
              // ── MRN Header ───────────────────────────────────────────────
              MrnCard(
                child: Column(children: [
                  const MrnSectionHead('MRN Header'),
                  // Row 1: Series Type + MRN Date
                  Row(children: [
                    Expanded(
                      child: MrnSearchableDropdown<MrnDropdownOption>(
                        label: 'Series Type',
                        value: ctrl.selectedSeriesType,
                        items: ctrl.seriesTypeList,
                        isLoading: ctrl.isLoadingSeriesType,
                        itemLabel: (o) => o.label,
                        onChanged: ctrl.setSeriesType,
                        hint: 'Select series',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MrnField(
                        label: 'MRN Date',
                        controller: ctrl.mrnDateCtrl,
                        readOnly: true,
                        onTap: () => ctrl.pickMrnDate(context),
                        suffix: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 18, color: newTextSecondary),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  // MRN Number (read-only, full width)
                  MrnField(
                    label: 'MRN No.',
                    controller: TextEditingController(text: ctrl.mrnNumber),
                    readOnly: true,
                  ),
                ]),
              ),

              // ── Source selection ───────────────────────────────────────────
              MrnCard(
                child: Column(children: [
                  MrnSectionHead(
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
                                ]),
                          )
                        : null,
                  ),
                  // Wrap chips in Opacity + AbsorbPointer when editing
                  AbsorbPointer(
                    absorbing: ctrl.isEditMode,
                    child: Opacity(
                      opacity: ctrl.isEditMode ? 0.5 : 1.0,
                      child: Row(children: [
                        Expanded(
                          child: _sourceChip(
                              ctrl,
                              MrnSourceType.purchaseOrder,
                              '📄',
                              'Purchase\nOrder',
                              'From PO',
                              newBlueLightColor),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _sourceChip(
                              ctrl,
                              MrnSourceType.directPurchase,
                              '🛒',
                              'Direct\nPurchase',
                              'Manual',
                              newOrangeLightColor),
                        ),
                      ]),
                    ),
                  ),
                ]),
              ),

              // ── Party / Site details ──────────────────────────────────────
              MrnCard(
                child: Column(children: [
                  const MrnSectionHead('Party & Site Details'),

                  // ── Party Name (searchable dropdown) ──────────────────────
                  // Replace the party MrnSearchableDropdown with:
                  AbsorbPointer(
                    absorbing: ctrl.isEditMode,
                    child: Opacity(
                      opacity: ctrl.isEditMode ? 0.85 : 1.0,
                      child: MrnSearchableDropdown<MrnDropdownOption>(
                        label: ctrl.isEditMode ? 'Party Name 🔒' : 'Party Name',
                        value: ctrl.selectedParty,
                        items: ctrl.partyList,
                        isLoading: ctrl.isLoadingParty,
                        itemLabel: (o) => o.label,
                        onChanged: ctrl.setParty,
                        hint: 'Search party / supplier…',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Site (searchable dropdown)
                  MrnSearchableDropdown<MrnDropdownOption>(
                    label: 'Site',
                    value: ctrl.selectedSite,
                    items: ctrl.siteList,
                    isLoading: ctrl.isLoadingSite,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setSite,
                    hint: 'Search site…',
                  ),
                  const SizedBox(height: 10),

                  // Godown (searchable dropdown)
                  MrnSearchableDropdown<MrnDropdownOption>(
                    label: 'Godown',
                    value: ctrl.selectedGodown,
                    items: ctrl.godownList,
                    isLoading: ctrl.isLoadingGodown,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setGodown,
                    hint: 'Search godown…',
                  ),
                  const SizedBox(height: 10),

                  // Bill No + Bill Date
                  Row(children: [
                    Expanded(
                      child: MrnField(
                        label: 'Bill No.',
                        controller: ctrl.billNoCtrl,
                        hint: 'Enter bill number',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MrnField(
                        label: 'Bill Date',
                        controller: ctrl.billDateCtrl,
                        readOnly: true,
                        hint: 'DD/MM/YYYY',
                        onTap: () => ctrl.pickBillDate(context),
                        suffix: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 16, color: newTextSecondary),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),

                  // Received By (non-editable)
                  MrnField(
                    label: 'Received By',
                    controller:
                        TextEditingController(text: ctrl.receivedByName),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),

                  // Challan No + Challan Date
                  Row(children: [
                    Expanded(
                      child: MrnField(
                        label: 'Challan No.',
                        controller: ctrl.challanNoCtrl,
                        hint: 'Enter challan number',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MrnField(
                        label: 'Challan Date',
                        controller: ctrl.challanDateCtrl,
                        readOnly: true,
                        hint: 'DD/MM/YYYY',
                        onTap: () => ctrl.pickChallanDate(context),
                        suffix: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 16, color: newTextSecondary),
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),

              // ── Additional details (Paid Type, QC, Lot, GRN) ─────────────
              MrnCard(
                child: Column(children: [
                  const MrnSectionHead('Additional Details'),

                  // Paid Type (searchable)
                  MrnSearchableDropdown<MrnDropdownOption>(
                    label: 'Paid Type',
                    value: ctrl.selectedPaidType,
                    items: ctrl.paidTypeList,
                    isLoading: false,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setPaidType,
                    hint: 'Select paid type…',
                  ),
                  const SizedBox(height: 10),

                  // Paid By — only shown when Employee is selected
                  if (ctrl.selectedPaidType?.id == 'Employee') ...[
                    MrnSearchableDropdown<MrnDropdownOption>(
                      label: 'Paid By',
                      value: ctrl.selectedPaidBy,
                      items: ctrl.paidByList,
                      isLoading: ctrl.isLoadingPaidBy,
                      itemLabel: (o) => o.label,
                      onChanged: ctrl.setPaidBy,
                      hint: 'Search employee…',
                    ),
                    const SizedBox(height: 10),
                  ],

                  // QC Required (Yes / No only)
                  MrnDropdown(
                    label: 'QC Required',
                    value: ctrl.selectedQcRequired,
                    items: ctrl.qcRequiredOptions,
                    onChanged: (v) => ctrl.setQcRequired(v ?? 'Yes'),
                  ),
                  const SizedBox(height: 10),

                  // // Lot No + GRN No row
                  // Row(children: [
                  //   Expanded(
                  //     child: MrnField(
                  //       label: 'Lot No.',
                  //       controller: ctrl.lotNoCtrl,
                  //       hint: 'Enter lot number',
                  //     ),
                  //   ),
                  //   const SizedBox(width: 10),
                  //   Expanded(
                  //     child: MrnField(
                  //       label: 'GRN No.',
                  //       controller: ctrl.grnNoCtrl,
                  //       hint: 'Enter GRN number',
                  //     ),
                  //   ),
                  // ]),
                  // const SizedBox(height: 10),
                  //
                  // // GRN Date + Gate Entry No row
                  // Row(children: [
                  //   Expanded(
                  //     child: MrnField(
                  //       label: 'GRN Date',
                  //       controller: ctrl.grnDateCtrl,
                  //       readOnly: true,
                  //       hint: 'DD/MM/YYYY',
                  //       onTap: () => ctrl.pickGrnDate(context),
                  //       suffix: const Padding(
                  //         padding: EdgeInsets.all(12),
                  //         child: Icon(Icons.calendar_today_outlined,
                  //             size: 16, color: newTextSecondary),
                  //       ),
                  //     ),
                  //   ),
                  //   const SizedBox(width: 10),
                  //   Expanded(
                  //     child: MrnField(
                  //       label: 'Gate Entry No.',
                  //       controller: ctrl.gateEntryNoCtrl,
                  //       hint: 'Enter gate entry no.',
                  //     ),
                  //   ),
                  // ]
                  // ),
                ]),
              ),
            ]),
          ),
        ),

        // ── Bottom CTA ───────────────────────────────────────────────────────
        _bottomCta(ctrl),
      ]);
    });
  }

  // ── Source chip ───────────────────────────────────────────────────────────
  Widget _sourceChip(MrnController ctrl, MrnSourceType type, String emoji,
      String title, String sub, Color iconBg) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
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
          ],
        ),
      ),
    );
  }

  // ── Bottom CTA ─────────────────────────────────────────────────────────────
  Widget _bottomCta(MrnController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: newBorderColor)),
      ),
      child: SafeArea(
        top: false,
        child: MrnPrimaryBtn(
          label: 'Continue → Select Items',
          icon: Icons.arrow_forward_rounded,
          onTap: () => ctrl.nextStep(),
        ),
      ),
    );
  }

  Widget _addressTile({
    required IconData icon,
    required String label,
    required MrnAddress address,
    required Color color,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(9)),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w800, color: color)),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4)),
                child: const Text('READ ONLY',
                    style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey)),
              ),
            ]),
            const SizedBox(height: 4),
            if (address.line1.isNotEmpty)
              Text(address.line1,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: newTextPrimary)),
            if (address.line2.isNotEmpty)
              Text(address.line2,
                  style:
                      const TextStyle(fontSize: 11, color: newTextSecondary)),
            if (address.city.isNotEmpty || address.state.isNotEmpty)
              Text(
                [address.city, address.state]
                    .where((s) => s.isNotEmpty)
                    .join(', '),
                style: const TextStyle(fontSize: 11, color: newTextSecondary),
              ),
            if (address.pincode.isNotEmpty)
              Text('PIN: ${address.pincode}',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: newTextSecondary)),
          ]),
        ),
      ]),
    );
  }
}
