// lib/payment_request/payment request list/payment_request_filter_sheet.dart
//
// Drop-in filter bottom sheet for PaymentRequestListScreen.
// All filtering is client-side — operates on the already-loaded paymentRequestList.
//
// USAGE (in PaymentRequestListScreen):
//
//   void _showFilterBottomSheet(BuildContext context, PaymentRequestListController ctrl) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => PaymentRequestFilterSheet(
//         allItems: ctrl.paymentRequestList,
//         activeFilter: ctrl.activeFilter,
//         onApply: (filter) => ctrl.applyFilter(filter),
//         onReset: () => ctrl.resetFilter(),
//       ),
//     );
//   }
//
// Add to PaymentRequestListController:
//   PaymentRequestFilter activeFilter = const PaymentRequestFilter();
//
//   void applyFilter(PaymentRequestFilter f) {
//     activeFilter = f;
//     update();
//   }
//
//   void resetFilter() {
//     activeFilter = const PaymentRequestFilter();
//     update();
//   }
//
// Replace filteredPaymentRequestList getter to also run activeFilter.apply():
//   List<PaymentRequestModel> get filteredPaymentRequestList {
//     final base = activeFilter.apply(paymentRequestList);
//     if (_searchQuery.isEmpty) return base;
//     final q = _searchQuery.toLowerCase();
//     return base.where((r) =>
//       (r.partyName ?? '').toLowerCase().contains(q) ||
//       (r.reason ?? '').toLowerCase().contains(q) ||
//       (r.requestNo ?? '').toLowerCase().contains(q)).toList();
//   }

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../payment_request_model/payment_request_model.dart';

// ═════
// FILTER MODEL
// ═════

class PaymentRequestFilter {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Set<String> statuses; // Pending, Approved, Rejected, Paid, Finalised
  final Set<String> partyTypes; // Employee A/c, Sundry Creditors …
  final Set<String> requestTypes; // Loan, Salary Advance …
  final Set<String> siteNames;
  final double? minAmount;
  final double? maxAmount;

  const PaymentRequestFilter({
    this.fromDate,
    this.toDate,
    this.statuses = const {},
    this.partyTypes = const {},
    this.requestTypes = const {},
    this.siteNames = const {},
    this.minAmount,
    this.maxAmount,
  });

  bool get isActive =>
      fromDate != null ||
      toDate != null ||
      statuses.isNotEmpty ||
      partyTypes.isNotEmpty ||
      requestTypes.isNotEmpty ||
      siteNames.isNotEmpty ||
      minAmount != null ||
      maxAmount != null;

  PaymentRequestFilter copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    Set<String>? statuses,
    Set<String>? partyTypes,
    Set<String>? requestTypes,
    Set<String>? siteNames,
    double? minAmount,
    double? maxAmount,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearMinAmount = false,
    bool clearMaxAmount = false,
  }) {
    return PaymentRequestFilter(
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      statuses: statuses ?? this.statuses,
      partyTypes: partyTypes ?? this.partyTypes,
      requestTypes: requestTypes ?? this.requestTypes,
      siteNames: siteNames ?? this.siteNames,
      minAmount: clearMinAmount ? null : (minAmount ?? this.minAmount),
      maxAmount: clearMaxAmount ? null : (maxAmount ?? this.maxAmount),
    );
  }

  List<PaymentRequestModel> apply(List<PaymentRequestModel> all) {
    return all.where((r) {
      // Date
      if (fromDate != null &&
          r.requestDate != null &&
          r.requestDate!.isBefore(fromDate!)) return false;
      if (toDate != null && r.requestDate != null) {
        final end =
            DateTime(toDate!.year, toDate!.month, toDate!.day, 23, 59, 59);
        if (r.requestDate!.isAfter(end)) return false;
      }

      // ✅ Status — normalize approve/approved and reject/rejected
      if (statuses.isNotEmpty) {
        final s = (r.status ?? '').trim().toLowerCase();
        final matched = statuses.any((f) {
          final fl = f.trim().toLowerCase();
          if (fl == 'approved') return s == 'approved' || s == 'approve';
          if (fl == 'rejected') return s == 'rejected' || s == 'reject';
          return s == fl;
        });
        if (!matched) return false;
      }

      // Party Type
      if (partyTypes.isNotEmpty && !partyTypes.contains(r.partyType ?? ''))
        return false;
      // Request Type
      if (requestTypes.isNotEmpty &&
          !requestTypes.contains(r.requestType ?? '')) return false;
      // Site
      if (siteNames.isNotEmpty && !siteNames.contains(r.branchName ?? ''))
        return false;
      // Amount
      final amt = r.amount ?? 0.0;
      if (minAmount != null && amt < minAmount!) return false;
      if (maxAmount != null && amt > maxAmount!) return false;
      return true;
    }).toList();
  }
}

// ═════
// FILTER SHEET
// ═════

class PaymentRequestFilterSheet extends StatefulWidget {
  final List<PaymentRequestModel> allItems;
  final PaymentRequestFilter activeFilter;
  final void Function(PaymentRequestFilter) onApply;
  final VoidCallback? onReset;

  const PaymentRequestFilterSheet({
    Key? key,
    required this.allItems,
    required this.activeFilter,
    required this.onApply,
    this.onReset,
  }) : super(key: key);

  @override
  State<PaymentRequestFilterSheet> createState() =>
      _PaymentRequestFilterSheetState();
}

class _PaymentRequestFilterSheetState extends State<PaymentRequestFilterSheet> {
  late PaymentRequestFilter _draft;

  // Option lists derived from data
  late List<String> _statusOptions;
  late List<String> _partyTypeOptions;
  late List<String> _requestTypeOptions;
  late List<String> _siteOptions;
  late double _dataMaxAmount;

  // Amount controllers
  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();

  // Expand state per section
  final Map<String, bool> _expanded = {
    'status': false,
    'partyType': false,
    'requestType': false,
    'site': false,
    'amount': false,
  };

  // Search per section
  final Map<String, String> _search = {
    'site': '',
    'partyType': '',
    'requestType': '',
  };

  @override
  void initState() {
    super.initState();
    _draft = widget.activeFilter;
    _buildOptions();
    _minCtrl.text = _draft.minAmount?.toStringAsFixed(0) ?? '';
    _maxCtrl.text = _draft.maxAmount?.toStringAsFixed(0) ?? '';
  }

  void _buildOptions() {
    final items = widget.allItems;

    _statusOptions = items
        .map((e) {
      final s = (e.status ?? '').trim();
      // ✅ Normalize variants to canonical form
      if (s.toLowerCase() == 'approve') return 'Approved';
      if (s.toLowerCase() == 'reject') return 'Rejected';
      return s;
    })
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _partyTypeOptions = items
        .map((e) => e.partyType ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _requestTypeOptions = items
        .map((e) => e.requestType ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _siteOptions = items
        .map((e) => e.branchName ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _dataMaxAmount =
        items.map((e) => e.amount ?? 0.0).fold(0.0, (a, b) => a > b ? a : b);
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  int _activeCount() {
    int n = 0;
    if (_draft.fromDate != null || _draft.toDate != null) n++;
    if (_draft.statuses.isNotEmpty) n++;
    if (_draft.partyTypes.isNotEmpty) n++;
    if (_draft.requestTypes.isNotEmpty) n++;
    if (_draft.siteNames.isNotEmpty) n++;
    if (_draft.minAmount != null || _draft.maxAmount != null) n++;
    return n;
  }

  void _toggle(String key, bool val) => setState(() => _expanded[key] = val);

  void _toggleItem(Set<String> current, String item, String field) {
    final next = Set<String>.from(current);
    next.contains(item) ? next.remove(item) : next.add(item);
    setState(() {
      switch (field) {
        case 'status':
          _draft = _draft.copyWith(statuses: next);
          break;
        case 'partyType':
          _draft = _draft.copyWith(partyTypes: next);
          break;
        case 'requestType':
          _draft = _draft.copyWith(requestTypes: next);
          break;
        case 'site':
          _draft = _draft.copyWith(siteNames: next);
          break;
      }
    });
  }

  void _reset() {
    setState(() {
      _draft = const PaymentRequestFilter();
      _minCtrl.clear();
      _maxCtrl.clear();
      for (final k in _search.keys) _search[k] = '';
    });
    Navigator.pop(context);
    widget.onApply(const PaymentRequestFilter());
    widget.onReset?.call();
  }

  void _apply() {
    final min = double.tryParse(_minCtrl.text.trim());
    final max = double.tryParse(_maxCtrl.text.trim());
    final committed = _draft.copyWith(
      minAmount: min,
      maxAmount: max,
      clearMinAmount: min == null,
      clearMaxAmount: max == null,
    );
    Navigator.pop(context);
    widget.onApply(committed);
  }

  Future<void> _pickDate(bool isFrom) async {
    final initial = isFrom
        ? (_draft.fromDate ?? DateTime.now().subtract(const Duration(days: 30)))
        : (_draft.toDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: purpleColor,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _draft = isFrom
            ? _draft.copyWith(fromDate: picked)
            : _draft.copyWith(toDate: picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final activeCount = _activeCount();

    return Container(
      height: mq.size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHeader(activeCount),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                //  Date Range
                _PRDateRangeCard(
                  fromDate: _draft.fromDate,
                  toDate: _draft.toDate,
                  onPickFrom: () => _pickDate(true),
                  onPickTo: () => _pickDate(false),
                  onClearFrom: () => setState(
                      () => _draft = _draft.copyWith(clearFromDate: true)),
                  onClearTo: () => setState(
                      () => _draft = _draft.copyWith(clearToDate: true)),
                ),
                const SizedBox(height: 10),

                //  Status
                _PRAccordion(
                  title: 'Payment Status',
                  icon: Icons.flag_outlined,
                  selectedCount: _draft.statuses.length,
                  expanded: _expanded['status']!,
                  onToggle: (v) => _toggle('status', v),
                  child: _PRChecklist(
                    options: _statusOptions,
                    selected: _draft.statuses,
                    search: '',
                    onSearchChanged: (_) {},
                    onToggle: (item) =>
                        _toggleItem(_draft.statuses, item, 'status'),
                    showSearch: false,
                    statusMode: true,
                  ),
                ),
                const SizedBox(height: 8),

                //  Party Type
                _PRAccordion(
                  title: 'Party Type',
                  icon: Icons.category_outlined,
                  selectedCount: _draft.partyTypes.length,
                  expanded: _expanded['partyType']!,
                  onToggle: (v) => _toggle('partyType', v),
                  child: _PRChecklist(
                    options: _partyTypeOptions,
                    selected: _draft.partyTypes,
                    search: _search['partyType']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['partyType'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.partyTypes, item, 'partyType'),
                    showSearch: false,
                  ),
                ),
                const SizedBox(height: 8),

                //  Request Type
                _PRAccordion(
                  title: 'Request Type',
                  icon: Icons.receipt_long_outlined,
                  selectedCount: _draft.requestTypes.length,
                  expanded: _expanded['requestType']!,
                  onToggle: (v) => _toggle('requestType', v),
                  child: _PRChecklist(
                    options: _requestTypeOptions,
                    selected: _draft.requestTypes,
                    search: _search['requestType']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['requestType'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.requestTypes, item, 'requestType'),
                    showSearch: false,
                  ),
                ),
                const SizedBox(height: 8),

                //  Site Name
                _PRAccordion(
                  title: 'Site Name',
                  icon: Icons.location_on_outlined,
                  selectedCount: _draft.siteNames.length,
                  expanded: _expanded['site']!,
                  onToggle: (v) => _toggle('site', v),
                  child: _PRChecklist(
                    options: _siteOptions,
                    selected: _draft.siteNames,
                    search: _search['site']!,
                    onSearchChanged: (v) => setState(() => _search['site'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.siteNames, item, 'site'),
                    showSearch: true,
                  ),
                ),
                const SizedBox(height: 8),

                //  Amount
                _PRAccordion(
                  title: 'Amount',
                  icon: Icons.currency_rupee_rounded,
                  selectedCount:
                      (_draft.minAmount != null || _draft.maxAmount != null)
                          ? 1
                          : 0,
                  expanded: _expanded['amount']!,
                  onToggle: (v) => _toggle('amount', v),
                  child: _PRAmountPanel(
                    minCtrl: _minCtrl,
                    maxCtrl: _maxCtrl,
                    dataMax: _dataMaxAmount,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _buildBottomBar(activeCount),
          SizedBox(height: mq.padding.bottom),
        ],
      ),
    );
  }

  Widget _buildHeader(int activeCount) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.filter_list_rounded,
                  size: 20, color: purpleColor),
              const SizedBox(width: 8),
              Text(
                'Filter',
                style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
              if (activeCount > 0) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: purpleColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$activeCount',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (activeCount > 0)
                TextButton(
                  onPressed: _reset,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade600,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                  child: Text(
                    'Clear All',
                    style: GoogleFonts.dmSans(
                        fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(int activeCount) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: _reset,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                foregroundColor: Colors.grey.shade700,
              ),
              child: Text('Reset',
                  style: GoogleFonts.dmSans(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                backgroundColor: purpleColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                activeCount > 0 ? 'Apply ($activeCount)' : 'Apply',
                style: GoogleFonts.dmSans(
                    fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════
// DATE RANGE CARD
// ═════

class _PRDateRangeCard extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onPickFrom;
  final VoidCallback onPickTo;
  final VoidCallback onClearFrom;
  final VoidCallback onClearTo;

  const _PRDateRangeCard({
    required this.fromDate,
    required this.toDate,
    required this.onPickFrom,
    required this.onPickTo,
    required this.onClearFrom,
    required this.onClearTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.date_range_outlined, size: 16, color: purpleColor),
            const SizedBox(width: 6),
            Text('DATE RANGE',
                style: GoogleFonts.dmSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: purpleColor,
                    letterSpacing: 0.8)),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: _PRDateTile(
              label: 'From',
              date: fromDate,
              onTap: onPickFrom,
              onClear: fromDate != null ? onClearFrom : null,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('to',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, color: Colors.grey.shade400)),
            ),
            Expanded(
                child: _PRDateTile(
              label: 'To',
              date: toDate,
              onTap: onPickTo,
              onClear: toDate != null ? onClearTo : null,
            )),
          ]),
        ],
      ),
    );
  }
}

class _PRDateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _PRDateTile({
    required this.label,
    required this.date,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasDate = date != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: hasDate
              ? purpleColor.withValues(alpha: 0.06)
              : const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: hasDate
                ? purpleColor.withValues(alpha: 0.3)
                : const Color(0xFFE8E8E8),
          ),
        ),
        child: Row(children: [
          Icon(Icons.calendar_today_outlined,
              size: 14, color: hasDate ? purpleColor : Colors.grey.shade400),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              hasDate ? DateFormat('dd MMM yy').format(date!) : label,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: hasDate ? FontWeight.w600 : FontWeight.w400,
                color: hasDate ? purpleColor : Colors.grey.shade400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onClear != null)
            GestureDetector(
              onTap: onClear,
              child: Icon(Icons.close, size: 14, color: Colors.grey.shade500),
            ),
        ]),
      ),
    );
  }
}

// ═════
// ACCORDION
// ═════

class _PRAccordion extends StatelessWidget {
  final String title;
  final IconData icon;
  final int selectedCount;
  final bool expanded;
  final void Function(bool) onToggle;
  final Widget child;

  const _PRAccordion({
    required this.title,
    required this.icon,
    required this.selectedCount,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: expanded || selectedCount > 0
              ? purpleColor.withValues(alpha: 0.25)
              : const Color(0xFFEEEEEE),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => onToggle(!expanded),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(children: [
                Icon(icon, size: 18, color: purpleColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title,
                      style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A2E))),
                ),
                if (selectedCount > 0) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('$selectedCount',
                        style: GoogleFonts.dmSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                  const SizedBox(width: 8),
                ],
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.keyboard_arrow_down_rounded,
                      size: 20, color: Colors.grey.shade400),
                ),
              ]),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(children: [
              const Divider(height: 1, color: Color(0xFFF0F0F0)),
              child,
            ]),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

// ═════
// CHECKLIST
// ═════

class _PRChecklist extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String search;
  final void Function(String) onSearchChanged;
  final void Function(String) onToggle;
  final bool showSearch;
  final bool statusMode;

  const _PRChecklist({
    required this.options,
    required this.selected,
    required this.search,
    required this.onSearchChanged,
    required this.onToggle,
    this.showSearch = true,
    this.statusMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = search.isEmpty
        ? options
        : options
            .where((o) => o.toLowerCase().contains(search.toLowerCase()))
            .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showSearch) ...[
            TextField(
              onChanged: onSearchChanged,
              style: GoogleFonts.dmSans(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: GoogleFonts.dmSans(
                    fontSize: 13, color: Colors.grey.shade400),
                prefixIcon:
                    Icon(Icons.search, size: 18, color: Colors.grey.shade400),
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('No options found',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, color: Colors.grey.shade400)),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: SingleChildScrollView(
                child: Column(
                  children: filtered
                      .map((opt) => _PRCheckItem(
                            label: opt,
                            selected: selected.contains(opt),
                            onToggle: () => onToggle(opt),
                            statusMode: statusMode,
                          ))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PRCheckItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onToggle;
  final bool statusMode;

  const _PRCheckItem({
    required this.label,
    required this.selected,
    required this.onToggle,
    this.statusMode = false,
  });

  Color _statusColor(String s) {
    switch (s.toLowerCase().trim()) {
      case 'approved':
      case 'approve': // ✅
        return const Color(0xFF2196F3);
      case 'finalised':
        return const Color(0xFF9C27B0);
      case 'paid':
        return const Color(0xFF4CAF50);
      case 'rejected':
      case 'reject': // ✅
        return const Color(0xFFF44336);
      case 'pending':
        return const Color(0xFFFF9800);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = statusMode ? _statusColor(label) : null;

    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: selected ? purpleColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selected ? purpleColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: selected
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          if (statusMode && color != null)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color:
                    selected ? const Color(0xFF1A1A2E) : Colors.grey.shade700,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ═════
// AMOUNT PANEL
// ═════

class _PRAmountPanel extends StatelessWidget {
  final TextEditingController minCtrl;
  final TextEditingController maxCtrl;
  final double dataMax;

  const _PRAmountPanel({
    required this.minCtrl,
    required this.maxCtrl,
    required this.dataMax,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dataMax > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                'Range in data: ₹0 – ₹${dataMax.toStringAsFixed(0)}',
                style: GoogleFonts.dmSans(
                    fontSize: 11, color: Colors.grey.shade500),
              ),
            ),
          Row(children: [
            Expanded(child: _PRAmountField(controller: minCtrl, hint: 'Min ₹')),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('–',
                  style: GoogleFonts.dmSans(
                      fontSize: 16, color: Colors.grey.shade400)),
            ),
            Expanded(child: _PRAmountField(controller: maxCtrl, hint: 'Max ₹')),
          ]),
        ],
      ),
    );
  }
}

class _PRAmountField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _PRAmountField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: GoogleFonts.dmSans(fontSize: 13, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.dmSans(fontSize: 13, color: Colors.grey.shade400),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: const Color(0xFFF8F7FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDD8FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFDDD8FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: purpleColor, width: 1.5),
        ),
      ),
    );
  }
}
