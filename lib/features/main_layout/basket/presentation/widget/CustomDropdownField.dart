import 'package:flutter/material.dart';
import 'package:greengrocer/core/resources/responsive/responsive.dart';

class CustomDropdownField extends StatefulWidget {

  String selectedDate;
  CustomDropdownField({super.key, required this.selectedDate});

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.scaleWidth(15),
        vertical: responsive.scaleHeight(5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(responsive.scaleWidth(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.selectedDate,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: responsive.scaleWidth(30),
          ),
          elevation: 16,
          style: TextStyle(
            fontSize: responsive.scaleWidth(14),
            color: Colors.black,
          ),
          items: const [
            DropdownMenuItem(
              value: "09-15-2021",
              child: Text("09-15-2022"),
            ),
            DropdownMenuItem(
              value: "09-16-2021",
              child: Text("09-16-2021"),
            ),
            DropdownMenuItem(
              value: "09-17-2021",
              child: Text("09-17-2021"),
            ),
          ],
          onChanged: (val) {
            setState(() {
              widget.selectedDate = val!;
            });
          },
        ),
      ),
    );
  }
}

