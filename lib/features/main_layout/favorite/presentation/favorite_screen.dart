import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/cubit/favorite_state.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
          "Favorite",
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
          onPressed: () => Navigator.pop(context),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(1),
          ),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites =
          state is FavoriteUpdated ? state.favorites : [];

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: responsive.scaleWidth(80), color: Colors.grey),
                  SizedBox(height: responsive.scaleHeight(20)),
                  Text(
                    'No favorites yet',
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
              ? GridView.builder(
            padding: EdgeInsets.all(responsive.scaleWidth(15)),
            itemCount: favorites.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: responsive.scaleWidth(0),
              mainAxisSpacing: responsive.scaleHeight(10),
              childAspectRatio: 2.3,
            ),
            itemBuilder: (context, index) =>
                _buildItem(context, favorites[index], responsive, true),
          )
              : ListView.builder(
            itemCount: favorites.length,
            padding: EdgeInsets.symmetric(
                vertical: responsive.scaleHeight(10)),
            itemBuilder: (context, index) =>
                _buildItem(context, favorites[index], responsive, false),
          );
        },
      ),
    );
  }

  Widget _buildItem(
      BuildContext context,
      dynamic product,
      Responsive responsive,
      bool isLandscape,
      ) {
    final imageUrl =
    product.image != null ? _imageBase + product.image! : null;

    return CustomListCard(
      onTap: () => Navigator.pushNamed(
        context,
        '/productDetails',
        arguments: product,
      ),
      leading: imageUrl != null
          ? Image.network(
        imageUrl,
        width: responsive.scaleWidth(isLandscape ? 35 : 60),
        height: responsive.scaleHeight(isLandscape ? 35 : 60),
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          AppAssets.product,
          width: responsive.scaleWidth(isLandscape ? 35 : 60),
        ),
      )
          : Image.asset(
        AppAssets.product,
        width: responsive.scaleWidth(isLandscape ? 35 : 60),
      ),
      title: product.name,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${product.price.toStringAsFixed(2)} KD',
            style: TextStyle(
              fontSize: responsive.scaleWidth(isLandscape ? 9 : 14),
              fontWeight: FontWeight.bold,
              color: const Color(0xff656565),
            ),
          ),
          SizedBox(height: responsive.scaleHeight(4)),
          if (product.categoryName != null)
            Text(
              product.categoryName!,
              style: TextStyle(
                fontSize: responsive.scaleWidth(isLandscape ? 11 : 14),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: IconButton(
        alignment: Alignment.topRight,
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.close_outlined,
          color: Colors.grey,
          size: responsive.scaleWidth(isLandscape ? 16 : 20),
        ),
        onPressed: () =>
            context.read<FavoriteCubit>().toggleFavorite(product),
      ),
    );
  }
}

