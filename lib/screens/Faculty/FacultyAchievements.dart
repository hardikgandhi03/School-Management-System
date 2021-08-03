import 'package:flutter/material.dart';
import 'package:school_management_system/widgets/Faculty/customScafold.dart';
import 'package:school_management_system/models/AchievementModal.dart';
import 'package:school_management_system/screens/Faculty/FacultyAddAchievements.dart';

class Facultyachieve extends StatefulWidget {
  static final id='/FacultyAcievement';

  @override
  _FacultyachieveState createState() => _FacultyachieveState();
}

class _FacultyachieveState extends State<Facultyachieve> {
 List<AchievementModal> achievements=[
   AchievementModal(title: "Dance Compition",desc: "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year."),
   AchievementModal(title: "Dance Compition",desc: "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year."),
   AchievementModal(title: "Dance Compition",desc: "A sleepover is a great treat for kids. Many schools use such an event as the culminating activity of the school year."),
 ];

  @override
  Widget build(BuildContext context) {
    return CustomScafold(
      title: "Achievements",
      body: ListView.builder(
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(FacultyAddAchievements.id,arguments: {'achiobj':achievements[index],'edit':true}).then((value){
                  setState(() {
                    achievements[index]=value as AchievementModal;
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffE1E3E8)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 120,
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

                          // for event desc
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 7,),
                              // for name and date
                              Text(
                                achievements[index].title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
                                padding: EdgeInsets.only(bottom: 5),
                                width: 250,
                                height: 60,
                                child: Text(
                                  achievements[index].desc,
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
          Navigator.of(context).pushNamed(FacultyAddAchievements.id,arguments: {'edit':false,'achievements':achievements}).then((value) {
            setState(() {
              if(value!=null){
                achievements=value as List<AchievementModal>;
              }
            });
          });
        },
      ),
    );
  }
}
