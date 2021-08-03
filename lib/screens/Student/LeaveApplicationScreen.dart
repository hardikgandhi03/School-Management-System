import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/models/LeaveApplication.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/screens/Student/AddLeaveApplicationScreen.dart';
import 'package:school_management_system/services/LeaveApplicationService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaveApplicationScreen extends StatefulWidget {
  static final String id = 'LeaveApplicationScreen';

  @override
  _LeaveApplicationScreenState createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  List<LeaveApplication> _leaveApplicationsList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await LeaveApplicationService.getLeaveApplicationData(prefs.getString('UserID')!);
    if (res['status']) {
      setState(() {
        print(res['data']);
        List data = res['data'];
        _leaveApplicationsList =
            data.map((leaveApplication) => LeaveApplication.fromJson(leaveApplication)).toList();
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
                var data = await Navigator.pushNamed(context, AddLeaveApplicationScreen.id);
                if (data != null && data == true) {
                  getData();
                }
              },
              backgroundColor: kPrimaryButtonColor,
              child: Icon(Icons.add),
            ),
            title: 'Leave Applications',
            body: _leaveApplicationsList.length == 0
                ? Center(
                    child: Text('No leave applications found.'),
                  )
                : ListView.builder(
                    itemCount: _leaveApplicationsList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (_leaveApplicationsList[index].approved == 0) {
                            var data = await Navigator.pushNamed(
                                context, AddLeaveApplicationScreen.id,
                                arguments: _leaveApplicationsList[index]);
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
                                      _leaveApplicationsList[index].title,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'From: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _leaveApplicationsList[index].from,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          ' To: ',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          _leaveApplicationsList[index].to,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      _leaveApplicationsList[index].description,
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
                                  kLeaveApplicationStatusList[
                                      _leaveApplicationsList[index].approved],
                                  style: TextStyle(
                                    color: kLeaveApplicationStatusColorList[
                                        _leaveApplicationsList[index].approved],
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
