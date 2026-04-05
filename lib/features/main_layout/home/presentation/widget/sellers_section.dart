import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class SellersSection extends StatelessWidget {
  const SellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(responsive),
        SizedBox(height: responsive.scaleHeight(12)),

        isLandscape
            ? _buildLandscapeGrid(responsive)
            : _buildPortraitList(responsive),
      ],
    );
  }

  Widget _buildHeader(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sellers",
            style: TextStyle(
              fontSize: responsive.scaleWidth(18),
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          Text(
            "Show all",
            style: TextStyle(
              fontSize: responsive.scaleWidth(16),
              color: const Color(0xff235C95),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitList(Responsive responsive) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (_, __) => SizedBox(height: responsive.scaleHeight(12)),
      itemBuilder: (context, index) =>
          _buildSellerItem(index, responsive, false, context),
    );
  }

  Widget _buildLandscapeGrid(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: responsive.scaleWidth(10),
          mainAxisSpacing: responsive.scaleHeight(15),
          mainAxisExtent: responsive.scaleHeight(300),
        ),
        itemBuilder: (context, index) =>
            _buildSellerItem(index, responsive, true,context),
      ),
    );
  }

  Widget _buildSellerItem(
      int index,
      Responsive responsive,
      bool isLandscape,
      BuildContext context,
      ) {
    return GestureDetector(
      onTap: () {},
      child: _buildSellerCard(
        context: context,
        logo: AppAssets.sellerLogo,
        name: "Seller name",
        delivery: index == 0 ? "0.5 KD" : "Free Delivery",
        status: index % 2 == 0 ? "Open" : "Close",
        category: index == 0 ? "Beverages" : "Pizza",
        distance: "2.5 KM",
        rating: "4.5",
        responsive: responsive,
        isLandscape: isLandscape,
      ),
    );
  }

  Widget _buildSellerCard({
    required String logo,
    required String name,
    required String delivery,
    required String status,
    required String category,
    required String distance,
    required String rating,
    required Responsive responsive,
    required bool isLandscape,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/sellersDetails");
      },
      child: Container(
        margin: isLandscape
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
        padding: EdgeInsets.all(responsive.scaleWidth(10)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: responsive.scaleWidth(isLandscape ? 40 : 80),
              height: responsive.scaleWidth(isLandscape ? 50 : 80),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(logo, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: responsive.scaleWidth(7)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: responsive.scaleWidth(
                              isLandscape ? 10 : 15,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        rating,
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(isLandscape ? 10 : 13),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.scaleHeight(4)),
                  Text(
                    delivery,
                    style: TextStyle(
                      fontSize: responsive.scaleWidth(isLandscape ? 10 : 13),
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: responsive.scaleHeight(4)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$status · $category",
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(isLandscape ? 8 : 12),
                          color: status == "Open" ? AppColors.green : Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        distance,
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(isLandscape ? 8 : 11),
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
