import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../grn_controller/grn_controller.dart';
import '../grn_response/grn_models.dart';
import '../grn_widgets.dart';


class GrnDirectItemForm extends StatefulWidget {
  const GrnDirectItemForm({super.key});

  @override
  State<GrnDirectItemForm> createState() => _GrnDirectItemFormState();
}

class _GrnDirectItemFormState extends State<GrnDirectItemForm> {
  // Form controllers
  final _qtyCtrl = TextEditingController();
  final _rateCtrl = TextEditingController();
  final _gstCtrl = TextEditingController();
  final _discCtrl = TextEditingController(text: '0');
  final _remarksCtrl = TextEditingController();
  final _discPctCtrl = TextEditingController(text: '0'); // ← add this

  // Selected values
  GrnDropdownOption? _selectedItem;
  GrnDropdownOption? _selectedUnit;
  GrnDropdownOption? _selectedMake;
  GrnDropdownOption? _selectedGodown;

  // ── NEW: tracks whether GST was auto-filled from API (locks field) ────────
  bool _gstFromApi = false;

  // Computed preview
  double get _qty => double.tryParse(_qtyCtrl.text) ?? 0;
  double get _rate => double.tryParse(_rateCtrl.text) ?? 0;
  double get _gstPct => double.tryParse(_gstCtrl.text) ?? 0;
  double get _discPct => double.tryParse(_discPctCtrl.text) ?? 0;
  double get _disc => double.tryParse(_discCtrl.text) ?? 0;

  // ✅ Replace existing _amount getter:
  double get _discAmt => double.tryParse(_discCtrl.text) ?? 0;

  double get _amount => (_qty * _rate) - _discAmt;
  double get _gstAmt => _amount * _gstPct / 100;
  double get _totalAmt => _amount + _gstAmt;

  GrnDropdownOption? get _effectiveGodown =>
      _selectedGodown ?? Get.find<GrnController>().selectedGodown;

  bool get _isValid =>
      _selectedItem != null &&
          _selectedUnit != null &&
          _selectedMake != null &&
          _effectiveGodown != null &&
          _qty > 0 &&
          _rate > 0 &&
          _gstPct >= 0;

  // ── Reset all form fields ─────────────────────────────────────────────────
  void _resetForm() {
    setState(() {
      _selectedItem = null;
      _selectedUnit = null;
      _selectedMake = null;
      _selectedGodown = null;
      _gstFromApi = false;
      _qtyCtrl.clear();
      _rateCtrl.clear();
      _gstCtrl.clear();
      _discPctCtrl.text = '0';
      _discCtrl.text = '0';
      _remarksCtrl.clear();
    });
  }

  void _addItem(GrnController ctrl) {
    if (!_isValid) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: newRedColor,
        ),
      );
      return;
    }

    final godown = _effectiveGodown!;

    ctrl.addDirectItem(
      itemName: _selectedItem!.label,
      itemCode: _selectedItem!.id,
      unit: _selectedUnit!.label,
      make: _selectedMake!.label,
      godownId: godown.id,
      godownLabel: godown.label,
      qty: _qty,
      rate: _rate,
      gstPct: _gstPct,
      discountPct: _discPct,
      discount: _discAmt,
      remarks: _remarksCtrl.text.trim(),
    );

    _resetForm(); // ← uses _resetForm instead of inline setState
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _rateCtrl.dispose();
    _gstCtrl.dispose();
    _discCtrl.dispose();
    _discPctCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GrnController>();
    return Column(children: [
      // ── Add item form card ──────────────────────────────────────────────
      GrnCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const GrnSectionHead('Add Item'),

          // ── Item Name / Code ────────────────────────────────────────────
          _SearchableField(
            label: 'Item Name / Code *',
            value: _selectedItem,
            items: ctrl.directItemList,
            isLoading: ctrl.isLoadingDirectItems,
            hint: 'Search item name or code…',
            onChanged: (v) async {
              setState(() {
                _selectedItem = v;
                _selectedMake = null;
               // _gstFromApi = false; // reset lock when item changes
                _gstCtrl.clear(); // clear old GST value
              });
              if (v != null) {
                // Auto-fill GST % from item detail API
                final detail = await ctrl.fetchItemDetail(
                  int.tryParse(v.id) ?? 0,
                );
                if (detail != null && mounted) {
                  setState(() {
                    _gstCtrl.text = detail.gstpercent % 1 == 0
                        ? detail.gstpercent.toInt().toString()
                        : detail.gstpercent.toString();
                   // _gstFromApi = true; // lock field after API fill
                  });
                }
                // Load makes for this item
                await ctrl.fetchMakes(dependentId: int.tryParse(v.id) ?? 0);
                if (mounted) setState(() {});
              }
            },
            hasError: _selectedItem == null,
          ),
          const SizedBox(height: 10),

          // ── Unit + Make ─────────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: _SearchableField(
                label: 'Unit *',
                value: _selectedUnit,
                items: ctrl.unitList,
                isLoading: ctrl.isLoadingUnit,
                hint: 'Select unit…',
                onChanged: (v) => setState(() => _selectedUnit = v),
                hasError: _selectedUnit == null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _SearchableField(
                label: 'Make *',
                value: _selectedMake,
                items: ctrl.makeList,
                isLoading: ctrl.isLoadingMake,
                hint: 'Select make…',
                onChanged: (v) => setState(() => _selectedMake = v),
                hasError: _selectedMake == null,
              ),
            ),
          ]),
          const SizedBox(height: 10),

          // ── Godown ──────────────────────────────────────────────────────
          _SearchableField(
            label: 'Godown *',
            value: _selectedGodown ?? ctrl.selectedGodown,
            items: ctrl.godownList,
            isLoading: ctrl.isLoadingGodown,
            hint: 'Select godown…',
            onChanged: (v) => setState(() => _selectedGodown = v),
            hasError: (_selectedGodown ?? ctrl.selectedGodown) == null,
          ),
          const SizedBox(height: 10),

          // ── Qty + Rate ──────────────────────────────────────────────────
          Row(children: [
            Expanded(
              child: _NumField(
                label: 'Qty *',
                controller: _qtyCtrl,
                hint: '0',
                hasError: _qty <= 0,
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _NumField(
                label: 'Rate *',
                controller: _rateCtrl,
                hint: '0.00',
                decimal: true,
                hasError: _rate <= 0,
                onChanged: (_) => setState(() {}),
              ),
            ),
          ]),
          const SizedBox(height: 10),

          // ── GST % (locked after API fill) + Discount ────────────────────
          Row(children: [
            Expanded(
                child: _GstField(
                  controller: _gstCtrl,
                  isLocked: _gstFromApi,
                  onChanged: (_) => setState(() {}),
                )),
            const SizedBox(width: 10),
            // ✅ NEW: Discount %
            // ── Replace the Discount % NumField onChanged ──────────────────────────────
            Expanded(
              child: _NumField(
                label: 'Discount %',
                controller: _discPctCtrl,
                hint: '0',
                decimal: true,
                onChanged: (v) {
                  setState(() {
                    // ✅ Auto-fill flat ₹ discount field from %
                    final pct = double.tryParse(v) ?? 0;
                    if (pct > 0) {
                      final computed = (_qty * _rate) * pct / 100;
                      _discCtrl.text = computed.toStringAsFixed(2);
                    } else {
                      _discCtrl.text = '0';
                    }
                  });
                },
              ),
            ),
          ]),
          const SizedBox(height: 10),

// ✅ NEW: Discount ₹ (flat amount) on its own row
          _NumField(
            label: 'Discount (₹)',
            controller: _discCtrl,
            hint: '0',
            decimal: true,
            onChanged: (v) {
              setState(() {
                // ✅ If user manually types flat ₹, clear the % field
                final flat = double.tryParse(v) ?? 0;
                final pctComputed =
                (_qty * _rate) > 0 ? (flat / (_qty * _rate) * 100) : 0.0;
                // Only clear % if it doesn't match the computed value
                // (i.e. user is typing manually, not synced from % field)
                final currentPct = double.tryParse(_discPctCtrl.text) ?? 0;
                final expectedFlat = (_qty * _rate) * currentPct / 100;
                if ((flat - expectedFlat).abs() > 0.01) {
                  _discPctCtrl.text =
                  pctComputed > 0 ? pctComputed.toStringAsFixed(2) : '0';
                }
              });
            },
          ),
          const SizedBox(height: 10),

          // ── Remarks ─────────────────────────────────────────────────────
          GrnField(
            label: 'Remarks',
            controller: _remarksCtrl,
            hint: 'Optional note…',
            minLines: 2,
          ),
          const SizedBox(height: 14),

          // ── Live calculation preview ────────────────────────────────────
          if (_qty > 0 && _rate > 0)
            _CalcPreview(
              qty: _qty,
              rate: _rate,
              gstPct: _gstPct,
              disc: _disc,
              discPct: _discPct,
              amount: _amount,
              gstAmt: _gstAmt,
              totalAmt: _totalAmt,
            ),

          if (_qty > 0 && _rate > 0) const SizedBox(height: 14),

          // ── Add button ──────────────────────────────────────────────────
          GrnPrimaryBtn(
            label: 'Add Item',
            icon: Icons.add_rounded,
            color: newGreenColor,
            onTap: () => _addItem(ctrl),
          ),
        ]),
      ),

      // ── Added items list ────────────────────────────────────────────────
      GetBuilder<GrnController>(
        id: 'items_list',   // ← add this
        builder: (ctrl) => ctrl.itemLines.isEmpty
            ? const SizedBox.shrink()
            : GrnCard(
          padding: EdgeInsets.zero,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: GrnSectionHead(
                'Added Items',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 9, vertical: 3),
                  decoration: BoxDecoration(
                      color: newGreenLightColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('${ctrl.itemLines.length} items',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: newGreenColor)),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ctrl.itemLines.length,
              separatorBuilder: (_, __) =>
              const Divider(height: 1, color: newBorderColor),
              itemBuilder: (_, i) => _DirectItemRow(
                  item: ctrl.itemLines[i], ctrl: ctrl, index: i),
            ),
            _DirectTotalsFooter(ctrl: ctrl),
          ]),
        ),
      ),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// GST field — read-only + green badge when auto-filled from API
// ═══════════════════════════════════════════════════════════════════════════════
class _GstField extends StatelessWidget {
  final TextEditingController controller;
  final bool isLocked;
  final ValueChanged<String>? onChanged;

  const _GstField({
    required this.controller,
    required this.isLocked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Label row with optional lock badge
      Row(children: [
        const Text('GST % *',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: newTextPrimary)),
        // if (isLocked) ...[
        //   const SizedBox(width: 6),
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //     decoration: BoxDecoration(
        //       color: newGreenLightColor,
        //       borderRadius: BorderRadius.circular(4),
        //     ),
        //     child: const Row(mainAxisSize: MainAxisSize.min, children: [
        //       Icon(Icons.lock_rounded, size: 9, color: newGreenColor),
        //       SizedBox(width: 3),
        //       Text('Auto-filled',
        //           style: TextStyle(
        //               fontSize: 9,
        //               fontWeight: FontWeight.w700,
        //               color: newGreenColor)),
        //     ]),
        //   ),
        // ],
      ]),
      const SizedBox(height: 5),

      // Text field
      TextField(
        controller: controller,
        readOnly: isLocked, // ← can't edit when locked
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))
        ],
        onChanged: isLocked ? null : onChanged,
        style: const TextStyle(fontSize: 13, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: '0',
          hintStyle: const TextStyle(color: newTextHint),
          filled: true,
          // Green tint when locked, normal when editable
          fillColor: isLocked ? newGreenLightColor : newSurfaceColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          // Lock icon suffix when locked
          suffixIcon: isLocked
              ? const Padding(
              padding: EdgeInsets.all(13),
              child:
              Icon(Icons.lock_rounded, size: 15, color: newGreenColor))
              : null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: isLocked ? newGreenColor : newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
              BorderSide(color: isLocked ? newGreenColor : newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: isLocked ? newGreenColor : newBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// Live calculation preview box
// ═══════════════════════════════════════════════════════════════════════════════
class _CalcPreview extends StatelessWidget {
  final double qty, rate, gstPct, disc, discPct, amount, gstAmt, totalAmt;
  const _CalcPreview({
    required this.qty,
    required this.rate,
    required this.gstPct,
    required this.discPct,
    required this.disc,
    required this.amount,
    required this.gstAmt,
    required this.totalAmt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: newBlueLightColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Live Preview',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: newBlueColor, borderRadius: BorderRadius.circular(4)),
              child: const Text('AUTO',
                  style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        //_row('Qty × Rate', '${qty.toInt()} × ₹${rate.toStringAsFixed(2)}'),
        _row('Amount', '₹${amount.toStringAsFixed(2)}'),
        if (disc > 0)
          _row(
              discPct > 0
                  ? 'Discount ${discPct.toStringAsFixed(1)}%'
                  : 'Discount',
              '- ₹${disc.toStringAsFixed(2)}'),

        _row('GST ${gstPct.toInt()}%', '₹${gstAmt.toStringAsFixed(2)}'),
        const Divider(color: newBlueColor, height: 16, thickness: 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor)),
            Text('₹${totalAmt.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor)),
          ],
        ),
      ]),
    );
  }

  Widget _row(String label, String val) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 11, color: newBlueColor)),
        Text(val,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: newBlueColor)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// Added item row (compact, with delete)
// ═══════════════════════════════════════════════════════════════════════════════
class _DirectItemRow extends StatelessWidget {
  final GrnItemLine item;
  final GrnController ctrl;
  final int index;
  const _DirectItemRow(
      {required this.item, required this.ctrl, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
              color: newGreenLightColor,
              borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text('${index + 1}',
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: newGreenColor)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.itemName,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
            const SizedBox(height: 3),
            Wrap(spacing: 5, children: [
              _pill(item.itemCode, newSurfaceColor, newTextSecondary),
              _pill(item.unit, newSurfaceColor, newTextSecondary),
              _pill('Qty: ${item.receiveNowQty.toInt()}', newGreenLightColor,
                  newGreenColor),
              _pill('₹${item.rate.toStringAsFixed(2)}', newBlueLightColor,
                  newBlueColor),
              _pill('GST ${item.gstPercent.toInt()}%', newSurfaceColor,
                  newTextSecondary),
              if (item.discountPercent > 0)
                _pill('Disc ${item.discountPercent.toStringAsFixed(1)}%',
                    newOrangeLightColor, newOrangeColor),
            ]),
            const SizedBox(height: 4),
            Text(
              'Godown: ${ctrl.godownList.firstWhereOrNull((g) => g.id == item.selectedGodownId)?.label ?? ctrl.selectedGodown?.label ?? "—"}',
              style: const TextStyle(fontSize: 10, color: newTextSecondary),
            ),
          ]),
        ),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text('₹${item.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: newBlueColor)),
          const SizedBox(height: 6),
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
      ]),
    );
  }

  Widget _pill(String text, Color bg, Color fg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration:
    BoxDecoration(color: bg, borderRadius: BorderRadius.circular(5)),
    child: Text(text,
        style:
        TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: fg)),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// Totals footer for direct items
// ═══════════════════════════════════════════════════════════════════════════════
class _DirectTotalsFooter extends StatelessWidget {
  final GrnController ctrl;
  const _DirectTotalsFooter({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
          color: newSurfaceColor,
          border: Border(top: BorderSide(color: newBorderColor))),
      child: Column(children: [
        _row('Subtotal', '₹${ctrl.subtotal.toStringAsFixed(2)}'),
        const SizedBox(height: 6),
        _row('Total GST', '₹${ctrl.totalGst.toStringAsFixed(2)}'),
        const Divider(height: 16, color: newBorderColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
          ],
        ),
      ]),
    );
  }

  Widget _row(String l, String v) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(l,
          style: const TextStyle(fontSize: 12, color: newTextSecondary)),
      Text(v,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// Reusable searchable field
// ═══════════════════════════════════════════════════════════════════════════════
class _SearchableField extends StatelessWidget {
  final String label, hint;
  final GrnDropdownOption? value;
  final List<GrnDropdownOption> items;
  final bool isLoading;
  final bool hasError;
  final ValueChanged<GrnDropdownOption?> onChanged;

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
          final picked = await showModalBottomSheet<GrnDropdownOption>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20))),
            builder: (_) =>
                _PickerSheet(title: label, items: items, selected: value),
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
                  height: 14,
                  width: 14,
                  child: CircularProgressIndicator(
                      strokeWidth: 1.5, color: newBlueColor))
                  : Text(
                value?.label ?? hint,
                style: TextStyle(
                    fontSize: 13,
                    color: value != null
                        ? newTextPrimary
                        : newTextSecondary),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded,
                size: 18, color: newTextSecondary),
          ]),
        ),
      ),
    ]);
  }
}

// ── Bottom sheet picker ───────────────────────────────────────────────────────
class _PickerSheet extends StatefulWidget {
  final String title;
  final List<GrnDropdownOption> items;
  final GrnDropdownOption? selected;
  const _PickerSheet({required this.title, required this.items, this.selected});

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
              width: 38,
              height: 4,
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
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                final isSelected = item.id == widget.selected?.id;
                return ListTile(
                  dense: true,
                  onTap: () => Navigator.pop(context, item),
                  leading: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: isSelected
                            ? newBlueLightColor
                            : newSurfaceColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(
                      item.id.length <= 4 ? item.id : '•',
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? newBlueColor
                              : newTextSecondary),
                    ),
                  ),
                  title: Text(item.label,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? newBlueColor
                              : newTextPrimary)),
                  trailing: isSelected
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

// ═══════════════════════════════════════════════════════════════════════════════
// Number input field
// ═══════════════════════════════════════════════════════════════════════════════
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
        keyboardType: TextInputType.numberWithOptions(decimal: decimal),
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
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }
}
