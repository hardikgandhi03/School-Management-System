import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:school_management_system/models/Teacher.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherListScreen extends StatefulWidget {
  static final String id = 'TeacherListScreen';

  const TeacherListScreen({Key? key}) : super(key: key);

  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  List<Teacher> _teacherList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getTeachers.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _teacherList = data.map((teacher) => Teacher.fromJson(teacher)).toList();
        _isLoading = false;
      });
    } else {
      //TODO: Remove while deployment
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : CustomScaffold(
            title: 'Teachers List',
            body: _teacherList.length == 0
                ? Center(
                    child: Text('No teachers found.'),
                  )
                : ListView.builder(
                    itemCount: _teacherList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                        child: _teacherList[index].photo == ''
                                            ? Image.asset(
                                                'assets/images/student.png',
                                                height: 75.0,
                                                width: 75.0,
                                                fit: BoxFit.contain,
                                              )
                                            : Image.memory(
                                                base64Decode(_teacherList[index].photo),
                                                width: 75.0,
                                                height: 75.0,
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _teacherList[index].firstName +
                                              ' ' +
                                              _teacherList[index].lastName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        Text(
                                          _teacherList[index].email,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                            Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.phone,
                                  color: kPrimaryButtonColor,
                                ),
                                onPressed: () =>
                                    _launchUrl('tel: ' + _teacherList[index].contactNumber),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ));
  }
}
