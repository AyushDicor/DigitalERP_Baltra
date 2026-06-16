import 'package:flutter/material.dart';

/// Clip widget in wave shape shape
class WaveClipper extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  /// flip the wave direction horizontal axis
  bool flip;

  /// Wave circle by default 40
  double radius;

  double height;

  WaveClipper({this.reverse = false, this.flip = false, this.radius = 40, this.height = 120});

  @override
  Path getClip(Size size) {
    /// old way
    // double sizeHeight=size.height;
    double sizeHeight = height;
    Offset firstEndPoint = Offset(radius, sizeHeight - radius);
    Offset firstControlPoint = Offset(0, sizeHeight - radius);
    Offset flatLineEndPoint = Offset(size.width - radius, sizeHeight - radius);
    Offset flatLineControlPoint = Offset(size.width * .5, sizeHeight - radius);
    Offset secondEndPoint = Offset(size.width, sizeHeight - (radius * 2));
    Offset secondControlPoint = Offset(size.width, sizeHeight - radius);

    final path = Path()
      ..lineTo(0.0, sizeHeight)
      ..quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy)
      ..quadraticBezierTo(flatLineControlPoint.dx, flatLineControlPoint.dy, flatLineEndPoint.dx, flatLineEndPoint.dy)
      ..quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy)
      ..lineTo(size.width, 0.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
