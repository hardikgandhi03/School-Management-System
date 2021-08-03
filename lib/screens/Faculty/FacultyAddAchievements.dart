import 'package:school_management_system/models/AchievementModal.dart';
import 'package:flutter/material.dart';

class FacultyAddAchievements extends StatefulWidget {
  static final id = "/facultyAddAchievements";

  @override
  _FacultyAddAchievementsState createState() => _FacultyAddAchievementsState();
}

class _FacultyAddAchievementsState extends State<FacultyAddAchievements> {
  bool isedit=false;
  late AchievementModal achievement;
  List achievements=[];
  String title='', desc='';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argu = ModalRoute.of(context)!.settings.arguments as dynamic;
    isedit = argu['edit'];
    if (isedit) {
      achievement = argu['achiobj'];
    } else {
      achievements = argu['achievements'];
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
                            Navigator.pop(context,achievement);
                          }else{
                            Navigator.of(context).pop();
                          }
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Text(
                      "Add Achievement",
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
                            "Achievement Title",
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
                            initialValue: isedit ? achievement.title : null,
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
                            initialValue: isedit ? achievement.desc : null,
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
                              AchievementModal e=AchievementModal(title: title,desc: desc);
                              achievements.add(e);

                              Navigator.pop(context,achievements);
                            }else{

                              if(title.isNotEmpty){
                                print(title);
                                achievement.title=title;
                              }
                              if(desc.isNotEmpty){
                                print(desc);
                                achievement.desc=desc;
                              }

                              Navigator.pop(context,achievement);
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
