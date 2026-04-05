import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  Size get size => MediaQuery.of(context).size;
  double get width => size.width;
  double get height => size.height;

  Orientation get orientation => MediaQuery.of(context).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  double scaleWidth(double value) => value * (width / 375);
  double scaleHeight(double value) => value * (height / 812);

  int getGridCount({
    int mobilePortrait = 2,
    int mobileLandscape = 3,
    int tablet = 4,
    int desktop = 6,
  }) {
    if (isMobile) return isPortrait ? mobilePortrait : mobileLandscape;
    if (isTablet) return tablet;
    return desktop;
  }

  double gridAspectRatio() {
    double baseRatio = 191 / 279;
    if (isMobile) return isPortrait ? baseRatio * 0.95 : baseRatio * 1.1;
    if (isTablet) return baseRatio * 1.05;
    return baseRatio * 1.15;
  }

  double scaledCardWidth(double baseWidth) => scaleWidth(baseWidth);
  double scaledCardHeight(double baseHeight) => scaleHeight(baseHeight);
}
