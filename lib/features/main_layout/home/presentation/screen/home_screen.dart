import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/categories_section.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/custom_ads_widget.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/filter_popup.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/sellers_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    AppAssets.adsOne, AppAssets.adsTwo, AppAssets.adsThree, AppAssets.adsFour,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % adsImages.length;
        });
      }
    });
  }

  void _updateIndex(int newIndex) {
    _timer.cancel();
    setState(() => _currentIndex = newIndex);
    _startImageSwitching();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildResponsiveAppBar(responsive, isLandscape, context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 15)),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isLandscape ? responsive.scaleWidth(50) : 0,
              ),
              child: CustomAdsWidget(
                adsImages: adsImages,
                currentIndex: _currentIndex,
                onSwipe: (index) => _updateIndex(index),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: responsive.scaleHeight(isLandscape ? 15 : 10)),
                const CategoriesSection(),
                SizedBox(height: responsive.scaleHeight(isLandscape ? 15 : 20)),
              ],
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.scaleWidth(isLandscape ? 0 : 0),
            ),
            sliver: const SliverToBoxAdapter(
              child: SellersSection(),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: responsive.scaleHeight(40)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(
      Responsive responsive,
      bool isLandscape,
      BuildContext context,
      ) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: responsive.scaleHeight(isLandscape ? 110 : 55),
      title: Text(
        "Fruit Market",
        style: GoogleFonts.poppins(
          fontSize: responsive.scaleWidth(isLandscape ? 18 : 22),
          fontWeight: FontWeight.bold,
          color: AppColors.green,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.searchIcon,
            width: responsive.scaleWidth(isLandscape ? 15 : 24),
          ),
        ),
        IconButton(
          onPressed: () => FilterPopup.show(context),
          icon: SvgPicture.asset(
            AppAssets.filterIcon,
            width: responsive.scaleWidth(isLandscape ? 15 : 24),
          ),
        ),
        SizedBox(width: responsive.scaleWidth(10)),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xffDEDFDF), height: 1),
      ),
    );
  }
}