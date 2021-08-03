import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  final String route;

  const GridItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.index,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xffeeeeff),
              child: Image.asset(icon),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
