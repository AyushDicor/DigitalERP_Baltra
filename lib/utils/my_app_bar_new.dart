import 'package:digitalerp/screen/ui/home/home_controller.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Lightweight white app-bar that matches the Figma design.
/// All icon callbacks are optional — pass what you need.
class MyAppBar extends StatelessWidget {
  final HomeController? homeController = Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : null;

  final String title;
  final dynamic unApproval;
  final VoidCallback? onDrawerTap;
  final VoidCallback? onBackTap;
  final VoidCallback? onFilterTap;
  final VoidCallback? onResetTap;
  final VoidCallback? onCartTap;
  final bool? showCartIcon;
  final Widget? deFaultIcon;
  final bool? showApprovalIcon;
  final VoidCallback? defaultTap;

  MyAppBar({
    Key? key,
    this.unApproval,
    required this.title,
    this.onDrawerTap,
    this.onBackTap,
    this.onFilterTap,
    this.onCartTap,
    this.showCartIcon,
    this.showApprovalIcon,
    this.deFaultIcon,
    this.defaultTap,
    this.onResetTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Leading: back or drawer
            _IconBtn(
              onTap: onDrawerTap ?? onBackTap,
              child: onDrawerTap != null
                  ? Icon(Icons.menu_rounded, size: 22, color: newTextPrimary)
                  : Icon(Icons.arrow_back_ios_new_rounded,
                  size: 20, color: newTextPrimary),
            ),
            const SizedBox(width: 8),

            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: newTextPrimary,
                ),
              ),
            ),

            // Reset
            if (onResetTap != null) ...[
              _IconBtn(
                onTap: onResetTap,
                child: const Icon(Icons.refresh_rounded, size: 22, color: newTextSecondary),
              ),
              const SizedBox(width: 4),
            ],

            // Filter
            if (onFilterTap != null) ...[
              _IconBtn(
                onTap: onFilterTap,
                hasBg: true,
                child: const Icon(Icons.filter_list_sharp, size: 20, color: purpleColor),
              ),
              const SizedBox(width: 4),
            ],

            // Cart
            if (showCartIcon ?? false) ...[
              Obx(() => _IconBtn(
                onTap: onCartTap ?? () {},
                hasBg: true,
                child: Badge(
                  isLabelVisible: (homeController?.itemInCart.value ?? 0) > 0,
                  label: Text(
                    (homeController?.itemInCart.value ?? 0).toString(),
                    style: const TextStyle(fontSize: 9),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined,
                      size: 20, color: purpleColor),
                ),
              )),
              const SizedBox(width: 4),
            ],

            // Approval badge
            if (showApprovalIcon ?? false) ...[
              _IconBtn(
                onTap: defaultTap ?? () {},
                hasBg: true,
                child: Badge(
                  label: Text(unApproval?.toString() ?? '0',
                      style: const TextStyle(fontSize: 9)),
                  child: const Icon(Icons.check_circle_outline_rounded,
                      size: 20, color: newBlueColor),
                ),
              ),
            ],

            // Default icon slot
            if (deFaultIcon != null) deFaultIcon!,
          ],
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool hasBg;

  const _IconBtn({required this.child, this.onTap, this.hasBg = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: hasBg
            ? BoxDecoration(
          color: purpleLightest,
          borderRadius: BorderRadius.circular(18),
        )
            : null,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

/// Legacy myAppBar function (used in a few old screens — forwards to MyAppBar)
Widget myAppBar({
  required String title,
  VoidCallback? onBackTap,
  VoidCallback? onFilterTap,
}) =>
    MyAppBar(title: title, onBackTap: onBackTap, onFilterTap: onFilterTap);

/// Alias kept for backwards compat
class MyAppBarNew extends MyAppBar {
  MyAppBarNew({
    Key? key,
    required String title,
    VoidCallback? onDrawerTap,
    VoidCallback? onBackTap,
    VoidCallback? onFilterTap,
    VoidCallback? onCartTap,
    bool? showCartIcon,
    bool? showApprovalIcon,
    VoidCallback? defaultTap,
    VoidCallback? onResetTap,
    dynamic unApproval,
  }) : super(
    key: key,
    title: title,
    onDrawerTap: onDrawerTap,
    onBackTap: onBackTap,
    onFilterTap: onFilterTap,
    onCartTap: onCartTap,
    showCartIcon: showCartIcon,
    showApprovalIcon: showApprovalIcon,
    defaultTap: defaultTap,
    onResetTap: onResetTap,
    unApproval: unApproval,
  );
}
