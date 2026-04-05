import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? iconPath;
  final Color? iconColor;
  final Color? color;
  final Color? textColor;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? iconSize;

  const CustomButton({
    super.key,
    required this.text,
    this.iconPath,
    this.color,
    this.textColor,
    required this.onTap,
    this.iconColor,
    this.width,
    this.height,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? responsive.scaleHeight(isLandscape ? 160 : 55),
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null && iconPath!.isNotEmpty) ...[
              SvgPicture.asset(
                iconPath!,
                height: iconSize ?? responsive.scaleHeight(isLandscape ? 55 : 20),
                colorFilter: iconColor != null
                    ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                    : null,
              ),
              SizedBox(width: responsive.scaleWidth(8)),
            ],
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: responsive.scaleWidth(isLandscape ? 12 : 17),
                fontWeight: FontWeight.bold,
                color: textColor ?? const Color(0xFF242729),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}