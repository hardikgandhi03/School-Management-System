import 'package:flutter/material.dart';
import 'package:school_management_system/models/Homework.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/screens/Student/HomeworkDetailsScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeworkScreen extends StatefulWidget {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Homework';
  }

  const HomeworkScreen({Key? key}) : super(key: key);

  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  bool _isLoading = true;
  List<Homework> _homeworkList = [];

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getHomework.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _homeworkList = data.map((homework) => Homework.fromJson(homework)).toList();
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : Container(
            decoration: kContainerDecoration,
            child: _homeworkList.length == 0
                ? Center(
                    child: Text('No homework found.'),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(20.0),
                    itemCount: _homeworkList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, HomeworkDetailsScreen.id,
                              arguments: _homeworkList[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                  color: Color(0xffE6EFFF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  _homeworkList[index].subjectName,
                                  style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                _homeworkList[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Issued Date:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _homeworkList[index].issueDate,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Due Date:',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _homeworkList[index].dueDate.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
  }
}
