import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/CustomDropdownField.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/PaymentMethodTile.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/address_card.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/custom_primary_Button.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/custom_selection_tile.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/order_summary.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;
  int _selectedPaymentIndex = 1;

  final List<String> _stepsLabels = [
    "Delivery Time",
    "Delivery Address",
    "Payment",
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: responsive.scaleHeight(isLandscape ? 120 : 65),
        title: Text(
          "Checkout",
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
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: responsive.scaleWidth(isLandscape ? 16 : 25),
          ),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(1),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: responsive.scaleHeight(isLandscape ? 50 : 20)),
          _buildStepper(responsive, isLandscape),
          SizedBox(height: responsive.scaleHeight(isLandscape ? 5 : 10)),
          Divider(
            thickness: responsive.scaleWidth(1),
            color: const Color(0xffBFBFBF),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.scaleWidth(isLandscape ? 80 : 20),
                vertical: responsive.scaleHeight(10),
              ),
              child: _buildCurrentStepContent(responsive, isLandscape),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.scaleWidth(isLandscape ? 80 : 20),
              vertical: responsive.scaleHeight(isLandscape ? 10 : 20),
            ),
            child: CustomPrimaryButton(
              text: _currentStep == 2 ? "Place Order" : "Continue",
              onPressed: () {
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  Navigator.pushNamed(context, "/checkoutSuccess");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(Responsive responsive, bool isLandscape) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_stepsLabels.length, (index) {
        bool isActive = index <= _currentStep;
        bool isLast = index == _stepsLabels.length - 1;
        return Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: responsive.scaleWidth(isLandscape ? 5 : 6),
                  backgroundColor: isActive ? AppColors.green : AppColors.grey,
                ),
                SizedBox(height: responsive.scaleHeight(isLandscape ? 4 : 7)),
                Text(
                  _stepsLabels[index],
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 10 : 11),
                    color: isActive ? AppColors.green : AppColors.grey,
                  ),
                ),
              ],
            ),
            if (!isLast)
              Container(
                width: responsive.scaleWidth(isLandscape ? 75 : 60),
                height: responsive.scaleHeight(2),
                color: index < _currentStep
                    ? const Color(0xFF2D5E42)
                    : Colors.grey[300],
                margin:
                EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(isLandscape ? 4 : 7),
                ).copyWith(
                  bottom: responsive.scaleHeight(isLandscape ? 10 : 20),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildCurrentStepContent(Responsive responsive, bool isLandscape) {
    switch (_currentStep) {
      case 0:
        return _deliveryTimeContent(responsive, isLandscape);
      case 1:
        return _deliveryAddressContent(responsive, isLandscape);
      case 2:
        return _paymentContent(responsive, isLandscape);
      default:
        return Container();
    }
  }

  Widget _deliveryTimeContent(Responsive responsive, bool isLandscape) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSelectionTile(title: "Now"),
        SizedBox(
          height: responsive.scaleHeight(isLandscape ? 10 : 20),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Padding(
            padding: EdgeInsets.all(responsive.scaleWidth(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Delivery Time",
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: responsive.scaleHeight(10)),
                Text(
                  "Select Date",
                  style: TextStyle(fontSize: responsive.scaleWidth(14)),
                ),
                SizedBox(height: responsive.scaleHeight(10)),
                CustomDropdownField(selectedDate: "09-15-2021"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _deliveryAddressContent(Responsive responsive, bool isLandscape) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Delivery Address",
          style: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 16 : 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        _buildAddNewAddress(responsive),
        SizedBox(height: responsive.scaleHeight(15)),
        const AddressCard(
          title: "Address 1",
          subtitle: "John Doe\n+000-11-1234567",
          info: "Room #1 - Ground Floor, Al Najoum Building, Dubai",
          isSelected: true,
        ),
      ],
    );
  }

  Widget _paymentContent(Responsive responsive, bool isLandscape) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Coupon Code",
          style: TextStyle(
            fontSize: responsive.scaleWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        _buildCouponField(responsive, isLandscape),
        SizedBox(height: responsive.scaleHeight(20)),
        OrderSummary(),
        SizedBox(height: responsive.scaleHeight(20)),
        Text(
          "Payment",
          style: TextStyle(
            fontSize: responsive.scaleWidth(16),
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildPaymentTiles(responsive),
      ],
    );
  }


  Widget _buildAddNewAddress(Responsive responsive) {
    return Container(
      padding: EdgeInsets.all(responsive.scaleWidth(15)),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(responsive.scaleWidth(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Add New Address",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.scaleWidth(14),
            ),
          ),
          Icon(
            Icons.add,
            size: responsive.scaleWidth(25),
            color: const Color(0xff656565),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponField(Responsive responsive, bool isLandscape) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(10),
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Have a Coupon Code?",
              style: TextStyle(fontSize: responsive.scaleWidth(12)),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5E42),
              shape: const StadiumBorder(),
            ),
            child: const Text("Apply", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTiles(Responsive responsive) {
    return Column(
      children: [
        PaymentMethodTile(
          title: "Credit Card",
          icon: SvgPicture.asset(AppAssets.credit),
          isSelected: _selectedPaymentIndex == 0,
          onTap: () => setState(() => _selectedPaymentIndex = 0),
        ),
        PaymentMethodTile(
          title: "Cash on Delivery",
          icon: SvgPicture.asset(AppAssets.cash),
          isSelected: _selectedPaymentIndex == 1,
          onTap: () => setState(() => _selectedPaymentIndex = 1),
        ),
      ],
    );
  }
}
