import 'package:flutter/foundation.dart';

class Faculty extends ChangeNotifier {
  String name = '',
      email = '',
      classTeacher = '',
      DOB = '',
      phone = '',
      address = '',
      gender = '',
      password = '',
      profileImg = '';
  List<String> OtherClasses = [];

  Faculty(
      {this.name = '',
      this.email = '',
      this.classTeacher = '',
      this.profileImg = '',
      this.address = '',
      this.password = '',
      this.DOB = '',
      this.phone = '',
      this.gender = ''});

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'email': this.email,
      'contactNumber': this.phone,
      'dateOfBirth': this.DOB,
      'classTeacher': this.classTeacher,
      'address': this.address,
      'photo': this.profileImg,
      'gender': this.gender,
      'otherClasses': this.OtherClasses,
      'password':this.password,
    };
  }

  void updateStudent(Faculty faculty) {
    this.address = faculty.address;
    this.name = faculty.name;
    this.DOB = faculty.DOB;
    this.phone = faculty.phone;
    this.email = faculty.email;
    this.classTeacher = faculty.classTeacher;
    this.profileImg = faculty.profileImg;
    this.gender = faculty.gender;
    this.password=faculty.password;
    print(this.toJson());
    notifyListeners();
  }

  void fromJson({required Map<String, dynamic> json}) {
    this.address = json['address'] ?? this.address;
    this.name = json['name'] ?? this.name;
    this.DOB = json['DOB'] ?? this.DOB;
    this.phone = json['phone'] ?? this.phone;
    this.password = json['password'] ?? this.password;
    this.email = json['email'] ?? this.email;
    this.classTeacher = json['classTeacher'] ?? this.classTeacher;
    this.profileImg = json['profileImg'] ?? this.profileImg;
    this.gender = json['gender'] ?? this.gender;
    this.OtherClasses=json['otherClasses']??this.OtherClasses;
    notifyListeners();
  }
}
