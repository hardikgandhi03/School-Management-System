import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/screens/NotificationScreen.dart';
import 'package:school_management_system/screens/Student/AssignmentScreen.dart';
import 'package:school_management_system/screens/Student/HomeworkScreen.dart';
import 'package:school_management_system/screens/Student/MainMenuScreen.dart';
import 'package:school_management_system/screens/Student/TimeTableScreen.dart';
import 'package:school_management_system/services/StudentService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/Student/StudentDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  static final String id = 'StudentDashBoardScreen';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  bool _isLoading = true;
  GlobalKey _bottomNavigationKey = GlobalKey();

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await StudentService.getStudentData(prefs.getString('UserID')!);
    if (res['status']) {
      Provider.of<Student>(context, listen: false).fromJson(json: res['data'][0]);
      setState(() {
        _isLoading = false;
      });
    } else {
      //TODO: Uncomment the lines during deployment
      // prefs.clear();
      // Navigator.pushReplacementNamed(context, SelectScreen.id);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  final List<Widget> _pages = [
    MainMenuScreen(),
    HomeworkScreen(),
    AssignmentScreen(),
    TimeTableScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: kPrimaryBlue,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimaryBlue,
              title: Text(_selectedIndex == 0 ? '' : _pages[_selectedIndex].toString()),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.pushNamed(context, NotificationScreen.id);
                  },
                  // margin: EdgeInsets.only(right: 20),
                ),
              ],
            ),
            drawer: SafeArea(
              child: StudentDrawer(),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: Container(
              color: Colors.white,
              child: CurvedNavigationBar(
                key: _bottomNavigationKey,
                items: [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.home_work_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.assignment,
                    size: 30,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
                animationDuration: Duration(milliseconds: 300),
                color: kPrimaryButtonColor,
                height: 60,
                backgroundColor: Colors.transparent,
                buttonBackgroundColor: kPrimaryButtonColor,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          );
  }
}
