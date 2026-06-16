import 'package:digitalerp/screen/ui/fab/menu_fab.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approvals_list_responce.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../approval_hub_controller/approval_hub_controller.dart';
import 'approval_hub_detail.dart';
import 'approval_hub_list.dart';

class ApprovalHubDashboard extends StatelessWidget {
  const ApprovalHubDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalHubController>(
      init: ApprovalHubController(),
      initState: (_) {
        if (!Get.isRegistered<ApprovalHubController>()) {
          Get.put(ApprovalHubController());
        }
      },
      builder: (ctrl) => Scaffold(
        backgroundColor: newSurfaceColor,
        body: Column(children: [
          _DashAppBar(ctrl: ctrl),
          Expanded(
            child: ctrl.isBusy && ctrl.allApprovals.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: newBlueColor))
                : RefreshIndicator(
                    color: newBlueColor,
                    onRefresh: ctrl.refreshDashboard,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StatsRow(ctrl: ctrl),
                            const SizedBox(height: 14),
                            if (_hasOverdue(ctrl)) _OverdueBanner(),
                            _SectionHead('By Category'),
                            const SizedBox(height: 10),
                            _CategoryGrid(ctrl: ctrl),
                            const SizedBox(height: 6),
                            _SectionHead('Recently Submitted'),
                            const SizedBox(height: 10),
                            _RecentList(ctrl: ctrl),
                            const SizedBox(height: 14),
                            //_ViewAllBtn(ctrl: ctrl),
                          ]),
                    ),
                  ),
          ),
        ]),
      //   floatingActionButton: MenuFab(parentMenuId: 2384),
      ),
    );
  }

  bool _hasOverdue(ApprovalHubController ctrl) =>
      ctrl.categories.any((c) => c.overdueCount > 0);
}

//  App bar
class _DashAppBar extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _DashAppBar({required this.ctrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 4,
        bottom: 14,
        left: 16,
        right: 16,
      ),
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
            child: const Icon(Icons.arrow_back_ios_new,
                size: 20, color: newTextPrimary),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
            child: Text('Approval Hub',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: newTextPrimary))),
        Stack(children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: newBlueLightColor,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: const Icon(Icons.notifications_outlined,
                size: 20, color: newBlueColor),
          ),
          if (ctrl.totalPending > 0)
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                      color: newRedColor, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Text(
                    ctrl.totalPending > 99 ? '99+' : '${ctrl.totalPending}',
                    style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                )),
        ]),
      ]),
    );
  }
}

//  Stats row
class _StatsRow extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _StatsRow({required this.ctrl});
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
            child: _StatTile('${ctrl.totalPending}', 'Pending', newRedColor,
                newRedLightColor)),
        const SizedBox(width: 10),
        Expanded(
            child: _StatTile('${ctrl.totalOnHold}', 'On Hold', newOrangeColor,
                newOrangeLightColor)),
        const SizedBox(width: 10),
        Expanded(
            child: _StatTile('${ctrl.totalThisMonth}', 'This Month',
                newGreenColor, newGreenLightColor)),
      ]);
}

class _StatTile extends StatelessWidget {
  final String num, label;
  final Color color, bg;
  const _StatTile(this.num, this.label, this.color, this.bg);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: newBorderColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(num,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: newTextPrimary,
              height: 1.4,
            )),
      ]),
    );
  }
}

//  Overdue banner
class _OverdueBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: newRedLightColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: newRedColor)),
        child: const Row(children: [
          Icon(Icons.warning_amber_rounded, size: 16, color: newRedColor),
          SizedBox(width: 8),
          Expanded(
              child: Text('3 approvals overdue by more than 48 hours',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF991B1B)))),
        ]),
      );
}

//  Section heading
class _SectionHead extends StatelessWidget {
  final String text;
  const _SectionHead(this.text);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(children: [
          Text(text,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: newTextSecondary,
                  letterSpacing: .4)),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, color: const Color(0xFFEEF1FF))),
        ]),
      );
}

//  Category grid
class _CategoryGrid extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _CategoryGrid({required this.ctrl});
  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
        children: ctrl.categories
            .map((cat) => _CatTile(
                  cat: cat,
                  onTap: () {
                    ctrl.selectCategory(cat.key);
                    Get.to(const ApprovalHubList());
                  },
                ))
            .toList(),
      );
}

class _CatTile extends StatelessWidget {
  final ApprovalCategory cat;
  final VoidCallback onTap;
  const _CatTile({required this.cat, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: newBorderColor),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: cat.lightColor,
                    borderRadius: BorderRadius.circular(9)),
                alignment: Alignment.center,
                child: Text(cat.emoji, style: const TextStyle(fontSize: 18)),
              ),
              Text('${cat.count}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: cat.color)),
            ]),
            const SizedBox(height: 8),
            Text(cat.label,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(
                cat.overdueCount > 0
                    ? '${cat.overdueCount} overdue'
                    : 'Tap to view',
                style: TextStyle(
                    fontSize: 10,
                    color:
                        cat.overdueCount > 0 ? newRedColor : newTextSecondary)),
          ]),
        ),
      );
}

//  Recent list
class _RecentList extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _RecentList({required this.ctrl});
  @override
  Widget build(BuildContext context) {
    final items = ctrl.allApprovals.take(4).toList();
    if (items.isEmpty)
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
            child: Text('No pending approvals',
                style: TextStyle(color: newTextSecondary))),
      );
    return Column(
        children:
            items.map((item) => _ApprovalRow(item: item, ctrl: ctrl)).toList());
  }
}

class _ApprovalRow extends StatelessWidget {
  final ApprovalListData item;
  final ApprovalHubController ctrl;
  const _ApprovalRow({required this.item, required this.ctrl});
  @override
  Widget build(BuildContext context) {
    final color = ctrl.catColor(item.documentname);
    final lightColor = ctrl.catLightColor(item.documentname);
    final emoji = ctrl.catEmoji(item.documentname);
    return GestureDetector(
      onTap: () async {
        await ctrl.openDetail(item);
        Get.to(const ApprovalHubDetail());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: newBorderColor)),
        child: Row(children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
                color: lightColor, borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('${item.documentname ?? ''} — ${item.documentno ?? ''}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: newTextPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Text(
                    '${item.partyname ?? item.clintname ?? ''} · ${item.documentDate ?? ''}',
                    style:
                        const TextStyle(fontSize: 10, color: newTextSecondary)),
              ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            if ((item.totalamount ?? '').isNotEmpty)
              Text('₹${item.totalamount}',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                  color: newOrangeLightColor,
                  borderRadius: BorderRadius.circular(20)),
              child: const Text('Pending',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: newOrangeColor)),
            ),
          ]),
        ]),
      ),
    );
  }
}

//  View all button
class _ViewAllBtn extends StatelessWidget {
  final ApprovalHubController ctrl;
  const _ViewAllBtn({required this.ctrl});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            ctrl.selectCategory('');
            Get.to(const ApprovalHubList());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: newBlueColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text('View all ${ctrl.totalPending} pending approvals →',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
        ),
      );
}
