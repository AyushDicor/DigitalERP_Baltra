import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../approval_hub_controller/approval_hub_controller.dart';
import 'approval_hub_bulk.dart';

class ApprovalHubList extends StatelessWidget {
  const ApprovalHubList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(
      builder: (ctrl) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Column(children: [
            _AppBar(ctrl: ctrl),
            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
              child: TextFormField(
                controller: ctrl.searchCtrl,
                onChanged: ctrl.onSearch,
                style: const TextStyle(fontSize: 13, color: newTextPrimary),
                decoration: InputDecoration(
                  hintText: 'Search doc no, party, executive...',
                  hintStyle: const TextStyle(color: newTextHint, fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded,
                      size: 20, color: newTextSecondary),
                  suffixIcon: ctrl.searchQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: ctrl.clearSearch,
                          child: const Icon(Icons.close_rounded,
                              size: 18, color: newTextSecondary))
                      : null,
                  filled: true,
                  fillColor: newSurfaceColor,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
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
            ),
            // Category filter tabs
            _FilterTabs(ctrl: ctrl),
            // Active filter chip row
            if (ctrl.isFilterActive) _ActiveFilterBar(ctrl: ctrl),
            // Bulk selection bar
            if (ctrl.hasSelection) _BulkBar(ctrl: ctrl),
            // List
            Expanded(
              child: ctrl.filteredApprovals.isEmpty
                  ? const Center(
                      child: Text('No approvals found',
                          style:
                              TextStyle(color: newTextSecondary, fontSize: 14)))
                  : _ApprovalList(ctrl: ctrl),
            ),
          ]),
        ),
      ),
    );
  }
}

//  App bar

class _AppBar extends StatelessWidget {
  final ApprovalHubController ctrl;

  const _AppBar({required this.ctrl});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Row(children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
                width: 38,
                height: 38,
                // decoration: BoxDecoration(
                //     color: newSurfaceColor,
                //     borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: newTextPrimary)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text('All Approvals',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: newTextPrimary)),
                Text('${ctrl.filteredApprovals.length} approvals',
                    style:
                        const TextStyle(fontSize: 11, color: newTextSecondary)),
              ])),
          // ✅ Filter button — wired up
          GestureDetector(
            onTap: () => showFilterSheet(context, ctrl),
            child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                    // Highlight when filter is active
                    color: ctrl.isFilterActive
                        ? purpleLightest
                        : newBlueLightColor,
                    borderRadius: BorderRadius.circular(18)),
                alignment: Alignment.center,
                child: Icon(Icons.filter_list_sharp,
                    size: 20,
                    color: ctrl.isFilterActive ? purpleColor : newBlueColor)),
          ),
        ]),
      );
}

//  Filter bottom sheet

void showFilterSheet(BuildContext context, ApprovalHubController ctrl) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _FilterSheet(ctrl: ctrl),
  );
}

class _FilterSheet extends StatefulWidget {
  final ApprovalHubController ctrl;

  const _FilterSheet({required this.ctrl});

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late DateTime _from;
  late DateTime _to;
  late String _status;

  final _fmt = DateFormat('dd MMM yyyy');

  static const _statuses = [
    '',
    'Pending',
    'Approved',
    'Rejected',
    'Verify',
    // 'Hold',
    // 'Reverted',
  ];

  static const _quickRanges = [
    ('Today', 0),
    ('Last 7 days', 7),
    ('Last 30 days', 30),
    ('Last 90 days', 90),
  ];

  @override
  void initState() {
    super.initState();
    _from = widget.ctrl.filterFrom;
    _to = widget.ctrl.filterTo;
    _status = widget.ctrl.filterStatus;
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFrom ? _from : _to,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: newBlueColor),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    setState(() {
      if (isFrom) {
        _from = picked;
        if (_from.isAfter(_to)) _to = _from;
      } else {
        _to = picked;
        if (_to.isBefore(_from)) _from = _to;
      }
    });
  }

  void _applyQuick(int days) {
    setState(() {
      _to = DateTime.now();
      _from = days == 0 ? _to : _to.subtract(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                  color: newBorderColor,
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filter Approvals',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: newTextPrimary)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _from =
                            DateTime.now().subtract(const Duration(days: 30));
                        _to = DateTime.now();
                        _status = '';
                      });
                    },
                    child: const Text('Reset',
                        style: TextStyle(
                            fontSize: 13,
                            color: newBlueColor,
                            fontWeight: FontWeight.w600)),
                  ),
                ]),
          ),
          const SizedBox(height: 20),

          //  Quick date range
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Quick Range',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newTextSecondary)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 34,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: _quickRanges.map((r) {
                final isOn = r.$2 == 0
                    ? _from.day == _to.day &&
                        _from.month == _to.month &&
                        _from.year == _to.year
                    : _to.difference(_from).inDays.abs() == r.$2;
                return GestureDetector(
                  onTap: () => _applyQuick(r.$2),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isOn ? newBlueColor : newSurfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isOn ? newBlueColor : newBorderColor),
                    ),
                    alignment: Alignment.center,
                    child: Text(r.$1,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: isOn ? Colors.white : newTextSecondary)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          //  Custom date pickers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              Expanded(
                  child: _DateTile(
                      label: 'From',
                      value: _fmt.format(_from),
                      onTap: () => _pickDate(isFrom: true))),
              const SizedBox(width: 12),
              Expanded(
                  child: _DateTile(
                      label: 'To',
                      value: _fmt.format(_to),
                      onTap: () => _pickDate(isFrom: false))),
            ]),
          ),
          const SizedBox(height: 20),

          //  Status filter
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Status',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newTextSecondary)),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _statuses.map((s) {
                final label = s.isEmpty ? 'All' : s;
                final isOn = _status == s;
                return GestureDetector(
                  onTap: () => setState(() => _status = s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isOn ? newBlueColor : newSurfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: isOn ? newBlueColor : newBorderColor),
                    ),
                    child: Text(label,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isOn ? Colors.white : newTextSecondary)),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 28),

          //  Apply button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                widget.ctrl.applyFilter(from: _from, to: _to, status: _status);
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                    color: newBlueColor,
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: const Text('Apply Filter',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;

  const _DateTile(
      {required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: newSurfaceColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: newBorderColor)),
          child: Row(children: [
            const Icon(Icons.calendar_today_outlined,
                size: 14, color: newBlueColor),
            const SizedBox(width: 8),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(label,
                  style:
                      const TextStyle(fontSize: 10, color: newTextSecondary)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary)),
            ]),
          ]),
        ),
      );
}

//  Active filter chips

class _ActiveFilterBar extends StatelessWidget {
  final ApprovalHubController ctrl;

  const _ActiveFilterBar({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM');
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 6, 14, 0),
      child: Row(children: [
        const Icon(Icons.filter_list_rounded, size: 14, color: newBlueColor),
        const SizedBox(width: 6),
        // Date chip
        _Chip('${fmt.format(ctrl.filterFrom)} – ${fmt.format(ctrl.filterTo)}'),
        if (ctrl.filterStatus.isNotEmpty) ...[
          const SizedBox(width: 6),
          _Chip(ctrl.filterStatus),
        ],
        const Spacer(),
        GestureDetector(
          onTap: ctrl.resetFilter,
          child: const Text('Clear',
              style: TextStyle(
                  fontSize: 11,
                  color: newBlueColor,
                  fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;

  const _Chip(this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: newBlueLightColor, borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: newBlueColor)),
      );
}

//  Filter tabs

class _FilterTabs extends StatelessWidget {
  final ApprovalHubController ctrl;

  const _FilterTabs({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ...ctrl.categories.map((c) => MapEntry(c.key, c.label)),
    ];
    return SizedBox(
      height: 44,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 4, 14, 4),
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (_, i) {
          final isOn = ctrl.selectedCategory == tabs[i].key;
          return GestureDetector(
            onTap: () => ctrl.selectCategory(tabs[i].key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              margin: const EdgeInsets.only(right: 7),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isOn ? newBlueColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isOn ? newBlueColor : newBorderColor),
              ),
              alignment: Alignment.center,
              child: Text(tabs[i].value,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isOn ? Colors.white : newTextSecondary)),
            ),
          );
        },
      ),
    );
  }
}

//  Bulk action bar

class _BulkBar extends StatelessWidget {
  final ApprovalHubController ctrl;

  const _BulkBar({required this.ctrl});

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.fromLTRB(14, 4, 14, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
            color: newBlueColor, borderRadius: BorderRadius.circular(12)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${ctrl.selectionCount} selected',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800)),
            const Text('Long press to add more',
                style: TextStyle(color: Colors.white60, fontSize: 10)),
          ]),
          Row(children: [
            _BarBtn('Clear', () => ctrl.clearSelection(), filled: false),
            const SizedBox(width: 8),
            _BarBtn('Bulk Action →', () => Get.to(const ApprovalHubBulk()),
                filled: true),
          ]),
        ]),
      );
}

class _BarBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;

  const _BarBtn(this.label, this.onTap, {required this.filled});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: filled ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white60),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: filled ? newBlueColor : Colors.white)),
        ),
      );
}

//  Approval list

class _ApprovalList extends StatelessWidget {
  final ApprovalHubController ctrl;

  const _ApprovalList({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final pending = ctrl.filteredApprovals
        .where((a) => (a.status ?? '').toLowerCase() == 'pending')
        .toList();
    final approved = ctrl.filteredApprovals.where((a) {
      final s = (a.status ?? '').toLowerCase();
      return s == 'approved' || s == 'approve'; // ✅
    }).toList();
    final onHold = ctrl.filteredApprovals
        .where((a) => (a.status ?? '').toLowerCase() == 'on hold')
        .toList();
    final rejected = ctrl.filteredApprovals.where((a) {
      final s = (a.status ?? '').toLowerCase();
      return s == 'rejected' || s == 'reject'; // ✅ covers both variants
    }).toList();
    final others = ctrl.filteredApprovals.where((a) {
      final s = (a.status ?? '').toLowerCase();
      return !['pending', 'approved', 'on hold', 'rejected'].contains(s);
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 100),
      children: [
        if (pending.isNotEmpty) ...[
          _GroupLabel('Pending'),
          ...pending.map((item) =>
              _ApprovalCard(item: item, ctrl: ctrl, status: 'pending')),
        ],
        if (approved.isNotEmpty) ...[
          _GroupLabel('Approved'),
          ...approved.map((item) =>
              _ApprovalCard(item: item, ctrl: ctrl, status: 'approved')),
        ],
        if (onHold.isNotEmpty) ...[
          _GroupLabel('On Hold'),
          ...onHold.map((item) =>
              _ApprovalCard(item: item, ctrl: ctrl, status: 'on hold')),
        ],
        if (rejected.isNotEmpty) ...[
          _GroupLabel('Rejected'),
          ...rejected.map((item) =>
              _ApprovalCard(item: item, ctrl: ctrl, status: 'rejected')),
        ],
        if (others.isNotEmpty) ...[
          _GroupLabel('Others'),
          ...others
              .map((item) => _ApprovalCard(item: item, ctrl: ctrl, status: '')),
        ],
      ],
    );
  }
}

class _GroupLabel extends StatelessWidget {
  final String label;

  const _GroupLabel(this.label);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: newTextSecondary,
                  letterSpacing: .5)),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, color: newBorderColor)),
        ]),
      );
}

//  Approval card

class _ApprovalCard extends StatelessWidget {
  final ApprovalListData item;
  final ApprovalHubController ctrl;
  final String status;

  const _ApprovalCard(
      {required this.item, required this.ctrl, required this.status});

  @override
  Widget build(BuildContext context) {
    final isSelected = ctrl.isSelected(item);
    final color = ctrl.catColor(item.approvalType);
    final lightColor = ctrl.catLightColor(item.approvalType);
    final emoji = ctrl.catEmoji(item.approvalType);
    final docType = (item.approvalType ?? '').toLowerCase();
    final isWoOrPo = docType.contains('work order') ||
        docType.contains('workorder') ||
        docType.contains('purchase');

    return GestureDetector(
      onTap: () => ctrl.onCardTap(item),
      onLongPress: () => ctrl.onCardLongPress(item),
      onTapDown: (_) {},
      excludeFromSemantics: true,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? newBlueLightColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? newBlueColor : newBorderColor,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(children: [
          // Checkbox
          if (ctrl.hasSelection) ...[
            GestureDetector(
              onTap: () => ctrl.toggleSelect(item),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isSelected ? newBlueColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: isSelected ? newBlueColor : newBorderColor,
                      width: 1.5),
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? const Icon(Icons.check_rounded,
                        size: 13, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 9),
          ],
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: lightColor, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),
          // Info
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // Document name & number
                Text('${item.documentname ?? ''} — ${item.documentno ?? ''}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),

                // Requested By
                if ((item.requestedBy ?? '').isNotEmpty)
                  Text(item.requestedBy ?? '',
                      style: const TextStyle(
                          fontSize: 11, color: newTextSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),

                // Site Name
                if ((item.siteName ?? '').isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        size: 11, color: newTextHint),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(item.siteName ?? '',
                          style: const TextStyle(
                              fontSize: 11, color: newTextSecondary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ]),
                ],

                if (isWoOrPo && (item.subType ?? '').isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.storefront_outlined,
                        size: 11, color: newTextHint),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        item.subType ?? '',
                        style: const TextStyle(
                            fontSize: 11, color: newTextSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ],

                const SizedBox(height: 3),

                // Date + Last Remark
                Row(children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 11, color: newTextHint),
                  const SizedBox(width: 3),
                  Text(item.documentDate ?? '',
                      style: const TextStyle(fontSize: 10, color: newTextHint)),
                  if ((item.lastremark ?? '').isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text('· ${item.lastremark}',
                            style: const TextStyle(
                                fontSize: 10, color: newTextHint),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)),
                  ],
                ]),
              ])),
          const SizedBox(width: 8),
          // Amount + badge
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if ((item.totalamount ?? '').isNotEmpty)
              Text('₹${item.totalamount}',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: ctrl
                    .statusBadgeBg(item.status), // already in your controller
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.status ?? 'Pending',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: ctrl
                      .statusBadgeFg(item.status), // already in your controller
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
