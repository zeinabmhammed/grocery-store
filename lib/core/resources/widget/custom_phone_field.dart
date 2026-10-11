import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import '../app_colors/app_colors.dart';

class CustomPhoneField extends StatefulWidget {
  final TextEditingController? controller;

  const CustomPhoneField({super.key, this.controller});

  @override
  State<CustomPhoneField> createState() => _CustomPhoneFieldState();
}

class _CustomPhoneFieldState extends State<CustomPhoneField> {
  String selectedCountry = "KW";

  List<Map<String, String>> countries = [
    {'name': 'Kuwait', 'code': 'KW'},
    {'name': 'Egypt', 'code': 'EG'},
    {'name': 'Saudi', 'code': 'SA'},
    {'name': 'Oman', 'code': 'OM'},
    {'name': 'Qatar', 'code': 'QA'},
    {'name': 'Bahrain', 'code': 'BH'},
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF858D9A),
          ),
        ),
        SizedBox(height: responsive.scaleHeight(isLandscape ? 25 : 10)),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (value.length < 8) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
          style: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
          ),
          decoration: InputDecoration(
            hintText: "Mobile Number",
            hintStyle: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
              color: AppColors.black,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: responsive.scaleWidth(15),
              vertical: responsive.scaleHeight(isLandscape ? 10 : 15),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.scaleWidth(isLandscape ? 15 : 15),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCountry,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    size: responsive.scaleWidth(isLandscape ? 18 : 25),
                  ),
                  elevation: 16,
                  items: countries.map((country) {
                    return DropdownMenuItem<String>(
                      value: country['code'],
                      child: Text(
                        country['code']!,
                        style: TextStyle(
                          fontSize:
                          responsive.scaleWidth(isLandscape ? 12 : 14),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCountry = newValue!;
                    });
                  },
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(responsive.scaleWidth(25)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(responsive.scaleWidth(25)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(responsive.scaleWidth(25)),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(responsive.scaleWidth(25)),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(responsive.scaleWidth(25)),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}