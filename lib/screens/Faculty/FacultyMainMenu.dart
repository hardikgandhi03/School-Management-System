import 'package:flutter/material.dart';
import 'package:school_management_system/screens/Faculty/FacultyStudentList.dart';

class FacultyMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List otherClasses=['X','XI','IX','IIX'];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xff2855ae),Color(0xff7292cf)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.loose,
        children: [
          // profile short
          Positioned(
            top: 0,
            left: 1,
            right: 1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi Akshay",style: TextStyle(fontFamily: 'source sans pro',fontSize: 30,color: Colors.white),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(Icons.mail,color: Colors.white.withOpacity(0.61),size: 20,),
                          SizedBox(width: 5,),
                          Text("akshayd@gmail.com",style: TextStyle(fontFamily: 'source sans pro',fontSize: 18,color: Colors.white.withOpacity(0.61)),),
                        ],
                      )
                    ],
                  ),
                  CircleAvatar(
                    radius: 40,
                  ),
                ],
              ),
            ),
          ),

          // for navitems
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Text("My Class",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20,fontFamily: "source sans pro",),),
                    ),

                    // for class
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(FacultyStudentList.id,arguments: {'type':false});
                        print("hello");
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xffeeeeff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffdce6f2),
                              blurRadius: 15.0, // soften the shadow
                              spreadRadius: 5.0, //extend the shadow
                              offset: Offset(
                                5.0, // Move to right 10  horizontally
                                5.0, // Move to bottom 10 Vertically
                              ),
                            ),
                          ],
                        ),
                        child: Center(child: Text("IX",style: TextStyle(color: Color(0xff345fb4),fontFamily: "source sans pro",fontSize: 28),)),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Other Classes",style: TextStyle(fontSize: 20,fontFamily: "source sans pro",fontWeight: FontWeight.w600),),
                          GestureDetector(
                            onTap: (){},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                              child: Row(
                                children: [
                                  Icon(Icons.add,color: Colors.blueAccent,size: 20,),
                                  Text("Add Class",style: TextStyle(color: Colors.blueAccent,fontSize: 15),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // for other classes
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.36,
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemCount: otherClasses.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(FacultyStudentList.id,arguments: {'type':false});
                                // Navigator.of(context).pushNamed(ExamSchedule.id);
                                print("hello");
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xfffef8ea),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xfff0ece3),
                                      blurRadius: 15.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        5.0, // Move to right 10  horizontally
                                        5.0, // Move to bottom 10 Vertically
                                      ),
                                    ),
                                  ],
                                ),
                                child: Center(child: Text(otherClasses[index],style: TextStyle(color: Color(0xffe9ae24),fontFamily: "source sans pro",fontSize: 28),)),
                              ),
                            );
                          }),
                    ),

                  ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
