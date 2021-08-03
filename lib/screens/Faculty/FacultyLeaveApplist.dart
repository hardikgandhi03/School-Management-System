import 'package:flutter/material.dart';
import 'package:school_management_system/widgets/Faculty/customScafold.dart';
import 'package:school_management_system/widgets/Faculty/LeaveAppWidget.dart';
import 'package:school_management_system/models/LeaveAppModal.dart';

class FacultyLeaveApplication extends StatefulWidget {
  static final id = "/Leaveapplication";

  @override
  State<FacultyLeaveApplication> createState() =>
      FacultyLeaveApplicationState();
}

class FacultyLeaveApplicationState extends State<FacultyLeaveApplication> {
  List LeaveApplist = [
    LeaveAppModal(type: "Medical",from: "01-7-2020",to: '05-7-2020',desc: "Medical Leave needed for me because i am very seek",isAccept: false,StudentName: "Akshay J Desai"),
    LeaveAppModal(type: "Medical",from: "01-7-2020",to: '05-7-2020',desc: "Medical Leave needed for me because i am very seek",isAccept: true,StudentName: "Akshay J Desai"),
    LeaveAppModal(type: "Medical",from: "01-7-2020",to: '05-7-2020',desc: "Medical Leave needed for me because i am very seek",isAccept: false,StudentName: "Akshay J Desai"),
    LeaveAppModal(type: "Medical",from: "01-7-2020",to: '05-7-2020',desc: "Medical Leave needed for me because i am very seek",isAccept: false,StudentName: "Akshay J Desai"),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: "Leave Applications",
      body: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: ListView.builder(
          itemCount: LeaveApplist.length,
          itemBuilder: (context, index) {
            return LeaveWidget(type: LeaveApplist[index].type,from: LeaveApplist[index].from,to: LeaveApplist[index].to,desc: LeaveApplist[index].desc,isAccept: LeaveApplist[index].isAccept,name: LeaveApplist[index].StudentName,);
          },
        ),
      ),
    );
  }
}
