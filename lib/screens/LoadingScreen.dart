import 'package:flutter/material.dart';
import 'package:school_management_system/utils/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: kPrimaryBlue,
            backgroundColor: kSecondaryBlue,
          ),
        ),
      ),
    );
  }
}
