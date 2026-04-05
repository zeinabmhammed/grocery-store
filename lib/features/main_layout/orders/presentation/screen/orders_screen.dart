import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_assets/app_assets.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/core/resources/widget/CustomListCard.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final List<Map<String, dynamic>> orders = const [
    {
      'id': '#8263100',
      'price': '37 KD',
      'date': '2 Sep',
      'items': 3,
      'status': 'Delivering',
      'color': Colors.amber,
    },
    {
      'id': '#8263101',
      'price': '40 KD',
      'date': '3 Sep',
      'items': 5,
      'status': 'Finished',
      'color': Colors.green,
    },
    {
      'id': '#8263102',
      'price': '25 KD',
      'date': '1 Sep',
      'items': 2,
      'status': 'Canceled',
      'color': Colors.red,
    },
    {
      'id': '#8263103',
      'price': '50 KD',
      'date': '4 Sep',
      'items': 4,
      'status': 'Moving',
      'color': Colors.blue,
    },
    {
      'id': '#8263104',
      'price': '15 KD',
      'date': '5 Sep',
      'items': 1,
      'status': 'New',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

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
              color: Colors.black, size: responsive.scaleWidth(isLandscape ? 16 : 25)),
          onPressed: () => Navigator.pop(context),
        ),
        shape: Border(
          bottom: BorderSide(
            color: const Color(0xffDEDFDF),
            width: responsive.scaleWidth(isLandscape ? 1 : 1),
          ),
        ),
      ),

      body: isLandscape
          ? GridView.builder(
        padding: EdgeInsets.all(responsive.scaleWidth(10)),
        itemCount: orders.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: responsive.scaleWidth(0),
          mainAxisSpacing: responsive.scaleHeight(10),
          childAspectRatio: 2.2,
        ),
        itemBuilder: (context, index) => _buildOrderItem(context, index, responsive, true),
      )
          : ListView.builder(
        itemCount: orders.length,
        padding: EdgeInsets.symmetric(vertical: responsive.scaleHeight(10)),
        itemBuilder: (context, index) => _buildOrderItem(context, index, responsive, false),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, int index, Responsive responsive, bool isGrid) {
    final order = orders[index];
    final Color orderColor = order['color'];

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/orderTracking");
      },
      child: CustomListCard(
        leading: Container(
          decoration: BoxDecoration(
            color: orderColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
              Icons.delivery_dining,
              color: orderColor,
              size: responsive.scaleWidth(isGrid ? 16 : 22)
          ),
        ),
        title: '${order['id']} - ${order['price']}',
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${order['date']} - ${order['items']} Items',
              style: TextStyle(
                color: Colors.grey,
                fontSize: responsive.scaleWidth(isGrid ? 10 : 14),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: responsive.scaleHeight(isGrid ? 2 : 4)),
            Text(
              'Status: ${order['status']}',
              style: TextStyle(
                color: orderColor,
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
            color: orderColor,
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