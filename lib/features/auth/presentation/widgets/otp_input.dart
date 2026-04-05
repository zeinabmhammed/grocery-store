import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
            (index) => _buildOtpBox(context, index == 0, responsive, isLandscape),
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, bool first, Responsive responsive, bool isLandscape) {
    return SizedBox(
      // تصغير الحجم في اللاندسكيب عشان مياخدش مساحة رأسية
      width: responsive.scaleWidth(isLandscape ? 30 : 50),
      height: responsive.scaleHeight(isLandscape ? 180 : 50),
      child: TextField(
        autofocus: first,
        onChanged: (value) {
          if (value.length == 1) FocusScope.of(context).nextFocus();
          if (value.isEmpty) FocusScope.of(context).previousFocus();
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: responsive.scaleWidth(isLandscape ? 15 : 20),
          fontWeight: FontWeight.bold,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF9F9F9),
          contentPadding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 5 : 10)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(isLandscape ? 15 : 30)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(isLandscape ? 15 : 30)),
            borderSide: const BorderSide(color: Color(0xFF929292)),
          ),
        ),
      ),
    );
  }
}