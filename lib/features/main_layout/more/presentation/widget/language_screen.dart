import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class LanguagePopup {
  static void show(BuildContext context) {
    String selectedOption = "en";
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
              ),
              child: Container(
                width: responsive.scaleWidth(
                  isLandscape ? 350 : double.infinity,
                ),
                padding: EdgeInsets.all(
                  responsive.scaleWidth(isLandscape ? 15 : 20),
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    responsive.scaleWidth(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: "ar",
                            groupValue: selectedOption,
                            activeColor: AppColors.green,
                            onChanged: (val) {
                              setState(() {
                                selectedOption = val!;
                              });
                            },
                          ),
                          SizedBox(width: responsive.scaleWidth(8)),
                          SvgPicture.asset(
                            AppAssets.arabicFlag,
                            height: responsive.scaleHeight(
                              isLandscape ? 50 : 20,
                            ),
                          ),
                          SizedBox(width: responsive.scaleWidth(10)),
                          Text(
                            "العربية",
                            style: TextStyle(
                              fontSize: responsive.scaleWidth(
                                isLandscape ? 14 : 16,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff656565),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Radio<String>(
                            value: "en",
                            groupValue: selectedOption,
                            activeColor: AppColors.green,
                            onChanged: (val) {
                              setState(() {
                                selectedOption = val!;
                              });
                            },
                          ),
                          SizedBox(width: responsive.scaleWidth(8)),
                          SvgPicture.asset(
                            AppAssets.englishFlag,
                            height: responsive.scaleHeight(
                              isLandscape ? 40 : 16,
                            ),
                          ),
                          SizedBox(width: responsive.scaleWidth(8)),
                          Text(
                            "English",
                            style: TextStyle(
                              fontSize: responsive.scaleWidth(
                                isLandscape ? 14 : 16,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff656565),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 50 : 20),
                      ),

                      SizedBox(
                        width: responsive.scaleWidth(isLandscape ? 200 : 244),
                        height: responsive.scaleHeight(isLandscape ? 130 : 44),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                responsive.scaleWidth(25),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              fontSize: responsive.scaleWidth(
                                isLandscape ? 11 : 14,
                              ),
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 20 : 12),
                      ),

                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Center(
                          child: Text(
                            "Close",
                            style: TextStyle(
                              fontSize: responsive.scaleWidth(
                                isLandscape ? 12 : 16,
                              ),
                              color: const Color(0xff656565),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
