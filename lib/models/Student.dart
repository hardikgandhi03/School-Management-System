import 'package:flutter/foundation.dart';

class Student extends ChangeNotifier {
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String email = '';
  String contactNumber = '';
  String dateOfBirth = '';
  String rollNumber = '';
  String classTeacher = '';
  String gender = '';
  String address = '';
  String password = '';
  String photo = '';
  String section = '';
  String standard = '';

  Student({
    this.firstName = '',
    this.lastName = '',
    this.middleName = '',
    this.email = '',
    this.contactNumber = '',
    this.dateOfBirth = '',
    this.rollNumber = '',
    this.classTeacher = '',
    this.address = '',
    this.password = '',
    this.photo = '',
    this.gender = '',
    this.standard = '',
    this.section = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'middleName': this.middleName,
      'email': this.email,
      'contactNumber': this.contactNumber,
      'dateOfBirth': this.dateOfBirth,
      'rollNumber': this.rollNumber,
      'classTeacher': this.classTeacher,
      'address': this.address,
      'photo': this.photo,
      'password': this.password,
      'gender': this.gender,
    };
  }

  void updateStudent(Student student) {
    this.address = student.address;
    this.firstName = student.firstName;
    this.middleName = student.middleName;
    this.lastName = student.lastName;
    this.dateOfBirth = student.dateOfBirth;
    this.contactNumber = student.contactNumber;
    this.email = student.email;
    this.rollNumber = student.rollNumber;
    this.classTeacher = student.classTeacher;
    this.photo = student.photo;
    this.gender = student.gender;
    print(this.toJson());
    notifyListeners();
  }

  void fromJson({required Map<String, dynamic> json}) {
    this.address = json['address'] ?? this.address;
    this.firstName = json['firstName'] ?? this.firstName;
    this.middleName = json['middleName'] ?? this.middleName;
    this.lastName = json['lastName'] ?? this.lastName;
    this.dateOfBirth = json['dateOfBirth'] ?? this.dateOfBirth;
    this.contactNumber = json['contactNumber'] ?? this.contactNumber;
    this.password = json['password'] ?? this.password;
    this.email = json['email'] ?? this.email;
    this.rollNumber = json['rollNumber'] ?? this.rollNumber;
    this.classTeacher = json['classTeacher'] ?? this.classTeacher;
    this.photo = json['photo'] ?? this.photo;
    this.section = json['sectionName'] ?? this.section;
    this.standard = json['standardNumber'] ?? this.standard;
    this.gender = json['gender'] ?? this.gender;
    notifyListeners();
  }
}
