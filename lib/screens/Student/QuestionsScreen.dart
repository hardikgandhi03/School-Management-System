import 'package:flutter/material.dart';
import 'package:school_management_system/models/Question.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/screens/Student/AddQuestionScreen.dart';
import 'package:school_management_system/services/QuestionService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsScreen extends StatefulWidget {
  static final String id = 'QuestionsScreen';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  List<Question> _questionList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // TODO:
    var res = await QuestionService.getQuestionData(prefs.getString('UserID')!);
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _questionList = data.map((question) => Question.fromJson(question)).toList();
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
            fab: FloatingActionButton(
              onPressed: () async {
                var data = await Navigator.pushNamed(context, AddQuestionScreen.id);
                if (data != null && data == true) {
                  getData();
                }
              },
              backgroundColor: kPrimaryButtonColor,
              child: Icon(Icons.add),
            ),
            title: 'Question and Answers',
            body: _questionList.length == 0
                ? Center(
                    child: Text('No Questions found.'),
                  )
                : ListView.builder(
                    itemCount: _questionList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (_questionList[index].status == 0) {
                            var data = await Navigator.pushNamed(context, AddQuestionScreen.id,
                                arguments: _questionList[index]);
                            if (data != null && data == true) {
                              getData();
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _questionList[index].title,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      _questionList[index].description,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  kLeaveApplicationStatusList[_questionList[index].status],
                                  style: TextStyle(
                                    color: kLeaveApplicationStatusColorList[
                                        _questionList[index].status],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
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
