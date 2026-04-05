import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/custom_text_field.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final messageController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: responsive.scaleHeight(isLandscape ? 110 : 65),
        title: Text(
          "Contact Us",
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
            Navigator.pop(context);
          },
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(isLandscape ? 1 : 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(responsive.scaleWidth(isLandscape ? 12 : 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(text: "Name", controller: nameController),
              SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 16)),

              CustomTextField(
                  text: "Mobile Number",
                  controller: phoneController
              ),
              SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 16)),

              CustomTextField(
                text: "Message",
                controller: messageController,
                maxLines: isLandscape ? 5 : 4,
              ),

              SizedBox(height: responsive.scaleHeight(isLandscape ? 45 : 20)),

              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.scaleWidth(isLandscape ? 55 : 30),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: responsive.scaleHeight(isLandscape ? 35 : 14),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: responsive.scaleWidth(isLandscape ? 14 : 18),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: responsive.scaleHeight(isLandscape ? 55 : 27)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(AppAssets.whatsapp, responsive, isLandscape),
                  SizedBox(width: responsive.scaleWidth(16)),
                  _buildSocialIcon(AppAssets.faceIcon, responsive, isLandscape),
                  SizedBox(width: responsive.scaleWidth(16)),
                  _buildSocialIcon(AppAssets.instagram, responsive, isLandscape),
                  SizedBox(width: responsive.scaleWidth(16)),
                  _buildSocialIcon(AppAssets.youtube, responsive, isLandscape),
                ],
              ),
              SizedBox(height: responsive.scaleHeight(isLandscape ? 50 : 0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String asset, Responsive responsive, bool isLandscape) {
    return SvgPicture.asset(
      asset,
      height: responsive.scaleHeight(isLandscape ? 110 : 40),
    );
  }
}