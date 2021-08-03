import 'package:flutter/material.dart';
import 'package:school_management_system/models/Event.dart';
import 'package:school_management_system/widgets/Faculty/customScafold.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddEvents.dart';

class FacultyEvent extends StatefulWidget {
  static final id = '/Facultyevent';

  @override
  State<FacultyEvent> createState() => _FacultyEventState();
}

class _FacultyEventState extends State<FacultyEvent> {
  List<Event> events = [
    Event(
        title: "Rangoli Compition",
        description:
            "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year.",
        date: "01-01-2021",
        img: "assets/images/profile.png"),
    Event(
        title: "Rangoli Compition",
        description:
            "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year.",
        date: "01-01-2021",
        img: "assets/images/profile.png"),
    Event(
        title: "Rangoli Compition",
        description:
            "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year.",
        date: "01-01-2021",
        img: "assets/images/profile.png"),
    Event(
        title: "Rangoli Compition",
        description:
            "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year.",
        date: "01-01-2021",
        img: "assets/images/profile.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: "Events",
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FacultyAddEvent.id,arguments: {'eventobj':events[index],'edit':true}).then((value){
                  setState(() {
                    events[index]=value as Event;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E3E8)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 140,
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // for img
                          Expanded(
                            child: Container(
                              // margin: EdgeInsets.only(top:5,left: 5),
                              height: 120,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage(events[index].img),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          // for event desc
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // for name and date
                              Text(
                                events[index].title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Color(0xff2351ad),
                                    size: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      events[index].date,
                                      style: TextStyle(
                                          color: Color(0xff2351ad), fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                width: 250,
                                height: 60,
                                child: Text(
                                  events[index].description,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        // itemCount: eventname.length,
      ),
      fab: FloatingActionButton(
        backgroundColor: Color(0xff2351ad),
        child: Icon(Icons.event),
        onPressed: (){
          Navigator.of(context).pushNamed(FacultyAddEvent.id,arguments: {'edit':false,'event':events}).then((value) {
            setState(() {
              if(value!=null){
                events=value as List<Event>;
              }
            });
          });
        },
      ),
    );
  }
}
