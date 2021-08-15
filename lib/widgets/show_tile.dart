import 'package:flutter/material.dart';

class ShowTile extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final Color containerColor;

  ShowTile(
      {required this.value,
      required this.title,
      required this.containerColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ],
        ));
  }
}
