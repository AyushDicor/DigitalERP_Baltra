// // // import 'package:digitalerp/Menu_new_list_responce.dart';
// // // import 'package:digitalerp/homeview_new_controller.dart';
// // // import 'package:digitalerp/new_menu_defalut_screen.dart';
// // // import 'package:digitalerp/screen/base/base_controller.dart';
// // // import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
// // // import 'package:digitalerp/utils/app_constant.dart';
// // // import 'package:digitalerp/utils/app_constant_new.dart';
// // // import 'package:digitalerp/utils/app_profile_image.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // //
// // // class HomeViewNew extends StatefulWidget {
// // //   const HomeViewNew({Key? key}) : super(key: key);
// // //
// // //   @override
// // //   State<HomeViewNew> createState() => _HomeViewNewState();
// // // }
// // //
// // // class _HomeViewNewState extends State<HomeViewNew> with WidgetsBindingObserver {
// // //   late HomeViewNewController controller;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     WidgetsBinding.instance.addObserver(this);
// // //     controller = Get.put(HomeViewNewController());
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     WidgetsBinding.instance.removeObserver(this);
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   void didChangeAppLifecycleState(AppLifecycleState state) {
// // //     if (state == AppLifecycleState.resumed) {
// // //       controller.getUnApprovalCount();
// // //       controller.getNewMenuList(0);
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return GetBuilder<HomeViewNewController>(
// // //       builder: (ctrl) => Scaffold(
// // //         backgroundColor: Colors.white,
// // //         appBar: _buildAppBar(ctrl),
// // //         body: Column(
// // //           children: [
// // //             _profileBanner(ctrl),
// // //             const SizedBox(height: 8),
// // //             // Section title
// // //             const Padding(
// // //               padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
// // //               child: Align(
// // //                 alignment: Alignment.centerLeft,
// // //                 child: Text('Quick Links',
// // //                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: newTextPrimary)),
// // //               ),
// // //             ),
// // //             Expanded(child: _menuGrid(ctrl)),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   PreferredSizeWidget _buildAppBar(HomeViewNewController ctrl) {
// // //     return AppBar(
// // //       backgroundColor: Colors.white,
// // //       elevation: 0,
// // //       surfaceTintColor: Colors.transparent,
// // //       titleSpacing: 16,
// // //       title: const Text('Admin',
// // //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: newTextPrimary)),
// // //       leading: GestureDetector(
// // //         onTap: () => ctrl.openDrawer(context),
// // //         child: const Padding(
// // //           padding: EdgeInsets.all(12),
// // //           child: Icon(Icons.menu_rounded, color: newTextPrimary),
// // //         ),
// // //       ),
// // //       actions: [
// // //         GestureDetector(
// // //           onTap: () => Get.to(const ApprovalList()),
// // //           child: Container(
// // //             margin: const EdgeInsets.only(right: 12),
// // //             width: 38, height: 38,
// // //             decoration: BoxDecoration(color: newBlueLightColor, borderRadius: BorderRadius.circular(10)),
// // //             child: Badge(
// // //               isLabelVisible: ctrl.unApprovalCount > 0,
// // //               label: Text(ctrl.unApprovalCount > 99 ? '+99' : ctrl.unApprovalCount.toString(),
// // //                   style: const TextStyle(fontSize: 9)),
// // //               child: const Icon(Icons.notifications_outlined, size: 20, color: newBlueColor),
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _profileBanner(HomeViewNewController ctrl) {
// // //     return Container(
// // //       margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
// // //       padding: const EdgeInsets.all(14),
// // //       decoration: BoxDecoration(
// // //         gradient: const LinearGradient(
// // //           colors: [Color(0xFF4361EE), Color(0xFF738EFF)],
// // //           begin: Alignment.topLeft, end: Alignment.bottomRight,
// // //         ),
// // //         borderRadius: BorderRadius.circular(14),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           ProfileImageView(
// // //             size: 46,
// // //             imageUrl: ctrl.homeController.currentUserData?.photo ?? '',
// // //           ),
// // //           const SizedBox(width: 12),
// // //           Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(
// // //                   ctrl.homeController.currentUserData?.name ?? 'User',
// // //                   style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
// // //                   maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                 ),
// // //                 Text(
// // //                   ctrl.homeController.currentUserData?.usertype ?? '',
// // //                   style: const TextStyle(fontSize: 12, color: Colors.white70),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _menuGrid(HomeViewNewController ctrl) {
// // //     if (ctrl.isListLoading) {
// // //       return const Center(child: CircularProgressIndicator(color: newBlueColor));
// // //     }
// // //     if (ctrl.menuListData.isEmpty) {
// // //       return const Center(
// // //           child: Text('No menu items found',
// // //               style: TextStyle(color: newTextSecondary)));
// // //     }
// // //     return GridView.builder(
// // //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
// // //       itemCount: ctrl.menuListData.length,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //         crossAxisCount: 3,
// // //         crossAxisSpacing: 12,
// // //         mainAxisSpacing: 12,
// // //         childAspectRatio: 1.0,
// // //       ),
// // //       itemBuilder: (_, i) => _menuTile(ctrl.menuListData[i], ctrl),
// // //     );
// // //   }
// // //
// // //   Widget _menuTile(MenuNewData data, HomeViewNewController ctrl) {
// // //     return GestureDetector(
// // //       onTap: () {
// // //         if (data.child == 1) {
// // //           newMenuId
// // //             ..clear()
// // //             ..add(data.menuid!);
// // //           Get.to(MenuDefaultScreen(menuID: data.menuid!));
// // //         } else {
// // //           Get.toNamed(HomeViewNewController.getRouteNameById(data.menuid));
// // //         }
// // //       },
// // //       child: Container(
// // //         decoration: BoxDecoration(
// // //           color: Colors.white,
// // //           borderRadius: BorderRadius.circular(14),
// // //           border: Border.all(color: newBorderColor),
// // //           boxShadow: [
// // //             BoxShadow(color: Colors.black.withValues(alpha:0.04), blurRadius: 6, offset: const Offset(0, 2)),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Container(
// // //               width: 44, height: 44,
// // //               decoration: BoxDecoration(color: newBlueLightColor, borderRadius: BorderRadius.circular(10)),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(8),
// // //                 child: Image.asset(
// // //                   ctrl.imageList()[data.menuname] ?? '',
// // //                   errorBuilder: (_, __, ___) =>
// // //                   const Icon(Icons.grid_view_rounded, color: newBlueColor, size: 24),
// // //                 ),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 6),
// // //               child: Text(
// // //                 data.menuname ?? '',
// // //                 textAlign: TextAlign.center,
// // //                 maxLines: 2,
// // //                 overflow: TextOverflow.ellipsis,
// // //                 style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: newTextPrimary),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:digitalerp/Menu_new_list_responce.dart';
// // import 'package:digitalerp/homeview_new_controller.dart';
// // import 'package:digitalerp/new_menu_defalut_screen.dart';
// // import 'package:digitalerp/screen/base/base_controller.dart';
// // import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
// // import 'package:digitalerp/utils/app_constant_new.dart';
// // import 'package:digitalerp/utils/app_profile_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // class HomeViewNew extends StatefulWidget {
// //   const HomeViewNew({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomeViewNew> createState() => _HomeViewNewState();
// // }
// //
// // class _HomeViewNewState extends State<HomeViewNew> with WidgetsBindingObserver {
// //   late HomeViewNewController controller;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addObserver(this);
// //     controller = Get.put(HomeViewNewController());
// //   }
// //
// //   @override
// //   void dispose() {
// //     WidgetsBinding.instance.removeObserver(this);
// //     super.dispose();
// //   }
// //
// //   @override
// //   void didChangeAppLifecycleState(AppLifecycleState state) {
// //     if (state == AppLifecycleState.resumed) {
// //       controller.getUnApprovalCount();
// //       controller.getNewMenuList(0);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<HomeViewNewController>(
// //       builder: (ctrl) => Scaffold(
// //         backgroundColor: Colors.white,
// //         appBar: _buildAppBar(ctrl),
// //         body: Column(
// //           children: [
// //             _profileBanner(ctrl),
// //             const SizedBox(height: 8),
// //             // Section title
// //             const Padding(
// //               padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
// //               child: Align(
// //                 alignment: Alignment.centerLeft,
// //                 child: Text('Quick Links',
// //                     style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w800,
// //                         color: newTextPrimary)),
// //               ),
// //             ),
// //             Expanded(child: _menuGrid(ctrl)),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   PreferredSizeWidget _buildAppBar(HomeViewNewController ctrl) {
// //     return AppBar(
// //       backgroundColor: Colors.white,
// //       elevation: 0,
// //       surfaceTintColor: Colors.transparent,
// //       titleSpacing: 16,
// //       title: const Text('Admin',
// //           style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w700,
// //               color: newTextPrimary)),
// //       leading: GestureDetector(
// //         onTap: () => ctrl.openDrawer(context),
// //         child: const Padding(
// //           padding: EdgeInsets.all(12),
// //           child: Icon(Icons.menu_rounded, color: newTextPrimary),
// //         ),
// //       ),
// //       actions: [
// //         GestureDetector(
// //           onTap: () => Get.to(const ApprovalList()),
// //           child: Container(
// //             margin: const EdgeInsets.only(right: 12),
// //             width: 38,
// //             height: 38,
// //             decoration: BoxDecoration(
// //                 color: newBlueLightColor,
// //                 borderRadius: BorderRadius.circular(10)),
// //             child: Badge(
// //               isLabelVisible: ctrl.unApprovalCount > 0,
// //               label: Text(
// //                   ctrl.unApprovalCount > 99
// //                       ? '+99'
// //                       : ctrl.unApprovalCount.toString(),
// //                   style: const TextStyle(fontSize: 9)),
// //               child: const Icon(Icons.approval_outlined,
// //                   size: 20, color: newBlueColor),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _profileBanner(HomeViewNewController ctrl) {
// //     return Container(
// //       margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
// //       padding: const EdgeInsets.all(14),
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           colors: [Color(0xFF4361EE), Color(0xFF738EFF)],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         borderRadius: BorderRadius.circular(14),
// //       ),
// //       child: Row(
// //         children: [
// //           ProfileImageView(
// //             size: 46,
// //             imageUrl: ctrl.homeController.currentUserData?.photo ?? '',
// //           ),
// //           const SizedBox(width: 12),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   ctrl.homeController.currentUserData?.name ?? 'User',
// //                   style: const TextStyle(
// //                       fontSize: 15,
// //                       fontWeight: FontWeight.w700,
// //                       color: Colors.white),
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 Text(
// //                   ctrl.homeController.currentUserData?.usertype ?? '',
// //                   style: const TextStyle(fontSize: 12, color: Colors.white70),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _menuGrid(HomeViewNewController ctrl) {
// //     if (ctrl.isListLoading) {
// //       return const Center(
// //           child: CircularProgressIndicator(color: newBlueColor));
// //     }
// //     if (ctrl.menuListData.isEmpty) {
// //       return const Center(
// //           child: Text('No menu items found',
// //               style: TextStyle(color: newTextSecondary)));
// //     }
// //     return GridView.builder(
// //       padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
// //       itemCount: ctrl.menuListData.length,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 3,
// //         crossAxisSpacing: 12,
// //         mainAxisSpacing: 12,
// //         childAspectRatio: 1.0,
// //       ),
// //       itemBuilder: (_, i) => _menuTile(ctrl.menuListData[i], ctrl),
// //     );
// //   }
// //
// //   void _openQuickLinksSheet(HomeViewNewController ctrl) {
// //     showModalBottomSheet(
// //       context: Get.context!,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (_) {
// //         return Container(
// //           height: Get.height * 0.88,
// //           decoration: const BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
// //           ),
// //           child: Column(
// //             children: [
// //               // 🔹 DRAG HANDLE
// //               const SizedBox(height: 8),
// //               Container(
// //                 height: 4,
// //                 width: 40,
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.shade300,
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 10),
// //
// //               // 🔹 HEADER
// //               Padding(
// //                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     const Text(
// //                       'Quick Links',
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.w700,
// //                         color: Colors.black,
// //                       ),
// //                     ),
// //                     GestureDetector(
// //                       onTap: () => Get.back(),
// //                       child: Container(
// //                         height: 36,
// //                         width: 36,
// //                         decoration: BoxDecoration(
// //                           color: Colors.grey.shade100,
// //                           borderRadius: BorderRadius.circular(10),
// //                         ),
// //                         child: const Icon(Icons.close, size: 20),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //
// //               const Divider(height: 1),
// //
// //               // 🔹 GRID (UNCHANGED LOGIC)
// //               Expanded(
// //                 child: ctrl.isListLoading
// //                     ? const Center(child: CircularProgressIndicator())
// //                     : GridView.builder(
// //                   padding:
// //                   const EdgeInsets.fromLTRB(16, 16, 16, 30),
// //                   itemCount: ctrl.menuListData.length,
// //                   gridDelegate:
// //                   const SliverGridDelegateWithFixedCrossAxisCount(
// //                     crossAxisCount: 3,
// //                     crossAxisSpacing: 14,
// //                     mainAxisSpacing: 14,
// //                     childAspectRatio: 1,
// //                   ),
// //                   itemBuilder: (_, i) =>
// //                       _menuTile(ctrl.menuListData[i], ctrl),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _menuTile(MenuNewData data, HomeViewNewController ctrl) {
// //     return GestureDetector(
// //       onTap: () {
// //         if (data.child == 1) {
// //           newMenuId
// //             ..clear()
// //             ..add(data.menuid!);
// //           Get.to(MenuDefaultScreen(menuID: data.menuid!));
// //         } else {
// //           Get.toNamed(HomeViewNewController.getRouteNameById(data.menuid));
// //         }
// //       },
// //       child: Container(
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(14),
// //           border: Border.all(color: newBorderColor),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withValues(alpha: 0.1),
// //               blurRadius: 8,
// //               offset: const Offset(0, 2),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               width: 44,
// //               height: 44,
// //               decoration: BoxDecoration(
// //                   color: Colors.transparent,
// //                   borderRadius: BorderRadius.circular(10)),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(8),
// //                 child: Image.asset(
// //                   ctrl.imageList()[data.menuname] ?? '',
// //                   errorBuilder: (_, __, ___) => const Icon(
// //                       Icons.grid_view_rounded,
// //                       color: Colors.transparent ,
// //                       size: 28),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 8),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 6),
// //               child: Text(
// //                 data.menuname ?? '',
// //                 textAlign: TextAlign.center,
// //                 maxLines: 2,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: const TextStyle(
// //                     fontSize: 11,
// //                     fontWeight: FontWeight.w600,
// //                     color: newTextPrimary),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // home_view_new.dart
// // FIX: Removed all references to `newMenuId` global list.
// //      MenuDefaultController.initMenu() now handles the stack internally.
// //      No other logic changed.
//
// import 'package:digitalerp/Menu_new_list_responce.dart';
// import 'package:digitalerp/homeview_new_controller.dart';
// import 'package:digitalerp/new_menu_defalut_screen.dart';
// import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
// import 'package:digitalerp/utils/app_constant_new.dart';
// import 'package:digitalerp/utils/app_profile_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomeViewNew extends StatefulWidget {
//   const HomeViewNew({Key? key}) : super(key: key);
//
//   @override
//   State<HomeViewNew> createState() => _HomeViewNewState();
// }
//
// class _HomeViewNewState extends State<HomeViewNew> with WidgetsBindingObserver {
//   late HomeViewNewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     controller = Get.find<HomeViewNewController>();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       controller.getUnApprovalCount();
//       controller.getNewMenuList(0);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeViewNewController>(
//       builder: (ctrl) => Scaffold(
//         backgroundColor: const Color(0xFFF4F6FB),
//         appBar: _buildAppBar(ctrl),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 14),
//             _profileBanner(ctrl),
//             const SizedBox(height: 20),
//             _quickLinksButton(ctrl),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _buildAppBar(HomeViewNewController ctrl) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//       titleSpacing: 16,
//       title: const Text(
//         'Admin',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w700,
//           color: newTextPrimary,
//         ),
//       ),
//       leading: GestureDetector(
//         onTap: () => ctrl.openDrawer(context),
//         child: const Padding(
//           padding: EdgeInsets.all(12),
//           child: Icon(Icons.menu_rounded, color: newTextPrimary),
//         ),
//       ),
//       actions: [
//         GestureDetector(
//           onTap: () => Get.to(const ApprovalList()),
//           child: Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   width: 38,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     color: newBlueLightColor,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.approval_outlined,
//                     size: 20,
//                     color: newBlueColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _profileBanner(HomeViewNewController ctrl) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
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
//             size: 50,
//             imageUrl: ctrl.homeController.currentUserData?.photo ?? '',
//           ),
//           const SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   ctrl.homeController.currentUserData?.name ?? 'User',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   ctrl.homeController.currentUserData?.usertype ?? '',
//                   style:
//                   const TextStyle(fontSize: 13, color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _quickLinksButton(HomeViewNewController ctrl) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GestureDetector(
//         onTap: () => _openQuickLinksSheet(ctrl),
//         child: Container(
//           padding:
//           const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.06),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: newBlueLightColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.grid_view_rounded,
//                   color: newBlueColor,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 14),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Quick Links',
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: newTextPrimary,
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     Text(
//                       'Access all your modules',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: newTextSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(
//                 Icons.keyboard_arrow_up_rounded,
//                 color: newTextSecondary,
//                 size: 22,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _openQuickLinksSheet(HomeViewNewController ctrl) {
//     showModalBottomSheet(
//       context: Get.context!,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) {
//         return Container(
//           height: Get.height * 0.88,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//           ),
//           child: Column(
//             children: [
//               // Drag handle
//               const SizedBox(height: 10),
//               Container(
//                 height: 4,
//                 width: 44,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               const SizedBox(height: 14),
//
//               // Header row
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 38,
//                       height: 38,
//                       decoration: BoxDecoration(
//                         color: newBlueLightColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.grid_view_rounded,
//                         color: newBlueColor,
//                         size: 18,
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         'Quick Links',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                           color: newTextPrimary,
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Get.back(),
//                       child: Container(
//                         height: 36,
//                         width: 36,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(
//                           Icons.close_rounded,
//                           size: 18,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 14),
//               Divider(height: 1, color: Colors.grey.shade100),
//
//               // Grid
//               Expanded(
//                 child: ctrl.isListLoading
//                     ? const Center(
//                   child: CircularProgressIndicator(
//                       color: newBlueColor),
//                 )
//                     : ctrl.menuListData.isEmpty
//                     ? Center(
//                   child: Text(
//                     'No menu items found',
//                     style:
//                     TextStyle(color: Colors.grey.shade500),
//                   ),
//                 )
//                     : GridView.builder(
//                   padding: const EdgeInsets.fromLTRB(
//                       16, 16, 16, 30),
//                   itemCount: ctrl.menuListData.length,
//                   gridDelegate:
//                   const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 1.0,
//                   ),
//                   itemBuilder: (_, i) =>
//                       _menuTile(ctrl.menuListData[i], ctrl),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _menuTile(MenuNewData data, HomeViewNewController ctrl) {
//     return GestureDetector(
//       onTap: () {
//         Get.back(); // close bottom sheet before navigating
//         if (data.child == 1) {
//           // ✅ FIXED: `newMenuId` global removed.
//           // MenuDefaultScreen calls controller.initMenu() internally on open.
//           Get.to(() => MenuDefaultScreen(menuID: data.menuid!));
//         } else {
//           Get.toNamed(HomeViewNewController.getRouteNameById(data.menuid));
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: newBorderColor),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.05),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: newBlueLightColor,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Image.asset(
//                   ctrl.imageList()[data.menuname] ?? '',
//                   errorBuilder: (_, __, ___) => const Icon(
//                     Icons.grid_view_rounded,
//                     color: newBlueColor,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6),
//               child: Text(
//                 data.menuname ?? '',
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w600,
//                   color: newTextPrimary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// home_view_new.dart
// 
// Only change from last version: MenuDefaultScreen now receives `title`
// so the loading screen (if briefly visible) shows the correct group name.
// 

import 'package:digitalerp/Menu_new_list_responce.dart';
import 'package:digitalerp/homeview_new_controller.dart';
import 'package:digitalerp/new_menu_defalut_screen.dart';
import 'package:digitalerp/screen/ui/home/approval/approval_list/approval_list_Screen.dart';
import 'package:digitalerp/screen/ui/home/approval_management/approval_hub_screens/approval_hub_dashboard.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_routes/app_routes.dart';

class HomeViewNew extends StatefulWidget {
  const HomeViewNew({Key? key}) : super(key: key);

  @override
  State<HomeViewNew> createState() => _HomeViewNewState();
}

class _HomeViewNewState extends State<HomeViewNew> with WidgetsBindingObserver {
  late HomeViewNewController controller;
  bool _isOpeningExternalFile = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = Get.find<HomeViewNewController>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.getUnApprovalCount();
      controller.getNewMenuList(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewNewController>(
      builder: (ctrl) => Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        appBar: _buildAppBar(ctrl),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            _profileBanner(ctrl),
            const SizedBox(height: 20),
            _quickLinksButton(ctrl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(HomeViewNewController ctrl) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: Text(
        ctrl.homeController.currentUserData?.usertype ?? 'Home',
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: newTextPrimary),
      ),
      leading: GestureDetector(
        onTap: () => ctrl.openDrawer(context),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.menu_rounded, color: newTextPrimary),
        ),
      ),
      // actions: [
      //   GestureDetector(
      //     onTap: () => Get.to(const ApprovalHubDashboard()),
      //     child: Padding(
      //       padding: const EdgeInsets.only(right: 16),
      //       child: Container(
      //         width: 38,
      //         height: 38,
      //         decoration: BoxDecoration(
      //             color: newBlueLightColor,
      //             borderRadius: BorderRadius.circular(10)),
      //         child: const Icon(Icons.approval_outlined,
      //             size: 20, color: newBlueColor),
      //       ),
      //     ),
      //   ),
      // ],
    );
  }

  Widget _profileBanner(HomeViewNewController ctrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
            size: 50,
            imageUrl: ctrl.homeController.currentUserData?.photo ?? '',
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ctrl.homeController.currentUserData?.name ?? 'User',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  ctrl.homeController.currentUserData?.usertype ?? '',
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickLinksButton(HomeViewNewController ctrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => _openQuickLinksSheet(ctrl),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: newBlueLightColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.grid_view_rounded,
                    color: newBlueColor, size: 20),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quick Links',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: newTextPrimary)),
                    SizedBox(height: 2),
                    Text('Access all your modules',
                        style:
                            TextStyle(fontSize: 12, color: newTextSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_up_rounded,
                  color: newTextSecondary, size: 22),
            ],
          ),
        ),
      ),
    );
  }

  void _openQuickLinksSheet(HomeViewNewController ctrl) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: Get.height * 0.88,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 4,
              width: 44,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                        color: newBlueLightColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.grid_view_rounded,
                        color: newBlueColor, size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text('Quick Links',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: newTextPrimary)),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(Icons.close_rounded,
                          size: 18, color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Divider(height: 1, color: Colors.grey.shade100),
            Expanded(
              child: ctrl.isListLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: newBlueColor))
                  : ctrl.menuListData.isEmpty
                      ? Center(
                          child: Text('No menu items found',
                              style: TextStyle(color: Colors.grey.shade500)))
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                          itemCount: ctrl.menuListData.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.0,
                          ),
                          itemBuilder: (_, i) =>
                              _menuTile(ctrl.menuListData[i], ctrl),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuTile(MenuNewData data, HomeViewNewController ctrl) {
    return GestureDetector(
      onTap: () {
        Get.back(); // close sheet

        // ✅ Intercept known menu IDs before the child==1 check
        final route = _getDirectRoute(data.menuid);
        if (route != null) {
          Get.toNamed(route);
          return;
        }

        if (data.child == 1) {
          Get.to(() => MenuDefaultScreen(
            menuID: data.menuid!,
            title: data.menuname ?? 'Menu',
          ));
        } else {
          Get.toNamed(HomeViewNewController.getRouteNameById(data.menuid));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: newBorderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 6,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: newBlueLightColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  ctrl.imageList()[data.menuname] ?? '',
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.grid_view_rounded,
                      color: newBlueColor,
                      size: 24),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                data.menuname ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: newTextPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _getDirectRoute(int? menuId) {
    const directRoutes = {
      2384: AppRoutes.approvalHub,
      2385: AppRoutes.taskManagement,
      2754: AppRoutes.mrnScreen,
      2701: AppRoutes.reimbursement,
      2586: AppRoutes.paymentRequestListScreen,
    };
    return menuId != null ? directRoutes[menuId] : null;
  }
}
