// import 'package:digitalerp/homeview_new_controller.dart';
// import 'package:digitalerp/screen/ui/home/attendance/attendance_view.dart';
// import 'package:digitalerp/screen/ui/home/dashboard/dashboard_view.dart';
// import 'package:digitalerp/screen/ui/home/executive_list/executive_list_view.dart';
// import 'package:digitalerp/screen/ui/home/home_controller.dart';
// import 'package:digitalerp/homeview_new_controller.dart';
// import 'package:digitalerp/screen/ui/home/order/order_view.dart';
// import 'package:digitalerp/screen/ui/home/order/order_view_drawer.dart';
// import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:upgrader/upgrader.dart';
// import '../../../utils/app_constant_new.dart';
// import 'drawer/drawer_view.dart';
// import 'package:digitalerp/home_view_new.dart';
//
// import 'executive_list/executive_list_drawer_view.dart';
//
// // Nav item model
// class _NavItem {
//   final IconData icon;
//   final IconData activeIcon;
//   final String label;
//   final Widget page;
//   const _NavItem({
//     required this.icon,
//     required this.activeIcon,
//     required this.label,
//     required this.page,
//   });
// }
//
// // Map: menu ID → nav item definition
// //  Add new entries here whenever a new menu is added to the backend.
// const Map<int, _NavItem> _menuNavMap = {
//   2378: _NavItem(
//     icon: Icons.inventory_2_outlined,
//     activeIcon: Icons.inventory_2_rounded,
//     label: 'Orders',
//     page: OrderViewDrawer(), // child: 1 → uses sub-menu nav, still fine
//   ),
//   // 2379: _NavItem(
//   //   icon: Icons.map_outlined,
//   //   activeIcon: Icons.map_rounded,
//   //   label: 'Visits',
//   //   page: VisitPlanView(),
//   // ),
//   2377: _NavItem(
//     icon: Icons.group_outlined,
//     activeIcon: Icons.group_rounded,
//     label: 'Team',
//     page: ExecutiveListDrawerView(),
//   ),
//   // Attendance is a bottom-nav tab, not in menuListData,
//   // so we keep it as a fixed optional tab via isCustomer logic.
//   // If you ever get it from API, add its ID here.
// };
//
// //  HomeView
// class HomeView extends StatelessWidget {
//   HomeView({Key? key}) : super(key: key);
//
//   // ✅ Create ONCE, not inside build()
//   final _upgrader = Upgrader(
//     storeController: UpgraderStoreController(
//       onAndroid: () => UpgraderAppcastStore(appcastURL: AppConst.appCastUrl),
//       oniOS: () => UpgraderAppcastStore(appcastURL: AppConst.appCastUrl),
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       init: HomeController(),
//       builder: (controller) {
//         return Scaffold(
//           backgroundColor: lightGreyColor,
//           drawer: const DrawerView(),
//           resizeToAvoidBottomInset: false,
//           body: UpgradeAlert(
//             upgrader: _upgrader, // ✅ use the stable instance
//             showIgnore: false,
//             showLater: false,
//             shouldPopScope: () => false,
//             child: GetBuilder<HomeViewNewController>(
//               init: HomeViewNewController(), // ✅ add fallback init
//               builder: (menuCtrl) {
//                 final isLoading = menuCtrl.isBusy;
//                 final dynamicTabs = _buildTabs(controller, menuCtrl);
//
//                 return Stack(
//                   children: [
//                     Positioned.fill(
//                       child: _currentPage(controller, dynamicTabs),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: isLoading
//                           ? const _NavBarShimmer()
//                           : _BottomNav(
//                               tabs: dynamicTabs,
//                               selectedIndex: controller.selectedTabI
//                                   .clamp(0, dynamicTabs.length - 1),
//                               onTap: (i) => controller.onItemTapped(i),
//                             ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
// // ... rest unchanged
//   /// Builds tab list: Home (fixed) + permitted middle tabs + More (fixed)
//   List<_NavItem> _buildTabs(
//       HomeController controller, HomeViewNewController menuCtrl) {
//     final menuIds = menuCtrl.menuListData
//         .map((e) => e.menuid ?? -1)
//         .where((id) => id > 0)
//         .toSet();
//
//     // Always first: Dashboard/Home
//     final tabs = <_NavItem>[
//       const _NavItem(
//         icon: Icons.home_outlined,
//         activeIcon: Icons.home_rounded,
//         label: 'Home',
//         page: DashboardView(),
//       ),
//     ];
//
//     // Attendance tab — show if user is NOT a customer
//     if (controller.isCustomer != true) {
//       tabs.add(_NavItem(
//         icon: Icons.date_range_outlined,
//         activeIcon: Icons.date_range_rounded,
//         label: 'Attendance',
//         page: AttendanceView(),
//       ));
//     }
//
//     // Middle tabs — only add if API granted that menu ID
//     for (final entry in _menuNavMap.entries) {
//       if (menuIds.contains(entry.key)) {
//         tabs.add(entry.value);
//       }
//     }
//
//     // Always last: More (Quick Links grid)
//     tabs.add(const _NavItem(
//       icon: Icons.apps_outlined,
//       activeIcon: Icons.apps_rounded,
//       label: 'More',
//       page: HomeViewNew(),
//     ));
//
//     return tabs;
//   }
//
//   /// Extracts menu IDs from the controller's menu list
//   Set<int> _getMenuIds(HomeController controller) {
//     try {
//       final menuController = Get.find<HomeViewNewController>();
//       return menuController.menuListData
//           .map((e) => e.menuid ?? -1)
//           .where((id) => id > 0)
//           .toSet();
//     } catch (_) {
//       return {};
//     }
//   }
//
//   /// Returns the correct page widget for the selected tab index
//   Widget _currentPage(HomeController controller, List<_NavItem> tabs) {
//     final idx = controller.selectedTabI.clamp(0, tabs.length - 1);
//     return tabs[idx].page;
//   }
// }
//
// class _NavBarShimmer extends StatefulWidget {
//   const _NavBarShimmer();
//
//   @override
//   State<_NavBarShimmer> createState() => _NavBarShimmerState();
// }
//
// class _NavBarShimmerState extends State<_NavBarShimmer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _anim;
//   late Animation<double> _fade;
//
//   @override
//   void initState() {
//     super.initState();
//     _anim = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 700),
//     )..repeat(reverse: true);
//     _fade = Tween(begin: 0.25, end: 0.7).animate(
//       CurvedAnimation(parent: _anim, curve: Curves.easeInOut),
//     );
//   }
//
//   @override
//   void dispose() {
//     _anim.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _fade,
//       builder: (_, __) => Opacity(
//         opacity: _fade.value,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: whiteColor,
//             border: Border(top: BorderSide(color: newBorderColor, width: 1)),
//           ),
//           child: SafeArea(
//             top: false,
//             child: SizedBox(
//               height: 56,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: List.generate(4, (_) => _shimmerTab()),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _shimmerTab() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(6),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Container(
//           width: 34,
//           height: 8,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Bottom Nav Bar
// class _BottomNav extends StatelessWidget {
//   final List<_NavItem> tabs;
//   final int selectedIndex;
//   final ValueChanged<int> onTap;
//
//   const _BottomNav({
//     required this.tabs,
//     required this.selectedIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: whiteColor,
//         border: Border(top: BorderSide(color: newBorderColor, width: 1)),
//       ),
//       child: SafeArea(
//         top: false,
//         child: SizedBox(
//           height: 56,
//           child: Row(
//             children: List.generate(
//               tabs.length,
//               (i) => _NavTile(
//                 item: tabs[i],
//                 isSelected: selectedIndex == i,
//                 onTap: () {
//                   HapticFeedback.lightImpact();
//                   onTap(i);
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //  Nav Tile
// class _NavTile extends StatelessWidget {
//   final _NavItem item;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const _NavTile({
//     required this.item,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         splashColor: purpleColor,
//         highlightColor: Colors.transparent,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Active indicator bar
//             Container(
//               height: 2,
//               width: double.infinity,
//               color: isSelected ? newBlueColor : Colors.transparent,
//             ),
//             const SizedBox(height: 8),
//             Icon(
//               isSelected ? item.activeIcon : item.icon,
//               size: 22,
//               color: isSelected ? purple2Color : newTextSecondary,
//             ),
//             const SizedBox(height: 3),
//             Text(
//               item.label,
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
//                 color: isSelected ? newBlueColor : newTextSecondary,
//                 letterSpacing: 0.2,
//               ),
//             ),
//             const SizedBox(height: 6),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/screen/ui/home/attendance/attendance_view.dart';
import 'package:digitalerp/screen/ui/home/dashboard/dashboard_view.dart';
import 'package:digitalerp/screen/ui/home/executive_list/executive_list_view.dart';
import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/screen/ui/home/order/order_view.dart';
import 'package:digitalerp/screen/ui/home/order/order_view_drawer.dart';
import 'package:digitalerp/screen/ui/home/visit_plan/visit_plan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';
import '../../../utils/app_constant_new.dart';
import 'drawer/drawer_view.dart';
import 'package:digitalerp/home_view_new.dart';

import 'executive_list/executive_list_drawer_view.dart';

// Nav item model — UNCHANGED
class _NavItem {
  final String? assetImage;
  final IconData? icon;
  final IconData activeIcon;
  final String label;
  final Widget page;
  const _NavItem({
    this.assetImage,
    this.icon,
    required this.activeIcon,
    required this.label,
    required this.page,
  });
}

// Map: menu ID → nav item definition — UNCHANGED
const Map<int, _NavItem> _menuNavMap = {
  2378: _NavItem(
    assetImage: 'assets/bottomNavIcons/orderNav.png',
    icon: Icons.inventory_2_outlined,
    activeIcon: Icons.inventory_2_rounded,
    label: 'Orders',
    page: OrderViewDrawer(),
  ),
  2377: _NavItem(
    assetImage: 'assets/bottomNavIcons/groupNav.png',
    icon: Icons.group_outlined,
    activeIcon: Icons.group_rounded,
    label: 'Team',
    page: ExecutiveListDrawerView(),
  ),
};

//
// HomeView — FUNCTIONALITY UNCHANGED
//
class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final _upgrader = Upgrader(
    storeController: UpgraderStoreController(
      onAndroid: () => UpgraderAppcastStore(appcastURL: AppConst.appCastUrl),
      oniOS: () => UpgraderAppcastStore(appcastURL: AppConst.appCastUrl),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: lightGreyColor,
          drawer: const DrawerView(),
          resizeToAvoidBottomInset: false,
          body: UpgradeAlert(
            upgrader: _upgrader,
            showIgnore: false,
            showLater: false,
            shouldPopScope: () => false,
            child: GetBuilder<HomeViewNewController>(
              init: HomeViewNewController(),
              builder: (menuCtrl) {
                final isLoading = menuCtrl.isBusy;
                final dynamicTabs = _buildTabs(controller, menuCtrl);

                return Stack(
                  children: [
                    Positioned.fill(
                      child: _currentPage(controller, dynamicTabs),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: isLoading
                          ? const _NavBarShimmer()
                          : _BottomNav(
                              tabs: dynamicTabs,
                              selectedIndex: controller.selectedTabI
                                  .clamp(0, dynamicTabs.length - 1),
                              onTap: (i) => controller.onItemTapped(i),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  // UNCHANGED
  List<_NavItem> _buildTabs(
      HomeController controller, HomeViewNewController menuCtrl) {
    final menuIds = menuCtrl.menuListData
        .map((e) => e.menuid ?? -1)
        .where((id) => id > 0)
        .toSet();

    final tabs = <_NavItem>[
      const _NavItem(
        assetImage: 'assets/bottomNavIcons/homeNav.png',
        icon: Icons.home_filled,
        activeIcon: Icons.home_filled,
        label: 'Home',
        page: DashboardView(),
      ),
    ];

    if (controller.isCustomer != true) {
      tabs.add(_NavItem(
        icon: Icons.date_range_outlined,
        activeIcon: Icons.date_range_rounded,
        label: 'Attendance',
        page: AttendanceView(),
      ));
    }

    for (final entry in _menuNavMap.entries) {
      if (menuIds.contains(entry.key)) {
        tabs.add(entry.value);
      }
    }

    tabs.add(const _NavItem(
      assetImage: 'assets/bottomNavIcons/moreNav.png',
      icon: Icons.apps_outlined,
      activeIcon: Icons.apps_rounded,
      label: 'More',
      page: HomeViewNew(),
    ));

    return tabs;
  }

  Widget _currentPage(HomeController controller, List<_NavItem> tabs) {
    final idx = controller.selectedTabI.clamp(0, tabs.length - 1);
    return tabs[idx].page;
  }
}

//
// SHIMMER — UNCHANGED
//
class _NavBarShimmer extends StatefulWidget {
  const _NavBarShimmer();

  @override
  State<_NavBarShimmer> createState() => _NavBarShimmerState();
}

class _NavBarShimmerState extends State<_NavBarShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _fade = Tween(begin: 0.25, end: 0.7).animate(
      CurvedAnimation(parent: _anim, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fade,
      builder: (_, __) => Opacity(
        opacity: _fade.value,
        child: Container(
          decoration: const BoxDecoration(
            color: whiteColor,
            border: Border(top: BorderSide(color: newBorderColor, width: 1)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(4, (_) => _shimmerTab()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shimmerTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 36,
          height: 9,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }
}

//
// BOTTOM NAV BAR — UI ONLY CHANGE
//
class _BottomNav extends StatelessWidget {
  final List<_NavItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(
              tabs.length,
              (i) => _NavTile(
                item: tabs[i],
                isSelected: selectedIndex == i,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(i);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
// NAV TILE — UI redesigned to match the image
// Active state   → rounded square filled with purple, white icon, colored label
// Inactive state → plain icon + grey label (no background)
//
class _NavTile extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  // Active purple — matches image
  static const _activeColor = purpleColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon — filled rounded square when active, plain when not
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: 48,
              height: 38,
              decoration: BoxDecoration(
                color: isSelected ? _activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                // ← ADD Center
                child: item.assetImage != null
                    ? Image.asset(
                        item.assetImage!,
                        width: 24, // ← fix: was missing explicit size
                        height: 24, // ← fix: was missing explicit size
                        fit: BoxFit.contain,
                        color:
                            isSelected ? Colors.white : const Color(0xFF6B7380),
                      )
                    : Icon(
                        isSelected ? item.activeIcon : item.icon,
                        size: 22,
                        color:
                            isSelected ? Colors.white : const Color(0xFF6B7380),
                      ),
              ),
            ),
            const SizedBox(height: 5),

            // Label
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? _activeColor : const Color(0xFF6B7380),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
