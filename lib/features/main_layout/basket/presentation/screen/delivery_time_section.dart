import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/CustomDropdownField.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/custom_selection_tile.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSelectionTile(title: "Now"),
        SizedBox(height: responsive.scaleHeight(isLandscape ? 10 : 20)),

        Container(
          height: isLandscape ? null : responsive.scaleHeight(170),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              responsive.scaleWidth(isLandscape ? 15 : 25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: responsive.scaleWidth(10),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(
              responsive.scaleWidth(isLandscape ? 12 : 20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Delivery Time",
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 14 : 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: responsive.scaleHeight(isLandscape ? 5 : 10)),

                Text(
                  "Select Date",
                  style: TextStyle(
                    fontSize: responsive.scaleWidth(isLandscape ? 12 : 14),
                  ),
                ),

                SizedBox(height: responsive.scaleHeight(isLandscape ? 50 : 10)),

                CustomDropdownField(selectedDate: "09-15-2021"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
