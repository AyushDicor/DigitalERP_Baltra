// lib/screen/ui/home/reimbursements/Add/add_new_reimbursement_screen.dart

import 'package:digitalerp/model/reimbursement_dropdown_response_model.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/controller/new_reimbursement_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _kBg = Color(0xFFF5F6FA);
const Color _kCard = Colors.white;
const Color _kBorder = Color(0xFFE8E8E8);

class AddNewReimbursementScreen extends StatelessWidget {
  const AddNewReimbursementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(NewReimbursementController());

    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _AppBar(),
          Expanded(
            child: Obx(() => ctrl.isLoadingDropdowns.value
                ? const Center(
                    child: CircularProgressIndicator(color: purpleColor))
                : _FormBody(ctrl: ctrl)),
          ),
        ],
      ),
    );
  }
}

//  App bar
class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: _kCard,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          bottom: 14,
          left: 4,
          right: 16,
        ),
        child: Row(children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new,
                color: newTextPrimary, size: 20),
          ),
          const Expanded(
            child: Text(
              "New Reimbursement",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary),
            ),
          ),
        ]),
      );
}

//  Form body
class _FormBody extends StatelessWidget {
  final NewReimbursementController ctrl;
  const _FormBody({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  Header card
          _card(
            title: "Header Details",
            child: Column(children: [
              // Series Type — auto-selected, still shown as dropdown
              // (user can change if needed)
              // Obx(() => _dropdown<ReimbursementDropdownItem>(
              //       label: "Series Type",
              //       items: ctrl.seriesTypes,
              //       selected: ctrl.selectedSeries.value,
              //       onChanged: (v) => ctrl.selectedSeries.value = v,
              //       display: (e) => e.name ?? '',
              //     )),
              // const SizedBox(height: 14),

              // Expense Date — auto today, no future dates
              _dateField(context),
              const SizedBox(height: 14),

              // Site — searchable from loaded list
              _label("Site"),
              const SizedBox(height: 6),
              _SiteSearchField(ctrl: ctrl),
              const SizedBox(height: 14),

              // Request By — read-only, auto from API
              // _label("Request By"),
              // const SizedBox(height: 6),
              // _readonlyBox(ctrl.currentUserName),
            ]),
          ),

          const SizedBox(height: 16),

          //  Items section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: ctrl.addLineItem,
                icon: const Icon(Icons.add_circle_outline,
                    color: purpleColor, size: 18),
                label: Text("Add Item",
                    style: GoogleFonts.dmSans(
                        color: purpleColor, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Obx(() => ctrl.lineItems.isEmpty
              ? _emptyItems()
              : Column(
                  children: List.generate(
                    ctrl.lineItems.length,
                    (i) => _LineItemCard(
                      ctrl: ctrl,
                      index: i,
                      key: ValueKey(ctrl.lineItems[i].sno),
                    ),
                  ),
                )),

          const SizedBox(height: 16),

          //  Total
          Obx(() => ctrl.lineItems.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: purpleLightest,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: purpleColor.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Amount",
                          style: GoogleFonts.dmSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: newTextPrimary)),
                      Text(
                        "₹${ctrl.totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: purpleColor),
                      ),
                    ],
                  ),
                )),

          const SizedBox(height: 24),

          //  Submit button
          Obx(() => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      ctrl.isSaving.value ? null : ctrl.saveReimbursement,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: ctrl.isSaving.value
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white)))
                      : Text("Submit Reimbursement",
                          style: GoogleFonts.dmSans(
                              fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              )),
        ],
      ),
    );
  }

  //  Date field
  Widget _dateField(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("Claim Date"),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => ctrl.pickDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _kBorder),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 18, color: purpleColor),
                const SizedBox(width: 10),
                Obx(() {
                  final text = ctrl.expenseDateDisplay.value;
                  return Text(
                    text.isEmpty ? "Select Date" : text,
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        color: text.isEmpty
                            ? Colors.grey.shade400
                            : newTextPrimary),
                  );
                }),
                const Spacer(),
                Icon(Icons.edit_calendar_outlined,
                    size: 16, color: Colors.grey.shade400),
              ]),
            ),
          ),
        ],
      );

  //  Empty items placeholder
  Widget _emptyItems() => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
        ),
        child: Center(
          child: Column(children: [
            Icon(Icons.receipt_long_outlined,
                size: 40, color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Text("No items yet. Tap 'Add Item' to begin.",
                style:
                    GoogleFonts.dmSans(fontSize: 13, color: newTextSecondary)),
          ]),
        ),
      );

  //  Section card
  Widget _card({required String title, required Widget child}) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.dmSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
            const SizedBox(height: 14),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 14),
            child,
          ],
        ),
      );

  //  Shared label
  Widget _label(String text) => Text(text,
      style: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w600, color: newTextSecondary));

  //  Read-only box (Request By)
  Widget _readonlyBox(String value) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _kBorder),
        ),
        child: Row(children: [
          Icon(Icons.person_outline_rounded,
              size: 18, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          Text(
            value.isEmpty ? '—' : value,
            style: GoogleFonts.dmSans(
                fontSize: 14,
                color: newTextPrimary,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Icon(Icons.lock_outline_rounded,
              size: 14, color: Colors.grey.shade400),
        ]),
      );

  //  Dropdown helper
  Widget _dropdown<T>({
    required String label,
    required List<T> items,
    required T? selected,
    required ValueChanged<T?> onChanged,
    required String Function(T) display,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(label),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _kBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                value: selected,
                hint: Text("Select $label",
                    style: GoogleFonts.dmSans(
                        fontSize: 14, color: Colors.grey.shade400)),
                items: items
                    .map((e) => DropdownMenuItem<T>(
                          value: e,
                          child: Text(display(e),
                              style: GoogleFonts.dmSans(
                                  fontSize: 14, color: newTextPrimary)),
                        ))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      );
}

//  Site search field
// Uses ctrl.filteredSites (already loaded) — no extra API calls
class _SiteSearchField extends StatelessWidget {
  final NewReimbursementController ctrl;
  const _SiteSearchField({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = ctrl.selectedSite.value;
      final suggestions = ctrl.filteredSites;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _kBorder),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: ctrl.siteSearchCtrl,
              onChanged: (q) {
                // Clear selection when user types again
                if (selected != null &&
                    ctrl.siteSearchCtrl.text != selected.name) {
                  ctrl.clearSiteSelection();
                }
                ctrl.searchSite(q);
              },
              style: GoogleFonts.dmSans(fontSize: 14, color: newTextPrimary),
              decoration: InputDecoration(
                hintText: "Search site...",
                hintStyle: GoogleFonts.dmSans(
                    fontSize: 14, color: Colors.grey.shade400),
                prefixIcon: Icon(Icons.search_rounded,
                    size: 18, color: Colors.grey.shade500),
                suffixIcon: ctrl.siteSearchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear,
                            size: 16, color: Colors.grey.shade500),
                        onPressed: ctrl.clearSiteSelection,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
          ),

          // Suggestions list — only when no item selected yet
          if (selected == null &&
              suggestions.isNotEmpty &&
              ctrl.siteSearchCtrl.text.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 2),
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _kBorder),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: suggestions.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: _kBorder),
                itemBuilder: (_, i) => ListTile(
                  dense: true,
                  leading: Icon(Icons.location_on_outlined,
                      size: 16, color: Colors.grey.shade400),
                  title: Text(suggestions[i].name ?? '',
                      style: GoogleFonts.dmSans(
                          fontSize: 13, color: newTextPrimary)),
                  onTap: () => ctrl.onSiteSelected(suggestions[i]),
                ),
              ),
            ),

          // Selected site chip
          if (selected != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: purpleColor.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: purpleColor.withValues(alpha: 0.25)),
                ),
                child: Row(children: [
                  Icon(Icons.check_circle_outline,
                      size: 16, color: purpleColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(selected.name ?? '',
                        style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: purpleColor,
                            fontWeight: FontWeight.w500)),
                  ),
                  GestureDetector(
                    onTap: ctrl.clearSiteSelection,
                    child: Icon(Icons.close,
                        size: 16, color: Colors.grey.shade500),
                  ),
                ]),
              ),
            ),
        ],
      );
    });
  }
}

//  Line item card
class _LineItemCard extends StatefulWidget {
  final NewReimbursementController ctrl;
  final int index;

  const _LineItemCard({required this.ctrl, required this.index, Key? key})
      : super(key: key);

  @override
  State<_LineItemCard> createState() => _LineItemCardState();
}

class _LineItemCardState extends State<_LineItemCard> {
  late TextEditingController _descCtrl;
  late TextEditingController _amountCtrl;

  NewReimbursementController get ctrl => widget.ctrl;
  int get idx => widget.index;

  @override
  void initState() {
    super.initState();
    final item = ctrl.lineItems[idx];
    _descCtrl = TextEditingController(text: item.description);
    _amountCtrl = TextEditingController(
        text: item.amount > 0 ? item.amount.toString() : '');
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  void _syncItem() {
    final item = ctrl.lineItems[idx];
    item.description = _descCtrl.text;
    item.amount = double.tryParse(_amountCtrl.text) ?? 0.0;
    ctrl.lineItems.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = ctrl.lineItems[idx];

      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _kBorder),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  Item header row
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: purpleLightest,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: Text("${item.sno}",
                      style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: purpleColor)),
                ),
                const SizedBox(width: 8),
                Text("Item ${item.sno}",
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary)),
                const Spacer(),
                GestureDetector(
                  onTap: () => ctrl.removeLineItem(idx),
                  child: const Icon(Icons.delete_outline,
                      color: Colors.redAccent, size: 20),
                ),
              ],
            ),
            const Divider(height: 20, color: _kBorder),

            //  Expense Group dropdown
            // Uses ctrl.expenseGroups (top-level groups loaded on init)
            //  Expense Ledger dropdown (user picks this first)
            _label("Expense Ledger"),
            const SizedBox(height: 6),
            _dropdownWidget<ReimbursementDropdownItem>(
              items: ctrl.expenseGroups, // this list now holds ledgers
              selected: item.expenseLedger,
              hint: "Select Expense Ledger",
              onChanged: (v) {
                if (v != null) ctrl.onExpenseLedgerSelected(idx, v);
              },
              display: (e) => e.name ?? '',
            ),
            const SizedBox(height: 12),

//  Expense Group — auto-filled & locked after ledger selection
            _label("Expense Group"),
            const SizedBox(height: 6),
            Obx(() {
              if (item.isLoadingLedgers.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LinearProgressIndicator(color: purpleColor),
                );
              }

              // Not yet fetched — show empty disabled box
              if (item.expenseGroup == null) {
                return Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _kBorder),
                  ),
                  child: Text(
                    item.expenseLedger == null
                        ? "Auto-filled after ledger selection"
                        : "Fetching group...",
                    style: GoogleFonts.dmSans(
                        fontSize: 13, color: Colors.grey.shade400),
                  ),
                );
              }

              // Auto-filled & locked
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _kBorder),
                ),
                child: Row(children: [
                  Icon(Icons.folder_outlined,
                      size: 16, color: Colors.grey.shade500),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.expenseGroup!.name ?? '',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: newTextPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: purpleLightest,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline_rounded,
                            size: 11, color: purpleColor),
                        const SizedBox(width: 3),
                        Text('Auto',
                            style: GoogleFonts.dmSans(
                                fontSize: 10,
                                color: purpleColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ]),
              );
            }),
            const SizedBox(height: 12),

            //  Description
            _label("Description"),
            const SizedBox(height: 6),
            TextFormField(
              controller: _descCtrl,
              onChanged: (_) => _syncItem(),
              maxLines: 2,
              decoration: _inputDecoration("Enter description"),
              style: GoogleFonts.dmSans(fontSize: 14),
            ),
            const SizedBox(height: 12),

            //  Amount
            _label("Amount"),
            const SizedBox(height: 6),
            TextFormField(
              controller: _amountCtrl,
              onChanged: (_) => _syncItem(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: _inputDecoration("0.00"),
              style: GoogleFonts.dmSans(fontSize: 14),
            ),
            const SizedBox(height: 16),

            //  File attachments
            SizedBox(
              width: double.infinity,
              child: _MultiFileUploadButton(
                fileNames: item.attachmentFileNames,
                filePaths: item.attachmentFilePaths,
                isUploading: item.isUploading,
                onTap: () => ctrl.pickAndUploadFiles(idx),
                onRemove: (i) => ctrl.removeAttachment(idx, i),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _label(String text) => Text(text,
      style: GoogleFonts.dmSans(
          fontSize: 12, fontWeight: FontWeight.w600, color: newTextSecondary));

  Widget _dropdownWidget<T>({
    required List<T> items,
    required T? selected,
    required String hint,
    required ValueChanged<T?> onChanged,
    required String Function(T) display,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _kBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: selected,
            hint: Text(hint,
                style: GoogleFonts.dmSans(
                    fontSize: 13, color: Colors.grey.shade400)),
            items: items
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(display(e),
                          style: GoogleFonts.dmSans(
                              fontSize: 13, color: newTextPrimary)),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.dmSans(fontSize: 13, color: Colors.grey.shade400),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _kBorder)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _kBorder)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: purpleColor)),
        filled: true,
        fillColor: Colors.white,
      );
}

//  Multi file upload button
class _MultiFileUploadButton extends StatelessWidget {
  final RxList<String> fileNames;
  final RxList<String> filePaths;
  final RxBool isUploading;
  final VoidCallback onTap;
  final void Function(int) onRemove;

  const _MultiFileUploadButton({
    required this.fileNames,
    required this.filePaths,
    required this.isUploading,
    required this.onTap,
    required this.onRemove,
  });

  void _openFile(String path) {
    final file = File(path);
    if (file.existsSync()) {
      OpenFilex.open(path);
    } else {
      launchUrl(Uri.parse(path), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final names = fileNames.toList();
      final paths = filePaths.toList();
      final uploading = isUploading.value;
      final hasFiles = names.isNotEmpty;

      return GestureDetector(
        onTap: uploading ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: hasFiles ? Colors.green.shade50 : purpleLightest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasFiles
                  ? Colors.green.shade300
                  : purpleColor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              uploading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: purpleColor),
                    )
                  : Icon(
                      hasFiles
                          ? Icons.check_circle_outline
                          : Icons.upload_file_outlined,
                      color: hasFiles ? Colors.green : purpleColor,
                      size: 22,
                    ),
              const SizedBox(height: 4),
              Text(
                hasFiles
                    ? "${names.length} File(s) Attached ✓"
                    : "Attach Files",
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: hasFiles ? Colors.green.shade700 : purpleColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (hasFiles) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(names.length, (i) {
                    final isPdf = names[i].toLowerCase().endsWith('.pdf');
                    return GestureDetector(
                      onTap: () => _openFile(paths[i]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPdf
                                  ? Icons.picture_as_pdf_outlined
                                  : Icons.image_outlined,
                              size: 12,
                              color: isPdf ? Colors.red.shade400 : Colors.green,
                            ),
                            const SizedBox(width: 4),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 100),
                              child: Text(
                                names[i],
                                style: GoogleFonts.dmSans(
                                  fontSize: 10,
                                  color: Colors.green.shade800,
                                  decoration: TextDecoration.underline,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => onRemove(i),
                              child: const Icon(Icons.close,
                                  size: 12, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
