import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/OrderSummaryWidget.dart';
import '../../../../../core/resources/app_colors/app_colors.dart';
import '../../../../../core/resources/widget/CustomListCard.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: responsive.scaleHeight(isLandscape ? 110 : 65),
        title: Text(
          "Basket",
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 16 : 24),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: responsive.scaleWidth(isLandscape ? 16 : 25),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(1),
          ),
        ),
      ),
      bottomNavigationBar: isLandscape ? null : const OrderSummaryWidget(),

      body: isLandscape
          ? Row(
        children: [
          Expanded(
            flex: 55,
            child: _buildProductList(responsive, isLandscape),
          ),
          Container(width: 1, color: Colors.grey.shade200),
          Expanded(
            flex: 45,
            child: Container(
              color: const Color(0xFFFBFBFB),
              child: const SingleChildScrollView(
                child: OrderSummaryWidget(),
              ),
            ),
          ),
        ],
      )
          : _buildProductList(responsive, isLandscape),
    );
  }

  Widget _buildProductList(Responsive responsive, bool isLandscape) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: responsive.scaleHeight(10),
        horizontal: responsive.scaleWidth(isLandscape ? 2 : 15),

      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return CustomListCard(
          leading: Image.asset(
            AppAssets.product,
            width: responsive.scaleWidth(isLandscape ? 40 : 70),
            height: responsive.scaleHeight(isLandscape ? 40 : 70),
          ),
          title: 'Product name',
          subtitle: Text(
            '12.00 KD',
            style: TextStyle(fontSize: responsive.scaleWidth(
                isLandscape ? 8 : 12)
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: _buildQuantityControl(responsive, isLandscape),
        );
      },
    );
  }

  Widget _buildQuantityControl(Responsive responsive, bool isLandscape) {
    return SizedBox(
      height: responsive.scaleHeight(isLandscape ? 230 : 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
              AppAssets.delete,
              width: responsive.scaleWidth(isLandscape ? 13 : 20)),
          Container(
            width: responsive.scaleWidth(isLandscape ? 60 : 110),
            padding: EdgeInsets.all(responsive.scaleWidth(2)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                    Icons.remove_circle_outline,
                    size: responsive.scaleWidth(isLandscape ? 13 : 20)),
                Text(
                    '1',
                    style: TextStyle(
                        fontSize: responsive.scaleWidth(isLandscape ? 10 : 14))),
                Icon(Icons.add_circle_outline,
                    color: Colors.green,
                    size: responsive.scaleWidth(isLandscape ? 13 : 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}