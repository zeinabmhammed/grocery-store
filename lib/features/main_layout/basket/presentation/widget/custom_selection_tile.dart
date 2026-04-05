import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomSelectionTile extends StatelessWidget {
  final String title;

  const CustomSelectionTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(20),
        vertical: responsive.scaleHeight(isLandscape ? 30 : 15),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(responsive.scaleWidth(15)),
        color: AppColors.white.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 14 : 16),
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.circle_outlined,
            size: responsive.scaleWidth(isLandscape ? 18 : 22),
            color: AppColors.green,
          ),
        ],
      ),
    );
  }
}
