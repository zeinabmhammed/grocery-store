import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class OrderInfoSection extends StatelessWidget {
  const OrderInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Column(
      children: [
        Text(
          "Your Order Code: #882610",
          style: TextStyle(
            fontSize: responsive.scaleWidth(16),
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: responsive.scaleHeight(5)),
        Text(
          "3 items - 37.50 KD",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: responsive.scaleWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(5)),
        Text(
          "Payment Method : Cash",
          style: TextStyle(
            fontSize: responsive.scaleWidth(16),
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
