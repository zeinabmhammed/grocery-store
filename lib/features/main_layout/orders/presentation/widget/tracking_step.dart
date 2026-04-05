import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';


class TrackingStep extends StatelessWidget {
  final String title, subtitle;
  final bool isCompleted;
  final bool isLast;

  const TrackingStep({
    super.key,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.check_circle,
                size: responsive.scaleWidth(24),
                color: isCompleted ? const Color(0xFF2D5E42) : Colors.grey[300],
              ),
              if (!isLast)
                Expanded(
                  child: VerticalDivider(
                    thickness: responsive.scaleWidth(2),
                    color: isCompleted ? const Color(0xFF2D5E42) : Colors.grey[300],
                  ),
                ),
            ],
          ),
          SizedBox(width: responsive.scaleWidth(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(20),
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? const Color(0xff292727) : Colors.grey,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(16),
                    color: const Color(0xff656565),
                  ),
                ),
                SizedBox(height: responsive.scaleHeight(20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
