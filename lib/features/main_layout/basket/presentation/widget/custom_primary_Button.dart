import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return SizedBox(
      width: responsive.scaleWidth(isLandscape ? 347 : 347),
      height: responsive.scaleHeight(isLandscape ? 150 : 50),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D5E42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 18),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}