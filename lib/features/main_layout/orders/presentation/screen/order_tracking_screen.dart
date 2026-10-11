import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/custom_primary_Button.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/widget/TrackingVerticalStepper.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/widget/cancel_order.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/widget/order_info_section.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery
        .of(context)
        .orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: responsive.scaleHeight(isLandscape ? 120 : 65),
        title: Text(
          "Order Tracking",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 16 : 24),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.black,
              size: responsive.scaleWidth(isLandscape ? 16 : 25)),
          onPressed: () => Navigator.pop(context),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(isLandscape ? 1 : 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 36 : 30)),
        child: Column(
          children: [
            const OrderInfoSection(),
            SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 20)),
            const TrackingVerticalStepper(),
            SizedBox(height: responsive.scaleHeight(isLandscape ? 15 : 30)),

            CustomPrimaryButton(
                text: "Confirm",
                onPressed: () {}
            ),
            SizedBox(height: responsive.scaleHeight(15)),
            SizedBox(
              width: responsive.scaleWidth(isLandscape ? 347 : 347),
              height: responsive.scaleHeight(isLandscape ? 150 : 51),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        responsive.scaleWidth(25)),
                  ),
                ),
                onPressed: () => _showCancelDialog(context),
                child: Text(
                  "Cancel Order",
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 14 : 18),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.scaleHeight(isLandscape ? 20 : 0)),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const CancelOrderPopup(orderId: 1234567890 ),
    );
  }
}