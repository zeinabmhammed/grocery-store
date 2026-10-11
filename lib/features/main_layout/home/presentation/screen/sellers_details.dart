import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/vendor_entity.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendor_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/search_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/products_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/products_state.dart';

class SellersDetails extends StatelessWidget {
  const SellersDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final vendor = ModalRoute.of(context)?.settings.arguments as VendorEntity?;
    if (vendor == null) return const Scaffold(body: Center(child: Text('No vendor selected')));    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocProvider(
      create: (_) => ProductsCubit(
        getVendorProductsUseCase: sl<GetVendorProductsUseCase>(),
        searchProductsUseCase: sl<SearchProductsUseCase>(),
      )..getVendorProducts(vendor.id),
      child: Scaffold(
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
                  leading: vendor.logoUrl != null
                      ? Image.network(
                    vendor.logoUrl!,
                    width: responsive.scaleWidth(isLandscape ? 40 : 60),
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.store, size: 40),
                  )
                      : Image.asset(
                    AppAssets.sellerLogo,
                    width: responsive.scaleWidth(isLandscape ? 40 : 60),
                  ),
                  title: vendor.name,
                  subtitle: Text(
                    vendor.isFreeDelivery ? 'Free Delivery' : 'Paid Delivery',
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

              _buildSectionTitle("Products", responsive, isLandscape),

              BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ProductsSuccess) {
                    if (state.products.isEmpty) {
                      return const Center(child: Text('No products found'));
                    }
                    return isLandscape
                        ? _buildProductsGrid(
                        state.products, responsive, context)
                        : _buildProductsList(
                        state.products, responsive, context);
                  }
                  return const SizedBox();
                },
              ),

              SizedBox(height: responsive.scaleHeight(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      String title, Responsive responsive, bool isLandscape) {
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

  Widget _buildProductsList(
      List<ProductEntity> products, Responsive responsive, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.scaleWidth(16),
          ),
          child: CustomListCard(
            onTap: () => Navigator.pushNamed(
              context,
              "/productDetails",
              arguments: product,
            ),
            leading: product.imageUrl != null
                ? Image.network(
              product.imageUrl!,
              errorBuilder: (_, __, ___) =>
                  Image.asset(AppAssets.product),
            )
                : Image.asset(AppAssets.product),
            title: product.name,
            subtitle: Text(
              "Price: ${product.price} KD",
              style: TextStyle(fontSize: responsive.scaleWidth(10)),
            ),
            trailing: Image.asset(AppAssets.add, scale: 2.4),
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(
      List<ProductEntity> products, Responsive responsive, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: responsive.scaleHeight(5),
        mainAxisExtent: responsive.scaleHeight(350),
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return CustomListCard(
          onTap: () => Navigator.pushNamed(
            context,
            "/productDetails",
            arguments: product,
          ),
          leading: product.imageUrl != null
              ? Image.network(
            product.imageUrl!,
            errorBuilder: (_, __, ___) => Image.asset(AppAssets.product),
          )
              : Image.asset(AppAssets.product),
          title: product.name,
          subtitle: Text(
            "Price: ${product.price} KD",
            style: TextStyle(fontSize: responsive.scaleWidth(10)),
          ),
          trailing: Image.asset(AppAssets.add, scale: 3.4),
        );
      },
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(
      Responsive responsive, bool isLandscape, BuildContext context) {
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
}