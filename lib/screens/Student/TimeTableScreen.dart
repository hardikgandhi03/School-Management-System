import 'package:flutter/material.dart';
import 'package:school_management_system/models/Period.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTableScreen extends StatefulWidget {
  static final String id = 'TimeTableScreen';

  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Time Table';
  }

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  // Selected Day
  String _selectedDay = kTimetableDaysList[0]['value'].toString();
  List<Period> _periodList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(path: 'studentModule/getTimetable.php', parameters: {
      'sid': prefs.getString('UserID')!,
      'day': _selectedDay,
    });
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _periodList = data.map((period) => Period.fromJson(period)).toList();
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
            padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
            child: Column(
              children: [
                // Weekday tabs container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: kTimetableDaysList
                        .map(
                          (day) => Expanded(
                            //Change selected day when a day tab is clicked
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                  _selectedDay = day['value'].toString();
                                  getData();
                                });
                              },
                              // Container for Each day
                              child: Container(
                                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  // Change background color when selected day changes
                                  color: day['value'] == _selectedDay
                                      ? kPrimaryButtonColor
                                      : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    day['id'].toString(),
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      // Change text color when selected day changes
                                      color: day['value'] == _selectedDay
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                // Time Table List View
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    itemCount: _periodList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: Colors.grey.shade400,
                            )),
                        // Change container values if its lunch break
                        child: Column(
                          children: [
                            // Row containing subject and time slot
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _periodList[index].subjectName,
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      _periodList[index].timing,
                                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 2.0,
                            ),
                            // Row for Teacher name and Period number
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _periodList[index].teacherName,
                                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                                ),
                                Text(
                                  'Period ${_periodList[index].number}',
                                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
