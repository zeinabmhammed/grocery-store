import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class PaymentMethodTile extends StatefulWidget {
  final String title;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<PaymentMethodTile> createState() => _PaymentMethodTileState();
}

class _PaymentMethodTileState extends State<PaymentMethodTile> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(top: responsive.scaleHeight(10)),
        padding: EdgeInsets.all(responsive.scaleWidth(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: responsive.scaleWidth(10),
            ),
          ],
        ),
        child: Row(
          children: [
            widget.icon,
            SizedBox(width: responsive.scaleWidth(10)),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: responsive.scaleWidth(16),
                  fontWeight: widget.isSelected
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              widget.isSelected ? Icons.check_circle : Icons.circle_outlined,
              size: responsive.scaleWidth(22),
              color: AppColors.green,
            ),
          ],
        ),
      ),
    );
  }
}
