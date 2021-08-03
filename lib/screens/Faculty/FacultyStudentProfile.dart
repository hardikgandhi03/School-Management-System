import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/models/FacultyStudent.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentProfileAttendance.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentProfileMainProfile.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentProfileTask.dart';

class FacultyStudentProfile extends StatefulWidget {
  static final id = "/StudentProfile";

  @override
  _FacultyStudentProfileState createState() => _FacultyStudentProfileState();
}

class _FacultyStudentProfileState extends State<FacultyStudentProfile> {
  var studentObj = FacultyStudent(
      name: "Dhyey Desai",
      Result: [],
      Assignment: [],
      Remarks: [],
      Attendance: {},
      Homework: [],
      className: 'X-B',
      phone: "+916527865432",
      address: "kjshtyayuu jdfustuasi hjdysu",
      roll: "10",
      dob: '05-10-2000');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff2855ae),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2855ae), Color(0xff7292cf)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                // intro
                Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        // backgroundImage: , for image
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        studentObj.name,
                        style: TextStyle(
                            fontFamily: "source sans pro",
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Class ${studentObj.className}  |  Roll no: ${studentObj.roll}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "source sans pro",
                            color: Colors.white.withOpacity(0.61)),
                      ),
                    ],
                  ),
                ),

                // the tab bar with two items
                SizedBox(
                  height: 50,
                  child: Container(
                    color: Colors.transparent,
                    child: TabBar(
                      indicatorColor: Colors.blue[100],
                      indicatorWeight: 5,
                      labelColor: Colors.white,
                      labelStyle: TextStyle(
                          fontSize: 20, fontFamily: "source sans pro", fontWeight: FontWeight.w600),
                      unselectedLabelColor: Colors.white.withOpacity(0.61),
                      unselectedLabelStyle: TextStyle(fontSize: 18, fontFamily: "source sans pro"),
                      tabs: [
                        Tab(
                          text: "Profile",
                        ),
                        Tab(
                          text: "Task",
                        ),
                        Tab(
                          text: "Attendance",
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    children: [
                      // for profile
                      StudentProfileMain(studentObj),

                      // for task
                      StudentProfileTask(
                        student: studentObj,
                      ),

                      // for attendance
                      StudentProfileAttendance(
                        student: studentObj,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
