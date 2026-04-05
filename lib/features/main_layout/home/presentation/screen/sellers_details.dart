import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';

class SellersDetails extends StatelessWidget {
  const SellersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildResponsiveAppBar(responsive, isLandscape, context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: responsive.scaleHeight(isLandscape ? 10 : 0),
                horizontal: responsive.scaleWidth(16),
              ),
              child: CustomListCard(
                leading: Image.asset(
                  AppAssets.sellerLogo,
                  width: responsive.scaleWidth(isLandscape ? 40 : 60),
                ),
                title: " Seller Name",
                subtitle: Text(
                  "Delivery : 40 to 60 Min",
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 10 : 14),
                  ),
                ),
                trailing: SvgPicture.asset(
                  AppAssets.discount,
                  width: responsive.scaleWidth(isLandscape ? 20 : 30),
                ),
              ),
            ),

            _buildSectionTitle("Categories", responsive, isLandscape),
            SizedBox(
              height: responsive.scaleHeight(
                isLandscape ? 400 : 110,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(5),
                ),
                children: [
                  _buildCategoryItem(
                    "Fruits",
                    AppAssets.fruits,
                    responsive,
                    isLandscape,
                  ),
                  _buildCategoryItem(
                    "Vegetables",
                    AppAssets.vegetables,
                    responsive,
                    isLandscape,
                  ),
                  _buildCategoryItem(
                    "Phone",
                    AppAssets.phone,
                    responsive,
                    isLandscape,
                  ),
                  _buildCategoryItem(
                    "Pets",
                    AppAssets.pets,
                    responsive,
                    isLandscape,
                  ),
                ],
              ),
            ),

            _buildSectionTitle("Products", responsive, isLandscape),

            isLandscape
                ? _buildProductsGrid(responsive)
                : _buildProductsList(responsive),

            SizedBox(height: responsive.scaleHeight(20)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(16),
        vertical: responsive.scaleHeight(isLandscape ? 10 : 10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: responsive.scaleWidth(isLandscape ? 15 : 18),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProductsList(Responsive responsive) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.scaleWidth(16),
          ),
          child: CustomListCard(
            onTap: () => Navigator.pushNamed(context, "/productDetails"),
            leading: Image.asset(AppAssets.product),
            title: " Product Name",
            subtitle: Text(
              "Price : 5 KD",
              style: TextStyle(
                fontSize: responsive.scaleWidth(10),
              ),
            ),
            trailing: Image.asset(
              AppAssets.add,
              scale: 2.4,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(Responsive responsive) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: responsive.scaleHeight(5),
        mainAxisExtent: responsive.scaleHeight(350),
      ),
      itemBuilder: (context, index) {
        return CustomListCard(
          onTap: () => Navigator.pushNamed(context, "/productDetails"),
          leading: Image.asset(AppAssets.product),
          title: " Product Name",
          subtitle: Text(
            "Price : 5 KD",
            style: TextStyle(
              fontSize: responsive.scaleWidth(10),
            ),
          ),
          trailing: Image.asset(
            AppAssets.add,
            scale: 3.4,
          ),
        );
      },
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
      toolbarHeight: isLandscape
          ? responsive.scaleHeight(130)
          : responsive.scaleHeight(65),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: responsive.scaleWidth(isLandscape ? 15 : 25),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Fruit Market",
        style: GoogleFonts.poppins(
          fontSize: responsive.scaleWidth(isLandscape ? 18 : 24),
          fontWeight: FontWeight.bold,
          color: AppColors.green,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.searchIcon,
            width: responsive.scaleWidth(isLandscape ? 16 : 26),
          ),
        ),
        SizedBox(width: responsive.scaleWidth(10)),
      ],
      shape: Border(
        bottom: BorderSide(
          color: const Color(0xffDEDFDF),
          width: responsive.scaleWidth(1),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      String label,
      String image,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(8)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(
              responsive.scaleWidth(isLandscape ? 3 : 10),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.scaleWidth(16)),
              boxShadow: [
                BoxShadow(color: Colors.black12.withOpacity(.25), blurRadius: 4)],
            ),
            child: Image.asset(
                image,
                width: responsive.scaleWidth(isLandscape ? 55 : 50),
                height: responsive.scaleHeight(isLandscape ? 260 : 50),
                fit: BoxFit.fill
            ),
          ),
          SizedBox(height: responsive.scaleHeight(5)),
          Text(
            label,
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 10: 13),
            ),
          ),
        ],
      ),
    );
  }
}
