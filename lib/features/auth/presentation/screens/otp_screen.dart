import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import 'package:greengrocer/features/auth/presentation/widgets/otp_input.dart';
import 'package:greengrocer/features/auth/presentation/widgets/otp_timer.dart';


class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: isLandscape? 10: 50,
              left: isLandscape? 15: 36,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: responsive.scaleWidth(isLandscape ? 18 : 28),
                  color: AppColors.black,
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(30),
                  vertical: 20,
                ),
                child: isLandscape
                    ? _buildLandscapeLayout(context, responsive)
                    : _buildPortraitLayout(context, responsive),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, Responsive responsive) {
    return Column(
      children: [
        SizedBox(height: responsive.scaleHeight(40)),
        _buildHeader(responsive, false),
        SizedBox(height: responsive.scaleHeight(50)),
        const OtpInput(),
        SizedBox(height: responsive.scaleHeight(40)),
        CustomButton(
          text: "Confirm",
          onTap: () {},
          color: AppColors.green,
          textColor: AppColors.white,
        ),
        SizedBox(height: responsive.scaleHeight(40)),
        const OtpTimer(),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Responsive responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(responsive, true),
            ],
          ),
        ),

        const SizedBox(width: 30),

        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const OtpInput(),
              const SizedBox(height: 30),
              CustomButton(
                text: "Confirm",
                onTap: () {},
                color: AppColors.green,
                textColor: AppColors.white,
              ),
              const SizedBox(height: 20),
              const OtpTimer(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Text(
          "Fruit Market",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 18 : 40),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        Text(
          "Enter Received OTP",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 24),
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}