import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../indent_controller/indent_controller.dart';
import '../indent_response/indent_model.dart';
import '../indent_widgets.dart';

class IndentItemsScreen extends StatelessWidget {
  const IndentItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(builder: (ctrl) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: indSurfaceColor,
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                14,
                14,
                14,
                MediaQuery.of(context).viewInsets.bottom + 110,
              ),
              child: Column(children: [
                // ── Add Item form ───────────────────────────────────────
                const _AddItemForm(),
                const SizedBox(height: 12),

                // ── Items list ──────────────────────────────────────────
                if (ctrl.itemLines.isNotEmpty) ...[
                  _itemsHeader(ctrl),
                  const SizedBox(height: 8),
                  ...ctrl.itemLines.asMap().entries.map(
                        (e) => _ItemCard(
                      key: ValueKey(e.value.itemId + e.key.toString()),
                      item: e.value,
                      index: e.key,
                      ctrl: ctrl,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _totalBar(ctrl),
                ],
              ]),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0) _bottomBar(ctrl),
        ]),
      );
    });
  }

  Widget _itemsHeader(IndentController ctrl) {
    return Row(children: [
      const Expanded(
        child: Text('Added Items',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: indTextPrimary)),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: indBlueLightColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('${ctrl.itemLines.length} item(s)',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: indBlueColor)),
      ),
    ]);
  }

  Widget _totalBar(IndentController ctrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: indBlueLightColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: indBlueColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            const Icon(Icons.summarize_outlined, size: 16, color: indBlueColor),
            const SizedBox(width: 6),
            Text(
              'Total Qty: ${ctrl.totalQty.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: indBlueColor),
            ),
          ]),
          if (ctrl.totalAmount > 0)
            Text(
              '₹${_inr(ctrl.totalAmount)}',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: indBlueColor),
            ),
        ],
      ),
    );
  }

  Widget _bottomBar(IndentController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: indBorderColor))),
      child: SafeArea(
        top: false,
        child: IndentPrimaryBtn(
          label: 'Review & Submit →',
          icon: Icons.arrow_forward_rounded,
          onTap: () {
            if (ctrl.itemLines.isEmpty) {
              Get.snackbar('No Items', 'Please add at least one item',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade50,
                  colorText: Colors.red.shade800,
                  margin: const EdgeInsets.all(12));
              return;
            }
            if (ctrl.itemLines.any((i) => i.indentQty <= 0)) {
              Get.snackbar('Invalid Qty', 'All items must have qty > 0',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade50,
                  colorText: Colors.red.shade800,
                  margin: const EdgeInsets.all(12));
              return;
            }
            ctrl.nextStep();
          },
        ),
      ),
    );
  }

  static String _inr(double v) {
    if (v >= 10000000) return '${(v / 10000000).toStringAsFixed(2)} Cr';
    if (v >= 100000) return '${(v / 100000).toStringAsFixed(2)} L';
    final parts = v.toStringAsFixed(2).split('.');
    final whole = parts[0];
    final decimal = parts[1];
    if (whole.length <= 3) return '$whole.$decimal';
    final last3 = whole.substring(whole.length - 3);
    final rest = whole.substring(0, whole.length - 3);
    final buf = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buf.write(',');
      buf.write(rest[i]);
    }
    return '$buf,$last3.$decimal';
  }
}

// ── Add item form (bottom sheet style card) ───────────────────────────────────
class _AddItemForm extends StatefulWidget {
  const _AddItemForm();

  @override
  State<_AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<_AddItemForm> {
  IndentDropdownOption? _selectedItem;
  IndentDropdownOption? _selectedUnit;
  final TextEditingController _qtyCtrl = TextEditingController(text: '1');
  final TextEditingController _rateCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  double _stockAtSite = 0;
  bool _fetchingStock = false;

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _rateCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _onItemSelected(
      IndentDropdownOption? item, IndentController ctrl) async {
    setState(() {
      _selectedItem = item;
      _stockAtSite = 0;
      _fetchingStock = true;
    });

    if (item != null) {
      // Auto-select unit if available
      if (ctrl.unitList.isNotEmpty) {
        setState(() => _selectedUnit = ctrl.unitList.first);
      }
      // Fetch stock at site
      final stock = await ctrl.fetchStockAtSite(int.tryParse(item.id) ?? 0);
      if (mounted) {
        setState(() {
          _stockAtSite = stock ?? 0;
          _fetchingStock = false;
        });
      }
    } else {
      setState(() => _fetchingStock = false);
    }
  }

  void _addItem(IndentController ctrl) {
    if (_selectedItem == null) {
      Get.snackbar('Select Item', 'Please select an item first',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange.shade50,
          colorText: Colors.orange.shade900,
          margin: const EdgeInsets.all(12));
      return;
    }
    final qty = double.tryParse(_qtyCtrl.text) ?? 0;
    if (qty <= 0) {
      Get.snackbar('Invalid Qty', 'Quantity must be greater than 0',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade50,
          colorText: Colors.red.shade800,
          margin: const EdgeInsets.all(12));
      return;
    }
    ctrl.addItem(
      itemId: _selectedItem!.id,
      itemName: _selectedItem!.label,
      itemCode: _selectedItem!.id,
      unit: _selectedUnit?.label ?? '',
      unitId: _selectedUnit?.id ?? '',
      indentQty: qty,
      rate: double.tryParse(_rateCtrl.text) ?? 0,
      stockAtSite: _stockAtSite,
      itemDescription: _descCtrl.text.trim(),
    );
    // Reset form
    setState(() {
      _selectedItem = null;
      _selectedUnit = null;
      _stockAtSite = 0;
      _qtyCtrl.text = '1';
      _rateCtrl.clear();
      _descCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentController>(builder: (ctrl) {
      return IndentCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const IndentSectionHead('Add Item'),

          // Item Name / Code
          IndentSearchableDropdown<IndentDropdownOption>(
            label: 'Item Name / Code',
            value: _selectedItem,
            items: ctrl.itemList,
            isLoading: ctrl.isLoadingItems,
            itemLabel: (o) => o.label,
            onChanged: (v) => _onItemSelected(v, ctrl),
            hint: 'Search item…',
          ),
          const SizedBox(height: 10),

          // Unit Name
          IndentSearchableDropdown<IndentDropdownOption>(
            label: 'Unit Name',
            value: _selectedUnit,
            items: ctrl.unitList,
            isLoading: ctrl.isLoadingUnits,
            itemLabel: (o) => o.label,
            onChanged: (v) => setState(() => _selectedUnit = v),
            hint: 'Select unit…',
          ),
          const SizedBox(height: 10),

          // Qty + Rate row
          Row(children: [
            Expanded(
              child: IndentField(
                label: 'Indent Qty',
                controller: _qtyCtrl,
                hint: '0',
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                ],
                onChanged: (_) => setState(() {}),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IndentField(
                label: 'Rate (₹)',
                controller: _rateCtrl,
                hint: '0.00',
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                onChanged: (_) => setState(() {}),
              ),
            ),
          ]),
          const SizedBox(height: 10),

          // Stock at site chip
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: indSurfaceColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: indBorderColor),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.warehouse_outlined,
                    size: 13, color: indTextSecondary),
                const SizedBox(width: 5),
                const Text('Stock at Site: ',
                    style: TextStyle(fontSize: 11, color: indTextSecondary)),
                if (_fetchingStock)
                  const SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                          strokeWidth: 1.5, color: indBlueColor))
                else
                  Text(
                    _selectedItem == null
                        ? '—'
                        : _stockAtSite.toStringAsFixed(0),
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: indTextPrimary),
                  ),
              ]),
            ),
            const SizedBox(width: 10),
            // Amount preview
            if (_selectedItem != null &&
                (double.tryParse(_rateCtrl.text) ?? 0) > 0) ...[
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: indGreenLightColor,
                  borderRadius: BorderRadius.circular(8),
                  border:
                  Border.all(color: indGreenColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '₹${((double.tryParse(_qtyCtrl.text) ?? 0) * (double.tryParse(_rateCtrl.text) ?? 0)).toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: indGreenColor),
                ),
              ),
            ],
          ]),
          const SizedBox(height: 10),

          // Item description
          IndentField(
            label: 'Item Description',
            controller: _descCtrl,
            hint: 'Additional description or specification…',
            minLines: 2,
            maxLines: 3,
          ),
          const SizedBox(height: 14),

          // Add button
          GestureDetector(
            onTap: () => _addItem(ctrl),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                color: _selectedItem != null ? indBlueColor : indBorderColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded,
                      size: 18,
                      color:
                      _selectedItem != null ? Colors.white : indTextHint),
                  const SizedBox(width: 6),
                  Text('Add Item',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: _selectedItem != null
                              ? Colors.white
                              : indTextHint)),
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }
}

// ── Item card (one row in the list) ──────────────────────────────────────────
class _ItemCard extends StatefulWidget {
  final IndentItemLine item;
  final int index;
  final IndentController ctrl;

  const _ItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.ctrl,
  });

  @override
  State<_ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<_ItemCard> {
  late TextEditingController _qtyCtrl;
  late TextEditingController _rateCtrl;
  late TextEditingController _descCtrl;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _qtyCtrl =
        TextEditingController(text: widget.item.indentQty.toStringAsFixed(0));
    _rateCtrl = TextEditingController(
        text: widget.item.rate > 0 ? widget.item.rate.toStringAsFixed(2) : '');
    _descCtrl = TextEditingController(text: widget.item.itemDescription);
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _rateCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: indBorderColor),
      ),
      child: Column(children: [
        // ── Collapsed header row ────────────────────────────────────────
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Index bubble
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: indBlueLightColor,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Text('${widget.index + 1}',
                    style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: indBlueColor)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.itemName,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: indTextPrimary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(children: [
                        // Qty pill
                        _infoPill(
                          Icons.format_list_numbered_rounded,
                          'Qty: ${item.indentQty.toStringAsFixed(0)} ${item.unit}',
                          indBlueColor,
                          indBlueLightColor,
                        ),
                        const SizedBox(width: 6),
                        // Stock chip
                        if (item.stockAtSite > 0)
                          _infoPill(
                            Icons.warehouse_outlined,
                            'Stock: ${item.stockAtSite.toStringAsFixed(0)}',
                            indGreenColor,
                            indGreenLightColor,
                          ),
                      ]),
                      if (item.rate > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          '₹${item.rate.toStringAsFixed(2)} × ${item.indentQty.toStringAsFixed(0)} = ₹${item.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 10, color: indTextSecondary),
                        ),
                      ],
                    ]),
              ),
              const SizedBox(width: 8),
              // Actions
              Column(children: [
                GestureDetector(
                  onTap: () => setState(() => _isExpanded = !_isExpanded),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: indBlueLightColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.edit_rounded,
                      size: 14,
                      color: indBlueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => widget.ctrl.removeItem(item),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: indRedLightColor,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: const Icon(Icons.delete_outline_rounded,
                        size: 14, color: indRedColor),
                  ),
                ),
              ]),
            ]),
          ),
        ),

        // ── Expanded edit section ───────────────────────────────────────
        if (_isExpanded) ...[
          const Divider(height: 1, color: indBorderColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Indent Qty',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: indTextSecondary)),
                        const SizedBox(height: 4),
                        Row(children: [
                          _qtyBtn(
                            icon: Icons.remove_rounded,
                            onTap: () {
                              widget.ctrl.decreaseQty(item);
                              _qtyCtrl.text = item.indentQty.toStringAsFixed(0);
                            },
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _qtyCtrl,
                              textAlign: TextAlign.center,
                              keyboardType:
                              const TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,3}')),
                              ],
                              onChanged: (v) {
                                final q = double.tryParse(v) ?? 0;
                                widget.ctrl.setIndentQty(item, q);
                              },
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: indTextPrimary),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: indBorderColor)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: indBorderColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: indBlueColor, width: 1.5)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _qtyBtn(
                            icon: Icons.add_rounded,
                            onTap: () {
                              widget.ctrl.increaseQty(item);
                              _qtyCtrl.text = item.indentQty.toStringAsFixed(0);
                            },
                          ),
                        ]),
                      ]),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: IndentField(
                    label: 'Rate (₹)',
                    controller: _rateCtrl,
                    hint: '0.00',
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    onChanged: (v) {
                      widget.ctrl.updateItemRate(item, double.tryParse(v) ?? 0);
                    },
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              IndentField(
                label: 'Item Description',
                controller: _descCtrl,
                hint: 'Specification or notes…',
                minLines: 2,
                maxLines: 3,
                onChanged: (v) => widget.ctrl.setItemDescription(item, v),
              ),
            ]),
          ),
        ],
      ]),
    );
  }

  Widget _infoPill(IconData icon, String text, Color fg, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 10, color: fg),
        const SizedBox(width: 3),
        Text(text,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600, color: fg)),
      ]),
    );
  }

  Widget _qtyBtn({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
            color: indBlueLightColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: indBlueColor.withValues(alpha: 0.3))),
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: indBlueColor),
      ),
    );
  }
}
