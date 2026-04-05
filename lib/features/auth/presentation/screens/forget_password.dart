import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import 'package:greengrocer/core/resources/widget/custom_phone_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
        _buildHeader(responsive, false),
        SizedBox(height: responsive.scaleHeight(40)),
        const CustomPhoneField(),
        SizedBox(height: responsive.scaleHeight(48)),
        _buildSubmitButton(context),
        SizedBox(height: responsive.scaleHeight(20)),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Responsive responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: _buildHeader(responsive, true),
        ),

        const SizedBox(width: 40),

        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomPhoneField(),
              SizedBox(height: responsive.scaleHeight(20)),
              _buildSubmitButton(context),
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
            fontSize: responsive.scaleWidth(isLandscape ? 18 : 42),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        Text(
          "Enter your Number",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 28),
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CustomButton(
      text: "Submit",
      onTap: () {
        Navigator.pushNamed(context, "/otp");
      },
      color: AppColors.green,
      textColor: AppColors.white,
    );
  }
}