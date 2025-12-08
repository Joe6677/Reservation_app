import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateContainer extends StatelessWidget {
  String day;
  String daynum;
  DateContainer({super.key, required this.day, required this.daynum});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(day, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 5),
        Text(
          daynum,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
