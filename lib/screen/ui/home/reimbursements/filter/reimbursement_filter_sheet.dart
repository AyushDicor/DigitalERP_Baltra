// lib/screen/ui/home/reimbursements/reimbursement_filter_sheet.dart
//
// Drop-in filter bottom sheet for ReimbursementListScreen.
// All filtering is client-side — operates on the already-loaded expenseDataList.
//
// USAGE (from ReimbursementListScreen):
//
//   void _showFilterSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => ReimbursementFilterSheet(
//         allItems: ctrl.expenseDataList.toList(),
//         activeFilter: _activeFilter,
//         onApply: (filter) {
//           setState(() => _activeFilter = filter);
//         },
//       ),
//     );
//   }
//
// Add to state:
//   ReimbursementFilter _activeFilter = const ReimbursementFilter();
//
// Use in _filterList():
//   List<ExpenseData> _filterList(List<ExpenseData> all) =>
//       _activeFilter.apply(all, ctrl.parseExpenseDate);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
import 'package:digitalerp/utils/app_constant_new.dart';

// ═════
// FILTER MODEL
// ═════

class ReimbursementFilter {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Set<String> claimNumbers; // empty = all
  final Set<String> siteNames;
  final Set<String> reimburseTypes;
  final Set<String> statuses;
  final Set<String> executives;
  final double? minAmount;
  final double? maxAmount;

  const ReimbursementFilter({
    this.fromDate,
    this.toDate,
    this.claimNumbers = const {},
    this.siteNames = const {},
    this.reimburseTypes = const {},
    this.statuses = const {},
    this.executives = const {},
    this.minAmount,
    this.maxAmount,
  });

  bool get isActive =>
      fromDate != null ||
      toDate != null ||
      claimNumbers.isNotEmpty ||
      siteNames.isNotEmpty ||
      reimburseTypes.isNotEmpty ||
      statuses.isNotEmpty ||
      executives.isNotEmpty ||
      minAmount != null ||
      maxAmount != null;

  ReimbursementFilter copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    Set<String>? claimNumbers,
    Set<String>? siteNames,
    Set<String>? reimburseTypes,
    Set<String>? statuses,
    Set<String>? executives,
    double? minAmount,
    double? maxAmount,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearMinAmount = false,
    bool clearMaxAmount = false,
  }) {
    return ReimbursementFilter(
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      claimNumbers: claimNumbers ?? this.claimNumbers,
      siteNames: siteNames ?? this.siteNames,
      reimburseTypes: reimburseTypes ?? this.reimburseTypes,
      statuses: statuses ?? this.statuses,
      executives: executives ?? this.executives,
      minAmount: clearMinAmount ? null : (minAmount ?? this.minAmount),
      maxAmount: clearMaxAmount ? null : (maxAmount ?? this.maxAmount),
    );
  }

  List<ExpenseData> apply(
    List<ExpenseData> all,
    DateTime? Function(String?) parseDate,
  ) {
    return all.where((e) {
      // Date
      if (fromDate != null || toDate != null) {
        final d = parseDate(e.expenseDate);
        if (d == null) return false;
        if (fromDate != null && d.isBefore(fromDate!)) return false;
        final toEnd = toDate != null
            ? DateTime(toDate!.year, toDate!.month, toDate!.day, 23, 59, 59)
            : null;
        if (toEnd != null && d.isAfter(toEnd)) return false;
      }
      // Claim Number
      if (claimNumbers.isNotEmpty && !claimNumbers.contains(e.expenseNo ?? ''))
        return false;
      // Site
      if (siteNames.isNotEmpty && !siteNames.contains(e.site ?? ''))
        return false;
      // Type
      if (reimburseTypes.isNotEmpty &&
          !reimburseTypes.contains(e.entryFlag ?? '')) return false;
      // Status
      if (statuses.isNotEmpty) {
        final s = (e.approvalStatus?.trim().isEmpty ?? true)
            ? 'Pending'
            : e.approvalStatus!.trim();
        if (!statuses.contains(s)) return false;
      }
      // Executive
      if (executives.isNotEmpty && !executives.contains(e.employeeName ?? ''))
        return false;
      // Amount
      final amt = (e.amount as num?)?.toDouble() ?? 0.0;
      if (minAmount != null && amt < minAmount!) return false;
      if (maxAmount != null && amt > maxAmount!) return false;
      return true;
    }).toList();
  }
}

// ═════
// FILTER SHEET
// ═════

class ReimbursementFilterSheet extends StatefulWidget {
  final List<ExpenseData> allItems;
  final ReimbursementFilter activeFilter;
  final void Function(ReimbursementFilter) onApply;
  final VoidCallback? onReset;

  const ReimbursementFilterSheet({
    Key? key,
    required this.allItems,
    required this.activeFilter,
    required this.onApply,
    this.onReset,
  }) : super(key: key);

  @override
  State<ReimbursementFilterSheet> createState() =>
      _ReimbursementFilterSheetState();
}

class _ReimbursementFilterSheetState extends State<ReimbursementFilterSheet> {
  // Working copy — only committed on Apply
  late ReimbursementFilter _draft;

  // Derived option lists (unique values from data)
  late List<String> _claimOptions;
  late List<String> _siteOptions;
  late List<String> _typeOptions;
  late List<String> _statusOptions;
  late List<String> _executiveOptions;
  late double _dataMaxAmount;

  // Amount range controllers
  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();

  // Section expand states
  final Map<String, bool> _expanded = {
    'claim': false,
    'site': false,
    'type': false,
    'status': false,
    'executive': false,
    'amount': false,
  };

  // Search strings per section
  final Map<String, String> _search = {
    'claim': '',
    'site': '',
    'type': '',
    'status': '',
    'executive': '',
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

    _claimOptions = items
        .map((e) => e.expenseNo ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _siteOptions = items
        .map((e) => e.site ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _typeOptions = items
        .map((e) => e.entryFlag ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _statusOptions = items
        .map((e) => (e.approvalStatus?.trim().isEmpty ?? true)
            ? 'Pending'
            : e.approvalStatus!.trim())
        .toSet()
        .toList()
      ..sort();

    _executiveOptions = items
        .map((e) => e.employeeName ?? '')
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _dataMaxAmount = items
        .map((e) => (e.amount as num?)?.toDouble() ?? 0.0)
        .fold(0.0, (a, b) => a > b ? a : b);
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  //  Helpers

  int _activeCount() {
    int n = 0;
    if (_draft.fromDate != null || _draft.toDate != null) n++;
    if (_draft.claimNumbers.isNotEmpty) n++;
    if (_draft.siteNames.isNotEmpty) n++;
    if (_draft.reimburseTypes.isNotEmpty) n++;
    if (_draft.statuses.isNotEmpty) n++;
    if (_draft.executives.isNotEmpty) n++;
    if (_draft.minAmount != null || _draft.maxAmount != null) n++;
    return n;
  }

  void _toggle(String section, bool val) =>
      setState(() => _expanded[section] = val);

  void _toggleItem(Set<String> current, String item, String field) {
    final next = Set<String>.from(current);
    next.contains(item) ? next.remove(item) : next.add(item);
    setState(() {
      switch (field) {
        case 'claim':
          _draft = _draft.copyWith(claimNumbers: next);
          break;
        case 'site':
          _draft = _draft.copyWith(siteNames: next);
          break;
        case 'type':
          _draft = _draft.copyWith(reimburseTypes: next);
          break;
        case 'status':
          _draft = _draft.copyWith(statuses: next);
          break;
        case 'executive':
          _draft = _draft.copyWith(executives: next);
          break;
      }
    });
  }

  void _reset() {
    setState(() {
      _draft = const ReimbursementFilter();
      _minCtrl.clear();
      _maxCtrl.clear();
      for (final k in _search.keys) _search[k] = '';
    });
    // Apply the empty filter immediately + notify parent to reload
    Navigator.pop(context);
    widget.onApply(const ReimbursementFilter()); // clears client-side filters
    widget.onReset?.call(); // triggers API reload in parent
  }

  void _apply() {
    // Commit amount from text fields
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

  //  Date helpers

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
          colorScheme: ColorScheme.light(
            primary: purpleColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
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

  //

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
          //  Handle + Header
          _buildHeader(activeCount),

          //  Scrollable content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                // Date Range
                _DateRangeCard(
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

                // Claim Number
                _AccordionSection(
                  title: 'Claim Number',
                  icon: Icons.receipt_long_outlined,
                  selectedCount: _draft.claimNumbers.length,
                  expanded: _expanded['claim']!,
                  onToggle: (v) => _toggle('claim', v),
                  child: _ChecklistPanel(
                    options: _claimOptions,
                    selected: _draft.claimNumbers,
                    search: _search['claim']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['claim'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.claimNumbers, item, 'claim'),
                  ),
                ),
                const SizedBox(height: 8),

                // Site Name
                _AccordionSection(
                  title: 'Site Name',
                  icon: Icons.location_on_outlined,
                  selectedCount: _draft.siteNames.length,
                  expanded: _expanded['site']!,
                  onToggle: (v) => _toggle('site', v),
                  child: _ChecklistPanel(
                    options: _siteOptions,
                    selected: _draft.siteNames,
                    search: _search['site']!,
                    onSearchChanged: (v) => setState(() => _search['site'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.siteNames, item, 'site'),
                  ),
                ),
                const SizedBox(height: 8),

                // Reimbursement Type
                _AccordionSection(
                  title: 'Reimbursement Type',
                  icon: Icons.category_outlined,
                  selectedCount: _draft.reimburseTypes.length,
                  expanded: _expanded['type']!,
                  onToggle: (v) => _toggle('type', v),
                  child: _ChecklistPanel(
                    options: _typeOptions,
                    selected: _draft.reimburseTypes,
                    search: _search['type']!,
                    onSearchChanged: (v) => setState(() => _search['type'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.reimburseTypes, item, 'type'),
                    showSearch: false,
                  ),
                ),
                const SizedBox(height: 8),

                // Task Status
                _AccordionSection(
                  title: 'Task Status',
                  icon: Icons.flag_outlined,
                  selectedCount: _draft.statuses.length,
                  expanded: _expanded['status']!,
                  onToggle: (v) => _toggle('status', v),
                  child: _ChecklistPanel(
                    options: _statusOptions,
                    selected: _draft.statuses,
                    search: _search['status']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['status'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.statuses, item, 'status'),
                    showSearch: false,
                    statusMode: true,
                  ),
                ),
                const SizedBox(height: 8),

                // Executive Name
                _AccordionSection(
                  title: 'Executive Name',
                  icon: Icons.person_outline_rounded,
                  selectedCount: _draft.executives.length,
                  expanded: _expanded['executive']!,
                  onToggle: (v) => _toggle('executive', v),
                  child: _ChecklistPanel(
                    options: _executiveOptions,
                    selected: _draft.executives,
                    search: _search['executive']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['executive'] = v),
                    onToggle: (item) =>
                        _toggleItem(_draft.executives, item, 'executive'),
                  ),
                ),
                const SizedBox(height: 8),

                // Amount Range
                _AccordionSection(
                  title: 'Amount',
                  icon: Icons.currency_rupee_rounded,
                  selectedCount:
                      (_draft.minAmount != null || _draft.maxAmount != null)
                          ? 1
                          : 0,
                  expanded: _expanded['amount']!,
                  onToggle: (v) => _toggle('amount', v),
                  child: _AmountPanel(
                    minCtrl: _minCtrl,
                    maxCtrl: _maxCtrl,
                    dataMax: _dataMaxAmount,
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),

          //  Bottom action bar
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
          // Drag handle
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
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
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
          // Reset
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
              child: Text(
                'Reset',
                style: GoogleFonts.dmSans(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Apply
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

class _DateRangeCard extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onPickFrom;
  final VoidCallback onPickTo;
  final VoidCallback onClearFrom;
  final VoidCallback onClearTo;

  const _DateRangeCard({
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
          Row(
            children: [
              const Icon(Icons.date_range_outlined,
                  size: 16, color: purpleColor),
              const SizedBox(width: 6),
              Text(
                'DATE RANGE',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: purpleColor,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                  child: _DateTile(
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
                  child: _DateTile(
                label: 'To',
                date: toDate,
                onTap: onPickTo,
                onClear: toDate != null ? onClearTo : null,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _DateTile({
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
        child: Row(
          children: [
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
          ],
        ),
      ),
    );
  }
}

// ═════
// ACCORDION SECTION
// ═════

class _AccordionSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final int selectedCount;
  final bool expanded;
  final void Function(bool) onToggle;
  final Widget child;

  const _AccordionSection({
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
          // Header row — tap to expand/collapse
          InkWell(
            onTap: () => onToggle(!expanded),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Icon(icon, size: 18, color: purpleColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                  if (selectedCount > 0) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$selectedCount',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Collapsible body
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                child,
              ],
            ),
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
// CHECKLIST PANEL (with optional search)
// ═════

class _ChecklistPanel extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String search;
  final void Function(String) onSearchChanged;
  final void Function(String) onToggle;
  final bool showSearch;
  final bool statusMode; // use colored status chips instead of plain text

  const _ChecklistPanel({
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
                      .map((opt) => _CheckItem(
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

class _CheckItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onToggle;
  final bool statusMode;

  const _CheckItem({
    required this.label,
    required this.selected,
    required this.onToggle,
    this.statusMode = false,
  });

  Color _statusColor(String s) {
    switch (s.toLowerCase()) {
      case 'approved':
        return newGreenColor;
      case 'rejected':
        return newRedColor;
      case 'pending':
        return newOrangeColor;
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
        child: Row(
          children: [
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
          ],
        ),
      ),
    );
  }
}

// ═════
// AMOUNT PANEL
// ═════

class _AmountPanel extends StatelessWidget {
  final TextEditingController minCtrl;
  final TextEditingController maxCtrl;
  final double dataMax;

  const _AmountPanel({
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
          Row(
            children: [
              Expanded(
                child: _AmountField(
                  controller: minCtrl,
                  hint: 'Min ₹',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text('–',
                    style: GoogleFonts.dmSans(
                        fontSize: 16, color: Colors.grey.shade400)),
              ),
              Expanded(
                child: _AmountField(
                  controller: maxCtrl,
                  hint: 'Max ₹',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AmountField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _AmountField({required this.controller, required this.hint});

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
