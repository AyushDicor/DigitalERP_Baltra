// ─────────────────────────────────────────────────────────────────────────────
// issue_item_filter_sheet.dart
// ─────────────────────────────────────────────────────────────────────────────

import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../issue_item_response/issue_item_model.dart';

// ═══════════════════════════════════════════════════════════════════════════
// DATE PRESET
// ═══════════════════════════════════════════════════════════════════════════

enum _DatePreset {
  today('Today', 0),
  last7('Last 7 days', 6),
  last30('Last 30 days', 29),
  last90('Last 90 days', 89),
  custom('Custom', -1);

  final String label;
  final int daysBack;
  const _DatePreset(this.label, this.daysBack);

  DateTimeRange? get range {
    if (daysBack < 0) return null;
    final today = DateTime.now();
    final from = DateTime(today.year, today.month, today.day)
        .subtract(Duration(days: daysBack));
    final to = DateTime(today.year, today.month, today.day);
    return DateTimeRange(start: from, end: to);
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// FILTER MODEL
// ═══════════════════════════════════════════════════════════════════════════

class IssueItemFilter {
  final Set<String> issueTo;
  final Set<String> godowns;
  final Set<String> itemIssueTypes;
  final Set<String> issuedBy;
  final DateTime? fromDate;
  final DateTime? toDate;

  const IssueItemFilter({
    this.issueTo = const {},
    this.godowns = const {},
    this.itemIssueTypes = const {},
    this.issuedBy = const {},
    this.fromDate,
    this.toDate,
  });

  bool get isActive =>
      issueTo.isNotEmpty ||
          godowns.isNotEmpty ||
          itemIssueTypes.isNotEmpty ||
          issuedBy.isNotEmpty ||
          fromDate != null ||
          toDate != null;

  int get activeCount {
    int n = 0;
    if (issueTo.isNotEmpty) n++;
    if (godowns.isNotEmpty) n++;
    if (itemIssueTypes.isNotEmpty) n++;
    if (issuedBy.isNotEmpty) n++;
    if (fromDate != null || toDate != null) n++;
    return n;
  }

  IssueItemFilter copyWith({
    Set<String>? issueTo,
    Set<String>? godowns,
    Set<String>? itemIssueTypes,
    Set<String>? issuedBy,
    DateTime? fromDate,
    DateTime? toDate,
    bool clearFromDate = false,
    bool clearToDate = false,
  }) =>
      IssueItemFilter(
        issueTo: issueTo ?? this.issueTo,
        godowns: godowns ?? this.godowns,
        itemIssueTypes: itemIssueTypes ?? this.itemIssueTypes,
        issuedBy: issuedBy ?? this.issuedBy,
        fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
        toDate: clearToDate ? null : (toDate ?? this.toDate),
      );

  List<IssueItemListItem> apply(List<IssueItemListItem> all) {
    return all.where((item) {
      if (issueTo.isNotEmpty && !issueTo.contains(item.issueTo)) return false;
      if (godowns.isNotEmpty && !godowns.contains(item.godown)) return false;
      if (itemIssueTypes.isNotEmpty &&
          !itemIssueTypes.contains(item.itemIssueType)) return false;
      if (issuedBy.isNotEmpty && !issuedBy.contains(item.issuedBy))
        return false;

      if (fromDate != null || toDate != null) {
        final parsed = _parseDate(item.issueDate);
        if (parsed == null) return false;
        final d = DateTime(parsed.year, parsed.month, parsed.day);
        if (fromDate != null && d.isBefore(fromDate!)) return false;
        if (toDate != null && d.isAfter(toDate!)) return false;
      }

      return true;
    }).toList();
  }

  static DateTime? _parseDate(String raw) {
    if (raw.isEmpty) return null;
    try {
      final dt = DateTime.tryParse(raw);
      if (dt != null) return dt;
      DateTime? d = DateFormat('dd/MM/yyyy').tryParseStrict(raw);
      d ??= DateFormat('dd-MM-yyyy').tryParseStrict(raw);
      return d;
    } catch (_) {
      return null;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SHEET WIDGET
// ═══════════════════════════════════════════════════════════════════════════

class IssueItemFilterSheet extends StatefulWidget {
  final List<IssueItemListItem> items;
  final IssueItemFilter activeFilter;
  final void Function(IssueItemFilter) onApply;
  final VoidCallback? onReset;

  const IssueItemFilterSheet({
    super.key,
    required this.items,
    required this.activeFilter,
    required this.onApply,
    this.onReset,
  });

  @override
  State<IssueItemFilterSheet> createState() => _IssueItemFilterSheetState();
}

class _IssueItemFilterSheetState extends State<IssueItemFilterSheet> {
  late IssueItemFilter _draft;

  late List<String> _issueToOptions;
  late List<String> _godownOptions;
  late List<String> _itemIssueTypeOptions;
  late List<String> _issuedByOptions;

  final Map<String, bool> _expanded = {
    'date': false,
    'issueTo': false,
    'godown': false,
    'itemIssueType': false,
    'issuedBy': false,
  };

  final Map<String, String> _search = {
    'issueTo': '',
    'issuedBy': '',
  };

  _DatePreset _preset = _DatePreset.last30;
  static final _fmt = DateFormat('dd MMM yyyy');

  @override
  void initState() {
    super.initState();
    _draft = widget.activeFilter;
    _buildOptions();
    _syncPresetFromDraft();
  }

  void _buildOptions() {
    List<String> _unique(Iterable<String> src) =>
        src.where((s) => s.trim().isNotEmpty).toSet().toList()..sort();

    _issueToOptions      = _unique(widget.items.map((e) => e.issueTo));
    _godownOptions       = _unique(widget.items.map((e) => e.godown));
    _itemIssueTypeOptions = _unique(widget.items.map((e) => e.itemIssueType));
    _issuedByOptions     = _unique(widget.items.map((e) => e.issuedBy));
  }

  void _syncPresetFromDraft() {
    if (_draft.fromDate == null && _draft.toDate == null) {
      _preset = _DatePreset.last30;
      return;
    }
    for (final p in _DatePreset.values) {
      if (p == _DatePreset.custom) continue;
      final r = p.range!;
      if (_draft.fromDate == r.start && _draft.toDate == r.end) {
        _preset = p;
        return;
      }
    }
    _preset = _DatePreset.custom;
  }

  void _toggleExpand(String key, bool val) =>
      setState(() => _expanded[key] = val);

  void _toggleItem(Set<String> current, String item, String field) {
    final next = Set<String>.from(current);
    next.contains(item) ? next.remove(item) : next.add(item);
    setState(() {
      switch (field) {
        case 'issueTo':
          _draft = _draft.copyWith(issueTo: next);
          break;
        case 'godown':
          _draft = _draft.copyWith(godowns: next);
          break;
        case 'itemIssueType':
          _draft = _draft.copyWith(itemIssueTypes: next);
          break;
        case 'issuedBy':
          _draft = _draft.copyWith(issuedBy: next);
          break;
      }
    });
  }

  void _applyPreset(_DatePreset p) {
    setState(() {
      _preset = p;
      if (p != _DatePreset.custom) {
        final r = p.range!;
        _draft = _draft.copyWith(fromDate: r.start, toDate: r.end);
      }
    });
  }

  Future<void> _pickCustomRange() async {
    final initial = (_draft.fromDate != null && _draft.toDate != null)
        ? DateTimeRange(start: _draft.fromDate!, end: _draft.toDate!)
        : DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 29)),
      end: DateTime.now(),
    );

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
      initialDateRange: initial,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(
            primary: purpleColor,
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      setState(() {
        _preset = _DatePreset.custom;
        _draft = _draft.copyWith(
          fromDate:
          DateTime(picked.start.year, picked.start.month, picked.start.day),
          toDate:
          DateTime(picked.end.year, picked.end.month, picked.end.day),
        );
      });
    }
  }

  void _clearDateRange() {
    setState(() {
      _preset = _DatePreset.last30;
      _draft = _draft.copyWith(clearFromDate: true, clearToDate: true);
    });
  }

  void _reset() {
    setState(() {
      _draft = const IssueItemFilter();
      _preset = _DatePreset.last30;
      for (final k in _search.keys) _search[k] = '';
    });
    Navigator.pop(context);
    widget.onApply(const IssueItemFilter());
    widget.onReset?.call();
  }

  void _apply() {
    Navigator.pop(context);
    widget.onApply(_draft);
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
              // ── Date Range ────────────────────────────────────────────
              _Accordion(
                title: 'Date Range',
                icon: Icons.date_range_rounded,
                selectedCount:
                (_draft.fromDate != null || _draft.toDate != null) ? 1 : 0,
                expanded: _expanded['date']!,
                onToggle: (v) => _toggleExpand('date', v),
                child: _DateRangePanel(
                  draft: _draft,
                  selectedPreset: _preset,
                  fmt: _fmt,
                  onPresetTap: _applyPreset,
                  onCustomTap: _pickCustomRange,
                  onClear: _clearDateRange,
                ),
              ),
              const SizedBox(height: 8),

              // ── Issue To ──────────────────────────────────────────────
              _Accordion(
                title: 'Issue To',
                icon: Icons.arrow_forward_outlined,
                selectedCount: _draft.issueTo.length,
                expanded: _expanded['issueTo']!,
                onToggle: (v) => _toggleExpand('issueTo', v),
                child: _Checklist(
                  options: _issueToOptions,
                  selected: _draft.issueTo,
                  search: _search['issueTo']!,
                  onSearchChanged: (v) =>
                      setState(() => _search['issueTo'] = v),
                  onToggle: (o) => _toggleItem(_draft.issueTo, o, 'issueTo'),
                  showSearch: _issueToOptions.length > 5,
                ),
              ),
              const SizedBox(height: 8),

              // ── Godown ────────────────────────────────────────────────
              if (_godownOptions.isNotEmpty) ...[
                _Accordion(
                  title: 'Godown',
                  icon: Icons.warehouse_outlined,
                  selectedCount: _draft.godowns.length,
                  expanded: _expanded['godown']!,
                  onToggle: (v) => _toggleExpand('godown', v),
                  child: _Checklist(
                    options: _godownOptions,
                    selected: _draft.godowns,
                    search: '',
                    onSearchChanged: (_) {},
                    onToggle: (o) =>
                        _toggleItem(_draft.godowns, o, 'godown'),
                    showSearch: false,
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // ── Item Issue Type ───────────────────────────────────────
              if (_itemIssueTypeOptions.isNotEmpty) ...[
                _Accordion(
                  title: 'Item Issue Type',
                  icon: Icons.category_outlined,
                  selectedCount: _draft.itemIssueTypes.length,
                  expanded: _expanded['itemIssueType']!,
                  onToggle: (v) => _toggleExpand('itemIssueType', v),
                  child: _Checklist(
                    options: _itemIssueTypeOptions,
                    selected: _draft.itemIssueTypes,
                    search: '',
                    onSearchChanged: (_) {},
                    onToggle: (o) =>
                        _toggleItem(_draft.itemIssueTypes, o, 'itemIssueType'),
                    showSearch: false,
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // ── Issued By ─────────────────────────────────────────────
              if (_issuedByOptions.isNotEmpty) ...[
                _Accordion(
                  title: 'Issued By',
                  icon: Icons.person_outline_rounded,
                  selectedCount: _draft.issuedBy.length,
                  expanded: _expanded['issuedBy']!,
                  onToggle: (v) => _toggleExpand('issuedBy', v),
                  child: _Checklist(
                    options: _issuedByOptions,
                    selected: _draft.issuedBy,
                    search: _search['issuedBy']!,
                    onSearchChanged: (v) =>
                        setState(() => _search['issuedBy'] = v),
                    onToggle: (o) =>
                        _toggleItem(_draft.issuedBy, o, 'issuedBy'),
                    showSearch: _issuedByOptions.length > 5,
                  ),
                ),
                const SizedBox(height: 8),
              ],

              const SizedBox(height: 16),
            ],
          ),
        ),
        _bottomBar(count),
        SizedBox(height: mq.padding.bottom),
      ]),
    );
  }

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
          const Icon(Icons.filter_list_rounded, size: 20, color: purpleColor),
          const SizedBox(width: 8),
          Text('Filter Issues',
              style: GoogleFonts.dmSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A2E))),
          if (count > 0) ...[
            const SizedBox(width: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                  color: purpleColor,
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
                  padding: const EdgeInsets.symmetric(horizontal: 4)),
              child: Text('Clear All',
                  style: GoogleFonts.dmSans(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
        ]),
      ]),
    );
  }

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
              backgroundColor: purpleColor,
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

// ═══════════════════════════════════════════════════════════════════════════
// DATE RANGE PANEL
// ═══════════════════════════════════════════════════════════════════════════

class _DateRangePanel extends StatelessWidget {
  final IssueItemFilter draft;
  final _DatePreset selectedPreset;
  final DateFormat fmt;
  final void Function(_DatePreset) onPresetTap;
  final VoidCallback onCustomTap;
  final VoidCallback onClear;

  const _DateRangePanel({
    required this.draft,
    required this.selectedPreset,
    required this.fmt,
    required this.onPresetTap,
    required this.onCustomTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasRange = draft.fromDate != null || draft.toDate != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _DatePreset.values.map((p) {
            final isSelected = selectedPreset == p;
            final isCustom = p == _DatePreset.custom;
            return GestureDetector(
              onTap: isCustom ? onCustomTap : () => onPresetTap(p),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: isSelected
                      ? purpleColor
                      : purpleColor.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? purpleColor
                        : newBorderColor,
                  ),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (isCustom)
                    Icon(Icons.edit_calendar_rounded,
                        size: 13,
                        color:
                        isSelected ? Colors.white : purpleColor),
                  if (isCustom) const SizedBox(width: 4),
                  Text(p.label,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : newTextSecondary,
                      )),
                ]),
              ),
            );
          }).toList(),
        ),
        if (hasRange) ...[
          const SizedBox(height: 14),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: purpleColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: purpleColor.withValues(alpha: 0.25)),
            ),
            child: Row(children: [
              const Icon(Icons.date_range_rounded,
                  size: 15, color: purpleColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _rangeLabel(),
                  style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: purpleColor),
                ),
              ),
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close_rounded,
                    size: 16, color: Colors.grey.shade500),
              ),
            ]),
          ),
        ],
      ]),
    );
  }

  String _rangeLabel() {
    if (draft.fromDate != null && draft.toDate != null) {
      return '${fmt.format(draft.fromDate!)}  →  ${fmt.format(draft.toDate!)}';
    } else if (draft.fromDate != null) {
      return 'From ${fmt.format(draft.fromDate!)}';
    } else if (draft.toDate != null) {
      return 'Until ${fmt.format(draft.toDate!)}';
    }
    return '';
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ACCORDION
// ═══════════════════════════════════════════════════════════════════════════

class _Accordion extends StatelessWidget {
  final String title;
  final IconData icon;
  final int selectedCount;
  final bool expanded;
  final void Function(bool) onToggle;
  final Widget child;

  const _Accordion({
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
              ? purpleColor.withValues(alpha: 0.3)
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: purpleColor,
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

// ═══════════════════════════════════════════════════════════════════════════
// CHECKLIST
// ═══════════════════════════════════════════════════════════════════════════

class _Checklist extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final String search;
  final void Function(String) onSearchChanged;
  final void Function(String) onToggle;
  final bool showSearch;

  const _Checklist({
    required this.options,
    required this.selected,
    required this.search,
    required this.onSearchChanged,
    required this.onToggle,
    this.showSearch = true,
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
              hintText: 'Search…',
              hintStyle: GoogleFonts.dmSans(
                  fontSize: 13, color: Colors.grey.shade400),
              prefixIcon:
              Icon(Icons.search, size: 18, color: Colors.grey.shade400),
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
                ))
                    .toList(),
              ),
            ),
          ),
      ]),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CHECK ITEM
// ═══════════════════════════════════════════════════════════════════════════

class _CheckItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onToggle;

  const _CheckItem({
    required this.label,
    required this.selected,
    required this.onToggle,
  });

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
              color: selected ? purpleColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: selected ? purpleColor : Colors.grey.shade300,
                  width: 1.5),
            ),
            child: selected
                ? const Icon(Icons.check, size: 13, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  fontWeight:
                  selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? const Color(0xFF1A1A2E)
                      : Colors.grey.shade700,
                )),
          ),
        ]),
      ),
    );
  }
}