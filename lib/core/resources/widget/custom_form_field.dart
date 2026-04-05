import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

typedef Validator = String? Function(String?);

class CustomFormField extends StatefulWidget {
  String? label;
  String? hintText;
  Widget? prefixIcon;
  TextInputType keyboardType;
  bool isPassword;
  Validator? validator;
  TextEditingController? controller;
  int? maxLines;

  CustomFormField({
    this.label,
    this.prefixIcon,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.maxLines = 1,
    this.validator,
    this.controller,
    super.key,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool secureText = true;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(4),
        vertical: responsive.scaleHeight(isLandscape ? 10 : 9),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && secureText,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        style: TextStyle(
          color: AppColors.black,
          fontSize: responsive.scaleWidth(isLandscape ? 14 : 18),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          filled: true,
          fillColor: AppColors.white,
          hintStyle: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 16),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: responsive.scaleWidth(10),
            vertical: responsive.scaleHeight(isLandscape ? 29 : 15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
            padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 8 : 10)),
            child: widget.prefixIcon,
          )
              : null,
          suffixIcon: widget.isPassword
              ? InkWell(
            onTap: () {
              setState(() {
                secureText = !secureText;
              });
            },
            child: Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(isLandscape ? 15 : 10)) ,
              child: Icon(
                secureText
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: AppColors.grey,
                size: responsive.scaleWidth(isLandscape ? 15 : 22),
              ),
            ),
          )
              : null,
        ),
      ),
    );
  }
}