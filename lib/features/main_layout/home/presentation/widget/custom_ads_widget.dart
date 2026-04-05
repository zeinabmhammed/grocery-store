import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomAdsWidget extends StatelessWidget {
  final List<String> adsImages;
  final int currentIndex;
  final Function(int) onSwipe;

  const CustomAdsWidget({
    super.key,
    required this.adsImages,
    required this.currentIndex,
    required this.onSwipe,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final double adHeight = isLandscape
        ? responsive.scaleHeight(410)
        : responsive.scaleHeight(130);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsive.scaleWidth(16)),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            int prevIndex =
                (currentIndex - 1 + adsImages.length) % adsImages.length;
            onSwipe(prevIndex);
          } else if (details.primaryVelocity! < 0) {
            int nextIndex = (currentIndex + 1) % adsImages.length;
            onSwipe(nextIndex);
          }
        },
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(responsive.scaleWidth(25)),
                child: Image.asset(
                  adsImages[currentIndex],
                  key: ValueKey<int>(currentIndex),
                  height: adHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: responsive.scaleHeight(25)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(adsImages.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: responsive.scaleWidth(8),
                  height: responsive.scaleWidth(8),
                  margin: EdgeInsets.symmetric(
                    horizontal: responsive.scaleWidth(4),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? const Color(0xFF204F38)
                        : Colors.white,
                    border: Border.all(color: Colors.green),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
