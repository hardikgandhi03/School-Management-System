import 'package:flutter/material.dart';

class FacultyStudentAssignment extends StatefulWidget {
  static final id = 'StudentAssignment';

  @override
  _FacultyStudentAssignmentState createState() =>
      _FacultyStudentAssignmentState();
}

class _FacultyStudentAssignmentState extends State<FacultyStudentAssignment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                    "Assignments",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: "source pro sans",
                        color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.84,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(20.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, AssignmentDetailsScreen.id);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffe1e3e8),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                color: Color(0xffE6EFFF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'Subject $index',
                                style: TextStyle(
                                  fontFamily: "Source sans pro",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                'Assignment $index',
                                style: TextStyle(
                                  fontFamily: "Source sans pro",
                                  color: Color(0xff313131),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'Issued Date',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Source sans pro",
                                          color: Color(0xff777777)),
                                    ),
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${index + 1} / 07 / 2021',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                        color: Color(0xff3a3a3a)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      'Due Date',
                                      style: TextStyle(fontSize: 14.0,color: Color(0xff777777),fontFamily: "Source sans pro"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${index + 1} / 07 / 2021',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: "Source sans pro",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
