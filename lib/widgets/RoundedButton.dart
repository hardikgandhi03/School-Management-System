import 'package:flutter/material.dart';
import 'package:school_management_system/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final EdgeInsets padding;
  final Color color;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.all(15.0),
    this.color = kPrimaryButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        elevation: 8.0,
        padding: EdgeInsets.all(15.0),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () => onPressed(),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
