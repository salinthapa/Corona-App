import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constraint.dart';

class CountryItem extends StatelessWidget {
  final String countryName;
  final String flagUrl;
  final Function() onPress;

  CountryItem(
      {required this.countryName,
      required this.flagUrl,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 150,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: kThemeColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              countryName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SvgPicture.network(
              flagUrl,
              semanticsLabel: 'A Flag',
              height: 50,
              width: 50,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
