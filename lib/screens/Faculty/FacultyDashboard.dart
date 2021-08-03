import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/models/Faculty.dart';
import 'package:school_management_system/screens/Faculty/FacultyMainMenu.dart';
import 'package:school_management_system/screens/Faculty/FacultyProfile.dart';
import 'package:school_management_system/screens/Faculty/FacultyTimeTable.dart';
import 'package:school_management_system/screens/NotificationScreen.dart';
import 'package:school_management_system/widgets/Faculty/FacultyDrawer.dart';

class FacultyDashboardScreen extends StatefulWidget {
  static final id = '/FacultyDashboard';

  @override
  _FacultyDashboardScreenState createState() => _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState extends State<FacultyDashboardScreen> {
  int selectedIndex = 0;
  Faculty teacher = Faculty(
    name: "Akshay Desai",
    email: "akshay@gmail.com",
    classTeacher: "XI-B",
    phone: "7687897657",
    address:
        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable",
    DOB: '05-10-2000',
    gender: 'male',
  );
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Pages = [FacultyMainMenu(), FacultyTimeTable(), Profile(Teacher: teacher)];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff2855ae),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(NotificationScreen.id);
              },
              child: Container(
                child: Icon(Icons.notifications),
                margin: EdgeInsets.only(right: 20),
              ),
            ),
          ],
        ),
        drawer: drawer(
          faculty: teacher,
        ),
        body: Pages[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          items: [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          animationDuration: Duration(milliseconds: 300),
          color: Color(0xff2351ad),
          height: 60,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color(0xff2351ad),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
