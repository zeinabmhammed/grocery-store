import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: responsive.scaleHeight(isLandscape ? 25 : 12),
      width: isActive
          ? responsive.scaleWidth(isLandscape ? 11 : 15)
          : responsive.scaleWidth(isLandscape ? 8 : 10),
      margin: EdgeInsets.only(right: responsive.scaleWidth(isLandscape ? 6 : 8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
        border: Border.all(color: AppColors.green),
        color: isActive ? AppColors.green : AppColors.white,
      ),
    );
  }
}