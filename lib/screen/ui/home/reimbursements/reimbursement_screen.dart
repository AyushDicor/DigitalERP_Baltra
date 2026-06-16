import 'package:digitalerp/model/get_expense_list_new_response_model.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/Add/add_reimbursement_screen.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/controller/reimbursement_controller.dart';
import 'package:digitalerp/screen/ui/home/reimbursements/detail/reimbursement_detail_screen.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'filter/reimbursement_filter_sheet.dart';

//  Design tokens
const Color _kBg = Color(0xFFF5F6FA);
const Color _kCard = Colors.white;
const Color _kBlue = purpleColor;
const Color _kLabel = newTextPrimary;
const Color _kSub = newTextSecondary;
const Color _kBorder = Color(0xFFE8E8E8);

class ReimbursementListScreen extends StatefulWidget {
  const ReimbursementListScreen({Key? key}) : super(key: key);

  @override
  State<ReimbursementListScreen> createState() =>
      _ReimbursementListScreenState();
}

class _ReimbursementListScreenState extends State<ReimbursementListScreen> {
  late final ReimbursementController ctrl;
  ReimbursementFilter _activeFilter = const ReimbursementFilter();
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    ctrl = Get.isRegistered<ReimbursementController>()
        ? Get.find()
        : Get.put(ReimbursementController());

    // Set initial dates to last 30 days
    _from = DateTime.now().subtract(const Duration(days: 30));
    _to = DateTime.now();

    // Load data after frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() => ctrl.getExpenseListNew(
        fromDate: _from != null ? ctrl.formatDateForApi(_from!) : null,
        toDate: _to != null ? ctrl.formatDateForApi(_to!) : null,
      );

  void _resetFilters() {
    final defaultFrom = DateTime.now().subtract(const Duration(days: 30));
    final defaultTo = DateTime.now();

    setState(() {
      _activeFilter = const ReimbursementFilter();
      _from = defaultFrom;
      _to = defaultTo;
    });

    // Sync controller dates back to default
    ctrl.firstDate = ctrl.formatDateForApi(defaultFrom);
    ctrl.lastDate = ctrl.formatDateForApi(defaultTo);

    _load(); // reloads with default 30-day range
  }

  String _fmt(int n) => n > 999 ? "999+" : n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          _appBar(),
          // ✅ Fixed stat cards at top
          Obx(() {
            if (ctrl.isLoading.value && ctrl.expenseDataList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _skeletonSummaryGrid(),
              );
            }
            final all = ctrl.expenseDataList.toList();
            final list = _filterList(all);
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _summaryGrid(list),
            );
          }),
          // ✅ Scrollable content
          Expanded(
            child: Obx(() => _scrollableBody()),
          ),
        ],
      ),
      floatingActionButton: _addbtn(context),
    );
  }

  //  Filter helper
  List<ExpenseData> _filterList(List<ExpenseData> all) {
    return _activeFilter.apply(all, ctrl.parseExpenseDate);
  }

  //  FAB
  Widget _addbtn(BuildContext context) => FloatingActionButton(
        backgroundColor: _kBlue,
        shape:
            const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
        elevation: 4,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const AddNewReimbursementScreen()));
          _load();
        },
        child: const Icon(Icons.add, color: Colors.white),
      );

  //  App bar
  Widget _appBar() => Container(
        color: _kCard,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          bottom: 14,
          left: 16,
          right: 16,
        ),
        child: Row(children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon:
                const Icon(Icons.arrow_back_ios_new, color: _kLabel, size: 20),
          ),
          const SizedBox(width: 3),
          const Expanded(
            child: Text(
              "Reimbursement",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: newTextPrimary,
              ),
            ),
          ),
          // Refresh
          Obx(() => _iconBtn(
                onTap: ctrl.isLoading.value ? null : _load,
                child: ctrl.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(purpleColor)))
                    : const Icon(Icons.refresh, color: purpleColor, size: 20),
              )),
          const SizedBox(width: 8),
          // Filter
          _filterIconBtn(),
          const SizedBox(width: 12),
        ]),
      );

  Widget _iconBtn({required Widget child, VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: purpleLightest, borderRadius: BorderRadius.circular(18)),
          alignment: Alignment.center,
          child: child,
        ),
      );

  //  Scrollable Body
  Widget _scrollableBody() {
    final all = ctrl.expenseDataList.toList();
    final list = _filterList(all);

    if (ctrl.isLoading.value && list.isEmpty) {
      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Requests",
                style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w700, color: _kLabel)),
            const SizedBox(height: 12),
            ...List.generate(4, (_) => _skeletonCard()),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _load,
      color: purpleColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _filterChips(),
            if (ctrl.errorMessage.value.isNotEmpty) ...[
              _errorBanner(ctrl.errorMessage.value),
              const SizedBox(height: 12),
            ],
            Text("All Requests",
                style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w700, color: _kLabel)),
            const SizedBox(height: 12),
            list.isEmpty ? _emptyState() : _listView(list),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  //  Summary grid
  Widget _summaryGrid(List<ExpenseData> list) {
    int approved = 0, pending = 0, rejected = 0;
    for (final e in list) {
      final s = (e.approvalStatus ?? '').toLowerCase();
      if (s == 'approved' || s == 'approve') approved++;
      else if (s == 'rejected' || s == 'reject') rejected++;
      else pending++;
    }
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: [
        _statCard(_fmt(list.length), "Total Request", newBlueColor,
            newBlueLightColor),
        _statCard(
            _fmt(approved), "Approved", newGreenColor, newGreenLightColor),
        _statCard(
            _fmt(pending), "Pending", newOrangeColor, newOrangeLightColor),
        _statCard(_fmt(rejected), "Rejected", newRedColor, newRedLightColor),
      ],
    );
  }

  Widget _statCard(String val, String label, Color fg, Color bg) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: bg, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(val,
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800, color: fg)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary)),
          ),
        ]),
      );

  //  Filter chips
  Widget _filterChips() {
    if (!_activeFilter.isActive) return const SizedBox.shrink();

    final chips = <Widget>[];

    void addChip(String label, VoidCallback onDelete) {
      chips.add(Chip(
        label: Text(label,
            style: GoogleFonts.dmSans(fontSize: 12, color: purpleColor)),
        deleteIcon: const Icon(Icons.close, size: 14, color: purpleColor),
        onDeleted: onDelete,
        backgroundColor: purpleColor.withValues(alpha: 0.08),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ));
    }

    if (_activeFilter.fromDate != null || _activeFilter.toDate != null) {
      final from = _activeFilter.fromDate != null
          ? DateFormat('dd MMM yy').format(_activeFilter.fromDate!)
          : '...';
      final to = _activeFilter.toDate != null
          ? DateFormat('dd MMM yy').format(_activeFilter.toDate!)
          : '...';
      addChip('$from – $to', () {
        setState(() => _activeFilter = _activeFilter.copyWith(
              clearFromDate: true,
              clearToDate: true,
            ));
      });
    }

    if (_activeFilter.claimNumbers.isNotEmpty) {
      addChip(
        '${_activeFilter.claimNumbers.length} Claim(s)',
        () => setState(
            () => _activeFilter = _activeFilter.copyWith(claimNumbers: {})),
      );
    }

    if (_activeFilter.siteNames.isNotEmpty) {
      addChip(
        '${_activeFilter.siteNames.length} Site(s)',
        () => setState(
            () => _activeFilter = _activeFilter.copyWith(siteNames: {})),
      );
    }

    if (_activeFilter.reimburseTypes.isNotEmpty) {
      addChip(
        '${_activeFilter.reimburseTypes.length} Type(s)',
        () => setState(
            () => _activeFilter = _activeFilter.copyWith(reimburseTypes: {})),
      );
    }

    if (_activeFilter.statuses.isNotEmpty) {
      addChip(
        _activeFilter.statuses.join(', '),
        () => setState(
            () => _activeFilter = _activeFilter.copyWith(statuses: {})),
      );
    }

    if (_activeFilter.executives.isNotEmpty) {
      addChip(
        '${_activeFilter.executives.length} Executive(s)',
        () => setState(
            () => _activeFilter = _activeFilter.copyWith(executives: {})),
      );
    }

    if (_activeFilter.minAmount != null || _activeFilter.maxAmount != null) {
      final min = _activeFilter.minAmount != null
          ? '₹${_activeFilter.minAmount!.toStringAsFixed(0)}'
          : '₹0';
      final max = _activeFilter.maxAmount != null
          ? '₹${_activeFilter.maxAmount!.toStringAsFixed(0)}'
          : '∞';
      addChip('$min – $max', () {
        setState(() => _activeFilter = _activeFilter.copyWith(
              clearMinAmount: true,
              clearMaxAmount: true,
            ));
      });
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(spacing: 8, runSpacing: 6, children: chips),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  //  List
  Widget _listView(List<ExpenseData> list) => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) => _expenseCard(ctx, list[i]),
      );

  Widget _expenseCard(BuildContext context, ExpenseData item) {
    final rawStatus = (item.approvalStatus ?? '').trim();
    final status = rawStatus.isEmpty ? "Pending" : rawStatus;
    final bool isEditable = !['approved', 'approve'].contains(status)
        && (item.verifiedAmt == null || item.verifiedAmt == 0);

    Color statusBg, statusFg;
    switch (status.toLowerCase()) {
      case 'approved':
        statusBg = newGreenLightColor;
        statusFg = newGreenColor;
        break;
      case 'rejected':
        statusBg = newRedLightColor;
        statusFg = newRedColor;
        break;
      default:
        statusBg = newOrangeLightColor;
        statusFg = newOrangeColor;
    }

    bool hasValue(String? value) => value != null && value.trim().isNotEmpty;

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ReimbursementDetailScreen(listItem: item)),
        );
        _load();
      },
      child: Container(
        decoration: BoxDecoration(
          color: _kCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _kBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Claim No.: ${item.expenseNo ?? '—'}",
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _kLabel,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _actionIcon(Icons.description, Colors.green, () {
                    //  View Details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ReimbursementDetailScreen(listItem: item),
                      ),
                    ).then((_) => _load());
                  }),

                  // _actionIcon(Icons.picture_as_pdf, Colors.red, () {
                  //   //  Open Document
                  //   // item.expenseId used to construct the document URL
                  //   if (item.expenseId == null) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('No document available')),
                  //     );
                  //     return;
                  //   }
                  //   final url =
                  //       'http://supportapi.digitalerp.biz/ExpenseFiles/${item.expenseId}.pdf';
                  //   launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  // }),

                  if (isEditable)
                    _actionIcon(Icons.edit_outlined, Colors.blue, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReimbursementDetailScreen(
                            listItem: item,
                            openInEditMode: true,
                          ),
                        ),
                      ).then((_) => _load());
                    })
                  else
                    _actionIcon(Icons.edit_off_outlined, Colors.grey.shade400, null),

                  // _actionIcon(Icons.delete_outline, Colors.redAccent, () {
                  //   //  Delete with confirmation
                  //   showDialog(
                  //     context: context,
                  //     builder: (_) => AlertDialog(
                  //       title: const Text('Delete Reimbursement'),
                  //       content: Text(
                  //         'Are you sure you want to delete ${item.expenseNo ?? "this expense"}?',
                  //       ),
                  //       actions: [
                  //         TextButton(
                  //           onPressed: () => Navigator.pop(context),
                  //           child: const Text('Cancel'),
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.pop(context);
                  //             // Call delete — you'll need to add this method to controller
                  //             ctrl.deleteExpense(item.expenseId!).then((_) => _load());
                  //           },
                  //           style: TextButton.styleFrom(foregroundColor: Colors.red),
                  //           child: const Text('Delete'),
                  //         ),
                  //       ],
                  //     ),
                  //   );
                  // }),
                ],
              ),
            ),

            const Divider(height: 1, color: _kBorder),

            // Main Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Boxes
                  if (hasValue(item.site) || hasValue(item.employeeName))
                    Row(
                      children: [
                        if (hasValue(item.site))
                          Expanded(child: _infoBox("Site Name", item.site!)),
                        if (hasValue(item.site) && hasValue(item.employeeName))
                          const SizedBox(width: 12),
                        if (hasValue(item.employeeName))
                          Expanded(
                              child: _infoBox("Employee", item.employeeName!)),
                      ],
                    ),

                  if (hasValue(item.site) || hasValue(item.employeeName))
                    const SizedBox(height: 16),

                  // Date | Amount | Status
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _simpleInfo("Date", item.expenseDate ?? "—"),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _simpleInfo(
                          "Amount",
                          "₹${item.amount ?? 0}",
                          valueColor: _kBlue,
                          isBold: true,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: statusFg,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Description
                  if (hasValue(item.expenseDescription)) ...[
                    const SizedBox(height: 16),
                    Text("Description",
                        style: GoogleFonts.dmSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _kSub)),
                    const SizedBox(height: 6),
                    Text(
                      item.expenseDescription!,
                      style: GoogleFonts.dmSans(
                          fontSize: 14, height: 1.45, color: _kLabel),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed, // null = no-op automatically
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          icon,
          color: onPressed == null ? Colors.grey.shade300 : color, // ✅ greyed out
          size: 20,
        ),
      ),
    );
  }

  //  Empty / error
  Widget _emptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: Column(children: [
            Icon(Icons.receipt_long_outlined,
                size: 56, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text("No reimbursements found",
                style: GoogleFonts.dmSans(
                    fontSize: 14, color: Colors.grey.shade500)),
            const SizedBox(height: 6),
            Text("Tap + to add one or adjust filters",
                style: GoogleFonts.dmSans(
                    fontSize: 12, color: Colors.grey.shade400)),
          ]),
        ),
      );

  Widget _errorBanner(String msg) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Row(children: [
          Icon(Icons.error_outline, color: Colors.red.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(msg,
                style: GoogleFonts.dmSans(
                    color: Colors.red.shade700, fontSize: 13)),
          ),
          GestureDetector(
            onTap: _load,
            child: Text("Retry",
                style: GoogleFonts.dmSans(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
          ),
        ]),
      );

  //  Date filter bottom sheet
  void _showFilterSheet() {
    // Pre-fill dates from _from/_to which are always set to 30-day default
    final prefilledFilter = _activeFilter.copyWith(
      fromDate: _activeFilter.fromDate ?? _from,
      toDate: _activeFilter.toDate ?? _to,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReimbursementFilterSheet(
        allItems: ctrl.expenseDataList.toList(),
        activeFilter: prefilledFilter, // ← pre-filled dates
        onApply: (filter) {
          setState(() {
            _activeFilter = filter;
            if (filter.fromDate != null) _from = filter.fromDate;
            if (filter.toDate != null) _to = filter.toDate;
          });
          if (filter.fromDate != null || filter.toDate != null) {
            ctrl.firstDate = ctrl.formatDateForApi(filter.fromDate ??
                DateTime.now().subtract(const Duration(days: 30)));
            ctrl.lastDate =
                ctrl.formatDateForApi(filter.toDate ?? DateTime.now());
            _load();
          }
        },
        onReset: () {
          final defaultFrom = DateTime.now().subtract(const Duration(days: 30));
          final defaultTo = DateTime.now();
          setState(() {
            _activeFilter = const ReimbursementFilter();
            _from = defaultFrom;
            _to = defaultTo;
          });
          ctrl.firstDate = ctrl.formatDateForApi(defaultFrom);
          ctrl.lastDate = ctrl.formatDateForApi(defaultTo);
          _load();
        },
      ),
    );
  }

  Widget _datePicker({required String label, required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
              color: purpleLightest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kBorder)),
          child: Row(children: [
            const Icon(Icons.calendar_today_outlined, size: 15, color: _kBlue),
            const SizedBox(width: 6),
            Expanded(
                child: Text(label,
                    style: GoogleFonts.dmSans(fontSize: 13, color: _kLabel))),
          ]),
        ),
      );

  Widget _infoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _simpleInfo(String title, String value,
      {Color? valueColor, bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.dmSans(fontSize: 12, color: _kSub)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? _kLabel,
          ),
        ),
      ],
    );
  }

  Widget _filterIconBtn() {
    return _iconBtn(
      onTap: _showFilterSheet,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          const Icon(Icons.filter_list_sharp, color: purpleColor, size: 20),
          if (_activeFilter.isActive)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}

//  Skeleton Shimmer Widget
class _ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double radius;
  const _ShimmerBox(
      {required this.width, required this.height, this.radius = 8});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat();
    _anim = Tween<double>(begin: -1.5, end: 1.5)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end: Alignment(_anim.value + 1, 0),
            colors: const [
              Color(0xFFE8E8E8),
              Color(0xFFF4F4F4),
              Color(0xFFE8E8E8),
            ],
          ),
        ),
      ),
    );
  }
}

//  Skeleton Card
Widget _skeletonCard() => Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(children: [
            _ShimmerBox(width: 160, height: 16, radius: 6),
            const Spacer(),
            _ShimmerBox(width: 20, height: 20, radius: 4),
            const SizedBox(width: 8),
            _ShimmerBox(width: 20, height: 20, radius: 4),
            const SizedBox(width: 8),
            _ShimmerBox(width: 20, height: 20, radius: 4),
          ]),
          const SizedBox(height: 12),
          const Divider(height: 1, color: _kBorder),
          const SizedBox(height: 16),
          // Info boxes
          Row(children: [
            Expanded(
                child: _ShimmerBox(
                    width: double.infinity, height: 56, radius: 12)),
            const SizedBox(width: 12),
            Expanded(
                child: _ShimmerBox(
                    width: double.infinity, height: 56, radius: 12)),
          ]),
          const SizedBox(height: 16),
          // Date / amount / status row
          Row(children: [
            _ShimmerBox(width: 80, height: 14, radius: 6),
            const SizedBox(width: 20),
            _ShimmerBox(width: 60, height: 14, radius: 6),
            const Spacer(),
            _ShimmerBox(width: 72, height: 28, radius: 20),
          ]),
          const SizedBox(height: 16),
          _ShimmerBox(width: double.infinity, height: 12, radius: 6),
          const SizedBox(height: 6),
          _ShimmerBox(width: 180, height: 12, radius: 6),
        ],
      ),
    );

//  Skeleton Summary Grid
Widget _skeletonSummaryGrid() => GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: List.generate(
        4,
        (_) => Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(children: [
            _ShimmerBox(width: 44, height: 44, radius: 10),
            const SizedBox(width: 10),
            _ShimmerBox(width: 70, height: 14, radius: 6),
          ]),
        ),
      ),
    );
