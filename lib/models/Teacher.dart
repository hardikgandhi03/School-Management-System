import 'package:flutter/foundation.dart';

class Teacher extends ChangeNotifier {
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

  Teacher({
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

  void updateTeacher(Teacher teacher) {
    this.address = teacher.address;
    this.firstName = teacher.firstName;
    this.middleName = teacher.middleName;
    this.lastName = teacher.lastName;
    this.dateOfBirth = teacher.dateOfBirth;
    this.contactNumber = teacher.contactNumber;
    this.email = teacher.email;
    this.rollNumber = teacher.rollNumber;
    this.classTeacher = teacher.classTeacher;
    this.photo = teacher.photo;
    this.gender = teacher.gender;
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
    this.gender = json['gender'] ?? this.gender;
    notifyListeners();
  }

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      address: json['address'] ?? '',
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      rollNumber: json['rollNumber'] ?? '',
      classTeacher: json['classTeacher'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
    );
  }
}
