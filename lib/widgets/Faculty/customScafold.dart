import 'package:flutter/material.dart';

class CustomScafold extends StatelessWidget {
  final Widget body;
  final String title;
  final fab;

  CustomScafold({required this.body,required this.title,this.fab});


  @override
  Widget build(BuildContext context) {
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
                    title,
                    style:
                    TextStyle(fontSize: 24,
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
                child:body,
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: fab,
    );
  }
}
