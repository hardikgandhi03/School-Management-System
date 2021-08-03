import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/screens/LoginScreen.dart';
import 'package:school_management_system/utils/constants.dart';

class SelectScreen extends StatelessWidget {
  static final String id = 'SelectScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage('assets/images/vector_top.png'),
            ),
            Row(
              children: [
                Expanded(
                  child: SelectCard(
                    elevation: 10.0,
                    title: 'Student',
                    imagePath: 'assets/images/student.gif',
                    margin: EdgeInsets.only(left: 15.0, right: 7.5),
                    user: kUser.Student,
                  ),
                ),
                Expanded(
                  child: SelectCard(
                    user: kUser.Teacher,
                    margin: EdgeInsets.only(left: 7.5, right: 15.0),
                    elevation: 10.0,
                    imagePath: 'assets/images/teacher.gif',
                    title: 'Teacher',
                  ),
                ),
              ],
            ),
            Image(
              image: AssetImage('assets/images/vector_bottom.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectCard extends StatelessWidget {
  final EdgeInsets margin;
  final double elevation;
  final String imagePath;
  final String title;
  final kUser user;

  const SelectCard({
    Key? key,
    required this.margin,
    required this.elevation,
    required this.imagePath,
    required this.title,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, LoginScreen.id, arguments: user);
      },
      child: Card(
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: elevation,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                imagePath,
                height: 130.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ],
        ),
        shadowColor: Colors.black,
      ),
    );
  }
}
