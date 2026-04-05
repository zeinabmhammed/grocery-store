import 'package:flutter/material.dart';
import 'package:greengrocer/features/main_layout/orders/presentation/widget/tracking_step.dart';

class TrackingVerticalStepper extends StatelessWidget {
  const TrackingVerticalStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TrackingStep(
          title: "Delivered",
          subtitle: "Estimated for 10 September, 2021",
          isCompleted: true,
        ),
        TrackingStep(
          title: "Out for delivery",
          subtitle: "Estimated for 10 September, 2021",
          isCompleted: true,
        ),
        TrackingStep(
          title: "Order shipped",
          subtitle: "Estimated for 10 September, 2021",
          isCompleted: true,
        ),
        TrackingStep(
          title: "Confirmed",
          subtitle: "Your order has been confirmed",
          isCompleted: true,
        ),
        TrackingStep(
          title: "Order Placed",
          subtitle: "We have received your order",
          isCompleted: true,
          isLast: true,
        ),
      ],
    );
  }
}
