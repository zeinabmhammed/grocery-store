import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_elevated_button.dart';
import 'package:greengrocer/core/resources/widget/custom_form_field.dart';
import 'package:greengrocer/core/resources/widget/custom_phone_field.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.scaleWidth(isLandscape ? 50 : 30),
          ),
          child: Column(
            children: [
              // زر الرجوع
              SizedBox(height: responsive.scaleHeight(isLandscape ? 35 : 25)),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: responsive.scaleWidth(isLandscape ? 15 : 33),
                    color: AppColors.black,
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.all(responsive.scaleWidth(16)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 5 : 20),
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: responsive.scaleWidth(
                              isLandscape ? 90 : 120,
                            ),
                            height: responsive.scaleWidth(
                              isLandscape ? 90 : 120,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border: Border.all(
                                color: const Color(0xff959CA8),
                                width: responsive.scaleWidth(
                                  isLandscape ? 1 : 1,
                                ),
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.profileIcon,
                                height: responsive.scaleHeight(
                                  isLandscape ? 85 : 60,
                                ),
                                color: const Color(0xff959CA8),
                              ),
                            ),
                          ),
                          Container(
                            width: responsive.scaleWidth(isLandscape ? 25 : 40),
                            height: responsive.scaleWidth(
                              isLandscape ? 25 : 40,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.addPhotoIcon,
                                height: responsive.scaleHeight(
                                  isLandscape ? 100 : 30,
                                ),
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 30 : 20),
                      ),

                      Text(
                        "Welcome, Ahmed",
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(
                            isLandscape ? 18 : 24,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 35 : 20),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Full name ",
                          style: TextStyle(
                            fontSize: responsive.scaleWidth(
                              isLandscape ? 12 : 14,
                            ),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF858D9A),
                          ),
                        ),
                      ),
                      CustomFormField(
                        hintText: "First and Last Name",
                        isPassword: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        controller: nameController,
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 20 : 10),
                      ),

                      const CustomPhoneField(),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 20 : 15),
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: responsive.scaleWidth(
                              isLandscape ? 12 : 14,
                            ),
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF858D9A),
                          ),
                        ),
                      ),
                      CustomFormField(
                        hintText: "Enter your password",
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        controller: passwordController,
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 30 : 20),
                      ),

                      CustomButton(
                        text: "Update",
                        onTap: () {},
                        color: AppColors.green,
                        textColor: AppColors.white,
                      ),

                      SizedBox(
                        height: responsive.scaleHeight(isLandscape ? 20 : 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
