import 'package:flutter/material.dart';
import 'package:school_management_system/models/FacultyStudent.dart';
import 'package:school_management_system/models/StudentResult.dart';

class StudentResult extends StatefulWidget {
  static final id = "/FacultyStudentResult";

  @override
  _StudentResultState createState() => _StudentResultState();
}

class _StudentResultState extends State<StudentResult> {
  List ResultData = [
    {"sub": "Maths", "total": 100, "marks": 78, "grade": 'B'},
    {"sub": "Science", "total": 100, "marks": 98, "grade": 'A'},
    {"sub": "English", "total": 100, "marks": 88, "grade": 'B'},
    {"sub": "Hindi", "total": 100, "marks": 87, "grade": 'B'},
    {"sub": "Social Study", "total": 100, "marks": 89, "grade": 'B'},
    {"sub": "Computer", "total": 100, "marks": 96, "grade": 'A'},
    {"sub": "Drawing", "total": 100, "marks": 78, "grade": 'B'},
  ];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> argu = ModalRoute.of(context)!.settings.arguments as dynamic;
    FacultyStudent student = argu['student'];
    List<TableRow> data;
    var Result = ResultModal(className: 'IX', subResult: ResultData);

    // add student result comment this after backend
    student.Result.add(Result);
    student.Result.add(ResultModal(className: 'X', subResult: ResultData));

    List<TableRow> getTableRow(int index) {
      data = [];
      student.Result[index].subResult.forEach((value) {
        data.add(
          TableRow(children: [
            Text(
              value['sub'],
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 50,
              color: Color(0xffE6EFFF),
              child: Center(
                  child: Text(
                value['total'].toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
            ),
            Container(
              height: 50,
              color: Color(0xffB2CEFF),
              child: Center(
                  child: Text(
                value['marks'].toString() + ' - ' + value['grade'],
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )),
            ),
          ]),
        );
      });
      return data;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff2855ae), Color(0xff7292cf)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Text(
                    "Results",
                    style:
                        TextStyle(fontSize: 24, fontFamily: "source pro sans", color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 20),
                    itemCount: student.Result.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffe1e3e8)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // for subname
                            Center(
                              child: Text(
                                'Class - ' + student.Result[index].className,
                                style: TextStyle(
                                    fontSize: 28,
                                    color: Color(0xff313131),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            //SizedBox(height: 10,),

                            Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffE1E3E8),
                                ),
                              ),
                              margin: EdgeInsets.all(10),
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(2),
                                  1: FlexColumnWidth(2),
                                  2: FlexColumnWidth(2),
                                },
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                children: getTableRow(index),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
