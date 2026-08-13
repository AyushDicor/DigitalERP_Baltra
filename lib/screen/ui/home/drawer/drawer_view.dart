// import 'package:digitalerp/screen/ui/home/drawer/drawer_controller.dart';
// import 'package:digitalerp/utils/app_assets.dart';
// import 'package:digitalerp/utils/app_constant.dart';
// import 'package:digitalerp/utils/app_profile_image.dart';
// import 'package:digitalerp/utils/dottedline.dart';
// import 'package:flutter/material.dart';
// import 'package:digitalerp/screen/base/base_controller.dart';
// import 'package:get/get.dart';
//
// class DrawerView extends StatelessWidget {
//   const DrawerView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AppDrawerController>(
//       init: AppDrawerController(),
//       builder: (controller) => Container(
//         width: Get.width * .72,
//         color: Colors.white, // clean corporate look
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: Row(
//                   children: [
//                     ProfileImageView(
//                       size: 48, // reduced size
//                       imageUrl:
//                           controller.homeController.currentUserData?.photo ??
//                               '',
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             controller.homeController.currentUserData?.name ??
//                                 '',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF111827),
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             controller
//                                     .homeController.currentUserData?.usertype ??
//                                 '',
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: Color(0xFF6B7280),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 height: 1,
//                 color: const Color(0xFFE5E7EB),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // SECTION TITLE
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         child: Text(
//                           "GENERAL",
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF9CA3AF),
//                             letterSpacing: 1,
//                           ),
//                         ),
//                       ),
//
//                       if (controller.homeController.isCustomer == false)
//                         _drawerOption(
//                           icon: Icons.person_outline,
//                           name: 'Profile',
//                           function: () => controller.tapOnUser(context),
//                         ),
//
//                       _drawerOption(
//                         icon: Icons.business_outlined,
//                         name: 'Change Company',
//                         function: () => controller.tapOnChangeCompany(context),
//                       ),
//
//                       const Spacer(),
//
//                       // LOGOUT SECTION
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         child: Text(
//                           "ACCOUNT",
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF9CA3AF),
//                             letterSpacing: 1,
//                           ),
//                         ),
//                       ),
//
//                       _drawerOption(
//                         icon: Icons.logout,
//                         name: 'Sign out',
//                         function: () => _showDialog(controller),
//                         isDanger: true,
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _drawerOption({
//     required IconData icon,
//     required String name,
//     required VoidCallback function,
//     bool isDanger = false,
//     bool isSelected = false, // 👈 NEW
//   }) {
//     final activeColor = const Color(0xFF2563EB);
//
//     return InkWell(
//       onTap: function,
//       borderRadius: BorderRadius.circular(10),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? activeColor.withValues(alpha:0.08) // 👈 soft highlight
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             // 🔵 Left indicator (very subtle but premium)
//             Container(
//               width: 3,
//               height: 20,
//               margin: const EdgeInsets.only(right: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? activeColor : Colors.transparent,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//
//             // 🔹 Icon
//             Icon(
//               icon,
//               size: 20,
//               color: isDanger
//                   ? Colors.red
//                   : isSelected
//                       ? activeColor
//                       : const Color(0xFF6B7280),
//             ),
//
//             const SizedBox(width: 12),
//
//             // 🔹 Text
//             Text(
//               name,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 color: isDanger
//                     ? Colors.red
//                     : isSelected
//                         ? activeColor
//                         : const Color(0xFF111827),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDialog(AppDrawerController controller) {
//     Get.defaultDialog(
//       title: 'Sign out',
//       backgroundColor: Colors.white,
//       radius: 12,
//       textCancel: 'Cancel',
//       textConfirm: 'Sign out',
//       middleText: 'Are you sure want to Sign out ?',
//       buttonColor: purpleColor,
//       confirmTextColor: Colors.white,
//       cancelTextColor: purpleColor,
//       onConfirm: () async {
//         Get.back();
//         controller.logout();
//       },
//       onCancel: () {
//         Get.back();
//       },
//     );
//   }
// }
import 'package:digitalerp/screen/ui/home/drawer/drawer_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:digitalerp/utils/app_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppDrawerController>(
      init: AppDrawerController(),
      builder: (controller) {
        final user = controller.homeController.currentUserData;
        return Container(
          width: Get.width * 0.76,
          color: whiteColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Header 
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Row(
                    children: [
                      ProfileImageView(size: 44, imageUrl: user?.photo ?? ''),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: newTextPrimary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text(user?.usertype ?? '',
                                style: const TextStyle(
                                    fontSize: 11, color: newTextSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: newBorderColor),

                //  Nav 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SectionLabel('GENERAL'),
                      if (controller.homeController.isCustomer == false)
                        _NavTile(
                          icon: Icons.person_outline_rounded,
                          label: 'Profile',
                          onTap: () => controller.tapOnUser(context),
                        ),
                      _NavTile(
                        icon: Icons.business_outlined,
                        label: 'Change Company',
                        onTap: () => controller.tapOnChangeCompany(context),
                      ),
                      const Spacer(),
                      const _SectionLabel('ACCOUNT'),
                      _NavTile(
                        icon: Icons.logout_rounded,
                        label: 'Sign out',
                        isDanger: true,
                        onTap: () => _showSignOutDialog(controller),
                      ),
                      const SizedBox(height: 12),
                      //  Version 
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: lightGreyColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('Baltra  ·  v1.0.0',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: newTextHint,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSignOutDialog(AppDrawerController controller) {
    Get.defaultDialog(
      title: 'Sign out',
      backgroundColor: const Color(0xFFF5F6FA),
      radius: 12,
      textCancel: 'Cancel',
      textConfirm: 'Sign out',
      middleText: 'Are you sure you want to sign out?',
      buttonColor: newBlueColor,
      confirmTextColor: whiteColor,
      cancelTextColor: newBlueColor,
      onConfirm: () async {
        Get.back();
        controller.logout();
      },
      onCancel: () => Get.back(),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
        child: Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: newTextHint,
                letterSpacing: 1.2)),
      );
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDanger;
  const _NavTile(
      {required this.icon,
      required this.label,
      required this.onTap,
      this.isDanger = false});

  @override
  Widget build(BuildContext context) {
    final Color fg = isDanger ? newRedColor : newTextPrimary;
    final Color iconBg = isDanger ? newRedLightColor : lightGreyColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon,
                    size: 16, color: isDanger ? newRedColor : newTextSecondary),
              ),
              const SizedBox(width: 12),
              Text(label,
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: fg)),
            ],
          ),
        ),
      ),
    );
  }
}
