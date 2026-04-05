import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';


class CategoryItem extends StatelessWidget {
  final String label;
  final String image;
  const CategoryItem({super.key, required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(15)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(responsive.scaleWidth(10)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: responsive.scaleWidth(5),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.asset(
              image,
              width: responsive.scaleWidth(60),
              height: responsive.scaleHeight(60),
            ),
          ),
          SizedBox(height: responsive.scaleHeight(10)),
          Text(
            label,
            style: TextStyle(fontSize: responsive.scaleWidth(14)),
          ),
        ],
      ),
    );
  }
}
