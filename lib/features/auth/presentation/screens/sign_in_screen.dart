import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import 'package:greengrocer/core/resources/widget/custom_form_field.dart';
import 'package:greengrocer/core/resources/widget/custom_phone_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
              top: isLandscape? 35: 50,
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
        SizedBox(height: responsive.scaleHeight(40)),
        _buildForm(context, responsive, false),
        SizedBox(height: responsive.scaleHeight(35)),
        _buildFooter(context, responsive, false),
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

        const SizedBox(width: 30),

        Expanded(
          flex: 3,
          child: Column(
            children: [
              _buildForm(context, responsive, true),
              const SizedBox(height: 20),
              _buildFooter(context, responsive, true),
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
            fontSize: responsive.scaleWidth(isLandscape ? 15 : 40),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        Text(
          "Login to Wikala",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 28),
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, Responsive responsive, bool isLandscape) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomPhoneField(),
        SizedBox(height: responsive.scaleHeight(15)),
        Text(
          "Password",
          style: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 11 : 14),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF858D9A),
          ),
        ),
        CustomFormField(
          hintText: "Enter your password",
          isPassword: true,
          controller: TextEditingController(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pushNamed(context, "/forgetPassword"),
            child: Text(
              "Forget Password?",
              style: TextStyle(
                color: const Color(0xFF004D8E),
                fontSize: responsive.scaleWidth(isLandscape ? 11 : 16),
              ),
            ),
          ),
        ),
        SizedBox(height: isLandscape ? 10 : 20),
        CustomButton(
          text: " Login ",
          onTap: () => Navigator.pushNamed(context, "/mainLayout"),
          color: AppColors.green,
          textColor: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, Responsive responsive, bool isLandscape) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: responsive.scaleWidth(isLandscape ? 12 : 18)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/signUp"),
          child: Text(
            "Sign up",
            style: TextStyle(
              color: const Color(0xFF004D8E),
              fontSize: responsive.scaleWidth(isLandscape ? 12 : 18),
            ),
          ),
        ),
      ],
    );
  }
}