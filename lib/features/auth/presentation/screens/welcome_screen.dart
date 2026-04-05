import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 20 : responsive.scaleWidth(30),
                  vertical: isLandscape?10: 20,
                ),
                child: isLandscape
                    ? _buildLandscapeLayout(context, responsive)
                    : _buildPortraitLayout(context, responsive),
              ),
            ),

            Positioned(
              top:  isLandscape? 20 : 50,
              left: isLandscape? 10 : 36,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                iconSize: responsive.scaleWidth(isLandscape ? 15 : 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, Responsive responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: responsive.scaleHeight(50)),
        _buildHeader(responsive, false),
        SizedBox(height: responsive.scaleHeight(52)),
        _buildLoginButtons(responsive, false),
        SizedBox(height: responsive.scaleHeight(40)),
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

        const SizedBox(width: 40),

        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildLoginButtons(responsive, true),
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
          "Welcome to Our app",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 14 : 28),
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButtons(Responsive responsive, bool isLandscape) {
    double spacing = isLandscape ? 15 : 21;
    return Column(
      children: [
        CustomButton(
            text: "Sign in with Phone Number",
            iconPath: AppAssets.phoneIcon,
            onTap: () {}),
        SizedBox(height: spacing),
        CustomButton(text: "Sign in with Google", iconPath: AppAssets.googleIcon, onTap: () {}),
        SizedBox(height: spacing),
        CustomButton(
            text: "Sign in with Facebook",
            color: const Color(0xFF4267B2),
            iconPath: AppAssets.facebookIcon,
            textColor: Colors.white, onTap: () {}),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already member? ", style: GoogleFonts.poppins(fontSize: responsive.scaleWidth(isLandscape ? 12 : 18))),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/signIn"),
              child: Text("Sign In", style: GoogleFonts.poppins(color: const Color(0xFF004D8E), fontSize: responsive.scaleWidth(isLandscape ? 12 : 18))),
            ),
          ],
        ),
        SizedBox(height: isLandscape ? 20 : 47),
        Text(
          "By continue you agree to our Terms of service and our Privacy Policy",
          style: GoogleFonts.poppins(fontSize: responsive.scaleWidth(isLandscape ? 10 : 14), color: AppColors.grey),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}