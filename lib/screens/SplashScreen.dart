import 'package:flutter/material.dart';
import 'package:school_management_system/screens/SelectScreen.dart';
import 'package:school_management_system/screens/Student/DashBoardScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String id = 'SplashScreen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initialization() {
    Duration duration = Duration(seconds: 1);
    bool loggedIn = true;
    Future.delayed(duration, () {
      Navigator.pushReplacementNamed(
          context, loggedIn ? DashBoardScreen.id : SelectScreen.id);
    });
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/SplashScreen.png'),
        ),
      ),
    );
  }
}
