// lib/screen/ui/home/mrn_module/mrn_grn_filter/mrn_grn_filter_sheet.dart
//
// Shared filter bottom sheet for MrnListScreen and GrnListScreen.
// Same accordion style as PaymentRequestFilterSheet.
// All filtering is client-side on already-loaded data.
//
// ── MRN USAGE ──
//   Add to MrnListController:
//     MrnGrnFilter activeFilter = const MrnGrnFilter();
//     List<MrnListItem> get filteredItems => activeFilter.applyMrn(mrnItems);
//     bool get hasActiveFilter => activeFilter.isActive;
//     void applyFilter(MrnGrnFilter f) { activeFilter = f; update(); }
//     void resetFilter() { activeFilter = const MrnGrnFilter(); update(); }
//
//   In MrnListScreen AppBar actions:
//     IconButton(icon: Icon(Icons.tune_rounded), onPressed: () => _showFilterSheet(context, ctrl))
//
//   Method in MrnListScreen:
//     void _showFilterSheet(BuildContext ctx, MrnListController ctrl) {
//       showModalBottomSheet(
//         context: ctx, isScrollControlled: true, backgroundColor: Colors.transparent,
//         builder: (_) => MrnGrnFilterSheet.forMrn(
//           items: ctrl.mrnItems,
//           activeFilter: ctrl.activeFilter,
//           onApply: ctrl.applyFilter,
//           onReset: ctrl.resetFilter,
//         ),
//       );
//     }
//
// ── GRN USAGE ── (identical, just swap MrnListController → GrnListController)
//     MrnGrnFilterSheet.forGrn(items: ctrl.GrnItems, ...)

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ═══════════════════════════════════════════════════════════════
// SHARED DATA SHAPE  (MrnListItem & GrnListItem expose same fields)
// ═══════════════════════════════════════════════════════════════

/// Adapter so the sheet works with both MrnListItem and GrnListItem
/// without depending on the concrete type.
class _ListItemAdapter {
  final String partyName;
  final String siteName;
  final String jobType;
  final double totalAmt;

  const _ListItemAdapter({
    required this.partyName,
    required this.siteName,
    required this.jobType,
    required this.totalAmt,
  });
}

// ═══════════════════════════════════════════════════════════════
// FILTER MODEL
// ═══════════════════════════════════════════════════════════════

class MrnGrnFilter {
  final Set<String> partyNames;
  final Set<String> siteNames;
  final Set<String> jobTypes;
  final double? minAmount;
  final double? maxAmount;

  const MrnGrnFilter({
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

  MrnGrnFilter copyWith({
    Set<String>? partyNames,
    Set<String>? siteNames,
    Set<String>? jobTypes,
    double? minAmount,
    double? maxAmount,
    bool clearMin = false,
    bool clearMax = false,
  }) =>
      MrnGrnFilter(
        partyNames: partyNames ?? this.partyNames,
        siteNames: siteNames ?? this.siteNames,
        jobTypes: jobTypes ?? this.jobTypes,
        minAmount: clearMin ? null : (minAmount ?? this.minAmount),
        maxAmount: clearMax ? null : (maxAmount ?? this.maxAmount),
      );

  /// Generic apply — works on the adapter list
  List<T> _apply<T>(
      List<T> all,
      _ListItemAdapter Function(T) toAdapter,
      ) {
    return all.where((raw) {
      final item = toAdapter(raw);
      if (partyNames.isNotEmpty && !partyNames.contains(item.partyName)) {
        return false;
      }
      if (siteNames.isNotEmpty && !siteNames.contains(item.siteName)) {
        return false;
      }
      if (jobTypes.isNotEmpty && !jobTypes.contains(item.jobType)) {
        return false;
      }
      if (minAmount != null && item.totalAmt < minAmount!) return false;
      if (maxAmount != null && item.totalAmt > maxAmount!) return false;
      return true;
    }).toList();
  }

  /// Call this from MrnListController.filteredItems
  List<T> applyMrn<T extends Object>(
      List<T> items, {
        required String Function(T) partyName,
        required String Function(T) siteName,
        required String Function(T) jobType,
        required double Function(T) totalAmt,
      }) =>
      _apply(
        items,
            (e) => _ListItemAdapter(
          partyName: partyName(e),
          siteName: siteName(e),
          jobType: jobType(e),
          totalAmt: totalAmt(e),
        ),
      );
}

// ═══════════════════════════════════════════════════════════════
// SHEET WIDGET
// ═══════════════════════════════════════════════════════════════

class MrnGrnFilterSheet extends StatefulWidget {
  final List<_ListItemAdapter> _items;
  final MrnGrnFilter activeFilter;
  final void Function(MrnGrnFilter) onApply;
  final VoidCallback? onReset;
  final String title; // 'MRN' or 'GRN'

  const MrnGrnFilterSheet._({
    required List<_ListItemAdapter> items,
    required this.activeFilter,
    required this.onApply,
    required this.title,
    this.onReset,
  }) : _items = items;

  /// Factory for MRN — pass your List<MrnListItem>
  static MrnGrnFilterSheet forMrn<T extends Object>({
    required List<T> items,
    required MrnGrnFilter activeFilter,
    required void Function(MrnGrnFilter) onApply,
    VoidCallback? onReset,
    required String Function(T) partyName,
    required String Function(T) siteName,
    required String Function(T) jobType,
    required double Function(T) totalAmt,
  }) =>
      MrnGrnFilterSheet._(
        items: items
            .map((e) => _ListItemAdapter(
          partyName: partyName(e),
          siteName: siteName(e),
          jobType: jobType(e),
          totalAmt: totalAmt(e),
        ))
            .toList(),
        activeFilter: activeFilter,
        onApply: onApply,
        onReset: onReset,
        title: 'MRN',
      );

  /// Factory for GRN — pass your List<GrnListItem>
  static MrnGrnFilterSheet forGrn<T extends Object>({
    required List<T> items,
    required MrnGrnFilter activeFilter,
    required void Function(MrnGrnFilter) onApply,
    VoidCallback? onReset,
    required String Function(T) partyName,
    required String Function(T) siteName,
    required String Function(T) jobType,
    required double Function(T) totalAmt,
  }) =>
      MrnGrnFilterSheet._(
        items: items
            .map((e) => _ListItemAdapter(
          partyName: partyName(e),
          siteName: siteName(e),
          jobType: jobType(e),
          totalAmt: totalAmt(e),
        ))
            .toList(),
        activeFilter: activeFilter,
        onApply: onApply,
        onReset: onReset,
        title: 'GRN',
      );

  @override
  State<MrnGrnFilterSheet> createState() => _MrnGrnFilterSheetState();
}

class _MrnGrnFilterSheetState extends State<MrnGrnFilterSheet> {
  late MrnGrnFilter _draft;

  late List<String> _partyOptions;
  late List<String> _siteOptions;
  late List<String> _jobTypeOptions;
  late double _dataMaxAmt;

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
    _partyOptions = widget._items
        .map((e) => e.partyName)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _siteOptions = widget._items
        .map((e) => e.siteName)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _jobTypeOptions = widget._items
        .map((e) => e.jobType)
        .where((s) => s.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    _dataMaxAmt = widget._items
        .map((e) => e.totalAmt)
        .fold(0.0, (a, b) => a > b ? a : b);
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  void _toggleExpand(String key, bool val) =>
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
      _draft = const MrnGrnFilter();
      _minCtrl.clear();
      _maxCtrl.clear();
      for (final k in _search.keys) _search[k] = '';
    });
    Navigator.pop(context);
    widget.onApply(const MrnGrnFilter());
    widget.onReset?.call();
  }

  void _apply() {
    final min = double.tryParse(_minCtrl.text.trim());
    final max = double.tryParse(_maxCtrl.text.trim());
    Navigator.pop(context);
    widget.onApply(_draft.copyWith(
      minAmount: min,
      maxAmount: max,
      clearMin: min == null,
      clearMax: max == null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final count = _draft.activeCount;

    return Container(
      height: mq.size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FC),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(children: [
        _header(count),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: [
              // Party Name
              _Accordion(
                title: 'Party Name',
                icon: Icons.business_outlined,
                accentColor: newBlueColor,
                selectedCount: _draft.partyNames.length,
                expanded: _expanded['party']!,
                onToggle: (v) => _toggleExpand('party', v),
                child: _Checklist(
                  options: _partyOptions,
                  selected: _draft.partyNames,
                  search: _search['party']!,
                  onSearchChanged: (v) =>
                      setState(() => _search['party'] = v),
                  onToggle: (o) => _toggleItem(_draft.partyNames, o, 'party'),
                  showSearch: _partyOptions.length > 5,
                  accentColor: newBlueColor,
                ),
              ),
              const SizedBox(height: 8),

              // Site Name
              _Accordion(
                title: 'Site Name',
                icon: Icons.location_on_outlined,
                accentColor: newBlueColor,
                selectedCount: _draft.siteNames.length,
                expanded: _expanded['site']!,
                onToggle: (v) => _toggleExpand('site', v),
                child: _Checklist(
                  options: _siteOptions,
                  selected: _draft.siteNames,
                  search: _search['site']!,
                  onSearchChanged: (v) =>
                      setState(() => _search['site'] = v),
                  onToggle: (o) => _toggleItem(_draft.siteNames, o, 'site'),
                  showSearch: _siteOptions.length > 5,
                  accentColor: newBlueColor,
                ),
              ),
              const SizedBox(height: 8),

              // Job Type
              _Accordion(
                title: 'Job Type',
                icon: Icons.work_outline_rounded,
                accentColor: newBlueColor,
                selectedCount: _draft.jobTypes.length,
                expanded: _expanded['jobType']!,
                onToggle: (v) => _toggleExpand('jobType', v),
                child: _Checklist(
                  options: _jobTypeOptions,
                  selected: _draft.jobTypes,
                  search: '',
                  onSearchChanged: (_) {},
                  onToggle: (o) => _toggleItem(_draft.jobTypes, o, 'jobType'),
                  showSearch: false,
                  accentColor: newBlueColor,
                  showJobTypeDot: true,
                ),
              ),
              const SizedBox(height: 8),

              // Amount
              _Accordion(
                title: 'Amount',
                icon: Icons.currency_rupee_rounded,
                accentColor: newBlueColor,
                selectedCount:
                (_draft.minAmount != null || _draft.maxAmount != null)
                    ? 1
                    : 0,
                expanded: _expanded['amount']!,
                onToggle: (v) => _toggleExpand('amount', v),
                child: _AmountPanel(
                  minCtrl: _minCtrl,
                  maxCtrl: _maxCtrl,
                  dataMax: _dataMaxAmt,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        _bottomBar(count),
        SizedBox(height: mq.padding.bottom),
      ]),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────
  Widget _header(int count) {
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
          Text(
            'Filter ${widget.title}',
            style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E)),
          ),
          if (count > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: newBlueColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Text('$count',
                  style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ],
          const Spacer(),
          if (count > 0)
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

  // ── Bottom bar ───────────────────────────────────────────────────────────────
  Widget _bottomBar(int count) {
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
              count > 0 ? 'Apply ($count)' : 'Apply',
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

class _Accordion extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final int selectedCount;
  final bool expanded;
  final void Function(bool) onToggle;
  final Widget child;

  const _Accordion({
    required this.title,
    required this.icon,
    required this.accentColor,
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
              ? accentColor.withValues(alpha: 0.3)
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
              Icon(icon, size: 18, color: accentColor),
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
                      color: accentColor,
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
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CHECKLIST
// ═══════════════════════════════════════════════════════════════

class _Checklist extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String search;
  final void Function(String) onSearchChanged;
  final void Function(String) onToggle;
  final bool showSearch;
  final Color accentColor;
  final bool showJobTypeDot;

  const _Checklist({
    required this.options,
    required this.selected,
    required this.search,
    required this.onSearchChanged,
    required this.onToggle,
    this.showSearch = true,
    required this.accentColor,
    this.showJobTypeDot = false,
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
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    .map((opt) => _CheckItem(
                  label: opt,
                  selected: selected.contains(opt),
                  onToggle: () => onToggle(opt),
                  accentColor: accentColor,
                  showDot: showJobTypeDot,
                ))
                    .toList(),
              ),
            ),
          ),
      ]),
    );
  }
}

class _CheckItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onToggle;
  final Color accentColor;
  final bool showDot;

  const _CheckItem({
    required this.label,
    required this.selected,
    required this.onToggle,
    required this.accentColor,
    this.showDot = false,
  });

  Color _dotColor(String s) {
    switch (s.toLowerCase().trim()) {
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
      case 'pa system':
        return const Color(0xFF607D8B);
      case 'access control':
        return const Color(0xFF009688);
      default:
        return newOrangeColor;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: selected ? accentColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: selected ? accentColor : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: selected
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          if (showDot)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: _dotColor(label), shape: BoxShape.circle),
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
      child:
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Expanded(child: _AmountField(controller: minCtrl, hint: 'Min ₹')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('–',
                style: GoogleFonts.dmSans(
                    fontSize: 16, color: Colors.grey.shade400)),
          ),
          Expanded(child: _AmountField(controller: maxCtrl, hint: 'Max ₹')),
        ]),
      ]),
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