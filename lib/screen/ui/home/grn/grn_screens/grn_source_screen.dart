import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../grn_controller/grn_controller.dart';
import '../grn_response/grn_models.dart';
import '../grn_widgets.dart';

class GrnSourceScreen extends StatelessWidget {
  const GrnSourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrnController>(builder: (ctrl) {
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
            child: Column(children: [
              // ── Grn Header ───────────────────────────────────────────────
              GrnCard(
                child: Column(children: [
                  const GrnSectionHead('Grn Header'),
                  // Row 1: Series Type + Grn Date
                  Row(children: [
                    Expanded(
                      child: GrnSearchableDropdown<GrnDropdownOption>(
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
                      child: GrnField(
                        label: 'Grn Date',
                        controller: ctrl.GrnDateCtrl,
                        readOnly: true,
                        onTap: () => ctrl.pickGrnDate(context),
                        suffix: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 18, color: newTextSecondary),
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),
                  // Grn Number (read-only, full width)
                  GrnField(
                    label: 'Grn No.',
                    controller: ctrl.grnDisplayNoCtrl,
                    readOnly: true,
                  ),
                ]),
              ),

              // ── Source selection (3 tiles only) ──────────────────────────
              GrnCard(
                child: Column(children: [
                  const GrnSectionHead('Select Item Source'),
                  Row(children: [
                    Expanded(
                      child: _sourceChip(ctrl, GrnSourceType.grn, '📦', 'GRN',
                          'Receipt Note', newGreenLightColor),
                    ),
                  ]),
                ]),
              ),

              // ── Party / Site details ──────────────────────────────────────
              GrnCard(
                child: Column(children: [
                  const GrnSectionHead('Party & Site Details'),

                  // Party Name (free text)
                  // ── Party Name (searchable dropdown) ──────────────────────────────────────
                  AbsorbPointer(
                    absorbing: ctrl.isEditMode,
                    child: Opacity(
                      opacity: ctrl.isEditMode ? 0.85 : 1.0,
                      child: GrnSearchableDropdown<GrnDropdownOption>(
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
                  GrnSearchableDropdown<GrnDropdownOption>(
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
                  GrnSearchableDropdown<GrnDropdownOption>(
                    label: 'Godown',
                    value: ctrl.selectedGodown,
                    items: ctrl.godownList,
                    isLoading: ctrl.isLoadingGodown,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setGodown,
                    hint: 'Search godown…',
                  ),

                  // After existing Godown dropdown:
                  // After Godown dropdown, before Bill No row:
                  const SizedBox(height: 10),

// ── From Address ──────────────────────────────────────────────────────
                  _addressField(
                    label: 'From Address',
                    controller: ctrl.fromAddressCtrl,
                    hint: 'Enter dispatch / shipping address…',
                    icon: Icons.local_shipping_outlined,
                    color: newBlueColor,
                    bg: newBlueLightColor,
                  ),
                  const SizedBox(height: 10),

// ── To Address ────────────────────────────────────────────────────────
                  _addressField(
                    label: 'To Address',
                    controller: ctrl.toAddressCtrl,
                    hint: 'Enter delivery / billing address…',
                    icon: Icons.location_on_outlined,
                    color: newGreenColor,
                    bg: newGreenLightColor,
                  ),

                  const SizedBox(height: 10),
                  // Bill No + Bill Date
                  Row(children: [
                    Expanded(
                      child: GrnField(
                        label: 'Bill No.',
                        controller: ctrl.billNoCtrl,
                        hint: 'Enter bill number',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GrnField(
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
                  GrnField(
                    label: 'Received By',
                    controller:
                    TextEditingController(text: ctrl.receivedByName),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),

                  // Challan No + Challan Date
                  Row(children: [
                    Expanded(
                      child: GrnField(
                        label: 'Challan No.',
                        controller: ctrl.challanNoCtrl,
                        hint: 'Enter challan number',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GrnField(
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

              // ── Attachments ───────────────────────────────────────────────
              // GrnCard(
              //   child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const GrnSectionHead('Attachments'),
              //
              //         // Attachment Type checklist dropdown
              //         _attachmentTypeChecklist(ctrl),
              //         const SizedBox(height: 12),
              //
              //         // Bill Attachment (shown when Bill is checked)
              //         if (ctrl.selectedAttachmentTypes
              //             .contains(GrnAttachmentType.bill)) ...[
              //           _attachmentSection(
              //             context: context,
              //             label: 'Bill Attachment',
              //             docs: ctrl.billAttachments,
              //             existingUrls: ctrl.existingBillFiles, // ✅
              //             onCamera: ctrl.pickBillFromCamera,
              //             onGallery: ctrl.pickBillFromGallery,
              //             onFile: ctrl.pickBillFile,
              //             onRemove: ctrl.removeBillAttachment,
              //             onRemoveExisting: ctrl.removeExistingBillFile, // ✅
              //           ),
              //           const SizedBox(height: 12),
              //         ],
              //
              //         // Challan Attachment (shown when Challan is checked)
              //         if (ctrl.selectedAttachmentTypes
              //             .contains(GrnAttachmentType.challan)) ...[
              //           _attachmentSection(
              //             context: context,
              //             label: 'Challan Attachment',
              //             docs: ctrl.challanAttachments,
              //             existingUrls: ctrl.existingDcFiles, // ✅
              //             onCamera: ctrl.pickChallanFromCamera,
              //             onGallery: ctrl.pickChallanFromGallery,
              //             onFile: ctrl.pickChallanFile,
              //             onRemove: ctrl.removeChallanAttachment,
              //             onRemoveExisting: ctrl.removeExistingDcFile, // ✅
              //           ),
              //           const SizedBox(height: 12),
              //         ],
              //
              //         // Reason for N/A (shown when no attachments uploaded)
              //         if (ctrl.billAttachments.isEmpty &&
              //             ctrl.challanAttachments.isEmpty &&
              //             ctrl.existingBillFiles.isEmpty && // ✅
              //             ctrl.existingDcFiles.isEmpty) ...[
              //           GrnField(
              //             label: 'Reason for N/A Attachment',
              //             controller: ctrl.reasonNACtrl,
              //             hint: 'Explain why no attachment is available…',
              //             minLines: 3,
              //           ),
              //         ],
              //       ]),
              // ),

              // ── Additional details ────────────────────────────────────────
              GrnCard(
                child: Column(children: [
                  const GrnSectionHead('Additional Details'),

                  // Paid Type (searchable)
                  GrnSearchableDropdown<GrnDropdownOption>(
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
                    GrnSearchableDropdown<GrnDropdownOption>(
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
                  GrnDropdown(
                    label: 'QC Required',
                    value: ctrl.selectedQcRequired,
                    items: ctrl.qcRequiredOptions,
                    onChanged: (v) => ctrl.setQcRequired(v ?? 'Yes'),
                  ),
                  const SizedBox(height: 10),

                  // Customer PO (searchable)
                  GrnSearchableDropdown<GrnDropdownOption>(
                    label: 'Customer PO',
                    value: ctrl.selectedCustomerPo,
                    items: ctrl.customerPoList,
                    isLoading: ctrl.isLoadingCustomerPo,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setCustomerPo,
                    hint: 'Search customer PO…',
                  ),
                  const SizedBox(height: 10),

                  // Job Type (searchable)
                  GrnSearchableDropdown<GrnDropdownOption>(
                    label: 'Job Type',
                    value: ctrl.selectedJobType,
                    items: ctrl.jobTypeList,
                    isLoading: ctrl.isLoadingJobType,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setJobType,
                    hint: 'Search job type…',
                  ),
                  const SizedBox(height: 10),

                  // Work Order No. (searchable)
                  GrnSearchableDropdown<GrnDropdownOption>(
                    label: 'Work Order No.',
                    value: ctrl.selectedWorkOrder,
                    items: ctrl.workOrderList,
                    isLoading: ctrl.isLoadingWorkOrder,
                    itemLabel: (o) => o.label,
                    onChanged: ctrl.setWorkOrder,
                    hint: 'Search work order…',
                  ),

                  const SizedBox(height: 10),

// Lot No + GRN No row
                  Row(children: [
                    Expanded(
                      child: GrnField(
                        label: 'Lot No.',
                        controller: ctrl.lotNoCtrl,
                        hint: 'Enter lot number',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GrnField(
                        label: 'GRN No.',
                        controller: ctrl.grnNoCtrl,
                        hint: 'Enter GRN number',
                      ),
                    ),
                  ]),
                  const SizedBox(height: 10),

// GRN Date + Gate Entry No row
                  Row(children: [
                    Expanded(
                      child: GrnField(
                        label: 'GRN Date',
                        controller: ctrl.grnDateCtrl,
                        readOnly: true,
                        hint: 'DD/MM/YYYY',
                        onTap: () => ctrl.pickGrnDate(context),
                        suffix: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 16, color: newTextSecondary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GrnField(
                        label: 'Gate Entry No.',
                        controller: ctrl.gateEntryNoCtrl,
                        hint: 'Enter gate entry no.',
                      ),
                    ),
                  ]),
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

  // ── Source chip (3-column horizontal layout) ──────────────────────────────
  Widget _sourceChip(GrnController ctrl, GrnSourceType type, String emoji,
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

  // ── Attachment type checklist widget ──────────────────────────────────────
  // Widget _attachmentTypeChecklist(GrnController ctrl) {
  //   return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //     const Text('Attachment Type',
  //         style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w700,
  //             color: newTextPrimary)),
  //     const SizedBox(height: 5),
  //     Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  //       decoration: BoxDecoration(
  //         color: newSurfaceColor,
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(color: newBorderColor),
  //       ),
  //       child: Column(children: [
  //         _checkItem(
  //           label: 'Bill',
  //           checked:
  //           ctrl.selectedAttachmentTypes.contains(GrnAttachmentType.bill),
  //           onTap: () => ctrl.toggleAttachmentType(GrnAttachmentType.bill),
  //         ),
  //         const Divider(height: 1, color: newBorderColor),
  //         _checkItem(
  //           label: 'Challan',
  //           checked: ctrl.selectedAttachmentTypes
  //               .contains(GrnAttachmentType.challan),
  //           onTap: () => ctrl.toggleAttachmentType(GrnAttachmentType.challan),
  //         ),
  //       ]),
  //     ),
  //   ]);
  // }

  Widget _checkItem(
      {required String label,
        required bool checked,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: checked ? newBlueColor : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: checked ? newBlueColor : newBorderColor,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: checked
                ? const Icon(Icons.check_rounded, size: 12, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(fontSize: 13, color: newTextPrimary)),
        ]),
      ),
    );
  }

  // ── Attachment section (files list + upload buttons) ──────────────────────
  Widget _attachmentSection({
    required BuildContext context,
    required String label,
    required List<GrnDocument> docs,
    required List<String> existingUrls, // ✅ add this
    required VoidCallback onCamera,
    required VoidCallback onGallery,
    required VoidCallback onFile,
    required void Function(String id) onRemove,
    required void Function(int index) onRemoveExisting, // ✅ add this
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 6),

      // ── Existing server files ─────────────────────────────────────────────
      if (existingUrls.isNotEmpty) ...[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: newGreenLightColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(children: [
            const Icon(Icons.cloud_done_rounded,
                size: 12, color: newGreenColor),
            const SizedBox(width: 5),
            Text('${existingUrls.length} file(s) already on server',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: newGreenColor)),
          ]),
        ),
        const SizedBox(height: 6),
        ...existingUrls.asMap().entries.map((e) => _ExistingFileChip(
          url: e.value,
          onRemove: () => onRemoveExisting(e.key),
        )),
        const SizedBox(height: 6),
      ],

      // ── Upload new files ──────────────────────────────────────────────────
      Row(children: [
        _uploadBtn(Icons.camera_alt_outlined, 'Camera', onCamera),
        const SizedBox(width: 8),
        _uploadBtn(Icons.photo_library_outlined, 'Gallery', onGallery),
        const SizedBox(width: 8),
        _uploadBtn(Icons.attach_file_rounded, 'File', onFile),
      ]),

      // New local files
      if (docs.isNotEmpty) ...[
        const SizedBox(height: 8),
        ...docs.map((doc) => _fileChip(doc, onRemove)),
      ],
    ]);
  }

  Widget _uploadBtn(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: newBlueLightColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
          ),
          child: Column(children: [
            Icon(icon, size: 18, color: newBlueColor),
            const SizedBox(height: 3),
            Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: newBlueColor)),
          ]),
        ),
      ),
    );
  }

  Widget _fileChip(GrnDocument doc, void Function(String) onRemove) {
    final isPdf = doc.fileType == 'pdf';
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: newBorderColor),
      ),
      child: Row(children: [
        Icon(
          isPdf ? Icons.picture_as_pdf_outlined : Icons.image_outlined,
          size: 18,
          color: isPdf ? Colors.redAccent : newBlueColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(doc.fileName,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(doc.fileSize,
                style: const TextStyle(fontSize: 10, color: newTextSecondary)),
          ]),
        ),
        GestureDetector(
          onTap: () => onRemove(doc.id),
          child: const Icon(Icons.close_rounded,
              size: 16, color: newTextSecondary),
        ),
      ]),
    );
  }

  // ── Bottom CTA ─────────────────────────────────────────────────────────────
  Widget _bottomCta(GrnController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: newBorderColor)),
      ),
      child: SafeArea(
        top: false,
        child: GrnPrimaryBtn(
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
    required GrnAddress address,
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

  Widget _addressField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color color,
    required Color bg,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // ── Label row with icon ───────────────────────────────────────────
      Row(children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color.withValues(alpha: 0.3))),
          alignment: Alignment.center,
          child: Icon(icon, size: 13, color: color),
        ),
        const SizedBox(width: 7),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color),
        ),
      ]),
      const SizedBox(height: 6),

      // ── Multiline text field ──────────────────────────────────────────
      TextFormField(
        controller: controller,
        minLines: 3,
        maxLines: 5,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(fontSize: 13, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: newTextHint, fontSize: 12),
          filled: true,
          fillColor: bg.withValues(alpha: 0.4),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color.withValues(alpha: 0.3))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color.withValues(alpha: 0.3))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: color, width: 1.5)),
        ),
      ),
    ]);
  }
}

// ── Existing server attachment chip (read-only) ────────────────────────────
class _ExistingFileChip extends StatelessWidget {
  final String url;
  final VoidCallback onRemove;

  const _ExistingFileChip({required this.url, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final fileName = url.split('/').last;
    final isPdf = fileName.toLowerCase().endsWith('.pdf');
    final isImage = ['jpg', 'jpeg', 'png', 'webp']
        .any((ext) => fileName.toLowerCase().endsWith(ext));

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: newGreenLightColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: newGreenColor.withValues(alpha: 0.4)),
      ),
      child: Column(children: [
        // ── File row ──────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          child: Row(children: [
            // Icon
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                  color: newGreenColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Icon(
                isPdf
                    ? Icons.picture_as_pdf_outlined
                    : isImage
                    ? Icons.image_outlined
                    : Icons.attach_file_rounded,
                size: 18,
                color: newGreenColor,
              ),
            ),
            const SizedBox(width: 10),

            // File info
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName.length > 30
                          ? '${fileName.substring(0, 27)}…'
                          : fileName,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: newTextPrimary),
                    ),
                    Row(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                            color: newGreenColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('SERVER',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                      ),
                    ]),
                  ]),
            ),

            // Remove button
            GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: newRedLightColor,
                    borderRadius: BorderRadius.circular(7),
                    border:
                    Border.all(color: newRedColor.withValues(alpha: 0.3))),
                child: const Icon(Icons.delete_outline_rounded,
                    size: 14, color: newRedColor),
              ),
            ),
          ]),
        ),

        // ── Image preview (if image URL) ──────────────────────────────────
        if (isImage && url.startsWith('http'))
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Image.network(
              url,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 60,
                color: newSurfaceColor,
                alignment: Alignment.center,
                child: const Text('Preview unavailable',
                    style: TextStyle(fontSize: 11, color: newTextSecondary)),
              ),
            ),
          ),
      ]),
    );
  }
}
