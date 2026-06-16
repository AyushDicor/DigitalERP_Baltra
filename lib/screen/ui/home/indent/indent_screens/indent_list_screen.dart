import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../utils/app_constant_new.dart';
import '../indent_controller/indent_controller.dart';
import '../indent_controller/indent_list_controller.dart';
import '../indent_entry_view.dart';
import '../indent_filter/indent_filter_sheet.dart';
import '../indent_response/indent_model.dart';
import '../indent_widgets.dart';

class IndentListScreen extends StatelessWidget {
  const IndentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndentListController>(
      id: 'indentList',
      builder: (ctrl) => Scaffold(
        backgroundColor: indSurfaceColor,
        appBar: _buildAppBar(ctrl),
        body: _buildBody(ctrl),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  // ── App bar ───────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(IndentListController ctrl) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: indTextPrimary),
        onPressed: () => Get.back(),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Indent',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: indTextPrimary)),
          Text('Material Requisition',
              style: TextStyle(fontSize: 11, color: indTextSecondary)),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
          child: TextField(
            onChanged: ctrl.onSearch,
            decoration: InputDecoration(
              hintText: 'Search by indent no, site, dept…',
              hintStyle: const TextStyle(fontSize: 13, color: indTextHint),
              prefixIcon:
              const Icon(Icons.search, size: 18, color: indTextSecondary),
              filled: true,
              fillColor: indSurfaceColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: indBorderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: indBorderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                  const BorderSide(color: indBlueColor, width: 1.5)),
            ),
          ),
        ),
      ),
      actions: [
        _FilterButton(ctrl: ctrl),
        const SizedBox(width: 6),
      ],
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────
  Widget _buildBody(IndentListController ctrl) {
    if (ctrl.isLoadingList) {
      return const Center(
          child: CircularProgressIndicator(color: indBlueColor));
    }

    if (ctrl.filteredItems.isEmpty) {
      return RefreshIndicator(
        onRefresh: ctrl.refresh,
        color: indBlueColor,
        child: ListView(
          children: [
            SizedBox(
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_outlined,
                        size: 60, color: indBorderColor),
                    const SizedBox(height: 16),
                    const Text('No indents found',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: indTextSecondary)),
                    const SizedBox(height: 6),
                    const Text('Tap + to create a new indent',
                        style:
                        TextStyle(fontSize: 12, color: indTextSecondary)),
                  ]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: ctrl.refresh,
      color: indBlueColor,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 90),
        itemCount: ctrl.filteredItems.length,
        itemBuilder: (_, i) => _IndentCard(item: ctrl.filteredItems[i]),
      ),
    );
  }

  // FAB
  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => const IndentEntryView());
      },
      shape:
      const CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
      backgroundColor: purpleColor,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IndentListController ctrl;
  const _FilterButton({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final count = ctrl.activeFilter.activeCount;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: Icon(
            Icons.filter_list_rounded,
            color: indBlueColor,
            size: 20,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => IndentFilterSheet(
                items: ctrl.indentItems,
                activeFilter: ctrl.activeFilter,
                onApply: ctrl.applyFilter,
                onReset: ctrl.resetFilter,
              ),
            );
          },
        ),
        if (count > 0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: purpleLightest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  '$count',
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Single indent card ────────────────────────────────────────────────────────
class _IndentCard extends StatelessWidget {
  final IndentListItem item;
  const _IndentCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
            () => const IndentEntryView(),
        arguments: item,
        // ← NO binding here
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: indBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top row: indent no + approval status ──────────────────
            Row(children: [
              Expanded(
                child: Text(item.indentNo,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: indBlueColor)),
              ),
              if (item.approvalStatus.isNotEmpty)
                _approvalBadge(item.approvalStatus),
              const SizedBox(width: 6),
              StatusBadge(item.status),
            ]),
            const SizedBox(height: 4),

            // ── Order No ───────────────────────────────────────────────
            if (item.orderNo.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(children: [
                  const Icon(Icons.receipt_outlined,
                      size: 11, color: indTextSecondary),
                  const SizedBox(width: 4),
                  Text(item.orderNo,
                      style: const TextStyle(
                          fontSize: 11, color: indTextSecondary)),
                ]),
              ),

            // ── Date + requested by ────────────────────────────────────
            Row(children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 12, color: indTextSecondary),
              const SizedBox(width: 4),
              Text(_formatDate(item.indentDate),
                  style:
                  const TextStyle(fontSize: 11, color: indTextSecondary)),
              if (item.dueDate.isNotEmpty &&
                  item.dueDate != item.indentDate) ...[
                const SizedBox(width: 8),
                const Icon(Icons.event_available_outlined,
                    size: 12, color: indTextSecondary),
                const SizedBox(width: 4),
                Text(_formatDate(item.dueDate),
                    style:
                    const TextStyle(fontSize: 11, color: indTextSecondary)),
              ],
              const SizedBox(width: 12),
              const Icon(Icons.person_outline_rounded,
                  size: 12, color: indTextSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(item.requestBy,
                    style:
                    const TextStyle(fontSize: 11, color: indTextSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
            const SizedBox(height: 8),
            const Divider(height: 1, color: indBorderColor),
            const SizedBox(height: 8),

            // ── Info chips ─────────────────────────────────────────────
            Wrap(spacing: 6, runSpacing: 6, children: [
              if (item.siteName.isNotEmpty)
                _chip(Icons.location_on_outlined, item.siteName),
              if (item.jobType.isNotEmpty)
                _chip(Icons.work_outline_rounded, item.jobType),
              if (item.priority.isNotEmpty) PriorityBadge(item.priority),
            ]),

            // ── Qty summary row ────────────────────────────────────────
            const SizedBox(height: 8),
            const Divider(height: 1, color: indBorderColor),
            const SizedBox(height: 8),
            Row(children: [
              _qtyCell('Indent', item.totalItems.toDouble()),
              _qtyDivider(),
              _qtyCell('Approved', item.approveQty),
              _qtyDivider(),
              _qtyCell('PO', item.poQty),
              _qtyDivider(),
              _qtyCell('Balance', item.balQty, highlight: item.balQty > 0),
              const Spacer(),
              // Print button
              if (item.printUrl.isNotEmpty)
                GestureDetector(
                  onTap: () => _openPrint(item.printUrl),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: indBlueLightColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: indBlueColor.withValues(alpha: 0.3)),
                    ),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.print_outlined, size: 12, color: indBlueColor),
                      SizedBox(width: 4),
                      Text('Print',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: indBlueColor)),
                    ]),
                  ),
                ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _qtyCell(String label, double value, {bool highlight = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 9, color: indTextSecondary)),
      Text(value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: highlight ? indGreenColor : indTextPrimary)),
    ]);
  }

  Widget _qtyDivider() => Container(
    height: 28,
    width: 1,
    margin: const EdgeInsets.symmetric(horizontal: 10),
    color: indBorderColor,
  );

  Widget _approvalBadge(String status) {
    final isPending = status.toLowerCase() == 'pending';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: isPending
            ? Colors.orange.withValues(alpha: 0.1)
            : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isPending
                ? Colors.orange.withValues(alpha: 0.4)
                : Colors.green.withValues(alpha: 0.4)),
      ),
      child: Text(status,
          style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color:
              isPending ? Colors.orange.shade700 : Colors.green.shade700)),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: indSurfaceColor,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: indBorderColor),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 11, color: indTextSecondary),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: indTextSecondary)),
      ]),
    );
  }

  void _openPrint(String url) {
    // uses url_launcher — already in your pubspec
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  String _formatDate(String raw) {
    try {
      DateTime? dt = DateTime.tryParse(raw);
      dt ??= DateFormat('dd-MM-yyyy').tryParseStrict(raw);
      if (dt != null) return DateFormat('dd MMM yyyy').format(dt);
    } catch (_) {}
    return raw;
  }
}
