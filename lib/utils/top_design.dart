import 'package:digitalerp/utils/app_constant.dart';
import 'package:digitalerp/utils/wave_clipper.dart';
import 'package:flutter/material.dart';

class TopDesign extends StatelessWidget {
  const TopDesign({
    Key? key,
    required this.child,
    required this.appBar,
    this.topDesignHeight = 125,
    this.topDesignRadius = 50,
    this.paddingForChild = 30,
    this.isResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final Widget child;
  final Widget appBar;
  final double topDesignHeight;
  final double topDesignRadius;
  final double paddingForChild;
  final bool isResizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    double safeArea = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: isResizeToAvoidBottomInset,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              height: (topDesignHeight + safeArea),
              child: ClipPath(
                clipper: WaveClipper(
                  radius: 50,
                  height: topDesignHeight,
                ),
                child: Container(
                  height: topDesignHeight,
                  color: purpleColor,
                  child: SafeArea(
                    child: appBar,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              top: ((topDesignHeight - topDesignRadius) + paddingForChild),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
