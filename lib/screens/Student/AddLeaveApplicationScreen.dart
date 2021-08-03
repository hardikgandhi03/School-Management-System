import 'package:flutter/material.dart';
import 'package:school_management_system/models/LeaveApplication.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/LeaveApplicationService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:school_management_system/widgets/DropDown.dart';
import 'package:school_management_system/widgets/RoundedButton.dart';
import 'package:school_management_system/widgets/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLeaveApplicationScreen extends StatefulWidget {
  static final String id = 'AddLeaveApplicationScreen';
  const AddLeaveApplicationScreen({Key? key}) : super(key: key);

  @override
  _AddLeaveApplicationScreenState createState() => _AddLeaveApplicationScreenState();
}

class _AddLeaveApplicationScreenState extends State<AddLeaveApplicationScreen> {
  GlobalKey<FormState> _leaveApplicationKey = GlobalKey<FormState>();

  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  String _type = kLeaveApplicationTypes[0];
  String _title = 'New Application';

  late LeaveApplication _leaveApplication;
  bool _isLoading = true;
  bool _isNew = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _isNew = ModalRoute.of(context)!.settings.arguments == null;
        if (!_isNew) {
          _leaveApplication = ModalRoute.of(context)!.settings.arguments as LeaveApplication;
          _title = 'Edit application';
          _type = _leaveApplication.title;
          _fromController.text = DateTime.parse(_leaveApplication.from).isAfter(DateTime.now())
              ? _leaveApplication.from
              : '';
          _toController.text = DateTime.parse(_leaveApplication.to).isAfter(DateTime.now())
              ? _leaveApplication.to
              : '';
          _reasonController.text = _leaveApplication.description;
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _leaveApplicationKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextInput(
                                  hintText: '',
                                  labelText: 'From',
                                  suffix: Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.grey,
                                  ),
                                  textInputType: TextInputType.datetime,
                                  validatorFunction: (String str) {
                                    if (str.isEmpty)
                                      return 'This field can not be empty.';
                                    else
                                      return null;
                                  },
                                  textEditingController: _fromController,
                                  isPassword: false,
                                  isReadOnly: true,
                                  onClick: () async {
                                    DateTime selectedDate = _fromController.text.isNotEmpty
                                        ? DateTime.parse(_fromController.text)
                                        : DateTime.now();
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050),
                                    );
                                    if (picked != null && picked != selectedDate)
                                      setState(() {
                                        selectedDate = picked;
                                        _fromController.text = picked.toString().split(' ')[0];
                                        _toController.clear();
                                      });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextInput(
                                  hintText: '',
                                  labelText: 'To',
                                  suffix: Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.grey,
                                  ),
                                  textInputType: TextInputType.datetime,
                                  validatorFunction: (String str) {
                                    if (str.isEmpty)
                                      return 'This field can not be empty.';
                                    else
                                      return null;
                                  },
                                  textEditingController: _toController,
                                  isPassword: false,
                                  isDisabled: _fromController.text.isEmpty ? true : false,
                                  isReadOnly: true,
                                  onClick: () async {
                                    DateTime selectedDate = _toController.text.isNotEmpty
                                        ? DateTime.parse(_toController.text)
                                        : DateTime.parse(_fromController.text);
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime.parse(_fromController.text),
                                      lastDate: DateTime(2050),
                                    );
                                    if (picked != null && picked != selectedDate)
                                      setState(() {
                                        selectedDate = picked;
                                        _toController.text = picked.toString().split(' ')[0];
                                      });
                                  },
                                ),
                              )
                            ],
                          ),
                          DropDown(
                            title: 'Type',
                            value: _type,
                            items: kLeaveApplicationTypes,
                            onChange: (String value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                          TextInput(
                            hintText: 'Reason',
                            labelText: 'Reason',
                            textInputType: TextInputType.text,
                            validatorFunction: (String str) {
                              if (str.isEmpty)
                                return 'This field can not be empty.';
                              else
                                return null;
                            },
                            textEditingController: _reasonController,
                            isPassword: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    !_isNew
                        ? Expanded(
                            child: RoundedButton(
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                                onPressed: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var res =
                                      await LeaveApplicationService.deleteLeaveApplicationData(
                                          prefs.getString('UserID')!, _leaveApplication.id);
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
                            if (_leaveApplicationKey.currentState!.validate()) {
                              LeaveApplication leaveApplication = LeaveApplication(
                                from: _fromController.text.trim(),
                                to: _toController.text.trim(),
                                title: _type,
                                description: _reasonController.text.trim(),
                              );
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var res = _isNew
                                  ? await LeaveApplicationService.addLeaveApplicationData(
                                      prefs.getString('UserID')!, leaveApplication)
                                  : await LeaveApplicationService.updateLeaveApplicationData(
                                      prefs.getString('UserID')!,
                                      _leaveApplication.update(leaveApplication));
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
            ));
  }
}
