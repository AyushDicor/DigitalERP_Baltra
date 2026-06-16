import 'package:flutter/material.dart';

class SafeAreaWrapper extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const SafeAreaWrapper({
    Key? key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}

class BottomSafeWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? additionalPadding;

  const BottomSafeWrapper({
    Key? key,
    required this.child,
    this.additionalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final padding = additionalPadding ?? EdgeInsets.zero;

    return Padding(
      padding: EdgeInsets.only(
        top: padding.top,
        left: padding.left,
        right: padding.right,
        bottom: bottomPadding + padding.bottom,
      ),
      child: child,
    );
  }
}
