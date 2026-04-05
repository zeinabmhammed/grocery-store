import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greengrocer/core/resources/app_colors/app_colors.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key});

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int _start = 60;
  Timer? _timer;

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() => timer.cancel());
      } else {
        setState(() => _start--);
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timerText,
          style: GoogleFonts.poppins(
            fontSize: responsive.scaleWidth(isLandscape ? 15 : 22),
            fontWeight: FontWeight.bold,
            color: AppColors.grey,
          ),
        ),

        SizedBox(height: responsive.scaleHeight(isLandscape ? 5 : 10)),

        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Not received? ",
              style: TextStyle(
                fontSize: responsive.scaleWidth(isLandscape ? 12 : 16),
                color: AppColors.black,
              ),
            ),
            GestureDetector(
              onTap: _start == 0
                  ? () {
                setState(() => _start = 60);
                startTimer();
              }
                  : null,
              child: Text(
                "Send Again",
                style: TextStyle(
                  fontSize: responsive.scaleWidth(isLandscape ? 13 : 18),
                  color: _start == 0
                      ? AppColors.green
                      : AppColors.grey,
                  fontWeight: FontWeight.bold,
                  decoration: _start == 0 ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
