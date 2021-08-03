import 'package:flutter/material.dart';
import 'package:school_management_system/models/Event.dart';

class FacultyAddEvent extends StatefulWidget {
  static final id = "/facultyAddEvent";

  @override
  _FacultyAddEventState createState() => _FacultyAddEventState();
}

class _FacultyAddEventState extends State<FacultyAddEvent> {
  bool isedit=false;
  late Event event;
  List events=[];
  String title='', desc='', date = "enter date";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argu = ModalRoute.of(context)!.settings.arguments as dynamic;
    isedit = argu['edit'];
    if (isedit) {
      event = argu['eventobj'];
    } else {
      events = argu['event'];
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          if(isedit){
                            Navigator.pop(context,event);
                          }else{
                           Navigator.of(context).pop();
                          }
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      "Add Events",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "source pro sans",
                          color: Colors.white),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.84,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // for title
                        Container(
                          child: Text(
                            "Event Title",
                            style: TextStyle(
                                fontFamily: "source sans pro",
                                fontSize: 16,
                                color: Color(0xffa5a5a5)),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        ),
                        Container(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffe1e3e8),
                                ),
                              ),
                              hintText: "Title",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                            ),
                            style: TextStyle(
                              fontFamily: "source sans pro",
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                title = value;
                              });
                            },
                            initialValue: isedit ? event.title : null,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            "Event Date",
                            style: TextStyle(
                                fontFamily: "source sans pro",
                                fontSize: 16,
                                color: Color(0xffa5a5a5)),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2025))
                                      .then((value) {
                                    setState(() {
                                      date = value!.day.toString() +
                                          '-' +
                                          value.month.toString() +
                                          '-' +
                                          value.year.toString();
                                      // print(_date);
                                    });
                                  });
                                },
                                iconSize: 20,
                                color: Color(0xff777777),
                                icon: Icon(Icons.calendar_today_rounded),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffe1e3e8))),
                                width: 100,
                                height: 40,
                                child: Text(
                                  isedit?event.date:date,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // description
                        Container(
                          child: Text(
                            "Description",
                            style: TextStyle(
                                fontFamily: "source sans pro",
                                fontSize: 16,
                                color: Color(0xffa5a5a5)),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        ),
                        Container(
                          height: 80,
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffe1e3e8),
                                ),
                              ),
                              hintText: "Description",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                            ),
                            style: TextStyle(
                              fontFamily: "source sans pro",
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                desc = value;
                              });
                            },
                            initialValue: isedit ? event.description : null,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(height: 50,),

                        // button
                        MaterialButton(
                            minWidth: double.infinity,
                            elevation: 8.0,
                            padding: EdgeInsets.all(15.0),
                            color: Color(0xff2351ad),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () {
                              if(!isedit){
                                Event e=Event(title: title,description: desc,date: date,img: "assets/images/profile.png");
                                events.add(e);

                                Navigator.pop(context,events);
                              }else{

                                if(title.isNotEmpty){
                                  print(title);
                                  event.title=title;
                                }
                                if(desc.isNotEmpty){
                                  print(desc);
                                  event.description=desc;
                                }
                                if(date.compareTo("enter date")>0){
                                  event.date=date;
                                }
                                event.img="assets/images/profile.png";
                                // print(event);

                                Navigator.pop(context,event);
                              }
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
