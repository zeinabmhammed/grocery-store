import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import '../../../../../core/resources/app_assets/app_assets.dart';

class CheckoutFailed extends StatelessWidget {
  const CheckoutFailed({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 18 : 24),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent ,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: responsive.scaleWidth(isLandscape ? 16 : 25),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const Border(
          bottom: BorderSide(color: Color(0xffDEDFDF), width: 1),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 20 : 50)),
          child: isLandscape
              ? _buildLandscapeLayout(context ,responsive)
              : _buildPortraitLayout(context,responsive),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context,Responsive responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.checkOutFailed,
          width: responsive.scaleWidth(283),
          height: responsive.scaleHeight(176),
        ),
        SizedBox(height: responsive.scaleHeight(50)),
        _buildErrorMessage(responsive, false),
        SizedBox(height: responsive.scaleHeight(80)),
        _buildBackButton(context,responsive),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context,Responsive responsive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.asset(
            AppAssets.checkOutFailed,
            height: responsive.scaleHeight(350),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildErrorMessage(responsive, true),
              SizedBox(height: responsive.scaleHeight(40)),
              _buildBackButton(context,responsive),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Text(
          "OPS",
          style: TextStyle(
            color: const Color(0xffFF4A4A),
            fontSize: responsive.scaleWidth(isLandscape ? 18 : 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Error while confirming your payment/order",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xff656565),
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 16),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context, Responsive responsive) {
    return CustomButton(
      text: "Back",
      onTap: () {
        Navigator.pop(context);
      },
      color: const Color(0xffFF4A4A),
      textColor: AppColors.white,
    );
  }
}
