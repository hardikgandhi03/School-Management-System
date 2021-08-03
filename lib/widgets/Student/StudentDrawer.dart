import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/SelectScreen.dart';
import 'package:school_management_system/screens/Student/AchievementsScreen.dart';
import 'package:school_management_system/screens/Student/EditProfileScreen.dart';
import 'package:school_management_system/screens/Student/LeaveApplicationScreen.dart';
import 'package:school_management_system/screens/Student/TeacherListScreen.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              color: kBackgroundColor,
            ),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                children: [
                  Provider.of<Student>(context).photo == ''
                      ? CircleAvatar(
                          radius: 40, backgroundImage: AssetImage('assets/images/student.png'))
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              MemoryImage(base64Decode(Provider.of<Student>(context).photo))),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Provider.of<Student>(context).firstName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Class ${Provider.of<Student>(context).standard} - ${Provider.of<Student>(context).section} | Roll No: ${Provider.of<Student>(context).rollNumber}",
                      style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.50))),
                ],
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.article,
                  size: 25,
                  color: Colors.black,
                ),
                title: Text(
                  'Leave Application',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, LeaveApplicationScreen.id);
                },
              ),
              SizedBox(
                height: 5,
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.ondemand_video,
              //     size: 25,
              //     color: Colors.black,
              //   ),
              //   title: Text(
              //     'Courses',
              //     style: TextStyle(fontSize: 18),
              //   ),
              //   onTap: () {
              //     Navigator.popAndPushNamed(context, CourseScreen.id);
              //   },
              // ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/images/teacherfinal.png'),
                title: Text(
                  'Teacher List',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, TeacherListScreen.id);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/images/trophy.png'),
                title: Text(
                  'Achievements',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, AchievementsScreen.id);
                },
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset('assets/images/edit.png'),
                title: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, EditProfileScreen.id);
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.exit_to_app,
                    size: 25,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              tileColor: kPrimaryButtonColor,
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacementNamed(context, SelectScreen.id);
              },
            ),
          ),
        ],
      ),
    );
  }
}
