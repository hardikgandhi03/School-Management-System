import 'package:flutter/material.dart';
import 'package:school_management_system/models/Remark.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemarkScreen extends StatefulWidget {
  static final String id = "RemarkScreen";

  @override
  _RemarkScreenState createState() => _RemarkScreenState();
}

class _RemarkScreenState extends State<RemarkScreen> {
  List<Remark> _remarksList = [];
  bool _isLoading = true;

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getRemarks.php', parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _remarksList = data.map((remark) => new Remark.fromJson(remark)).toList();
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
            title: 'Remarks',
            body: _remarksList.length == 0
                ? Center(
                    child: Text('No remarks found.'),
                  )
                : ListView.builder(
                    // padding: EdgeInsets.symmetric(vertical: 15),
                    itemCount: _remarksList.length,
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
                                    _remarksList[index].subjectName,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    _remarksList[index].description,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!_remarksList[index].status)
                                  setState(() {
                                    _remarksList[index].status = !_remarksList[index].status;
                                  });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffe1e3e8).withOpacity(0.89),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                child: Text(
                                  _remarksList[index].status ? 'Completed' : "Parent's Signature",
                                  style: TextStyle(
                                      color:
                                          _remarksList[index].status ? Colors.green : Colors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
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
