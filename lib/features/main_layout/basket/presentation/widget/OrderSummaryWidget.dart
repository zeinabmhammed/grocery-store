import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 16 : 20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isLandscape
            ? BorderRadius.zero
            : BorderRadius.vertical(
          top: Radius.circular(responsive.scaleWidth(25)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: responsive.scaleWidth(10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: responsive.scaleHeight(10)),
            child: DottedLine(
              dashColor: Colors.grey.shade300,
              lineThickness: responsive.scaleWidth(1),
            ),
          ),

          _buildPriceRow("Subtotal", "36.00 KD", responsive, isLandscape),
          _buildPriceRow(
            "Shipping Charges",
            "1.50 KD",
            responsive,
            isLandscape,
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: responsive.scaleHeight(10)),
            child: Divider(thickness: 1, color: Colors.grey.shade100),
          ),

          _buildPriceRow(
            "Bag Total",
            "37.50 KD",
            responsive,
            isLandscape,
            isTotal: true,
          ),

          SizedBox(height: responsive.scaleHeight(isLandscape ? 15 : 20)),

          isLandscape
              ? Column(
            children: [
              _buildCartInfoRow(
                "4 items in cart",
                "37.50 KD",
                isLandscape,
                responsive,
              ),
              SizedBox(height: responsive.scaleHeight(15)),
              _buildCheckoutButton(context, responsive, isLandscape),
            ],
          )
              : Row(
            children: [
              _buildCartInfoColumn(
                "4 items in cart",
                "37.50 KD",
                responsive,
                isLandscape,
              ),
              SizedBox(width: responsive.scaleWidth(20)),
              Expanded(
                child: _buildCheckoutButton(
                  context,
                  responsive,
                  isLandscape,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      String label,
      String price,
      Responsive responsive,
      bool isLandscape, {
        bool isTotal = false,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsive.scaleHeight(isLandscape ? 8 : 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 10 : 14),
              color: isTotal ? Colors.black : Colors.grey[600],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
              color: isTotal ? const Color(0xFF2D6A4F) : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartInfoRow(
      String items,
      String price,
      bool isLandscape,
      Responsive responsive,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          items,
          style: TextStyle(
            color: Colors.grey,
            fontSize: responsive.scaleWidth(isLandscape ? 10 : 12),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive.scaleWidth(isLandscape ? 10 : 12),
            color: const Color(0xFF2D6A4F),
          ),
        ),
      ],
    );
  }

  Widget _buildCartInfoColumn(
      String items,
      String price,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          items,
          style: TextStyle(
            color: Colors.grey,
            fontSize: responsive.scaleWidth(isLandscape ? 10 : 12),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive.scaleWidth(isLandscape ? 10 : 18),
            color: const Color(0xFF2D6A4F),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(
      BuildContext context,
      Responsive responsive,
      bool isLandscape,
      ) {
    return SizedBox(
      width: double.infinity,
      height: responsive.scaleHeight(isLandscape ? 110 : 52),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/checkout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D6A4F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(12)),
          ),
        ),
        child: Text(
          "Proceed To Checkout",
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.scaleWidth(isLandscape ? 10 : 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
