import 'package:flutter/material.dart';

class Responsive {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  // Screen Width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Device Types
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= mobileBreakpoint &&
        screenWidth(context) < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return screenWidth(context) >= desktopBreakpoint;
  }
}