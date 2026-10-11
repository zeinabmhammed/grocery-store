import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/vendor_entity.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/vendors_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/vendors_state.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendors_usecase.dart';

class SellersSection extends StatelessWidget {
  const SellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SellersSectionContent();
  }
}

class _SellersSectionContent extends StatelessWidget {
  const _SellersSectionContent();

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
        BlocBuilder<VendorsCubit, VendorsState>(
          builder: (context, state) {
            if (state is VendorsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is VendorsError) {
              return Center(child: Text(state.message));
            }
            if (state is VendorsSuccess) {
              return isLandscape
                  ? _buildLandscapeGrid(state.vendors, responsive)
                  : _buildPortraitList(state.vendors, responsive);
            }
            return const SizedBox();
          },
        ),
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

  Widget _buildPortraitList(List<VendorEntity> vendors, Responsive responsive) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vendors.length,
      separatorBuilder: (_, __) => SizedBox(height: responsive.scaleHeight(12)),
      itemBuilder: (context, index) =>
          _buildSellerItem(vendors[index], responsive, false, context),
    );
  }

  Widget _buildLandscapeGrid(
    List<VendorEntity> vendors,
    Responsive responsive,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: vendors.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: responsive.scaleWidth(10),
          mainAxisSpacing: responsive.scaleHeight(15),
          mainAxisExtent: responsive.scaleHeight(300),
        ),
        itemBuilder: (context, index) =>
            _buildSellerItem(vendors[index], responsive, true, context),
      ),
    );
  }

  Widget _buildSellerItem(
    VendorEntity vendor,
    Responsive responsive,
    bool isLandscape,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        "/sellersDetails",
        arguments: vendor,
      ),
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: vendor.logoUrl != null
                    ? Image.network(
                        vendor.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.store, size: 40),
                      )
                    : const Icon(Icons.store, size: 40),
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
                          vendor.name,
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
                        vendor.rating?.toString() ?? '',
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(
                            isLandscape ? 10 : 13,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: responsive.scaleHeight(4)),
                  Text(
                    vendor.isFreeDelivery ? 'Free Delivery' : 'Paid Delivery',
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
                        vendor.status ?? '',
                        style: TextStyle(
                          fontSize: responsive.scaleWidth(isLandscape ? 8 : 12),
                          color: vendor.status == 'Open'
                              ? AppColors.green
                              : Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        vendor.distance ?? '',
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
