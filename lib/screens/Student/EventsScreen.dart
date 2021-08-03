import 'package:flutter/material.dart';
import 'package:school_management_system/models/Event.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsScreen extends StatefulWidget {
  static final id = "EventsScreen";

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Event> _eventsList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getEvent.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _eventsList = data.map((event) => new Event.fromJson(event)).toList();
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
            title: 'Events',
            body: _eventsList.length == 0
                ? Center(
                    child: Text('No remarks found.'),
                  )
                : ListView.builder(
                    itemCount: _eventsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _eventsList[index].title,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    _eventsList[index].description,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Date:',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          _eventsList[index].date,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 16.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Time:',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          _eventsList[index].time,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 16.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          );
  }
}
