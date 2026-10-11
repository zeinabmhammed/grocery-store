import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/cubit/cart_cubit.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/cubit/favorite_state.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int? _selectedSubUnitIndex;

  @override
  Widget build(BuildContext context) {
    final product =
    ModalRoute.of(context)?.settings.arguments as ProductEntity?;
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('No product selected')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      // تمرير الـ product هنا للـ AppBar
      appBar: _buildAppBar(responsive, isLandscape, context, product),
      body: isLandscape
          ? _buildLandscapeLayout(responsive, product)
          : _buildPortraitLayout(responsive, product),
    );
  }

  Widget _buildPortraitLayout(Responsive responsive, ProductEntity product) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(responsive.scaleWidth(23)),
        child: Column(
          children: [
            _buildProductImageSection(responsive, false, product),
            SizedBox(height: responsive.scaleHeight(20)),
            _buildProductDetailsContent(responsive, false, product),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(Responsive responsive, ProductEntity product) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildProductImageSection(responsive, true, product),
          ),
        ),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: _buildProductDetailsContent(responsive, true, product),
          ),
        ),
      ],
    );
  }

  Widget _buildProductImageSection(
      Responsive responsive, bool isLandscape, ProductEntity product) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
          child: product.imageUrl != null
              ? Image.network(
            product.imageUrl!,
            width: double.infinity,
            height: isLandscape ? double.infinity : null,
            fit: isLandscape ? BoxFit.cover : BoxFit.fill,
            errorBuilder: (_, __, ___) => Image.asset(
              AppAssets.productDetails,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          )
              : Image.asset(
            AppAssets.productDetails,
            width: double.infinity,
            height: isLandscape ? double.infinity : null,
            fit: isLandscape ? BoxFit.cover : BoxFit.fill,
          ),
        ),
        if (product.priceAfterDiscount != null &&
            product.priceAfterDiscount != product.price)
          Positioned(
            top: responsive.scaleHeight(isLandscape ? 30 : 10),
            right: responsive.scaleWidth(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.scaleWidth(10),
                vertical: responsive.scaleHeight(5),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(responsive.scaleWidth(25)),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Text(
                "Discount Available",
                style: TextStyle(
                  color: const Color(0xff656565),
                  fontSize: responsive.scaleWidth(isLandscape ? 8 : 14),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductDetailsContent(
      Responsive responsive, bool isLandscape, ProductEntity product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.categoryName != null)
                    Text(
                      product.categoryName!,
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize:
                        responsive.scaleWidth(isLandscape ? 14 : 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    product.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize:
                      responsive.scaleWidth(isLandscape ? 14 : 20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                      "KD ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: const Color(0xff656565),
                        fontSize:
                        responsive.scaleWidth(isLandscape ? 8 : 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.priceAfterDiscount != null &&
                        product.priceAfterDiscount != product.price) ...[
                      SizedBox(width: responsive.scaleWidth(10)),
                      Text(
                        "KD ${product.priceAfterDiscount!.toStringAsFixed(2)}",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: const Color(0xffDF958F),
                          fontSize:
                          responsive.scaleWidth(isLandscape ? 7 : 14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: responsive.scaleHeight(10)),
        if (product.description != null && product.description!.isNotEmpty)
          Text(
            product.description!,
            style: TextStyle(
              color: const Color(0xff656565),
              fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
            ),
          ),
        if (product.unit != null) ...[
          SizedBox(height: responsive.scaleHeight(10)),
          Text(
            "Sell Per: ${product.unit}",
            style: TextStyle(
              color: const Color(0xff656565),
              fontSize: responsive.scaleWidth(isLandscape ? 13 : 16),
            ),
          ),
        ],
        if (product.subUnits.isNotEmpty) ...[
          SizedBox(height: responsive.scaleHeight(23)),
          _buildSectionHeader("Select Size", responsive, isLandscape),
          const Divider(color: Color(0xffDEDFDF), thickness: 2),
          ...product.subUnits.asMap().entries.map((entry) {
            final index = entry.key;
            final subUnit = entry.value;
            return RadioListTile<int>(
              value: index,
              groupValue: _selectedSubUnitIndex,
              onChanged: (val) =>
                  setState(() => _selectedSubUnitIndex = val),
              activeColor: AppColors.green,
              title: Text(
                "${subUnit.subUnit} - KD ${subUnit.subPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: responsive.scaleWidth(isLandscape ? 12 : 15),
                ),
              ),
              dense: isLandscape,
            );
          }),
        ],
        SizedBox(height: responsive.scaleHeight(20)),
        _buildAddToCartButton(
          context,
          product,
          _selectedSubUnitIndex,
          responsive,
          isLandscape,
        )
      ],
    );
  }

  Widget _buildSectionHeader(
      String title, Responsive responsive, bool isLandscape) {
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

  Widget _buildAddToCartButton(
      BuildContext context,
      dynamic product,
      int? selectedSubUnitIndex,
      Responsive responsive,
      bool isLandscape,
      ) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: responsive.scaleWidth(isLandscape ? 160 : 161),
        height: responsive.scaleHeight(isLandscape ? 120 : 40),
        child: ElevatedButton(
          onPressed: () {
            context.read<CartCubit>().addItem(
              product,
              selectedSubUnit: selectedSubUnitIndex != null
                  ? product.subUnits[selectedSubUnitIndex]
                  : null,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to cart!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
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
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 10),
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

  // تم إضافة الـ ProductEntity هنا كـ Parameter
  PreferredSizeWidget _buildAppBar(Responsive responsive, bool isLandscape,
      BuildContext context, ProductEntity product) {
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
        // هنا تم استخدام الـ BlocBuilder الخاص بالـ FavoriteCubit
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            // ملاحظة: لو دالة isFavorite عندك بتاخد المنتج كامل بدل الـ id خليها isFavorite(product)
            final isFav = context.read<FavoriteCubit>().isFavorite(product.id);
            return IconButton(
              onPressed: () {
                // لو بتستخدمي الـ API token مرريه هنا لو الدالة محتاجاه
                context.read<FavoriteCubit>().toggleFavorite(product);
              },
              icon: SvgPicture.asset(
                AppAssets.addToFav,
                width: responsive.scaleWidth(isLandscape ? 16 : 26),
                colorFilter: ColorFilter.mode(
                  isFav ? Colors.red : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            AppAssets.shareIcon,
            width: responsive.scaleWidth(isLandscape ? 13 : 20),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}