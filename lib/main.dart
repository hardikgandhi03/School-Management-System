import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/Faculty.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/Faculty/FacultyAchievements.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddAchievements.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddEvents.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddNewAssignment.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddRemarks.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddResult.dart';
import 'package:school_management_system/screens/Faculty/FacultyAssignment.dart';
import 'package:school_management_system/screens/Faculty/FacultyDashboard.dart';
import 'package:school_management_system/screens/Faculty/FacultyEvent.dart';
import 'package:school_management_system/screens/Faculty/FacultyLeaveApplist.dart';
import 'package:school_management_system/screens/Faculty/FacultyQA.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentAssignment.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentList.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentProfile.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentRemarks.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentResult.dart';
import 'package:school_management_system/screens/LoginScreen.dart';
import 'package:school_management_system/screens/NotificationScreen.dart';
import 'package:school_management_system/screens/PrincipalDeskScreen.dart';
import 'package:school_management_system/screens/SelectScreen.dart';
import 'package:school_management_system/screens/SplashScreen.dart';
import 'package:school_management_system/screens/Student/AchievementsScreen.dart';
import 'package:school_management_system/screens/Student/AddLeaveApplicationScreen.dart';
import 'package:school_management_system/screens/Student/AddQuestionScreen.dart';
import 'package:school_management_system/screens/Student/AssignmentDetailsScreen.dart';
import 'package:school_management_system/screens/Student/AttendanceScreen.dart';
import 'package:school_management_system/screens/Student/CalendarScreen.dart';
import 'package:school_management_system/screens/Student/CourseDetailsScreen.dart';
import 'package:school_management_system/screens/Student/CourseScreen.dart';
import 'package:school_management_system/screens/Student/DashBoardScreen.dart';
import 'package:school_management_system/screens/Student/EditProfileScreen.dart';
import 'package:school_management_system/screens/Student/EventsScreen.dart';
import 'package:school_management_system/screens/Student/ExamScheduleScreen.dart';
import 'package:school_management_system/screens/Student/GalleryScreen.dart';
import 'package:school_management_system/screens/Student/HomeworkDetailsScreen.dart';
import 'package:school_management_system/screens/Student/LeaveApplicationScreen.dart';
import 'package:school_management_system/screens/Student/QuestionsScreen.dart';
import 'package:school_management_system/screens/Student/RemarksScreen.dart';
import 'package:school_management_system/screens/Student/ResultScreen.dart';
import 'package:school_management_system/screens/Student/SignUpScreen.dart';
import 'package:school_management_system/screens/Student/TeacherListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String _title = 'School Management System';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Student>(
          create: (context) => Student(),
        ),
        ChangeNotifierProvider<Faculty>(
          create: (context) => Faculty(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Source Sans Pro'),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          SelectScreen.id: (context) => SelectScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          CalendarScreen.id: (context) => CalendarScreen(),
          LeaveApplicationScreen.id: (context) => LeaveApplicationScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
          PrincipalDeskScreen.id: (context) => PrincipalDeskScreen(),
          RemarkScreen.id: (context) => RemarkScreen(),
          EventsScreen.id: (context) => EventsScreen(),
          AssignmentDetailsScreen.id: (context) => AssignmentDetailsScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          ResultScreen.id: (context) => ResultScreen(),
          AddQuestionScreen.id: (context) => AddQuestionScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          AttendanceScreen.id: (context) => AttendanceScreen(),
          HomeworkDetailsScreen.id: (context) => HomeworkDetailsScreen(),
          AddLeaveApplicationScreen.id: (context) => AddLeaveApplicationScreen(),
          TeacherListScreen.id: (context) => TeacherListScreen(),
          ExamScheduleScreen.id: (context) => ExamScheduleScreen(),
          AchievementsScreen.id: (context) => AchievementsScreen(),
          GalleryScreen.id: (context) => GalleryScreen(),
          QuestionsScreen.id: (context) => QuestionsScreen(),
          CourseScreen.id: (context) => CourseScreen(),
          CourseDetailsScreen.id: (context) => CourseDetailsScreen(),
          FacultyDashboardScreen.id: (context) => FacultyDashboardScreen(),
          FacultyStudentList.id: (context) => FacultyStudentList(),
          FacultyStudentAssignment.id: (context) => FacultyStudentAssignment(),
          FacultyStudentRemarks.id: (context) => FacultyStudentRemarks(),
          StudentResult.id: (context) => StudentResult(),
          FacultyStudentProfile.id: (context) => FacultyStudentProfile(),
          FacultyAddRemarks.id: (context) => FacultyAddRemarks(),
          FacultyLeaveApplication.id: (context) => FacultyLeaveApplication(),
          FacultyAssignment.id: (context) => FacultyAssignment(),
          AssignmentDetail.id: (context) => AssignmentDetail(),
          FacultyEvent.id: (context) => FacultyEvent(),
          FacultyAddEvent.id: (context) => FacultyAddEvent(),
          Facultyachieve.id: (context) => Facultyachieve(),
          FacultyAddAchievements.id: (context) => FacultyAddAchievements(),
          FacultyAddResult.id: (context) => FacultyAddResult(),
          FacultyQA.id: (context) => FacultyQA(),
        },
      ),
    );
  }
}
