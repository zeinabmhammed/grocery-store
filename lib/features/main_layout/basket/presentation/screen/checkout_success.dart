import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery
            .of(context)
            .orientation == Orientation.landscape;

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
        surfaceTintColor: Colors.transparent,
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
          padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 20 : 30)),
          child: isLandscape
              ? _buildLandscapeLayout(context,responsive)
              : _buildPortraitLayout(context,responsive),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout( BuildContext context , Responsive responsive) {
    return Column(
      children: [
        SizedBox(height: responsive.scaleHeight(60)),
        Image.asset(
          AppAssets.checkOutSuccess,
          width: responsive.scaleWidth(283),
          height: responsive.scaleHeight(176),
        ),
        SizedBox(height: responsive.scaleHeight(40)),
        _buildSuccessText(responsive, false),
        SizedBox(height: responsive.scaleHeight(30)),
        _buildActionButtons(context,responsive, false),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context ,Responsive responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Image.asset(
            AppAssets.checkOutSuccess,
            height: responsive.scaleHeight(350),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuccessText(responsive, true),
              SizedBox(height: responsive.scaleHeight(30)),
              _buildActionButtons(context, responsive, true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessText(Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Text(
          "YOUR ORDER IS CONFIRMED!",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.green,
            fontSize: responsive.scaleWidth(isLandscape ? 16 : 24),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(isLandscape ? 5 : 10)),
        Text(
          "Your order code: #243188",
          style: TextStyle(
            color: const Color(0xff656565),
            fontSize: responsive.scaleWidth(isLandscape ? 13 : 20),
          ),
        ),
        Text(
          "Thank you for choosing our products!",
          style: TextStyle(
            color: const Color(0xff656565),
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 18),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(
      BuildContext context,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Column(
      children: [
        CustomButton(
          text: "Continue Shopping",
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context, '/mainLayout', (route) => false, arguments: 0);
          },
          color: AppColors.green,
          textColor: AppColors.white,
        ),

        SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 20)),

        CustomButton(
          text: "Track Order",
          onTap: () {
            Navigator.pushNamed(context, '/checkoutFailed');
          },
          color: Colors.white,
          textColor: AppColors.green,
        ),
      ],
    );
  }
  List<Widget> _getButtonsList(BuildContext context, Responsive responsive,
      bool isLandscape) {
    final buttons = [
      CustomButton(
        text: "Continue Shopping",
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/mainLayout', (route) => false, arguments: 0);
        },
        color: AppColors.green,
        textColor: AppColors.white,
      ),
      SizedBox(
        height: isLandscape ? 0 : responsive.scaleHeight(15),
        width: isLandscape ? 15 : 0,
      ),
      CustomButton(
        text: "Track Order",
        onTap: () {
          Navigator.pushNamed(context, '/checkoutFailed');
        },
        color: Colors.white,
        textColor: AppColors.green,
      ),
    ];

    if (isLandscape) {
      return buttons
          .map((btn) => btn is SizedBox ? btn : Expanded(child: btn))
          .toList();
    }
    return buttons;
  }
}