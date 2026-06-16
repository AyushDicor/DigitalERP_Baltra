// lib/screen/ui/home/mrn_qc/mrn_qc_list/mrn_qc_filter_sheet.dart
//
// Drop-in filter bottom sheet for MrnQcListScreen.
// Matches the PaymentRequestFilterSheet style exactly.
// All filtering is client-side on already-loaded data.
//
// USAGE in MrnQcListScreen:
//   void _showFilterSheet(BuildContext context, MrnQcListController ctrl) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => MrnQcFilterSheet(
//         allItems: ctrl.activeItems,
//         activeFilter: ctrl.activeFilter,
//         onApply: (f) => ctrl.applyFilter(f),
//         onReset: () => ctrl.resetFilter(),
//       ),
//     );
//   }

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../mrn_qc_model/mrn_qc_models.dart';

// ═══════════════════════════════════════════════════════════════
// FILTER MODEL
// ═══════════════════════════════════════════════════════════════

class MrnQcFilter {
  final Set<String> partyNames;
  final Set<String> siteNames;
  final Set<String> jobTypes;
  final double? minAmount;
  final double? maxAmount;

  const MrnQcFilter({
    this.partyNames = const {},
    this.siteNames = const {},
    this.jobTypes = const {},
    this.minAmount,
    this.maxAmount,
  });

  bool get isActive =>
      partyNames.isNotEmpty ||
          siteNames.isNotEmpty ||
          jobTypes.isNotEmpty ||
          minAmount != null ||
          maxAmount != null;

  int get activeCount {
    int n = 0;
    if (partyNames.isNotEmpty) n++;
    if (siteNames.isNotEmpty) n++;
    if (jobTypes.isNotEmpty) n++;
    if (minAmount != null || maxAmount != null) n++;
    return n;
  }

  MrnQcFilter copyWith({
    Set<String>? partyNames,
    Set<String>? siteNames,
    Set<String>? jobTypes,
    double? minAmount,
    double? maxAmount,
    bool clearMinAmount = false,
    bool clearMaxAmount = false,
  }) {
    return MrnQcFilter(
      partyNames: partyNames ?? this.partyNames,
      siteNames: siteNames ?? this.siteNames,
      jobTypes: jobTypes ?? this.jobTypes,
      minAmount: clearMinAmount ? null : (minAmount ?? this.minAmount),
      maxAmount: clearMaxAmount ? null : (maxAmount ?? this.maxAmount),
    );
  }

  List<MrnQcListItem> apply(List<MrnQcListItem> all, bool isCompleted) {
    return all.where((item) {
      if (partyNames.isNotEmpty && !partyNames.contains(item.partyName)) {
        return false;
      }
      if (siteNames.isNotEmpty && !siteNames.contains(item.siteName)) {
        return false;
      }
      if (jobTypes.isNotEmpty && !jobTypes.contains(item.jobType)) {
        return false;
      }
      final amt = isCompleted && item.grandTotal > 0
          ? item.grandTotal
          : item.totalAmt;
      if (minAmount != null && amt < minAmount!) return false;
      if (maxAmount != null && amt > maxAmount!) return false;
      return true;
    }).toList();
  }
}

// ═══════════════════════════════════════════════════════════════
// FILTER SHEET WIDGET
// ═══════════════════════════════════════════════════════════════

class MrnQcFilterSheet extends StatefulWidget {
  final List<MrnQcListItem> allItems;
  final MrnQcFilter activeFilter;
  final bool isCompleted;
  final void Function(MrnQcFilter) onApply;
  final VoidCallback? onReset;

  const MrnQcFilterSheet({
    Key? key,
    required this.allItems,
    required this.activeFilter,
    required this.isCompleted,
    required this.onApply,
    this.onReset,
  }) : super(key: key);

  @override
  State<MrnQcFilterSheet> createState() => _MrnQcFilterSheetState();
}

class _MrnQcFilterSheetState extends State<MrnQcFilterSheet> {
  late MrnQcFilter _draft;

  late List<String> _partyOptions;
  late List<String> _siteOptions;
  late List<String> _jobTypeOptions;
  late double _dataMaxAmount;

  final _minCtrl = TextEditingController();
  final _maxCtrl = TextEditingController();

  final Map<String, bool> _expanded = {
    'party': false,
    'site': false,
    'jobType': false,
    'amount': false,
  };

  final Map<String, String> _search = {
    'party': '',
    'site': '',
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

    _partyOptions = items
        .map((e) => e.partyName)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _siteOptions = items
        .map((e) => e.siteName)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _jobTypeOptions = items
        .map((e) => e.jobType)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _dataMaxAmount = items
        .map((e) => widget.isCompleted && e.grandTotal > 0
        ? e.grandTotal
        : e.totalAmt)
        .fold(0.0, (a, b) => a > b ? a : b);
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  void _toggle(String key, bool val) =>
      setState(() => _expanded[key] = val);

  void _toggleItem(Set<String> current, String item, String field) {
    final next = Set<String>.from(current);
    next.contains(item) ? next.remove(item) : next.add(item);
    setState(() {
      switch (field) {
        case 'party':
          _draft = _draft.copyWith(partyNames: next);
          break;
        case 'site':
          _draft = _draft.copyWith(siteNames: next);
          break;
        case 'jobType':
          _draft = _draft.copyWith(jobTypes: next);
          break;
      }
    });
  }

  void _reset() {
    setState(() {
      _draft = const MrnQcFilter();
      _minCtrl.clear();
      _maxCtrl.clear();
      for (final k in _search.keys) _search[k] = '';
    });
    Navigator.pop(context);
    widget.onApply(const MrnQcFilter());
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

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final activeCount = _draft.activeCount;

    return Container(
      height: mq.size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(children: [
        _buildHeader(activeCount),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: [
              // ── Party Name ──────────────────────────────────────────
              _MrnAccordion(
                title: 'Party Name',
                icon: Icons.business_outlined,
                selectedCount: _draft.partyNames.length,
                expanded: _expanded['party']!,
                onToggle: (v) => _toggle('party', v),
                child: _MrnChecklist(
                  options: _partyOptions,
                  selected: _draft.partyNames,
                  search: _search['party']!,
                  onSearchChanged: (v) =>
                      setState(() => _search['party'] = v),
                  onToggle: (item) =>
                      _toggleItem(_draft.partyNames, item, 'party'),
                  showSearch: _partyOptions.length > 5,
                ),
              ),
              const SizedBox(height: 8),

              // ── Site Name ───────────────────────────────────────────
              _MrnAccordion(
                title: 'Site Name',
                icon: Icons.location_on_outlined,
                selectedCount: _draft.siteNames.length,
                expanded: _expanded['site']!,
                onToggle: (v) => _toggle('site', v),
                child: _MrnChecklist(
                  options: _siteOptions,
                  selected: _draft.siteNames,
                  search: _search['site']!,
                  onSearchChanged: (v) =>
                      setState(() => _search['site'] = v),
                  onToggle: (item) =>
                      _toggleItem(_draft.siteNames, item, 'site'),
                  showSearch: _siteOptions.length > 5,
                ),
              ),
              const SizedBox(height: 8),

              // ── Job Type ────────────────────────────────────────────
              _MrnAccordion(
                title: 'Job Type',
                icon: Icons.work_outline_rounded,
                selectedCount: _draft.jobTypes.length,
                expanded: _expanded['jobType']!,
                onToggle: (v) => _toggle('jobType', v),
                child: _MrnChecklist(
                  options: _jobTypeOptions,
                  selected: _draft.jobTypes,
                  search: '',
                  onSearchChanged: (_) {},
                  onToggle: (item) =>
                      _toggleItem(_draft.jobTypes, item, 'jobType'),
                  showSearch: false,
                  jobTypeMode: true,
                ),
              ),
              const SizedBox(height: 8),

              // ── Amount ──────────────────────────────────────────────
              _MrnAccordion(
                title: 'Amount',
                icon: Icons.currency_rupee_rounded,
                selectedCount:
                (_draft.minAmount != null || _draft.maxAmount != null)
                    ? 1
                    : 0,
                expanded: _expanded['amount']!,
                onToggle: (v) => _toggle('amount', v),
                child: _MrnAmountPanel(
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
      ]),
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
      child: Column(children: [
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
        Row(children: [
          const Icon(Icons.filter_list_rounded, size: 20, color: newBlueColor),
          const SizedBox(width: 8),
          Text('Filter',
              style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E))),
          if (activeCount > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: newBlueColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text('$activeCount',
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
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
              child: Text('Clear All',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
        ]),
      ]),
    );
  }

  Widget _buildBottomBar(int activeCount) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(children: [
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
              backgroundColor: newBlueColor,
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
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// ACCORDION
// ═══════════════════════════════════════════════════════════════

class _MrnAccordion extends StatelessWidget {
  final String title;
  final IconData icon;
  final int selectedCount;
  final bool expanded;
  final void Function(bool) onToggle;
  final Widget child;

  const _MrnAccordion({
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
              ? newBlueColor.withValues(alpha: 0.25)
              : const Color(0xFFEEEEEE),
        ),
      ),
      child: Column(children: [
        InkWell(
          onTap: () => onToggle(!expanded),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(children: [
              Icon(icon, size: 18, color: newBlueColor),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: newBlueColor,
                      borderRadius: BorderRadius.circular(20)),
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
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CHECKLIST
// ═══════════════════════════════════════════════════════════════

class _MrnChecklist extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String search;
  final void Function(String) onSearchChanged;
  final void Function(String) onToggle;
  final bool showSearch;
  final bool jobTypeMode;

  const _MrnChecklist({
    required this.options,
    required this.selected,
    required this.search,
    required this.onSearchChanged,
    required this.onToggle,
    this.showSearch = true,
    this.jobTypeMode = false,
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (showSearch) ...[
          TextField(
            onChanged: onSearchChanged,
            style: GoogleFonts.dmSans(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: GoogleFonts.dmSans(
                  fontSize: 13, color: Colors.grey.shade400),
              prefixIcon: Icon(Icons.search,
                  size: 18, color: Colors.grey.shade400),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
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
                    .map((opt) => _MrnCheckItem(
                  label: opt,
                  selected: selected.contains(opt),
                  onToggle: () => onToggle(opt),
                  jobTypeMode: jobTypeMode,
                ))
                    .toList(),
              ),
            ),
          ),
      ]),
    );
  }
}

class _MrnCheckItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onToggle;
  final bool jobTypeMode;

  const _MrnCheckItem({
    required this.label,
    required this.selected,
    required this.onToggle,
    this.jobTypeMode = false,
  });

  Color _jobTypeColor(String s) {
    switch (s.toLowerCase()) {
      case 'electrical':
        return const Color(0xFF2196F3);
      case 'civil':
        return const Color(0xFF795548);
      case 'plumbing':
        return const Color(0xFF00BCD4);
      case 'fire fighting':
        return const Color(0xFFF44336);
      case 'fire alarm system':
      case 'fire alarm & pa system':
        return const Color(0xFFFF5722);
      case 'cctv':
        return const Color(0xFF9C27B0);
      case 'networking':
        return const Color(0xFF4CAF50);
      default:
        return newOrangeColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dotColor = jobTypeMode ? _jobTypeColor(label) : null;

    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: selected ? newBlueColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selected ? newBlueColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: selected
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          if (jobTypeMode && dotColor != null)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration:
              BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight:
                selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? const Color(0xFF1A1A2E)
                    : Colors.grey.shade700,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// AMOUNT PANEL
// ═══════════════════════════════════════════════════════════════

class _MrnAmountPanel extends StatelessWidget {
  final TextEditingController minCtrl;
  final TextEditingController maxCtrl;
  final double dataMax;

  const _MrnAmountPanel({
    required this.minCtrl,
    required this.maxCtrl,
    required this.dataMax,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Expanded(
              child: _MrnAmountField(controller: minCtrl, hint: 'Min ₹')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('–',
                style: GoogleFonts.dmSans(
                    fontSize: 16, color: Colors.grey.shade400)),
          ),
          Expanded(
              child: _MrnAmountField(controller: maxCtrl, hint: 'Max ₹')),
        ]),
      ]),
    );
  }
}

class _MrnAmountField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _MrnAmountField(
      {required this.controller, required this.hint});

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
        fillColor: newBlueLightColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: newBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: newBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: newBlueColor, width: 1.5),
        ),
      ),
    );
  }
}