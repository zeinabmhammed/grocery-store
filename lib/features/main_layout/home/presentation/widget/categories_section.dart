import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(16),
        vertical: responsive.scaleHeight(isLandscape ? 30 : 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: responsive.scaleHeight(10)),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildCategoryItem(
                  AppAssets.restaurant,
                  responsive,
                  isLandscape,
                ),
                SizedBox(width: responsive.scaleWidth(13)),
                _buildCategoryItem(AppAssets.farm, responsive, isLandscape),
                SizedBox(width: responsive.scaleWidth(12)),
                _buildCategoryItem(AppAssets.coffee, responsive, isLandscape),
                SizedBox(width: responsive.scaleWidth(12)),
                _buildCategoryItem(AppAssets.pharmacy, responsive, isLandscape),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(
      String asset,
      Responsive responsive,
      bool isLandscape,
      ) {
    double boxWidth = responsive.scaleWidth(isLandscape ? 75 : 80);
    double boxHeight = responsive.scaleHeight(isLandscape ? 310 : 85);

    return Container(
      width: boxWidth,
      height: boxHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: responsive.scaleWidth(8),
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
        child: Padding(
          padding: EdgeInsets.all(responsive.scaleWidth(10)),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
