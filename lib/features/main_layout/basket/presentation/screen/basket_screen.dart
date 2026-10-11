import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/cubit/cart_cubit.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/cubit/cart_state.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/OrderSummaryWidget.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  static const String _imageBase = 'https://fruits.sys-web.net/storage/';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
      bottomNavigationBar:
      isLandscape ? null : const OrderSummaryWidget(),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartCheckoutSuccess) {
            Navigator.pushReplacementNamed(
              context,
              '/checkoutSuccess',
            );
          }
          if (state is CartCheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is CartUpdated && state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: responsive.scaleWidth(80), color: Colors.grey),
                  SizedBox(height: responsive.scaleHeight(20)),
                  Text(
                    'Your basket is empty',
                    style: TextStyle(
                      fontSize: responsive.scaleWidth(18),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return isLandscape
              ? Row(
            children: [
              Expanded(
                flex: 55,
                child: _buildProductList(context, responsive, isLandscape),
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
              : _buildProductList(context, responsive, isLandscape);
        },
      ),
    );
  }

  Widget _buildProductList(
      BuildContext context, Responsive responsive, bool isLandscape) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final items =
        state is CartUpdated ? state.items : <dynamic>[];

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            vertical: responsive.scaleHeight(10),
            horizontal: responsive.scaleWidth(isLandscape ? 2 : 15),
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final imageUrl = item.product.image != null
                ? _imageBase + item.product.image!
                : null;

            return CustomListCard(
              leading: imageUrl != null
                  ? Image.network(
                imageUrl,
                width: responsive.scaleWidth(isLandscape ? 40 : 70),
                height: responsive.scaleHeight(isLandscape ? 40 : 70),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  AppAssets.product,
                  width: responsive.scaleWidth(isLandscape ? 40 : 70),
                ),
              )
                  : Image.asset(
                AppAssets.product,
                width: responsive.scaleWidth(isLandscape ? 40 : 70),
              ),
              title: item.product.name,
              subtitle: Text(
                '${item.selectedSubUnit != null ? item.selectedSubUnit!.subPrice.toStringAsFixed(2) : item.product.price.toStringAsFixed(2)} KD',
                style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 8 : 12)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: _buildQuantityControl(
                  context, responsive, isLandscape, index),
            );
          },
        );
      },
    );
  }

  Widget _buildQuantityControl(
      BuildContext context,
      Responsive responsive,
      bool isLandscape,
      int index,
      ) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final items = state is CartUpdated ? state.items : [];
        if (index >= items.length) return const SizedBox();
        final item = items[index];

        return SizedBox(
          height: responsive.scaleHeight(isLandscape ? 230 : 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () =>
                    context.read<CartCubit>().removeItem(index),
                child: SvgPicture.asset(
                  AppAssets.delete,
                  width: responsive.scaleWidth(isLandscape ? 13 : 20),
                ),
              ),
              Container(
                width: responsive.scaleWidth(isLandscape ? 60 : 110),
                padding: EdgeInsets.all(responsive.scaleWidth(2)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(responsive.scaleWidth(25)),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          context.read<CartCubit>().decreaseQuantity(index),
                      child: Icon(Icons.remove_circle_outline,
                          size: responsive.scaleWidth(isLandscape ? 13 : 20)),
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(
                          fontSize:
                          responsive.scaleWidth(isLandscape ? 10 : 14)),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.read<CartCubit>().increaseQuantity(index),
                      child: Icon(Icons.add_circle_outline,
                          color: Colors.green,
                          size: responsive.scaleWidth(isLandscape ? 13 : 20)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}