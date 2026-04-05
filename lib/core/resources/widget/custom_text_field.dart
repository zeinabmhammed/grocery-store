import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(isLandscape ? 55 : 30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 12 : 16),
              color: const Color(0xff858D9A),
            ),
          ),
          SizedBox(height: responsive.scaleHeight(isLandscape ? 5 : 10)),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: responsive.scaleWidth(6),
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              style: TextStyle(
                fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(16),
                  vertical: responsive.scaleHeight(isLandscape ? 15 : 12),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}