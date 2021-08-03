import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/PrincipalDeskScreen.dart';
import 'package:school_management_system/screens/Student/AttendanceScreen.dart';
import 'package:school_management_system/screens/Student/CalendarScreen.dart';
import 'package:school_management_system/screens/Student/EventsScreen.dart';
import 'package:school_management_system/screens/Student/ExamScheduleScreen.dart';
import 'package:school_management_system/screens/Student/GalleryScreen.dart';
import 'package:school_management_system/screens/Student/QuestionsScreen.dart';
import 'package:school_management_system/screens/Student/RemarksScreen.dart';
import 'package:school_management_system/screens/Student/ResultScreen.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/Student/GridItem.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [kPrimaryBlue, kSecondaryBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.loose,
        children: [
          // profile short
          Positioned(
            top: 0,
            left: 1,
            right: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi ${Provider.of<Student>(context).firstName}",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Class ${Provider.of<Student>(context).standard} - ${Provider.of<Student>(context).section} | Roll No: ${Provider.of<Student>(context).rollNumber}",
                        style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.61)),
                      )
                    ],
                  ),
                  Provider.of<Student>(context).photo == ''
                      ? CircleAvatar(
                          radius: 40, backgroundImage: AssetImage('assets/images/student.png'))
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              MemoryImage(base64Decode(Provider.of<Student>(context).photo))),
                ],
              ),
            ),
          ),

          // for Main Icons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.58,
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.only(top: 30, bottom: 20),
                children: [
                  GridItem(
                    title: "Gallery",
                    icon: "assets/images/gallery.png",
                    index: 0,
                    route: GalleryScreen.id,
                  ),
                  GridItem(
                    title: "Principal Desk",
                    icon: "assets/images/principal.png",
                    route: PrincipalDeskScreen.id,
                    index: 1,
                  ),
                  GridItem(
                    title: "Attendance Report",
                    icon: "assets/images/attendance.png",
                    index: 2,
                    route: AttendanceScreen.id,
                  ),
                  GridItem(
                    title: "Result",
                    icon: "assets/images/result.png",
                    index: 3,
                    route: ResultScreen.id,
                  ),
                  GridItem(
                    title: "Exam Schedule",
                    icon: "assets/images/exam_schedule.png",
                    index: 4,
                    route: ExamScheduleScreen.id,
                  ),
                  GridItem(
                    title: "Remarks",
                    icon: "assets/images/remarks.png",
                    index: 5,
                    route: RemarkScreen.id,
                  ),
                  GridItem(
                    title: "Events",
                    icon: "assets/images/academic.png",
                    index: 6,
                    route: EventsScreen.id,
                  ),
                  GridItem(
                    title: "Q & A",
                    icon: "assets/images/ptm.png",
                    index: 7,
                    route: QuestionsScreen.id,
                  ),
                  GridItem(
                    title: "Calendar",
                    icon: "assets/images/calendar.png",
                    index: 8,
                    route: CalendarScreen.id,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
