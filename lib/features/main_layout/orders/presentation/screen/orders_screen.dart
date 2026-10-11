import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/di/injection.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';
import 'package:greengrocer/features/main_layout/orders/cubit/orders_cubit.dart';
import 'package:greengrocer/features/main_layout/orders/cubit/orders_state.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/get_orders_usecase.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/widget/cancel_order.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersCubit(
        getOrdersUseCase: sl<GetOrdersUseCase>(),
        cancelOrderUseCase: sl<CancelOrderUseCase>(),
      )..loadOrders(),
      child: const _OrdersScreenContent(),
    );
  }
}

class _OrdersScreenContent extends StatelessWidget {
  const _OrdersScreenContent();

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivering':
        return Colors.amber;
      case 'finished':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      case 'new':
        return Colors.purple;
      case 'moving':
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: responsive.scaleHeight(isLandscape ? 120 : 65),
        title: Text(
          "My Orders",
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
          icon: Icon(Icons.arrow_back_ios,
              color: Colors.black,
              size: responsive.scaleWidth(isLandscape ? 16 : 25)),
          onPressed: () => Navigator.pop(context),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(1),
          ),
        ),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<OrdersCubit>().loadOrders(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          if (state is OrdersSuccess) {
            if (state.orders.isEmpty) {
              return const Center(child: Text('No orders yet'));
            }

            return isLandscape
                ? GridView.builder(
              padding: EdgeInsets.all(responsive.scaleWidth(10)),
              itemCount: state.orders.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: responsive.scaleWidth(0),
                mainAxisSpacing: responsive.scaleHeight(10),
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                final color = _getStatusColor(order.status);
                return _buildOrderItem(
                  context: context,
                  responsive: responsive,
                  isGrid: true,
                  orderId: order.id,
                  price: '${order.totalPrice} KD',
                  itemsCount: order.products.length,
                  status: order.status,
                  color: color,
                  createdAt: order.createdAt ?? '',
                );
              },
            )
                : ListView.builder(
              itemCount: state.orders.length,
              padding: EdgeInsets.symmetric(
                  vertical: responsive.scaleHeight(10)),
              itemBuilder: (context, index) {
                final order = state.orders[index];
                final color = _getStatusColor(order.status);
                return _buildOrderItem(
                  context: context,
                  responsive: responsive,
                  isGrid: false,
                  orderId: order.id,
                  price: '${order.totalPrice} KD',
                  itemsCount: order.products.length,
                  status: order.status,
                  color: color,
                  createdAt: order.createdAt ?? '',
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildOrderItem({
    required BuildContext context,
    required Responsive responsive,
    required bool isGrid,
    required int orderId,
    required String price,
    required int itemsCount,
    required String status,
    required Color color,
    required String createdAt,
  }) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/orderTracking',
        arguments: {'orderId': orderId, 'status': status},
      ),
      child: CustomListCard(
        leading: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.delivery_dining,
            color: color,
            size: responsive.scaleWidth(isGrid ? 16 : 22),
          ),
        ),
        title: '#$orderId - $price',
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$createdAt - $itemsCount Items',
              style: TextStyle(
                color: Colors.grey,
                fontSize: responsive.scaleWidth(isGrid ? 10 : 14),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: responsive.scaleHeight(isGrid ? 2 : 4)),
            Text(
              'Status: $status',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: responsive.scaleWidth(isGrid ? 10 : 14),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: Container(
          width: responsive.scaleWidth(isGrid ? 20 : 70),
          height: responsive.scaleHeight(isGrid ? 90 : 70),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(responsive.scaleWidth(isGrid ? 0 : 20)),
            child: SvgPicture.asset(
              AppAssets.arrowIcon,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
