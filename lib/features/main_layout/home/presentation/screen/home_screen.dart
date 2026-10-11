import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_categories_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_sliders_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendor_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_vendors_usecase.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/search_products_usecase.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/home_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/products_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/products_state.dart';
import 'package:greengrocer/features/main_layout/home/presentation/cubit/vendors_cubit.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/categories_section.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/custom_ads_widget.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/filter_popup.dart';
import 'package:greengrocer/features/main_layout/home/presentation/widget/sellers_section.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCubit(
            getSlidersUseCase: sl<GetSlidersUseCase>(),
            getCategoriesUseCase: sl<GetCategoriesUseCase>(),
          )..loadHomeData(),
        ),
        BlocProvider(
          create: (_) => VendorsCubit(sl<GetVendorsUseCase>())
            ..getVendors(regionId: 0),
        ),
        BlocProvider(
          create: (_) => ProductsCubit(
            getVendorProductsUseCase: sl<GetVendorProductsUseCase>(),
            searchProductsUseCase: sl<SearchProductsUseCase>(),
          ),
        ),
      ],
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  int _currentIndex = 0;
  late Timer _timer;
  bool _showSearch = false;
  final _searchController = TextEditingController();
  Timer? _debounce;

  final List<String> adsImages = [
    AppAssets.adsOne,
    AppAssets.adsTwo,
    AppAssets.adsThree,
    AppAssets.adsFour,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % adsImages.length;
        });
      }
    });
  }

  void _updateIndex(int newIndex) {
    _timer.cancel();
    setState(() => _currentIndex = newIndex);
    _startImageSwitching();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isNotEmpty) {
        context.read<ProductsCubit>().searchProducts(value);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildResponsiveAppBar(responsive, isLandscape, context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
                height: responsive.scaleHeight(isLandscape ? 10 : 15)),
          ),

          // Search Bar
          if (_showSearch)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.scaleWidth(16),
                  vertical: responsive.scaleHeight(10),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _showSearch = false;
                          _searchController.clear();
                        });
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          responsive.scaleWidth(25)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),

          // Search Results
          if (_showSearch)
            SliverToBoxAdapter(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ProductsSuccess) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No products found'),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
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
                              style: TextStyle(
                                  fontSize: responsive.scaleWidth(10)),
                            ),
                            trailing: Image.asset(AppAssets.add, scale: 2.4),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),

          // Normal Home Content
          if (!_showSearch) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? responsive.scaleWidth(50) : 0,
                ),
                child: CustomAdsWidget(
                  adsImages: adsImages,
                  currentIndex: _currentIndex,
                  onSwipe: (index) => _updateIndex(index),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                      height: responsive.scaleHeight(isLandscape ? 15 : 10)),
                  const CategoriesSection(),
                  SizedBox(
                      height: responsive.scaleHeight(isLandscape ? 15 : 20)),
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SellersSection(),
            ),
          ],

          SliverToBoxAdapter(
            child: SizedBox(height: responsive.scaleHeight(40)),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildResponsiveAppBar(
      Responsive responsive, bool isLandscape, BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: responsive.scaleHeight(isLandscape ? 110 : 55),
      title: Text(
        "Fruit Market",
        style: GoogleFonts.poppins(
          fontSize: responsive.scaleWidth(isLandscape ? 18 : 22),
          fontWeight: FontWeight.bold,
          color: AppColors.green,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showSearch = !_showSearch;
              if (!_showSearch) _searchController.clear();
            });
          },
          icon: SvgPicture.asset(
            AppAssets.searchIcon,
            width: responsive.scaleWidth(isLandscape ? 15 : 24),
          ),
        ),
        IconButton(
          onPressed: () => FilterPopup.show(context),
          icon: SvgPicture.asset(
            AppAssets.filterIcon,
            width: responsive.scaleWidth(isLandscape ? 15 : 24),
          ),
        ),
        SizedBox(width: responsive.scaleWidth(10)),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: const Color(0xffDEDFDF), height: 1),
      ),
    );
  }
}
