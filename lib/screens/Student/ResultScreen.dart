import 'package:flutter/material.dart';
import 'package:school_management_system/models/Result.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:school_management_system/widgets/DropDown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  static final id = 'ResultScreen';
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List _standardList = [];
  String _selectedStandard = '';
  List<Result> _resultsList = [];
  bool _isLoading = false;
  bool _isResultLoading = true;

  void getResultStandardList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getResultStandardList.php',
        parameters: {'sid': prefs.getString('UserID')!});
    if (res['status']) {
      setState(() {
        _standardList = res['data'];
        _selectedStandard = _selectedStandard == '' ? res['data'][0]['ID'] : _selectedStandard;
        _isLoading = false;
        getData();
      });
    } else {
      //TODO: Remove while deployment
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      _isLoading = false;
    }
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await NetworkHelper.getData(
        path: 'studentModule/getResult.php',
        parameters: {'sid': prefs.getString('UserID')!, 'standardID': _selectedStandard});
    if (res['status']) {
      setState(() {
        List data = res['data'];
        _resultsList = data.map((result) => new Result.fromJson(result)).toList();
        _isResultLoading = false;
      });
    } else {
      //TODO: Remove while deployment
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      setState(() {
        _isResultLoading = false;
      });
    }
  }

  @override
  void initState() {
    getResultStandardList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingScreen() : buildCustomScaffold();
  }

  CustomScaffold buildCustomScaffold() {
    return CustomScaffold(
      title: 'Result',
      body: _standardList.isEmpty
          ? Center(
              child: Text('No results found.'),
            )
          : Column(
              children: [
                DropDown(
                  items: _standardList,
                  value: _selectedStandard,
                  title: 'Select Standard',
                  onChange: (String newValue) {
                    setState(() {
                      _selectedStandard = newValue;
                      _isResultLoading = true;
                    });
                    getData();
                  },
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  shrinkWrap: true,
                  itemCount: _resultsList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _resultsList[index].subjectName,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            color: Color(0xFFE6EFFF),
                            child: Center(
                                child: Text(
                              _resultsList[index].score,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            color: Color(0xFFB2CEFF),
                            child: Center(
                                child: Text(
                              '${_resultsList[index].score} - ${_resultsList[index].grade} ',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              alignment: FractionalOffset(0.5, 0.2),
              children: [
                CircleAvatar(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '85%',
                        style: TextStyle(
                          fontSize: 46,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'GRADE A',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                  radius: 54,
                  backgroundColor: Color(0xFFC2D7F2),
                )
              ],
            ),
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/resultBackground.png'),
                  alignment: FractionalOffset(0.1, 0.1),
                  fit: BoxFit.contain,
                ),
                gradient: new LinearGradient(
                  colors: [
                    Color(0xFF2855AE),
                    Color(0xFF7292CF),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Your Result is Here',
                        style: TextStyle(
                            fontSize: 15, color: Color(0xFF313131), fontWeight: FontWeight.w800),
                      ),
                      Text(
                        'Akshay Desai !!',
                        style: TextStyle(
                            fontSize: 32, color: Color(0xFF313131), fontWeight: FontWeight.bold),
                      ),
                      //SizedBox(height: 10,),

                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE1E3E8),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        margin: EdgeInsets.all(10),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                          },
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          //border: TableBorder.all(),
                          children: [
                            TableRow(children: [
                              Text(
                                'English',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFE6EFFF),
                                child: Center(
                                    child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
                                child: Container(
                                  height: 50,
                                  color: Color(0xFFB2CEFF),
                                  child: Center(
                                      child: Text(
                                    '74 - B ',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                            ]),
                            TableRow(children: [
                              Text(
                                'English',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFE6EFFF),
                                child: Center(
                                    child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFB2CEFF),
                                child: Center(
                                    child: Text(
                                  '74 - B ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              )
                            ]),
                            TableRow(children: [
                              Text(
                                'English',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFE6EFFF),
                                child: Center(
                                    child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFB2CEFF),
                                child: Center(
                                    child: Text(
                                  '74 - B ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              )
                            ]),
                            TableRow(children: [
                              Text(
                                'English',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFE6EFFF),
                                child: Center(
                                    child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFB2CEFF),
                                child: Center(
                                    child: Text(
                                  '74 - B ',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              )
                            ]),
                            TableRow(children: [
                              Text(
                                'English',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height: 50,
                                color: Color(0xFFE6EFFF),
                                child: Center(
                                    child: Text(
                                  '100',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                )),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                                child: Container(
                                  height: 50,
                                  color: Color(0xFFB2CEFF),
                                  child: Center(
                                      child: Text(
                                    '74 - B ',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Image(
                          image: AssetImage('assets/images/vector_bottom.png'),
                          // height: 100,
                          // width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )

                      // Container(
                      //   decoration: BoxDecoration(
                      //     image:DecorationImage(
                      //       image: AssetImage('assets/bottom.png')
                      //     )
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
