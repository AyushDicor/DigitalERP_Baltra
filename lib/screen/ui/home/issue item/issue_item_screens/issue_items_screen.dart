import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_constant_new.dart';
import '../../../../../utils/show_message.dart';
import '../issue_item_contoller/issue_item_contoller.dart';
import '../issue_item_response/issue_item_model.dart';
import '../issue_item_widgets.dart';


class IssueItemItemsScreen extends StatelessWidget {
  const IssueItemItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueItemEntryController>(builder: (ctrl) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  14, 14, 14,
                  MediaQuery.of(context).viewInsets.bottom + 110,
                ),
                child: Column(children: [

                  // ── Direct issue — entry form ──────────────────────────
                  if (ctrl.selectedSource == IssueItemSource.direct)
                    const _IssueDirectItemForm(),

                  // ── From Indent — indent picker ────────────────────────
                  if (ctrl.selectedSource == IssueItemSource.fromIndent)
                    IssCard(
                      padding: EdgeInsets.zero,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                          child: IssSectionHead(
                            'Select Indent',
                            trailing: ctrl.isLoadingIndents
                                ? const SizedBox(
                                width: 14, height: 14,
                                child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: newBlueColor))
                                : GestureDetector(
                              onTap: ctrl.fetchPendingIndents,
                              child: const Icon(Icons.refresh_rounded,
                                  size: 18, color: newBlueColor),
                            ),
                          ),
                        ),
                        if (ctrl.isLoadingIndents)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                            child: _shimmer(),
                          )
                        else if (ctrl.pendingIndentList.isEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                            child: _emptyState(
                                'No pending indents found',
                                Icons.assignment_outlined),
                          )
                        else
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(14, 0, 14, 14),
                            child: Column(
                              children: ctrl.pendingIndentList
                                  .map((i) => _IndentTile(ctrl: ctrl, item: i))
                                  .toList(),
                            ),
                          ),
                      ]),
                    ),

                  // ── Item lines (both sources) ──────────────────────────
                  if (ctrl.itemLines.isNotEmpty || ctrl.isBusy)
                    IssCard(
                      padding: EdgeInsets.zero,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                          child: IssSectionHead(
                            'Item Details',
                            trailing: _countBadge(ctrl.itemLines.length),
                          ),
                        ),
                        if (ctrl.isBusy)
                          Padding(
                              padding: const EdgeInsets.all(14),
                              child: _shimmer())
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ctrl.itemLines.length,
                            separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: newBorderColor),
                            itemBuilder: (_, i) => _ItemRow(
                                ctrl: ctrl,
                                item: ctrl.itemLines[i],
                                index: i),
                          ),
                        if (!ctrl.isBusy && ctrl.itemLines.isNotEmpty)
                          _totalsFooter(ctrl),
                      ]),
                    ),
                ]),
              ),
            ),

            // ── Bottom CTA ─────────────────────────────────────────────────
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              _bottomBar(ctrl),
          ]),
        ),
      );
    });
  }

  Widget _totalsFooter(IssueItemEntryController ctrl) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
          color: newSurfaceColor,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: Column(children: [
        _totalRow('Total Qty',    ctrl.totalQty.toStringAsFixed(2)),
        const SizedBox(height: 6),
        _totalRow('Total Amount', '₹${ctrl.totalAmount.toStringAsFixed(2)}'),
        const Divider(height: 16, color: newBorderColor),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Grand Total',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          Text('₹${ctrl.grandTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: newBlueColor)),
        ]),
      ]),
    );
  }

  Widget _totalRow(String l, String v) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l,
            style: const TextStyle(fontSize: 12, color: newTextSecondary)),
        Text(v,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: newTextPrimary)),
      ]);

  Widget _bottomBar(IssueItemEntryController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: SafeArea(
        top: false,
        child: IssPrimaryBtn(
          label: 'Review & Submit →',
          icon: Icons.arrow_forward_rounded,
          onTap: () {
            if (ctrl.itemLines.isEmpty) {
              ShowMessage.showSnackBar('No Items',
                  ctrl.selectedSource == IssueItemSource.fromIndent
                      ? 'Please select an indent first'
                      : 'Please add at least one item');
              return;
            }
            if (ctrl.itemLines.any((i) => i.qty <= 0)) {
              ShowMessage.showSnackBar(
                  'Invalid Qty', 'All items must have qty > 0');
              return;
            }
            ctrl.nextStep();
          },
        ),
      ),
    );
  }

  Widget _shimmer() => Column(
    children: List.generate(
        3,
            (_) => Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: newBorderColor,
              borderRadius: BorderRadius.circular(12)),
        )),
  );

  Widget _emptyState(String msg, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(children: [
      Icon(icon, size: 36, color: newBorderColor),
      const SizedBox(height: 8),
      Text(msg,
          style: const TextStyle(fontSize: 13, color: newTextSecondary)),
    ]),
  );

  Widget _countBadge(int count) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(
        color: newBlueLightColor, borderRadius: BorderRadius.circular(20)),
    child: Text('$count items',
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: newBlueColor)),
  );
}

// ── Indent tile — now uses _IndentStub ───────────────────────────────────────
class _IndentTile extends StatelessWidget {
  final IssueItemEntryController ctrl;
  final PendingIndent  item;            // ← was IssueItemListItem
  const _IndentTile({required this.ctrl, required this.item});

  @override
  Widget build(BuildContext context) {
    final isSelected = ctrl.selectedIndent?.id == item.id;
    return GestureDetector(
      onTap: () => ctrl.selectIndent(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? newBlueLightColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? newBlueColor : newBorderColor,
            width: isSelected ? 1.8 : 1,
          ),
        ),
        child: Row(children: [
          // Radio circle
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 20, height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? newBlueColor : Colors.white,
              border: Border.all(
                  color: isSelected ? newBlueColor : newBorderColor, width: 2),
            ),
            alignment: Alignment.center,
            child: isSelected
                ? Container(
                width: 8, height: 8,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle))
                : null,
          ),
          const SizedBox(width: 12),

          // Indent number
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.indentNo,           // ← indentno from API
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: newTextPrimary)),
                  const SizedBox(height: 3),
                  Text('Indent #${item.id}',    // ← indentid from API
                      style: const TextStyle(
                          fontSize: 11, color: newTextSecondary)),
                ]),
          ),

          // Selected checkmark
          if (isSelected)
            const Icon(Icons.check_circle_rounded,
                size: 18, color: newBlueColor),
        ]),
      ),
    );
  }
}

// ── Item row (editable qty) ───────────────────────────────────────────────────
class _ItemRow extends StatelessWidget {
  final IssueItemEntryController ctrl;
  final IssueItemLine item;
  final int index;
  const _ItemRow(
      {required this.ctrl, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Index badge
        Container(
          width: 26, height: 26,
          decoration: BoxDecoration(
              color: newBlueLightColor,
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: newBlueColor)),
        ),
        const SizedBox(width: 10),

        // Name + unit + rate
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemName,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary)),
                const SizedBox(height: 4),
                Wrap(spacing: 5, children: [
                  _pill(item.unitName, newSurfaceColor, newTextSecondary),
                  _pill('₹${item.rate.toStringAsFixed(2)}',
                      newBlueLightColor, newBlueColor),
                  _pill('Amt: ₹${item.amount.toStringAsFixed(2)}',
                      newGreenLightColor, newGreenColor),
                ]),
              ]),
        ),
        const SizedBox(width: 8),

        // Qty stepper
        _IssQtyField(ctrl: ctrl, item: item),
        const SizedBox(width: 6),

        // Delete
        GestureDetector(
          onTap: () => ctrl.removeItem(item),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: newRedLightColor,
                borderRadius: BorderRadius.circular(7),
                border:
                Border.all(color: newRedColor.withValues(alpha: 0.3))),
            child: const Icon(Icons.delete_outline_rounded,
                size: 15, color: newRedColor),
          ),
        ),
      ]),
    );
  }

  Widget _pill(String text, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
    child: Text(text,
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w700, color: fg)),
  );
}

// ── Qty stepper ───────────────────────────────────────────────────────────────
class _IssQtyField extends StatefulWidget {
  final IssueItemEntryController ctrl;
  final IssueItemLine item;
  const _IssQtyField({required this.ctrl, required this.item});

  @override
  State<_IssQtyField> createState() => _IssQtyFieldState();
}

class _IssQtyFieldState extends State<_IssQtyField> {
  late final TextEditingController _tc;

  @override
  void initState() {
    super.initState();
    _tc = TextEditingController(text: widget.item.qty.toInt().toString());
  }

  @override
  void dispose() { _tc.dispose(); super.dispose(); }

  void _sync() {
    final val = widget.item.qty.toInt().toString();
    if (_tc.text != val) {
      _tc.value = _tc.value.copyWith(
          text: val,
          selection: TextSelection.collapsed(offset: val.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    _sync();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: newBorderColor),
          borderRadius: BorderRadius.circular(9)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          onTap: () { widget.ctrl.decreaseQty(widget.item); _sync(); },
          child: Container(
            width: 30, height: 34,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8))),
            alignment: Alignment.center,
            child: const Icon(Icons.remove, size: 14, color: newBlueColor),
          ),
        ),
        SizedBox(
          width: 40,
          child: TextField(
            controller: _tc,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: newTextPrimary),
            decoration: const InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.zero),
            onChanged: (v) =>
                widget.ctrl.updateItemQty(widget.item, double.tryParse(v) ?? 0),
          ),
        ),
        GestureDetector(
          onTap: () { widget.ctrl.increaseQty(widget.item); _sync(); },
          child: Container(
            width: 30, height: 34,
            decoration: const BoxDecoration(
                color: newBlueColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8))),
            alignment: Alignment.center,
            child: const Icon(Icons.add, size: 14, color: Colors.white),
          ),
        ),
      ]),
    );
  }
}

// ── Direct item form ──────────────────────────────────────────────────────────
class _IssueDirectItemForm extends StatefulWidget {
  const _IssueDirectItemForm();

  @override
  State<_IssueDirectItemForm> createState() => _IssueDirectItemFormState();
}

class _IssueDirectItemFormState extends State<_IssueDirectItemForm> {
  final _qtyCtrl  = TextEditingController();
  final _rateCtrl = TextEditingController();

  IssueItemDropdownOption? _selectedItem;
  IssueItemDropdownOption? _selectedUnit;

  double get _qty  => double.tryParse(_qtyCtrl.text)  ?? 0;
  double get _rate => double.tryParse(_rateCtrl.text) ?? 0;
  double get _amt  => _qty * _rate;

  bool get _isValid =>
      _selectedItem != null && _selectedUnit != null && _qty > 0 && _rate >= 0;

  void _resetForm() => setState(() {
    _selectedItem = null;
    _selectedUnit = null;
    _qtyCtrl.clear();
    _rateCtrl.clear();
  });

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<IssueItemEntryController>();
    return IssCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const IssSectionHead('Add Item'),

        _SearchableField(
          label: 'Item *',
          value: _selectedItem,
          items: ctrl.itemList,
          isLoading: ctrl.isLoadingItems,
          hint: 'Search item…',
          onChanged: (v) => setState(() => _selectedItem = v),
          hasError: _selectedItem == null,
        ),
        const SizedBox(height: 10),

        Row(children: [
          Expanded(
            child: _SearchableField(
              label: 'Unit *',
              value: _selectedUnit,
              items: ctrl.unitList,
              isLoading: ctrl.isLoadingUnits,
              hint: 'Unit…',
              onChanged: (v) => setState(() => _selectedUnit = v),
              hasError: _selectedUnit == null,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _NumField(
              label: 'Qty *',
              controller: _qtyCtrl,
              hint: '0',
              hasError: _qty <= 0,
              onChanged: (_) => setState(() {}),
            ),
          ),
        ]),
        const SizedBox(height: 10),

        _NumField(
          label: 'Rate',
          controller: _rateCtrl,
          hint: '0.00',
          decimal: true,
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 10),

        if (_qty > 0)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: newBlueLightColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_qty.toInt()} × ₹${_rate.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 12, color: newBlueColor)),
                  Text('= ₹${_amt.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: newBlueColor)),
                ]),
          ),

        IssPrimaryBtn(
          label: 'Add Item',
          icon: Icons.add_rounded,
          color: newGreenColor,
          onTap: () {
            if (!_isValid) { setState(() {}); return; }
            ctrl.addDirectItem(
              itemId:   int.tryParse(_selectedItem!.id) ?? 0,
              itemName: _selectedItem!.label,
              unitId:   int.tryParse(_selectedUnit!.id) ?? 0,
              unitName: _selectedUnit!.label,
              qty:      _qty,
              rate:     _rate,
            );
            _resetForm();
          },
        ),
      ]),
    );
  }
}

// ── Reusable searchable field ─────────────────────────────────────────────────
class _SearchableField extends StatelessWidget {
  final String label, hint;
  final IssueItemDropdownOption? value;
  final List<IssueItemDropdownOption> items;
  final bool isLoading, hasError;
  final ValueChanged<IssueItemDropdownOption?> onChanged;

  const _SearchableField({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.isLoading,
    required this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 5),
      GestureDetector(
        onTap: isLoading
            ? null
            : () async {
          final picked =
          await showModalBottomSheet<IssueItemDropdownOption>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) => _PickerSheet(
                title: label, items: items, selected: value),
          );
          if (picked != null) onChanged(picked);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: hasError && value == null
                  ? newRedColor.withValues(alpha: 0.5)
                  : newBorderColor,
              width: hasError && value == null ? 1.5 : 1,
            ),
          ),
          child: Row(children: [
            Expanded(
              child: isLoading
                  ? const SizedBox(
                  width: 14, height: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: newBlueColor))
                  : Text(value?.label ?? hint,
                  style: TextStyle(
                      fontSize: 13,
                      color: value != null
                          ? newTextPrimary
                          : newTextSecondary)),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: newTextSecondary),
          ]),
        ),
      ),
    ]);
  }
}

class _PickerSheet extends StatefulWidget {
  final String title;
  final List<IssueItemDropdownOption> items;
  final IssueItemDropdownOption? selected;
  const _PickerSheet(
      {required this.title, required this.items, this.selected});

  @override
  State<_PickerSheet> createState() => _PickerSheetState();
}

class _PickerSheetState extends State<_PickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.items
        .where((i) =>
    i.label.toLowerCase().contains(_query.toLowerCase()) ||
        i.id.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (_, sc) => Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
              width: 38, height: 4,
              decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: newTextPrimary)),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: newSurfaceColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: filtered.isEmpty
                ? const Center(
                child: Text('No results',
                    style: TextStyle(color: newTextSecondary)))
                : ListView.builder(
              controller: sc,
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final item = filtered[i];
                final sel = item.id == widget.selected?.id;
                return ListTile(
                  dense: true,
                  onTap: () => Navigator.pop(context, item),
                  leading: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                        color: sel
                            ? newBlueLightColor
                            : newSurfaceColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      item.id.length <= 4 ? item.id : '•',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: sel
                              ? newBlueColor
                              : newTextSecondary),
                    ),
                  ),
                  title: Text(item.label,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: sel
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color:
                          sel ? newBlueColor : newTextPrimary)),
                  trailing: sel
                      ? const Icon(Icons.check_circle_rounded,
                      size: 18, color: newBlueColor)
                      : null,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

class _NumField extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final bool decimal, hasError;
  final ValueChanged<String>? onChanged;

  const _NumField({
    required this.label,
    required this.controller,
    required this.hint,
    this.decimal = false,
    this.hasError = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
      const SizedBox(height: 5),
      TextField(
        controller: controller,
        keyboardType:
        TextInputType.numberWithOptions(decimal: decimal),
        inputFormatters: decimal
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))]
            : [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: newTextHint),
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: hasError
                      ? newRedColor.withValues(alpha: 0.5)
                      : newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: hasError
                      ? newRedColor.withValues(alpha: 0.5)
                      : newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}