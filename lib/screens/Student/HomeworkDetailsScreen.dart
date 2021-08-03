import 'package:flutter/material.dart';
import 'package:school_management_system/models/Homework.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:school_management_system/widgets/RoundedButton.dart';

class HomeworkDetailsScreen extends StatefulWidget {
  static final String id = 'HomeworkDetailsScreen';
  const HomeworkDetailsScreen({Key? key}) : super(key: key);

  @override
  _HomeworkDetailsScreenState createState() => _HomeworkDetailsScreenState();
}

class _HomeworkDetailsScreenState extends State<HomeworkDetailsScreen> {
  late Homework homework;
  bool _isLoading = true;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        homework = ModalRoute.of(context)!.settings.arguments as Homework;
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : CustomScaffold(
            title: 'Homework Details',
            body: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    //color: Colors.lightBlueAccent,
                    decoration: BoxDecoration(
                      color: Color(0xffE6EFFF),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      homework.subjectName,
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name :",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            homework.title,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Description :",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            homework.description,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Due Date :",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            homework.dueDate,
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 40.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Attachments",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                RoundedButton(
                  onPressed: () {},
                  title: 'Submit',
                  padding: EdgeInsets.symmetric(horizontal: 0),
                )
              ],
            ),
          );
  }
}
