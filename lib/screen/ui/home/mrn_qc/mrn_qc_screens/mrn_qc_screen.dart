import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../mrn_qc_controller/mrn_qc_controller.dart';
import '../mrn_qc_model/mrn_qc_models.dart';

class MrnQcScreen extends StatefulWidget {
  const MrnQcScreen({super.key});

  @override
  State<MrnQcScreen> createState() => _MrnQcScreenState();
}

class _MrnQcScreenState extends State<MrnQcScreen>
    with SingleTickerProviderStateMixin {
  late MrnQcScreenController ctrl;
  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    Get.delete<MrnQcScreenController>(force: true);
    ctrl = Get.put(MrnQcScreenController());

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    Get.delete<MrnQcScreenController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MrnQcScreenController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: newSurfaceColor,
          appBar: _buildAppBar(ctrl),
          body: ctrl.isQcLoading
              ? _buildShimmerLoader()
              : ctrl.detail == null
              ? _buildError()
              : FadeTransition(
            opacity: _fadeAnim,
            child: _buildBody(ctrl),
          ),
          bottomNavigationBar: ctrl.isQcLoading || ctrl.detail == null || ctrl.isCompleted
              ? null
              : _buildSaveBar(ctrl, context),
        );
      },
    );
  }

  // ── AppBar ─────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(MrnQcScreenController ctrl) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
        onPressed: () => Get.back(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MRN Quality Check',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          if (ctrl.detail != null)
            Text(ctrl.detail!.receiptno,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: newTextSecondary)),
        ],
      ),
      actions: [
        if (ctrl.detail != null)
          Container(
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: ctrl.isCompleted ? newGreenLightColor : newOrangeLightColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ctrl.isCompleted
                  ? newGreenColor.withValues(alpha: 0.3)
                  : newOrangeColor.withValues(alpha: 0.3)),
            ),
            child: Row(children: [
              Icon(Icons.pending_actions_rounded,
                  size: 12, color: ctrl.isCompleted ? newGreenColor : newOrangeColor),
              const SizedBox(width: 4),
              Text(ctrl.isCompleted ? 'Completed QC' : 'Pending QC',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    color: ctrl.isCompleted ? newGreenColor : newOrangeColor)),
            ]),
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: newBorderColor),
      ),
    );
  }

  // ── Main Body ──────────────────────────────────────────────────────────────
  Widget _buildBody(MrnQcScreenController ctrl) {
    final d = ctrl.detail!;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 120),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Section 1: Receipt Info ─────────────────────────────────────
        _sectionHeader(
            icon: Icons.receipt_long_rounded,
            label: 'Receipt Information',
            color: newBlueColor),
        const SizedBox(height: 10),
        _infoCard(d),

        const SizedBox(height: 16),

        // ── Section 2: QC Details (editable) ───────────────────────────
        _sectionHeader(
            icon: Icons.fact_check_outlined,
            label: 'QC Details',
            color: newGreenColor),
        const SizedBox(height: 10),
        _qcEditCard(ctrl),

        const SizedBox(height: 16),

        // ── Section 3: Items Table ──────────────────────────────────────
        _sectionHeader(
            icon: Icons.inventory_2_outlined,
            label: 'Item Details',
            color: ctrl.isCompleted ? newGreenColor : newOrangeColor,
            trailing: _itemCountBadge(d.qcitems.length)),
        const SizedBox(height: 10),
        _itemsSection(ctrl),
      ]),
    );
  }

  // ── Section Header ─────────────────────────────────────────────────────────
  Widget _sectionHeader({
    required IconData icon,
    required String label,
    required Color color,
    Widget? trailing,
  }) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 14, color: color),
      ),
      const SizedBox(width: 8),
      Text(label,
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: newTextPrimary,
              letterSpacing: .2)),
      const Spacer(),
      if (trailing != null) trailing,
    ]);
  }

  Widget _itemCountBadge(int count) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: ctrl.isCompleted ? newGreenLightColor : newOrangeLightColor,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: newOrangeColor.withValues(alpha: 0.3)),
    ),
    child: Text('$count Items',
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          color: ctrl.isCompleted ? newGreenColor : newOrangeColor)),
  );

  // ── Info Card (read-only receipt details) ──────────────────────────────────
  Widget _infoCard(MrnQcDetail d) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(children: [
        // Blue header bar
        Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
            color: newBlueLightColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
          ),
          child: Row(children: [
            const Icon(Icons.receipt_long_rounded,
                size: 15, color: newBlueColor),
            const SizedBox(width: 8),
            Text(d.receiptno,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: newBlueColor)),
            const Spacer(),
            _dateBadge(_formatDate(d.receiptdate)),
          ]),
        ),
        // Grid of fields
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            _infoRow('Party Name', d.partyname, Icons.business_outlined),
            _divider(),
            Row(children: [
              Expanded(
                  child: _infoField('Bill No', d.billno,
                      Icons.receipt_outlined)),
              const SizedBox(width: 14),
              Expanded(
                  child: _infoField('QC No',
                      d.qcno.isNotEmpty ? d.qcno : 'Auto Generated',
                      Icons.numbers_rounded)),
            ]),
            _divider(),
            Row(children: [
              Expanded(
                  child: _infoField('Total Qty', '${d.totalqty.toInt()} Items',
                      Icons.inventory_2_outlined,
                      valueColor: newGreenColor)),
              const SizedBox(width: 14),
              Expanded(
                  child: _infoField('Total Amount', _inr(d.totalamt),
                      Icons.currency_rupee_rounded,
                      valueColor: newTextPrimary)),
            ]),
          ]),
        ),
      ]),
    );
  }

  Widget _infoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, size: 13, color: newTextSecondary),
        const SizedBox(width: 8),
        Text('$label: ',
            style: const TextStyle(fontSize: 11, color: newTextSecondary)),
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary),
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    );
  }

  Widget _infoField(String label, String value, IconData icon,
      {Color? valueColor}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, size: 11, color: newTextSecondary),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: newTextSecondary,
                fontWeight: FontWeight.w500)),
      ]),
      const SizedBox(height: 3),
      Text(value,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: valueColor ?? newTextPrimary)),
    ]);
  }

  Widget _dateBadge(String date) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: newBlueColor.withValues(alpha: 0.3)),
    ),
    child: Text(date,
        style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: newBlueColor)),
  );

  Widget _divider() =>
      const Divider(height: 16, thickness: 1, color: newBorderColor);

  // ── QC Edit Card (editable fields) ────────────────────────────────────────
  Widget _qcEditCard(MrnQcScreenController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: newBorderColor),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(children: [
        Row(children: [
          Expanded(child: _qcDateField(ctrl)),
          const SizedBox(width: 12),
          // ── CHANGED: editable checked by field ──────────────────────
          Expanded(child: _checkedByField(ctrl)),
        ]),
        const SizedBox(height: 12),
        _remarksField(ctrl),
      ]),
    );
  }

  Widget _qcDateField(MrnQcScreenController ctrl) {
    return GestureDetector(
      onTap: () => ctrl.pickQcDate(context),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: newBorderColor),
        ),
        child: Row(children: [
          const Icon(Icons.calendar_today_outlined,
              size: 14, color: newBlueColor),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('QC Date',
                    style: TextStyle(
                        fontSize: 9,
                        color: newTextSecondary,
                        fontWeight: FontWeight.w600)),
                Text(ctrl.qcDateDisplay,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary)),
              ]),
          const Spacer(),
          const Icon(Icons.edit_calendar_outlined,
              size: 13, color: newTextSecondary),
        ]),
      ),
    );
  }

  Widget _readOnlyField(String label, String value, IconData icon) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: newSurfaceColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: newBorderColor),
      ),
      child: Row(children: [
        Icon(icon, size: 14, color: newTextSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 9,
                        color: newTextSecondary,
                        fontWeight: FontWeight.w600)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary),
                    overflow: TextOverflow.ellipsis),
              ]),
        ),
      ]),
    );
  }

  Widget _remarksField(MrnQcScreenController ctrl) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Remarks',
          style: TextStyle(
              fontSize: 11,
              color: newTextSecondary,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      TextFormField(
        controller: ctrl.remarksCtrl,
        maxLines: 2,
        style: const TextStyle(fontSize: 12, color: newTextPrimary),
        decoration: InputDecoration(
          hintText: 'Add remarks (optional)...',
          hintStyle: const TextStyle(fontSize: 12, color: newTextSecondary),
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: newBlueColor, width: 1.5)),
        ),
      ),
    ]);
  }

  // ── Items Section ──────────────────────────────────────────────────────────
  Widget _itemsSection(MrnQcScreenController ctrl) {
    final items = ctrl.detail!.qcitems;
    return Column(
      children: items.asMap().entries.map((entry) {
        final idx = entry.key;
        final item = entry.value;
        final isExpanded = ctrl.expandedItemIndex == idx;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isExpanded ? newBlueColor : newBorderColor,
              width: isExpanded ? 1.5 : 1,
            ),
            boxShadow: isExpanded
                ? [
              BoxShadow(
                  color: newBlueColor.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ]
                : [],
          ),
          child: Column(children: [
            // ── Item Row (always visible) ─────────────────────────────
            _itemRow(ctrl, item, idx, isExpanded),
            // ── Edit Panel (expanded) ────────────────────────────────
            if (isExpanded && !ctrl.isCompleted) _itemEditPanel(ctrl, item, idx),
          ]),
        );
      }).toList(),
    );
  }

  Widget _itemRow(MrnQcScreenController ctrl, MrnQcItem item, int idx,
      bool isExpanded) {
    final state = ctrl.itemStates[idx];
    final receivedQty = state?.receivedQty ?? item.receiveqty;
    final rejectedQty = (item.actualqty - receivedQty).toInt(); // cast: double→int
    final isSaved = state?.isSaved ?? false;

    return GestureDetector(
      onTap: ctrl.isCompleted ? null : () => ctrl.toggleItemExpand(idx),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Top row: item name + status badge
          Row(children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: isExpanded ? newBlueColor : newBlueLightColor,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text('${idx + 1}',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isExpanded ? Colors.white : newBlueColor)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(item.itemname,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 8),
            _itemStatusBadge(isSaved, rejectedQty),
          ]),
          const SizedBox(height: 10),
          // Stats row
          Row(children: [
            _qtyChip('Actual', item.actualqty, newBlueLightColor, newBlueColor),
            const SizedBox(width: 6),
            _qtyChip('Received', receivedQty, newGreenLightColor, newGreenColor),
            const SizedBox(width: 6),
            if (rejectedQty > 0)
              _qtyChip('Rejected', rejectedQty, const Color(0xFFFEE2E2),
                  const Color(0xFFDC2626)),
            const Spacer(),
            Text(_inr(item.amount),
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: newTextPrimary)),
            const SizedBox(width: 8),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: newTextSecondary),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget _itemStatusBadge(bool isSaved, int rejectedQty) {
    if (isSaved) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: newGreenLightColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: newGreenColor.withValues(alpha: 0.3)),
        ),
        child: const Row(children: [
          Icon(Icons.check_circle_rounded, size: 10, color: newGreenColor),
          SizedBox(width: 3),
          Text('Updated',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: newGreenColor)),
        ]),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: newOrangeLightColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: newOrangeColor.withValues(alpha: 0.3)),
      ),
      child: const Row(children: [
        Icon(Icons.edit_outlined, size: 10, color: newOrangeColor),
        SizedBox(width: 3),
        Text('Pending',
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: newOrangeColor)),
      ]),
    );
  }

  Widget _qtyChip(String label, num qty, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Column(children: [
        Text(label,
            style: TextStyle(
                fontSize: 8, fontWeight: FontWeight.w600, color: fg)),
        Text('${qty.toInt()}',
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.w800, color: fg)),
      ]),
    );
  }

  // ── Item Edit Panel ────────────────────────────────────────────────────────
  Widget _itemEditPanel(MrnQcScreenController ctrl, MrnQcItem item, int idx) {
    final state = ctrl.itemStates[idx]!;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: newBorderColor)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Read-only fields ──────────────────────────────────────────
        Row(children: [
          Expanded(
              child: _compactReadOnly(
                  'Item Name', item.itemname, Icons.inventory_outlined)),
          const SizedBox(width: 10),
          _compactReadOnly(
              'Actual Qty', '${item.actualqty.toInt()}', Icons.straighten_rounded,
              width: 90),
        ]),
        const SizedBox(height: 12),

        // ── Editable: Received Qty ────────────────────────────────────
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Received Qty *', newGreenColor),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: state.receivedCtrl,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'))
                    ],
                    onChanged: (v) => ctrl.onReceivedQtyChanged(idx, v),
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary),
                    decoration: _inputDecoration(
                        hint: '0',
                        prefixIcon: Icons.input_rounded,
                        accentColor: newGreenColor),
                  ),
                ]),
          ),
          const SizedBox(width: 10),

          // ── Auto-calculated: Rejected Qty ─────────────────────────
          SizedBox(
            width: 110,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fieldLabel('Rejected Qty', const Color(0xFFDC2626)),
                  const SizedBox(height: 6),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: state.rejectedQty > 0
                          ? const Color(0xFFFEE2E2)
                          : newSurfaceColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: state.rejectedQty > 0
                            ? const Color(0xFFDC2626).withValues(alpha: 0.3)
                            : newBorderColor,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${state.rejectedQty}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: state.rejectedQty > 0
                              ? const Color(0xFFDC2626)
                              : newTextSecondary),
                    ),
                  ),
                ]),
          ),
        ]),

        if (state.rejectedQty > 0) ...[
          const SizedBox(height: 4),
          Row(children: [
            const Icon(Icons.info_outline_rounded,
                size: 11, color: Color(0xFFDC2626)),
            const SizedBox(width: 4),
            Text('${state.rejectedQty} item(s) will be rejected',
                style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFFDC2626),
                    fontWeight: FontWeight.w500)),
          ]),
        ],

        const SizedBox(height: 12),

        // ── Reason ────────────────────────────────────────────────────
        _fieldLabel('Reason', newTextSecondary),
        const SizedBox(height: 6),
        TextFormField(
          controller: state.reasonCtrl,
          maxLines: 2,
          style: const TextStyle(fontSize: 12, color: newTextPrimary),
          decoration: _inputDecoration(
              hint: state.rejectedQty > 0
                  ? 'Enter reason for rejection...'
                  : 'Add a reason (optional)...',
              prefixIcon: Icons.comment_outlined),
        ),

        const SizedBox(height: 14),

        // ── Save Item Button ──────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () => ctrl.saveItem(idx),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: newGreenColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: newGreenColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ],
              ),
              alignment: Alignment.center,
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_rounded,
                        size: 15, color: Colors.white),
                    SizedBox(width: 6),
                    Text('Update Item',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _fieldLabel(String label, Color color) => Text(label,
      style: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w600, color: color));

  Widget _compactReadOnly(String label, String value, IconData icon,
      {double? width}) {
    return SizedBox(
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _fieldLabel(label, newTextSecondary),
        const SizedBox(height: 6),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: newSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newBorderColor),
          ),
          child: Row(children: [
            Icon(icon, size: 13, color: newTextSecondary),
            const SizedBox(width: 6),
            Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary),
                  overflow: TextOverflow.ellipsis),
            ),
          ]),
        ),
      ]),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
    Color? accentColor,
  }) {
    final accent = accentColor ?? newBlueColor;
    return InputDecoration(
      hintText: hint,
      hintStyle:
      const TextStyle(fontSize: 12, color: newTextSecondary),
      prefixIcon:
      Icon(prefixIcon, size: 15, color: accent),
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
          borderSide: BorderSide(color: accent, width: 1.5)),
    );
  }

  // ── Save Bar (bottom) ──────────────────────────────────────────────────────
  Widget _buildSaveBar(MrnQcScreenController ctrl, BuildContext context) {
    final totalUpdated =
        ctrl.itemStates.values.where((s) => s.isSaved).length;
    final total = ctrl.detail?.qcitems.length ?? 0;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(14, 10, 14, MediaQuery.of(context).padding.bottom + 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // Progress bar
        if (total > 0) ...[
          Row(children: [
            Text('$totalUpdated of $total items updated',
                style: const TextStyle(
                    fontSize: 11,
                    color: newTextSecondary,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            Text('${((totalUpdated / total) * 100).toInt()}%',
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: newBlueColor)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: total > 0 ? totalUpdated / total : 0,
              backgroundColor: newBorderColor,
              color: newGreenColor,
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 10),
        ],
        // Submit button
        SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: ctrl.isQcSaving ? null : ctrl.submitQc,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 50,
              decoration: BoxDecoration(
                color: ctrl.isQcSaving ? newBorderColor : newBlueColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: ctrl.isQcSaving
                    ? []
                    : [
                  BoxShadow(
                      color: newBlueColor.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              alignment: Alignment.center,
              child: ctrl.isQcSaving
                  ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2))
                  : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_alt_rounded,
                        size: 16, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Submit QC Entry',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: .3)),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }

  // ── Loading / Error States ─────────────────────────────────────────────────
  Widget _buildShimmerLoader() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(children: List.generate(
        4,
            (_) => Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: newBorderColor,
              borderRadius: BorderRadius.circular(14)),
        ),
      )),
    );
  }

  Widget _buildError() => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.error_outline_rounded, size: 48, color: newBorderColor),
      const SizedBox(height: 12),
      const Text('Failed to load QC details',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: newTextSecondary)),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: ctrl.loadDetail,
        child: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              color: newBlueColor,
              borderRadius: BorderRadius.circular(8)),
          child: const Text('Retry',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    ]),
  );

  // ── Helpers ────────────────────────────────────────────────────────────────
  String _formatDate(DateTime dt) => DateFormat('dd MMM yyyy').format(dt);

  static String _inr(double v) {
    if (v >= 10000000) return '₹${(v / 10000000).toStringAsFixed(1)}Cr';
    if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
    if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
    return '₹${v.toStringAsFixed(0)}';
  }

  Widget _checkedByField(MrnQcScreenController ctrl) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('QC Checked By',
          style: TextStyle(
              fontSize: 9,
              color: newTextSecondary,
              fontWeight: FontWeight.w600)),
      const SizedBox(height: 4),
      TextFormField(
        controller: ctrl.checkedByCtrl,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: newTextPrimary),
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          hintText: 'Enter name...',
          hintStyle:
          const TextStyle(fontSize: 12, color: newTextSecondary),
          prefixIcon: const Icon(Icons.person_outline_rounded,
              size: 15, color: newTextSecondary),
          filled: true,
          fillColor: newSurfaceColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
    ]);
  }
}