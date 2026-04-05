import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/screen/basket_screen.dart';
import 'package:greengrocer/features/main_layout/favorite/presentation/favorite_screen.dart';
import 'package:greengrocer/features/main_layout/home/presentation/screen/home_screen.dart';
import 'package:greengrocer/features/main_layout/more/presentation/screen/more_screen.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/screen/orders_screen.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) {
      _currentIndex = args;
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const BasketScreen(),
    const FavoriteScreen(),
    const MoreScreen(),
  ];

  final List<String> _titles = ["Home", "Orders", "Basket", "Favorite", "More"];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;

        return Scaffold(
          body: _screens[_currentIndex],

          bottomNavigationBar: Container(
            height: isLandscape
                ? responsive.scaleHeight(140)
                : responsive.scaleHeight(70),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(responsive.scaleWidth(35)),
                topRight: Radius.circular(responsive.scaleWidth(35)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(AppAssets.homeIcon, 0, responsive, isLandscape),
                _buildNavItem(
                  AppAssets.ordersIcon,
                  1,
                  responsive,
                  isLandscape,
                ),
                _buildNavItem(
                  AppAssets.basketIcon,
                  2,
                  responsive,
                  isLandscape,
                ),
                _buildNavItem(
                  AppAssets.favoriteIcon,
                  3,
                  responsive,
                  isLandscape,
                ),
                _buildNavItem(AppAssets.moreIcon, 4, responsive, isLandscape),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      String asset,
      int index,
      Responsive responsive,
      bool isLandscape,
      ) {
    final bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.scaleWidth(isLandscape ? 8 : 14),
          vertical: responsive.scaleHeight(isLandscape ? 10 : 6),
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(responsive.scaleWidth(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              color: isActive ? AppColors.green : AppColors.white,
              height: responsive.scaleHeight(isLandscape ? 45 : 24),
            ),
            if (isActive) ...[
              SizedBox(width: responsive.scaleWidth(4)),
              Text(
                _titles[index],
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: responsive.scaleWidth(isLandscape ? 8 : 12),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
