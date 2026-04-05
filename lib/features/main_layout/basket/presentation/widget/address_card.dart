import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class AddressCard extends StatelessWidget {
  final String title, subtitle, info;
  final bool isSelected;
  const AddressCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      padding: EdgeInsets.all(responsive.scaleWidth(15)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: responsive.scaleWidth(20),
            color: Colors.grey,
          ),
          SizedBox(width: responsive.scaleWidth(5)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(16),
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(16),
                    color: const Color(0xff4A4A4A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  info,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(14),
                    color: const Color(0xff9F9F9F),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            size: responsive.scaleWidth(22),
            color: const Color(0xFF2D5E42),
          ),
        ],
      ),
    );
  }
}
