import 'package:digitalerp/utils/app_assets.dart';
import 'package:digitalerp/utils/app_constant_new.dart';
import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? icon;
  final Color? topColor, bottomColor, shadowColor;
  final double? vPadding, hPadding, radius, iconSize, shadowRadius;

  const GradientIconButton(
      {Key? key,
      required this.onPressed,
      this.icon,
      this.topColor,
      this.bottomColor,
      this.hPadding,
      this.vPadding,
      this.radius,
      this.iconSize,
      this.shadowRadius,
      this.shadowColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: purpleColor,
      shape: CircleBorder(side: BorderSide(color: Colors.white, width: 2)),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}
