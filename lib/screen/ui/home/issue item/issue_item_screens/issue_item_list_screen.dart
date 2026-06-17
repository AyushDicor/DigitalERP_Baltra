import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../utils/app_constant_new.dart';
import '../../../../../utils/show_message.dart';
import '../../indent/indent_widgets.dart';
import '../issue_item_contoller/issue_item_list_controller.dart';
import '../issue_item_entry_view.dart';
import '../issue_item_filter/issue_item_filter_sheet.dart';
import '../issue_item_response/issue_item_model.dart';



class IssueItemListScreen extends StatelessWidget {
  const IssueItemListScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<IssueItemListController>(
      init: IssueItemListController(),
      builder: (ctrl) => Scaffold(
        backgroundColor: newSurfaceColor,
        appBar: _buildAppBar(ctrl, context),
        body: _buildBody(ctrl),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(
      IssueItemListController ctrl, BuildContext ctx) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: newTextPrimary),
        onPressed: () => Get.back(),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Issue Items',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          Text('Stock Issue',
              style: TextStyle(fontSize: 11, color: newTextSecondary)),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.filter_list_rounded,
            color: indBlueColor,
            size: 20,
          ),
          onPressed: () => showModalBottomSheet(
            context: ctx,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => IssueItemFilterSheet(
              items: ctrl.issueItems,
              activeFilter: ctrl.activeFilter,
              onApply: ctrl.applyFilter,
              onReset: ctrl.resetFilter,
            ),
          ),
        ),
        // ── Date range picker ──────────────────────────────────────────
        // Padding(
        //   padding: const EdgeInsets.only(right: 8),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       _DateChip(
        //         label: ctrl.fromDateCtrl.text,
        //         onTap: () => ctrl.pickFromDate(ctx),
        //       ),
        //       const Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 4),
        //         child: Text('–',
        //             style: TextStyle(color: newTextSecondary, fontSize: 13)),
        //       ),
        //       _DateChip(
        //         label: ctrl.toDateCtrl.text,
        //         onTap: () => ctrl.pickToDate(ctx),
        //       ),
        //       const SizedBox(width: 4),
        //       _SearchButton(onTap: ctrl.fetchIssueItemList),
        //     ],
        //   ),
        // ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
          child: TextField(
            onChanged: ctrl.onSearch,
            decoration: InputDecoration(
              hintText: 'Search by issue no, issue to, godown…',
              hintStyle:
              const TextStyle(fontSize: 13, color: newTextHint),
              prefixIcon:
              const Icon(Icons.search, size: 18, color: newTextSecondary),
              filled: true,
              fillColor: newSurfaceColor,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: newBorderColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: newBorderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                  const BorderSide(color: purpleColor, width: 1.5)),
            ),
          ),
        ),
      ),
    );
  }

  // ── Body ──────────────────────────────────────────────────────────────────
  Widget _buildBody(IssueItemListController ctrl) {
    if (ctrl.isLoadingList) {
      return const Center(
          child: CircularProgressIndicator(color: purpleColor));
    }

    if (ctrl.filteredItems.isEmpty) {
      return RefreshIndicator(
        onRefresh: ctrl.onRefresh,
        color: purpleColor,
        child: ListView(children: [
          SizedBox(
            height: 400,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.outbox_outlined, size: 60, color: newBorderColor),
                  const SizedBox(height: 16),
                  const Text('No issue entries found',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: newTextSecondary)),
                  const SizedBox(height: 6),
                  const Text('Tap + to create a new issue',
                      style: TextStyle(
                          fontSize: 12, color: newTextSecondary)),
                ]),
          ),
        ]),
      );
    }

    return RefreshIndicator(
      onRefresh: ctrl.onRefresh,
      color: purpleColor,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 90),
        itemCount: ctrl.filteredItems.length,
        itemBuilder: (_, i) =>
            _IssueItemCard(item: ctrl.filteredItems[i]),
      ),
    );
  }

  // ── FAB ───────────────────────────────────────────────────────────────────
  Widget _buildFab() {
    return FloatingActionButton(
      onPressed: () {
         Get.to(() => const IssueItemEntryView());
      },
      shape: const CircleBorder(
          side: BorderSide(color: Colors.white, width: 2)),
      backgroundColor: purpleColor,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}

// ── Card ──────────────────────────────────────────────────────────────────────
class _IssueItemCard extends StatelessWidget {
  final IssueItemListItem item;
  const _IssueItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Get.to(() => const IssueItemEntryView(), arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
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
            // ── Top row: issue no + type ─────────────────────────────
            Row(children: [
              Expanded(
                child: Text(item.issueNo,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: purpleColor)),
              ),
              _TypeBadge(item.issueType),
            ]),
            const SizedBox(height: 6),

            // ── Date + issued by ─────────────────────────────────────
            Row(children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 12, color: newTextSecondary),
              const SizedBox(width: 4),
              Text(_fmt(item.issueDate),
                  style:
                  const TextStyle(fontSize: 11, color: newTextSecondary)),
              const SizedBox(width: 12),
              const Icon(Icons.person_outline_rounded,
                  size: 12, color: newTextSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(item.issuedBy,
                    style:
                    const TextStyle(fontSize: 11, color: newTextSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
            const SizedBox(height: 8),
            const Divider(height: 1, color: newBorderColor),
            const SizedBox(height: 8),

            // ── Chips row ────────────────────────────────────────────
            Wrap(spacing: 6, runSpacing: 6, children: [
              if (item.issueTo.isNotEmpty)
                _chip(Icons.arrow_forward_outlined, item.issueTo),
              if (item.godown.isNotEmpty)
                _chip(Icons.warehouse_outlined, item.godown),
              if (item.itemIssueType.isNotEmpty)
                _chip(Icons.category_outlined, item.itemIssueType),
            ]),
            const SizedBox(height: 8),

            // ── Totals row ───────────────────────────────────────────
            // ── Totals row ───────────────────────────────────────────
            Row(children: [
              _statCell('Qty', item.totalQty.toStringAsFixed(2)),
              const SizedBox(width: 16),
              _statCell('Amount', '₹${_fmt2(item.totalAmount)}'),
              const SizedBox(width: 16),
              _statCell('Grand Total', '₹${_fmt2(item.grandTotal)}'),
              const Spacer(),
              if (item.printUrl.isNotEmpty)
                GestureDetector(
                  onTap: () => _openUrl(item.printUrl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: purpleColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: purpleColor.withValues(alpha: 0.2)),
                    ),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.print_outlined, size: 12, color: purpleColor),
                      SizedBox(width: 4),
                      Text('Print',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: purpleColor)),
                    ]),
                  ),
                ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded, size: 18, color: newTextSecondary),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: newSurfaceColor,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: newBorderColor),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: newTextSecondary),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: newTextSecondary)),
    ]),
  );

  Widget _statCell(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: const TextStyle(fontSize: 9, color: newTextSecondary)),
      Text(value,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: newTextPrimary)),
    ],
  );

  String _fmt(String raw) {
    try {
      DateTime? dt = DateTime.tryParse(raw);
      dt ??= DateFormat('dd/MM/yyyy').tryParseStrict(raw);  // ← add this
      dt ??= DateFormat('dd-MM-yyyy').tryParseStrict(raw);
      if (dt != null) return DateFormat('dd MMM yyyy').format(dt);
    } catch (_) {}
    return raw;
  }

  String _fmt2(double v) =>
      NumberFormat('#,##,##0.00', 'en_IN').format(v);

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

// ── Type badge ────────────────────────────────────────────────────────────────
class _TypeBadge extends StatelessWidget {
  final String type;
  const _TypeBadge(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: purpleColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(type,
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: purpleColor)),
    );
  }
}

// ── Date chip ─────────────────────────────────────────────────────────────────
class _DateChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DateChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: newSurfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: newBorderColor),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 11, color: newTextPrimary)),
      ),
    );
  }
}

// ── Search/Go button ──────────────────────────────────────────────────────────
class _SearchButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SearchButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.search_rounded,
            size: 16, color: Colors.white),
      ),
    );
  }
}