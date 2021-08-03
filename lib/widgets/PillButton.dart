import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final Function onPressed;
  final Color bgColor;
  final Color fgColor;
  final IconData icon;

  const PillButton(
      {Key? key,
      required this.onPressed,
      required this.bgColor,
      required this.fgColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Icon(
          icon,
          size: 40.0,
          color: fgColor,
        ),
      ),
    );
  }
}
