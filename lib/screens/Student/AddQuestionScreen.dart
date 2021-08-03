import 'package:flutter/material.dart';
import 'package:school_management_system/models/Question.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/services/QuestionService.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:school_management_system/widgets/DropDown.dart';
import 'package:school_management_system/widgets/RoundedButton.dart';
import 'package:school_management_system/widgets/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddQuestionScreen extends StatefulWidget {
  static final String id = 'AddQuestionScreen';
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  GlobalKey<FormState> _questionFormKey = GlobalKey<FormState>();

  String _teacherID = '';
  String _subjectID = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String _title = 'New Question';

  late Question _question;
  bool _isLoading = true;
  bool _isNew = true;
  var _teacherList = [];
  var _subjectList = [];

  void getTeacherList() async {
    var res = await NetworkHelper.getData(path: 'studentModule/getClassTeacherList.php');
    if (res['status']) {
      setState(() {
        _teacherList = res['data'];
        _teacherID = _teacherID == '' ? res['data'][0]['ID'] : _teacherID;
      });
    } else {
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
    }
  }

  void getSubjectList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getSubjectList.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        _subjectList = res['data'];
        _subjectID = _subjectID == '' ? res['data'][0]['ID'] : _subjectID;
      });
    } else {
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
    }
  }

  @override
  void initState() {
    getTeacherList();
    getSubjectList();
    Future.delayed(Duration.zero, () {
      setState(() {
        _isNew = ModalRoute.of(context)!.settings.arguments == null;
        if (!_isNew) {
          _question = ModalRoute.of(context)!.settings.arguments as Question;
          _title = 'Edit Question';
          _titleController.text = _question.title;
          _descriptionController.text = _question.description;
          _subjectID = _question.subjectID;
          _teacherID = _question.teacherID;
        }
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : CustomScaffold(
            title: _title,
            body: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _questionFormKey,
                    child: Column(
                      children: [
                        DropDown(
                          title: 'Select Teacher',
                          value: _teacherID,
                          items: _teacherList,
                          onChange: (String? newValue) {
                            setState(() {
                              _teacherID = newValue!;
                              print(newValue);
                            });
                          },
                        ),
                        DropDown(
                          title: 'Select Subject',
                          value: _subjectID,
                          items: _subjectList,
                          onChange: (String? newValue) {
                            setState(() {
                              _subjectID = newValue!;
                              print(newValue);
                            });
                          },
                        ),
                        TextInput(
                          hintText: '',
                          labelText: 'Title',
                          textInputType: TextInputType.text,
                          validatorFunction: (String value) {
                            if (value.isEmpty) return 'This field cannot be empty.';
                            return null;
                          },
                          textEditingController: _titleController,
                          isPassword: false,
                        ),
                        TextInput(
                          hintText: '',
                          labelText: 'Description',
                          textInputType: TextInputType.text,
                          validatorFunction: (String value) {
                            if (value.isEmpty) return 'This field cannot be empty.';
                            return null;
                          },
                          textEditingController: _descriptionController,
                          isPassword: false,
                        ),
                      ],
                    ),
                  ),
                )),
                Row(
                  children: [
                    !_isNew
                        ? Expanded(
                            child: RoundedButton(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var res = await QuestionService.deleteQuestionData(
                                      prefs.getString('UserID')!, _question.id);
                                  SnackBar snackBar = SnackBar(
                                    content: Text(
                                      res['message'],
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    backgroundColor:
                                        (res['status']) ? Colors.teal : Colors.redAccent,
                                    duration: Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.pop(context, true);
                                },
                                color: Colors.red,
                                title: 'Delete'),
                          )
                        : SizedBox(),
                    SizedBox(width: !_isNew ? 20 : 0),
                    Expanded(
                      child: RoundedButton(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                          onPressed: () async {
                            if (_questionFormKey.currentState!.validate()) {
                              Question question = Question(
                                subjectID: _subjectID,
                                teacherID: _teacherID,
                                title: _titleController.text.trim(),
                                description: _descriptionController.text.trim(),
                              );
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var res = _isNew
                                  ? await QuestionService.addQuestionData(
                                      prefs.getString('UserID')!, question)
                                  : await QuestionService.updateQuestionData(
                                      prefs.getString('UserID')!, _question.update(question));
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                  _isNew ? res['data']['message'] : res['message'],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                backgroundColor: (res['status']) ? Colors.teal : Colors.redAccent,
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              Navigator.pop(context, true);
                            }
                          },
                          title: 'Submit'),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
