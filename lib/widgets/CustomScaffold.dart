import 'package:flutter/material.dart';
import 'package:school_management_system/utils/constants.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget> actions;
  final fab;
  final bool isBGImage;

  const CustomScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.actions = const <Widget>[],
    this.fab,
    this.isBGImage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryBlue,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: actions,
      ),
      body: Container(
        decoration:
            isBGImage ? kContainerImageDecoration : kContainerDecoration,
        child: body,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      floatingActionButton: fab,
    );
  }
}
