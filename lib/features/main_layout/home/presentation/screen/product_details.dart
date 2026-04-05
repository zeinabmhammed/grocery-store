import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool gram50 = false;
  bool kg1 = false;
  bool kg2 = false;
  bool gram60 = false;
  bool kg3 = false;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(responsive, isLandscape, context),
      body: isLandscape
          ? _buildLandscapeLayout(responsive)
          : _buildPortraitLayout(responsive),
    );
  }


  Widget _buildPortraitLayout(Responsive responsive) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(responsive.scaleWidth(23)),
        child: Column(
          children: [
            _buildProductImageSection(responsive, false),
            SizedBox(height: responsive.scaleHeight(20)),
            _buildProductDetailsContent(responsive, false),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(Responsive responsive) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildProductImageSection(responsive, true),
          ),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: _buildProductDetailsContent(responsive, true),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImageSection(Responsive responsive, bool isLandscape) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          child: Image.asset(
            AppAssets.productDetails,
            width: double.infinity,
            height: isLandscape ? double.infinity : null,
            fit: isLandscape ? BoxFit.cover : BoxFit.fill,
          ),
        ),
        Positioned(
          top: responsive.scaleHeight(isLandscape ? 30 : 10),
          right: responsive.scaleWidth(10),
          child: Container(
            width: responsive.scaleWidth(isLandscape ? 70 : 167),
            height: responsive.scaleHeight(isLandscape ? 85 : 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Center(
              child: Text(
                "10% Off Discount",
                style: TextStyle(
                  color: const Color(0xff656565),
                  fontSize: responsive.scaleWidth(isLandscape ? 8 : 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDetailsContent(Responsive responsive, bool isLandscape) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category Name",
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: responsive.scaleWidth(isLandscape ? 14 : 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Product name",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: responsive.scaleWidth(isLandscape ? 14 : 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "KD 12.00",
                      style: TextStyle(
                        color: const Color(0xff656565),
                        fontSize: responsive.scaleWidth(isLandscape ? 8 : 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: responsive.scaleWidth(10)),
                    Text(
                      "KD 14.00",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: const Color(0xffDF958F),
                        fontSize: responsive.scaleWidth(isLandscape ? 7 : 14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          style: TextStyle(
            color: const Color(0xff656565),
            fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
          ),
        ),
        SizedBox(height: responsive.scaleHeight(15)),
        Row(
          children: [
            Text(
              "Sell Per : Kartoon",
              style: TextStyle(
                color: const Color(0xff656565),
                fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
              ),
            ),
          ],
        ),
        SizedBox(height: responsive.scaleHeight(23)),
        _buildSectionHeader("Select weight", responsive, isLandscape),
        Divider(color: const Color(0xffDEDFDF), thickness: 2),
        _buildCheckBox(
          "50 Gram - 4.00 KD",
          gram50,
              (val) => setState(() => gram50 = val!),
          responsive,
          isLandscape,
        ),
        _buildCheckBox(
          "1 Kg - 6.25 KD",
          kg1,
              (val) => setState(() => kg1 = val!),
          responsive,
          isLandscape,
        ),
        _buildCheckBox(
          "2 Kg - 12.00 KD",
          kg2,
              (val) => setState(() => kg2 = val!),
          responsive,
          isLandscape,
        ),
        SizedBox(height: responsive.scaleHeight(15)),
        _buildSectionHeader("Select Addons", responsive, isLandscape),
        Divider(color: const Color(0xffDEDFDF), thickness: 2),
        _buildCheckBox(
          "50 Gram - 4.00 KD",
          gram60,
              (val) => setState(() => gram60 = val!),
          responsive,
          isLandscape,
        ),
        _buildCheckBox(
          "1 Kg - 6.25 KD",
          kg3,
              (val) => setState(() => kg3 = val!),
          responsive,
          isLandscape,
        ),
        SizedBox(height: responsive.scaleHeight(20)),
        _buildAddToCartButton(responsive, isLandscape),
      ],
    );
  }

  Widget _buildSectionHeader(
      String title,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xff292727),
            fontSize: responsive.scaleWidth(isLandscape ? 15 : 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down,
          color: const Color(0xff656565),
          size: responsive.scaleWidth(isLandscape ? 22 : 30),
        ),
      ],
    );
  }

  Widget _buildCheckBox(
      String text,
      bool value,
      Function(bool?) onChanged,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.green,

          visualDensity: isLandscape
              ? VisualDensity.compact
              : VisualDensity.standard,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: responsive.scaleWidth(isLandscape ? 12 : 15),
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(Responsive responsive, bool isLandscape) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: responsive.scaleWidth(isLandscape ? 160 : 161),
        height: responsive.scaleHeight(isLandscape ? 120 : 40),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2D6A4F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(responsive.scaleWidth(17)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.basketIcon,
                width: responsive.scaleWidth(isLandscape ? 16 : 20),
                color: AppColors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.scaleWidth(isLandscape ? 12 : 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      Responsive responsive,
      bool isLandscape,
      BuildContext context,
      ) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: responsive.scaleHeight(isLandscape ? 100 : 55),
      title: Text(
        "Product Details",
        style: GoogleFonts.poppins(
          fontSize: responsive.scaleWidth(isLandscape ? 16 : 24),
          fontWeight: FontWeight.bold,
          color: AppColors.green,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: responsive.scaleWidth(isLandscape ? 16 : 25),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.addToFav,
            width: responsive.scaleWidth(isLandscape ? 16 : 26),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.shareIcon,
            width: responsive.scaleWidth(isLandscape ? 13 : 20),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
