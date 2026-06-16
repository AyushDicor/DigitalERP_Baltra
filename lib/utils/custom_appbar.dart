import 'package:flutter/material.dart';

import 'app_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final IconData? icon;
  final Widget? leading;
  final VoidCallback? onPressed;

  const CustomAppBar({
    Key? key,
    this.title,
    this.icon,
    this.leading,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: title,
      leading: leading ??
          AppBackButton(
            icon: icon,
            onPressed: onPressed ?? onPressed,
          ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
