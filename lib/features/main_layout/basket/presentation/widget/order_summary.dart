import 'package:flutter/material.dart';
import 'package:greengrocer/features/main_layout/basket/presentation/widget/summary_row.dart';

class OrderSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SummaryRow(label: "Total Items",
          value: "4 Items in cart",
          isBold: true,
        ),
        SummaryRow(label: "Subtotal", value: "36.00 KD"),
        SummaryRow(label: "Shipping Charges", value: "1.50 KD"),
        Divider(),
        SummaryRow(label: "Bag Total", value: "37.50 KD", isBold: true),
      ],
    );
  }
}
