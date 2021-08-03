import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/ExamSchdule.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamScheduleScreen extends StatefulWidget {
  static final String id = 'ExamScheduleScreen';
  ExamScheduleScreen({Key? key}) : super(key: key);

  @override
  _ExamScheduleScreenState createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  List<ExamSchedule> examScheduleList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getExamSchedule.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        print(res['data']);
        examScheduleList = data.map((schedule) => new ExamSchedule.fromJson(schedule)).toList();
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
        : CustomScaffold(
            title: 'Exam Schedule',
            isBGImage: true,
            body: examScheduleList.length == 0
                ? Center(
                    child: Text('No remarks found.'),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Standard: ${Provider.of<Student>(context).standard}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: examScheduleList.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 10, top: 5),
                                child: Text(
                                  examScheduleList[index].subjectName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff313131),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff6ac259).withOpacity(0.11),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  examScheduleList[index].date,
                                  // value.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff3a3a3a),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffe6efff).withOpacity(0.4),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  examScheduleList[index].from,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff2351ad)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
  }
}
