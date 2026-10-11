import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/home_state.dart';
import 'package:greengrocer/features/main_layout/home/presentation/screen/category_products_screen.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  static const String _imageBase = 'https://fruits.sys-web.net/storage/';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeError) {
          return Center(child: Text(state.message));
        }

        if (state is HomeSuccess) {
          final categories = state.categories;

          if (categories.isEmpty) return const SizedBox();

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.scaleWidth(16),
              vertical: responsive.scaleHeight(isLandscape ? 30 : 10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: responsive.scaleHeight(10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      final CategoryEntity category = categories[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: responsive.scaleWidth(13),
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategoryProductsScreen(
                                categoryId: category.id,
                                categoryName: category.name,
                                products: category.products, // ← أضيف ده
                              ),
                            ),
                          ),

                          child: _buildCategoryItem(
                            imageUrl: _imageBase + category.img,
                            label: category.name,
                            responsive: responsive,
                            isLandscape: isLandscape,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildCategoryItem({
    required String imageUrl,
    required String label,
    required Responsive responsive,
    required bool isLandscape,
  }) {
    double boxWidth = responsive.scaleWidth(isLandscape ? 75 : 80);
    double boxHeight = responsive.scaleHeight(isLandscape ? 310 : 85);

    return Column(
      children: [
        Container(
          width: boxWidth,
          height: boxHeight,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: responsive.scaleWidth(8),
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
            child: Padding(
              padding: EdgeInsets.all(responsive.scaleWidth(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Image.asset(
                  AppAssets.product,
                  fit: BoxFit.contain,
                ),
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: responsive.scaleHeight(6)),
        Text(
          label,
          style: TextStyle(fontSize: responsive.scaleWidth(11)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}