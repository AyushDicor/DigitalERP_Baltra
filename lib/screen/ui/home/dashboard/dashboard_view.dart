// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:digitalerp/screen/ui/home/dashboard/dashboard_controller.dart';
// //import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/my_app_bar_new.dart';
// import 'package:digitalerp/utils/app_profile_image.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../utils/app_constant_new.dart';
//
// class DashboardView extends StatelessWidget {
//   const DashboardView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<DashboardController>(
//       init: DashboardController(),
//       builder: (controller) => Scaffold(
//         backgroundColor: newSurfaceColor,
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               // App bar
//               _dashAppBar(controller, context),
//               // Scrollable body
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _profileCard(controller),
//                       const SizedBox(height: 20),
//                       _statsRow(controller),
//                       const SizedBox(height: 24),
//                       _sectionTitle('Revenue'),
//                       const SizedBox(height: 12),
//                       _revenueChart(controller),
//                       const SizedBox(height: 24),
//                       _sectionTitle('Users Visits'),
//                       const SizedBox(height: 12),
//                       _visitsChart(controller),
//                       const SizedBox(height: 24),
//                       _sectionTitle('Recent Orders'),
//                       const SizedBox(height: 12),
//                       _recentOrdersTable(),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //  App bar 
//   Widget _dashAppBar(DashboardController controller, BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () => controller.openDrawer(context),
//             child: Container(
//               width: 40,
//               height: 40,
//               alignment: Alignment.center,
//               child: const Icon(Icons.menu_rounded,
//                   size: 24, color: newTextPrimary),
//             ),
//           ),
//           const SizedBox(width: 8),
//           const Expanded(
//             child: Text('Dashboard',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: newTextPrimary)),
//           ),
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//                 color: newBlueLightColor,
//                 borderRadius: BorderRadius.circular(10)),
//             alignment: Alignment.center,
//             child: const Icon(Icons.notifications_outlined,
//                 size: 22, color: newBlueColor),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //  Profile card 
//   Widget _profileCard(DashboardController controller) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF4361EE), Color(0xFF738EFF)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           ProfileImageView(
//             size: 52,
//             imageUrl: controller.homeController.currentUserData?.photo ?? '',
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   controller.homeController.currentUserData?.name ?? 'User',
//                   style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   controller.homeController.currentUserData?.usertype ?? '',
//                   style: const TextStyle(fontSize: 13, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //  Stats row 
//   Widget _statsRow(DashboardController controller) {
//     return Row(
//       children: [
//         Expanded(
//             child: _statCard(
//                 'TOTAL ORDERS',
//                 '1200',
//                 Icons.shopping_bag_outlined,
//                 newBlueColor,
//                 newBlueLightColor,
//                 '+5.2%',
//                 true)),
//         const SizedBox(width: 12),
//         Expanded(
//             child: _statCard(
//                 'PENDING VISITS',
//                 '15',
//                 Icons.person_pin_circle_outlined,
//                 newOrangeColor,
//                 newOrangeLightColor,
//                 '',
//                 false)),
//         const SizedBox(width: 12),
//         Expanded(
//             child: _statCard(
//                 'PAYMENT DUE',
//                 '₹1.2L',
//                 Icons.account_balance_wallet_outlined,
//                 newRedColor,
//                 newRedLightColor,
//                 '',
//                 false)),
//       ],
//     );
//   }
//
//   Widget _statCard(String label, String value, IconData icon, Color color,
//       Color bgColor, String badge, bool showBadge) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 36,
//                 height: 36,
//                 decoration: BoxDecoration(
//                     color: bgColor, borderRadius: BorderRadius.circular(8)),
//                 child: Icon(icon, size: 18, color: color),
//               ),
//               if (showBadge && badge.isNotEmpty) ...[
//                 const Spacer(),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                   decoration: BoxDecoration(
//                       color: newGreenLightColor,
//                       borderRadius: BorderRadius.circular(6)),
//                   child: Text(badge,
//                       style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: newGreenColor)),
//                 ),
//               ],
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w800,
//                   color: newTextPrimary)),
//           const SizedBox(height: 2),
//           Text(label,
//               style: const TextStyle(
//                   fontSize: 9,
//                   fontWeight: FontWeight.w600,
//                   color: newTextSecondary),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis),
//         ],
//       ),
//     );
//   }
//
//   //  Section title 
//   Widget _sectionTitle(String title) {
//     return Text(title,
//         style: const TextStyle(
//             fontSize: 16, fontWeight: FontWeight.w800, color: newTextPrimary));
//   }
//
//   //  Revenue line chart 
//   Widget _revenueChart(DashboardController controller) {
//     final spots = [
//       const FlSpot(0, 20),
//       const FlSpot(1, 30),
//       const FlSpot(2, 35),
//       const FlSpot(3, 28),
//       const FlSpot(4, 50),
//       const FlSpot(5, 18),
//       const FlSpot(6, 25),
//     ];
//     final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('₹11,642',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w800,
//                           color: newTextPrimary)),
//                   const SizedBox(height: 2),
//                   Row(children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                           color: newGreenLightColor,
//                           borderRadius: BorderRadius.circular(6)),
//                       child: const Text('+4%',
//                           style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700,
//                               color: newGreenColor)),
//                     ),
//                     const SizedBox(width: 6),
//                     const Text('from last period',
//                         style:
//                             TextStyle(fontSize: 11, color: newTextSecondary)),
//                   ]),
//                 ],
//               ),
//               Row(
//                   children: ['Day', 'Week', 'Month', 'Year']
//                       .map((t) => _periodTab(t, t == 'Week'))
//                       .toList()),
//
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 140,
//             child: LineChart(
//               LineChartData(
//                 minY: 0,
//                 maxY: 100,
//                 gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (_) => FlLine(
//                         color: newBorderColor.withValues(alpha: 0.5),
//                         strokeWidth: 1)),
//                 borderData: FlBorderData(show: false),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                           showTitles: true,
//                           interval: 50,
//                           getTitlesWidget: (v, _) => Text('₹${v.toInt()}k',
//                               style: const TextStyle(
//                                   fontSize: 9, color: newTextSecondary)),
//                           reservedSize: 36)),
//                   bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: (v, _) {
//                             if (v.toInt() >= 0 && v.toInt() < days.length) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(days[v.toInt()],
//                                     style: TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: v.toInt() == 4
//                                             ? FontWeight.w700
//                                             : FontWeight.normal,
//                                         color: v.toInt() == 4
//                                             ? newBlueColor
//                                             : newTextSecondary)),
//                               );
//                             }
//                             return const SizedBox();
//                           },
//                           reservedSize: 22)),
//                   rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: spots,
//                     isCurved: true,
//                     color: newBlueColor,
//                     barWidth: 2.5,
//                     dotData: FlDotData(
//                         show: true,
//                         checkToShowDot: (spot, _) => spot.x == 4,
//                         getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
//                             radius: 5,
//                             color: Colors.white,
//                             strokeColor: newBlueColor,
//                             strokeWidth: 2)),
//                     belowBarData: BarAreaData(
//                       show: true,
//                       gradient: LinearGradient(
//                           colors: [
//                             newBlueColor.withValues(alpha: 0.15),
//                             newBlueColor.withValues(alpha: 0.0)
//                           ],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _periodTab(String label, bool isActive) {
//     return GestureDetector(
//       child: Container(
//         margin: const EdgeInsets.only(left: 4),
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//         decoration: BoxDecoration(
//           color: isActive ? newBlueColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Text(label,
//             style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w600,
//                 color: isActive ? Colors.white : newTextSecondary)),
//       ),
//     );
//   }
//
//   //  Visits bar chart 
//   Widget _visitsChart(DashboardController controller) {
//     final vals = [1000.0, 3000, 10000, 1000, 10000, 700, 1500];
//     final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
//
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                   decoration: BoxDecoration(
//                       color: newGreenLightColor,
//                       borderRadius: BorderRadius.circular(6)),
//                   child: const Text('+3.4%',
//                       style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w700,
//                           color: newGreenColor)),
//                 ),
//                 const SizedBox(width: 6),
//                 const Text('from last period',
//                     style: TextStyle(fontSize: 11, color: newTextSecondary)),
//               ]),
//               Row(
//                   children: ['D', 'W', 'M', 'Y']
//                       .map((t) => _periodTab(t, t == 'W'))
//                       .toList()),
//             ],
//           ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 140,
//             child: BarChart(
//               BarChartData(
//                 maxY: 12000,
//                 minY: 0,
//                 gridData: FlGridData(
//                     show: true,
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (_) => FlLine(
//                         color: newBorderColor.withValues(alpha: 0.5),
//                         strokeWidth: 1)),
//                 borderData: FlBorderData(show: false),
//                 titlesData: FlTitlesData(
//                   leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                           showTitles: true,
//                           interval: 4000,
//                           getTitlesWidget: (v, _) => Text(v.toInt().toString(),
//                               style: const TextStyle(
//                                   fontSize: 9, color: newTextSecondary)),
//                           reservedSize: 38)),
//                   bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                           showTitles: true,
//                           getTitlesWidget: (v, _) {
//                             if (v.toInt() >= 0 && v.toInt() < days.length) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 4),
//                                 child: Text(days[v.toInt()],
//                                     style: const TextStyle(
//                                         fontSize: 11, color: newTextSecondary)),
//                               );
//                             }
//                             return const SizedBox();
//                           },
//                           reservedSize: 20)),
//                   rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                   topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 barGroups: List.generate(
//                     vals.length,
//                     (i) => BarChartGroupData(
//                           x: i,
//                           barRods: [
//                             BarChartRodData(
//                               toY: vals[i].toDouble(), // ✅ width: 16,
//                               color: newBlueColor,
//                               borderRadius: const BorderRadius.vertical(
//                                   top: Radius.circular(4)),
//                             )
//                           ],
//                         )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   //  Recent orders table 
//   Widget _recentOrdersTable() {
//     const headers = ['ID', 'Item', 'Qty', 'Date'];
//     const rows = [
//       ['I293DSA39', 'iPhone 13', '4', 'Jan'],
//       ['U2349SD12', 'Xiaomi Redmi Note 10', '1', 'Jan'],
//       ['F2349SU38', 'Macbook Air 2019', '2', 'Jan'],
//       ['U2349SD12', 'iPhone 13', '2', 'Jan'],
//     ];
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2))
//         ],
//       ),
//       child: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: const BoxDecoration(
//               color: newSurfaceColor,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             child: Row(
//               children: headers
//                   .map((h) => Expanded(
//                         child: Text(h,
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w700,
//                                 color: newTextSecondary)),
//                       ))
//                   .toList(),
//             ),
//           ),
//           // Rows
//           ...rows.map((r) => Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 decoration: const BoxDecoration(
//                   border: Border(
//                       top: BorderSide(color: newBorderColor, width: 0.5)),
//                 ),
//                 child: Row(
//                   children: r
//                       .map((cell) => Expanded(
//                             child: Text(cell,
//                                 style: const TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w500,
//                                     color: newTextPrimary),
//                                 overflow: TextOverflow.ellipsis),
//                           ))
//                       .toList(),
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }

import 'package:digitalerp/screen/ui/home/approval_management/approval_hub_screens/approval_hub_dashboard.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_controller.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:digitalerp/app_routes/app_routes.dart';
import 'package:digitalerp/utils/app_assets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../homeview_new_controller.dart';
import '../../../../utils/app_constant_new.dart';
import '../approval/approval_list/approval_list_Screen.dart';
import '../attendance/attendance_controller.dart';
import '../home_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => Scaffold(
        backgroundColor: newSurfaceColor,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _dashAppBar(controller, context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _profileCard(controller),
                      const SizedBox(height: 20),
                      // BALTRA: live overview stats from Orders + Visits list APIs.
                      _baltraStatsRow(controller),
                      const SizedBox(height: 24),
                      // BALTRA: static dashboard (no dashboard API) — only Order, Visit, MIS.
                      _sectionTitle('Quick Access'),
                      const SizedBox(height: 12),
                      _moduleList(),

                      // Original API-driven sections (stats / revenue / visits /
                      // attendance) hidden for Baltra — no dashboard API.
                      // Un-comment to restore.
                      /*
                      _statsRow(controller),
                      const SizedBox(height: 24),
                      _sectionTitle('Revenue'),
                      const SizedBox(height: 12),
                      _revenueChart(controller),
                      const SizedBox(height: 24),
                      _sectionTitle('Users Visits'),
                      const SizedBox(height: 12),
                      _visitsChart(controller),
                      const SizedBox(height: 24),
                      _sectionTitle('Attendance'),
                      const SizedBox(height: 12),
                      _attendanceTable(
                        Get.isRegistered<AttendanceController>()
                            ? Get.find<AttendanceController>()
                            : Get.put(AttendanceController()),
                      ),
                      const SizedBox(height: 20),
                      */
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  App bar 
  Widget _dashAppBar(DashboardController controller, BuildContext context) {
    final hasApproval = Get.isRegistered<HomeViewNewController>()
        ? Get.find<HomeViewNewController>().menuListData.any((m) => m.menuid == 2384)
        : false;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.openDrawer(context),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(Icons.menu_rounded, size: 24, color: newTextPrimary),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Dashboard',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: newTextPrimary)),
          ),
          if (hasApproval)
            GestureDetector(
              onTap: () => Get.to(() => const ApprovalHubDashboard()),
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: newBlueLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.approval_outlined,
                    size: 20,
                    color: newBlueColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  //  Profile card 
  Widget _profileCard(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4361EE), Color(0xFF738EFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ProfileImageView(
            size: 52,
            imageUrl: controller.homeController.currentUserData?.photo ?? '',
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.homeController.currentUserData?.name ?? 'User',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.homeController.currentUserData?.usertype ?? '',
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  Baltra overview stats (live counts from Orders + Visits list APIs)
  Widget _baltraStatsRow(DashboardController controller) {
    return Row(
      children: [
        Expanded(
          child: _statCard('TOTAL ORDERS', '${controller.orderCount}',
              Icons.shopping_bag_outlined, newBlueColor, newBlueLightColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard('TOTAL PARTIES', '${controller.partyCount}',
              Icons.groups_outlined, newOrangeColor, newOrangeLightColor),
        ),
      ],
    );
  }

  //  Baltra modules (static — Order, Visit, MIS)
  Widget _moduleList() {
    final modules =
        <({String title, String subtitle, String icon, Color color, String route})>[
      (
        title: 'Order',
        subtitle: 'Create & track customer orders',
        icon: AppAssets.ordernewIcon,
        color: newBlueColor,
        route: AppRoutes.orderView,
      ),
      (
        title: 'Party List',
        subtitle: 'View all parties',
        icon: AppAssets.partylistnewIcon,
        color: const Color(0xFF00B894),
        route: AppRoutes.partyList,
      ),
    ];
    return Column(
      children: [
        for (final m in modules) ...[
          _moduleCard(
            title: m.title,
            subtitle: m.subtitle,
            icon: m.icon,
            color: m.color,
            onTap: () => Get.toNamed(m.route),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _moduleCard({
    required String title,
    required String subtitle,
    required String icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Image.asset(icon, width: 26, height: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: newTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: newTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 15, color: color),
          ],
        ),
      ),
    );
  }

  //  Stats row
  Widget _statsRow(DashboardController controller) {
    return Row(
      children: [
        Expanded(
            child: _statCard('TOTAL ORDERS', '1200',
                Icons.shopping_bag_outlined, newBlueColor, newBlueLightColor,
                badge: '+5.2%')),
        const SizedBox(width: 12),
        Expanded(
            child: _statCard(
                'PENDING VISITS',
                '15',
                Icons.person_pin_circle_outlined,
                newOrangeColor,
                newOrangeLightColor)),
        const SizedBox(width: 12),
        Expanded(
            child: _statCard(
                'PAYMENT DUE',
                '₹1.2L',
                Icons.account_balance_wallet_outlined,
                newRedColor,
                newRedLightColor)),
      ],
    );
  }

  Widget _statCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color bgColor, {
    String? badge,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 18, color: color),
              ),
              if (badge != null) ...[
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                      color: newGreenLightColor,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(badge,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: newGreenColor)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: newTextPrimary)),
          const SizedBox(height: 2),
          Text(label,
              style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: newTextSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  //  Section title 
  Widget _sectionTitle(String title) => Text(title,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w800, color: newTextPrimary));

  //  Period tab pill 
  Widget _periodTab(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? newBlueColor : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : newTextSecondary)),
    );
  }

  //  Revenue line chart 
  Widget _revenueChart(DashboardController controller) {
    final spots = [
      const FlSpot(0, 20),
      const FlSpot(1, 30),
      const FlSpot(2, 35),
      const FlSpot(3, 28),
      const FlSpot(4, 50),
      const FlSpot(5, 18),
      const FlSpot(6, 25),
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Amount (left) | Tabs (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('₹11,642',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: newTextPrimary)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: newSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: newBorderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: ['D', 'W', 'M', 'Y']
                      .map((t) => _periodTab(t, t == 'W'))
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 2: Badge + subtitle (own line, no competition for space)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: newGreenLightColor,
                    borderRadius: BorderRadius.circular(6)),
                child: const Text('+4%',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: newGreenColor)),
              ),
              const SizedBox(width: 6),
              const Text('from last period',
                  style: TextStyle(fontSize: 11, color: newTextSecondary)),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 140,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                        color: newBorderColor.withValues(alpha: 0.5),
                        strokeWidth: 1)),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          interval: 50,
                          getTitlesWidget: (v, _) => Text('₹${v.toInt()}k',
                              style: const TextStyle(
                                  fontSize: 9, color: newTextSecondary)),
                          reservedSize: 36)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, _) {
                            final i = v.toInt();
                            if (i >= 0 && i < days.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(days[i],
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: i == 4
                                            ? FontWeight.w700
                                            : FontWeight.normal,
                                        color: i == 4
                                            ? newBlueColor
                                            : newTextSecondary)),
                              );
                            }
                            return const SizedBox();
                          },
                          reservedSize: 22)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => const Color(0xFF0A1628),
                    tooltipPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    getTooltipItems: (spots) => spots
                        .map((s) => LineTooltipItem(
                              '₹${s.y.toInt()}k',
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                        .toList(),
                  ),
                  getTouchedSpotIndicator: (_, indices) => indices
                      .map((_) => TouchedSpotIndicatorData(
                            FlLine(
                              color: newBlueColor.withValues(alpha: 0.4),
                              strokeWidth: 1.5,
                              dashArray: [4, 4],
                            ),
                            FlDotData(
                              show: true,
                              getDotPainter: (_, __, ___, ____) =>
                                  FlDotCirclePainter(
                                radius: 6,
                                color: Colors.white,
                                strokeColor: newBlueColor,
                                strokeWidth: 2.5,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: newBlueColor,
                    barWidth: 2.5,
                    dotData: FlDotData(
                        show: true,
                        checkToShowDot: (spot, _) => spot.x == 4,
                        getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                            radius: 5,
                            color: Colors.white,
                            strokeColor: newBlueColor,
                            strokeWidth: 2)),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                          colors: [
                            newBlueColor.withValues(alpha: 0.15),
                            newBlueColor.withValues(alpha: 0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Visits bar chart 
  Widget _visitsChart(DashboardController controller) {
    final vals = [1000.0, 3000, 10000, 1000, 10000, 700, 1500];
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: total visits value (left) | Tabs pill (right)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('10,700',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: newTextPrimary)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: newSurfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: newBorderColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: ['D', 'W', 'M', 'Y']
                      .map((t) => _periodTab(t, t == 'W'))
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Row 2: badge + subtitle
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: newGreenLightColor,
                    borderRadius: BorderRadius.circular(6)),
                child: const Text('+3.4%',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: newGreenColor)),
              ),
              const SizedBox(width: 6),
              const Text('from last period',
                  style: TextStyle(fontSize: 11, color: newTextSecondary)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: BarChart(
              BarChartData(
                maxY: 12000,
                minY: 0,
                gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                        color: newBorderColor.withValues(alpha: 0.5),
                        strokeWidth: 1)),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          interval: 4000,
                          getTitlesWidget: (v, _) => Text(v.toInt().toString(),
                              style: const TextStyle(
                                  fontSize: 9, color: newTextSecondary)),
                          reservedSize: 38)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (v, _) {
                            final i = v.toInt();
                            if (i >= 0 && i < days.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(days[i],
                                    style: const TextStyle(
                                        fontSize: 11, color: newTextSecondary)),
                              );
                            }
                            return const SizedBox();
                          },
                          reservedSize: 20)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => const Color(0xFF0A1628),
                    tooltipPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                        BarTooltipItem(
                      '${rod.toY.toInt()}',
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                barGroups: List.generate(
                    vals.length,
                    (i) => BarChartGroupData(
                          x: i,
                          barRods: [
                            BarChartRodData(
                              toY: vals[i].toDouble(),
                              width: 16,
                              color: newBlueColor,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                          ],
                        )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  Recent orders table (dynamic from API) 
  Widget _recentOrdersTable(DashboardController controller) {
    final data = controller.dashboardDetailsData;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          //  Header 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: newSurfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: const [
                Expanded(
                    flex: 3,
                    child: Text('Doc No.',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: newTextSecondary))),
                Expanded(
                    flex: 3,
                    child: Text('Description',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: newTextSecondary))),
                Expanded(
                    flex: 3,
                    child: Text('Executive',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: newTextSecondary))),
              ],
            ),
          ),

          //  Empty state 
          if (data == null || data.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined,
                        size: 36,
                        color: newTextSecondary.withValues(alpha: 0.3)),
                    const SizedBox(height: 8),
                    const Text('No recent data',
                        style:
                            TextStyle(fontSize: 13, color: newTextSecondary)),
                  ],
                ),
              ),
            )
          else
            //  Data rows 
            ...data.take(5).map((item) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: newBorderColor, width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      // Doc number with badge style
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 3),
                          decoration: BoxDecoration(
                            color: newBlueLightColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.documentNumber?.toString() ?? '—',
                            style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: newBlueColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Description
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.description?.toString() ?? '—',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: newTextPrimary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Executive name
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.executiveName?.toString() ?? '—',
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: newTextSecondary),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                )),

          //  View all button 
          if (data != null && data.isNotEmpty)
            Container(
              decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: newBorderColor, width: 0.5)),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('View All',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: newBlueColor)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded,
                        size: 14, color: newBlueColor),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _attendanceTable(AttendanceController controller) {
    final details = controller.attendanceSummaryData?[0].details ?? [];
    final displayList = details.take(5).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          // ✅ Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: newSurfaceColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text('Date',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: newTextSecondary,
                          letterSpacing: 0.4)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('In Time',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: newTextSecondary,
                          letterSpacing: 0.4)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Out Time',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: newTextSecondary,
                          letterSpacing: 0.4)),
                ),
                Expanded(
                  flex: 3,
                  child: Text('Status',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: newTextSecondary,
                          letterSpacing: 0.4)),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: newBorderColor),

          // ✅ Empty state
          if (displayList.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('No attendance records',
                    style: TextStyle(fontSize: 13, color: newTextSecondary)),
              ),
            )
          else
            ...displayList.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final bool inProgress =
                  item.outTime == null || item.outTime!.isEmpty;
              final statusColor =
              inProgress ? const Color(0xFFF59E0B) : newGreenColor;
              final statusLabel = inProgress ? 'In Progress' : 'Present';
              final isLast = index == displayList.length - 1;

              return Column(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    color: index.isOdd ? newSurfaceColor : Colors.white,
                    child: Row(
                      children: [
                        // Date
                        Expanded(
                          flex: 3,
                          child: Text(
                            item.date ?? '-',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: newTextPrimary),
                          ),
                        ),

                        // In Time
                        Expanded(
                          flex: 3,
                          child: Text(
                            item.inTime ?? 'N/A',
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: newGreenColor),
                          ),
                        ),

                        // Out Time
                        Expanded(
                          flex: 3,
                          child: Text(
                            item.outTime?.isNotEmpty == true
                                ? item.outTime!
                                : 'N/A',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: inProgress
                                    ? const Color(0xFFF59E0B)
                                    : newRedColor),
                          ),
                        ),

                        // Status — just a colored dot + text, no chip
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  statusLabel,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: statusColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) const Divider(height: 1, color: newBorderColor),
                ],
              );
            }),

          // ✅ View All button
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: newBorderColor, width: 0.5)),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: TextButton(
              onPressed: () {
                Get.find<HomeController>().onItemTapped(1); // 1 = Attendance tab
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('View All',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: newBlueColor)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_rounded,
                      size: 14, color: newBlueColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
