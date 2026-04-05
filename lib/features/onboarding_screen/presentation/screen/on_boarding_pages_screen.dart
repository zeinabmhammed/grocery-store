import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/onboarding_screen/presentation/widget/on_boarding_model.dart';

class OnBoardingPages extends StatelessWidget {
  final OnBoardingData data;

  const OnBoardingPages({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      children: [
        SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 70)),

        Image.asset(
          data.image,
          height: responsive.height * (isLandscape ? 0.30: 0.30),
          fit: BoxFit.cover,
        ),

        SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 24)),

        Text(
          data.title,
          style: GoogleFonts.poppins(
            fontSize: responsive.isTablet
                ? responsive.scaleWidth(isLandscape ? 10 : 26)
                : responsive.scaleWidth(isLandscape ? 18 : 22),
            fontWeight: FontWeight.bold,
            color: AppColors.darkPurple,
          ),
        ),

        SizedBox(height: responsive.scaleHeight(isLandscape ? 0 : 10)),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.scaleWidth(isLandscape ? 80 : 10),
          ),
          child: Text(
            data.subTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: responsive.isTablet
                  ? responsive.scaleWidth(isLandscape ? 10 : 20)
                  : responsive.scaleWidth(isLandscape ? 14 : 17),
              color: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }
}