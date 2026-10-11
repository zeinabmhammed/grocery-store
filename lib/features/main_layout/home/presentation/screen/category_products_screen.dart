import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_category_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/category_products_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/category_products_state.dart';

class CategoryProductsScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  final List<ProductEntity> products; // ← أضيف ده

  const CategoryProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.products, // ← أضيف ده
  });

  @override
  Widget build(BuildContext context) {
    return _CategoryProductsContent(
      categoryName: categoryName,
      products: products,
    );
  }
}

class _CategoryProductsContent extends StatelessWidget {
  final String categoryName;
  final List<ProductEntity> products;

  const _CategoryProductsContent({
    required this.categoryName,
    required this.products,
  });
  // ← غيّر الـ base URL لو الصور مش شغالة
  static const String _imageBase = 'https://fruits.sys-web.net/storage/';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: responsive.scaleWidth(18),
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xffDEDFDF), height: 1),
        ),
      ),
      body: products.isEmpty
          ? const Center(child: Text('لا توجد منتجات في هذه الفئة'))
          : GridView.builder(
              padding: EdgeInsets.all(responsive.scaleWidth(16)),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: responsive.scaleWidth(12),
                mainAxisSpacing: responsive.scaleHeight(12),
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/productDetails',
                    arguments: products[index],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        responsive.scaleWidth(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: responsive.scaleWidth(8),
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // صورة المنتج
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(responsive.scaleWidth(16)),
                            ),
                            child: product.image != null
                                ? Image.network(
                                    _imageBase + product.image!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Image.asset(
                                AppAssets.product,
                                fit: BoxFit.contain,
                              ),
                                  )
                                : Container(
                                    color: Colors.grey.shade100,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(responsive.scaleWidth(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: responsive.scaleWidth(12),
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: responsive.scaleHeight(4)),
                              Text(
                                '${product.price} KD',
                                style: TextStyle(
                                  fontSize: responsive.scaleWidth(13),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
