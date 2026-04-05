import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomListCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomListCard({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: responsive.scaleHeight(isLandscape ? 360 : 105),
        margin: EdgeInsets.symmetric(
          vertical: responsive.scaleHeight(isLandscape ? 10 : 8),
          horizontal: responsive.scaleWidth(3),
        ),
        padding: EdgeInsets.all(responsive.scaleWidth(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsive.scaleWidth(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: responsive.scaleWidth(5),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: responsive.scaleWidth(isLandscape ? 50 : 80),
              height: responsive.scaleWidth(isLandscape ? 50 : 80),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(responsive.scaleWidth(50)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(responsive.scaleWidth(50)),
                child: leading,
              ),
            ),
            SizedBox(width: responsive.scaleWidth(5)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.scaleWidth(isLandscape ? 9 : 14),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(
                      height: responsive.scaleHeight(isLandscape ? 2 : 5),
                    ),
                    Flexible(child: subtitle!),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
