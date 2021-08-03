import 'package:flutter/material.dart';

const kPrimaryBlue = Color(0xFF2855AE);
const kSecondaryBlue = Color(0xFF7292CF);
const kPrimaryButtonColor = Color(0xFF2351AD);
const kBackgroundColor = Color(0xffD6ECF2);

enum kUser { Student, Teacher }

enum kAnimationStates { idle, success, fail, after_success }

const kEmailValidationRegex = '^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9]{2,}.[a-zA-Z0-9]{2,}\$';
const kPasswordValidationRegex =
    '^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@\$!%*?&])[A-Za-z\\d@\$!%*?&]{8,}\$';
const kPhoneValidationRegex = '^[0-9]{10}';
const kOTPValidationRegex = '^[0-9]{6}';

const kContainerDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  ),
);

const kContainerImageDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  ),
  image: DecorationImage(
      image: AssetImage(
        'assets/images/vector_bottom.png',
      ),
      alignment: Alignment.bottomCenter),
);

const kGenderList = ['Male', 'Female', 'Others'];

const kLeaveApplicationStatusList = ['Pending', 'Approved', 'Disapproved'];
const kLeaveApplicationStatusColorList = [
  Colors.yellow,
  Colors.green,
  Colors.red,
];
const kLeaveApplicationTypes = ['Medical', 'Family Emergency', 'Family Function', 'Other'];

const kTimetableDaysList = [
  {'id': 'Mon', 'value': 'Monday'},
  {'id': 'Tue', 'value': 'Tuesday'},
  {'id': 'Wed', 'value': 'Wednesday'},
  {'id': 'Thu', 'value': 'Thursday'},
  {'id': 'Fri', 'value': 'Friday'},
  {'id': 'Sat', 'value': 'Saturday'},
];
