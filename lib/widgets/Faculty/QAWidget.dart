import 'package:flutter/material.dart';

class QAWidget extends StatefulWidget {
  String title,sub,doubt;

  QAWidget({this.title='',this.doubt='',this.sub=''});

  @override
  _QAWidgetState createState() => _QAWidgetState();
}

class _QAWidgetState extends State<QAWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffe1e3e8)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // for studentname & type
          Container(
            child: Text(
              widget.sub,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "source sans pro",
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Color(0xff6789ca),
            ),
            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
            padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 5),
          ),
          // SizedBox(height: 7,),
          Container(
            child: Text(
              widget.title,
              style: TextStyle(
                  color: Color(0xff313131),
                  fontFamily: "source sans pro",
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            padding: EdgeInsets.only(
                top: 10, left: 15, right: 15, bottom: 5),
          ),

          // for descr
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Text(
                  widget.doubt,
                  style: TextStyle(
                      color: Color(0xff777777),
                      fontFamily: "source sans pro",
                      fontSize: 13),
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                margin: EdgeInsets.only(bottom: 10),
                width: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
