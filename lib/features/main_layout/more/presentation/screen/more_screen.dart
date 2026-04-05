import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/more/presentation/widget/language_screen.dart';
import 'package:greengrocer/features/main_layout/more/presentation/widget/profile_screen.dart';
import 'package:greengrocer/features/main_layout/more/presentation/widget/support_screen.dart';
import 'package:greengrocer/features/main_layout/more/presentation/widget/terms_screen.dart';


class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Fruit Market",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 16 : 24),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        leading: Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: responsive.scaleWidth(isLandscape ? 15 : 22),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(1),
          ),
        ),
      ),
      body: isLandscape
          ? _buildLandscapeLayout(context, responsive)
          : _buildPortraitLayout(context, responsive),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, Responsive responsive) {
    return ListView(
      padding: EdgeInsets.all(responsive.scaleWidth(16)),
      children: [
        SizedBox(height: responsive.scaleHeight(20)),
        _buildProfileSection(responsive, false),
        SizedBox(height: responsive.scaleHeight(12)),
        _buildWelcomeText(responsive, false),
        SizedBox(height: responsive.scaleHeight(12)),
        _buildLoginButton(context, responsive, false),
        SizedBox(height: responsive.scaleHeight(20)),
        ..._buildOptionsList(),
        SizedBox(height: responsive.scaleHeight(20)),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, Responsive responsive) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _buildProfileSection(responsive, true),
                SizedBox(height: 15),
                _buildWelcomeText(responsive, true),
                SizedBox(height: 20),
                _buildLoginButton(context, responsive, true),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            children: _buildOptionsList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileSection(Responsive responsive, bool isLandscape) {
    double size = isLandscape ? 50 : 100;
    return Container(
      width: responsive.scaleWidth(size),
      height: responsive.scaleWidth(size),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xff9EA4AE)),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.profileIcon,
          height: isLandscape ? 40 : 50,
          color: const Color(0xff9EA4AE),
        ),
      ),
    );
  }

  Widget _buildWelcomeText(Responsive responsive, bool isLandscape) {
    return Text(
      "Welcome, Fruit Market",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: responsive.scaleWidth(isLandscape ? 12 : 22),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildLoginButton(
      BuildContext context,
      Responsive responsive,
      bool isLandscape,
      ) {
    return SizedBox(
      width: responsive.scaleWidth(isLandscape ? 100 : 200),
      height: responsive.scaleHeight(isLandscape ? 85 : 45),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, "/signIn"),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("Login", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  List<Widget> _buildOptionsList() {
    return [
      const MoreOptionItem(icon: AppAssets.profileIcon, title: "Profile"),
      const MoreOptionItem(icon: AppAssets.ordersIcon, title: "My Orders"),
      const MoreOptionItem(icon: AppAssets.favoriteIcon, title: "Favorite"),
      const MoreOptionItem(icon: AppAssets.languageIcon, title: "Language"),
      const MoreOptionItem(icon: AppAssets.supportIcon, title: "Support"),
      const MoreOptionItem(
        icon: AppAssets.termsIcon,
        title: "Terms & Conditions",
      ),
      const MoreOptionItem(icon: AppAssets.aboutIcon, title: "About Us"),
    ];
  }
}

class MoreOptionItem extends StatelessWidget {
  final String icon;
  final String title;

  const MoreOptionItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(10),
        vertical: isLandscape ? 0 : 5,
      ),
      leading: SvgPicture.asset(
        icon,
        height: isLandscape ? 26 : 25,
        color: AppColors.green,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: responsive.scaleWidth(isLandscape ? 12 : 16),
        color: Colors.grey,
      ),
      onTap: () {
        if (title == "Language") {
          LanguagePopup.show(context);
        } else if (title == "Support") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SupportScreen()),
          );
        } else if (title == "Terms & Conditions") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TermsScreen()),
          );
        } else if (title == "Profile") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ),
          );
        } else if (title == "My Orders") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/mainLayout",
                (route) => false,
            arguments: 1,
          );
        } else if (title == "Favorite") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/mainLayout",
                (route) => false,
            arguments: 3,
          );
        }
      },
    );
  }
}
