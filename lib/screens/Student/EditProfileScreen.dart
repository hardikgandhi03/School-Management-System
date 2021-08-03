import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/screens/LoadingScreen.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:school_management_system/services/StudentService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/CustomScaffold.dart';
import 'package:school_management_system/widgets/DropDown.dart';
import 'package:school_management_system/widgets/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  static final String id = 'EditProfileScreen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var _signUPFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _rollNoController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  var teacherList;

  String _teacherID = '';
  String _gender = kGenderList[0];
  String _photo = '';

  bool _isImageLoading = false;
  bool _isLoading = true;

  void getData() async {
    Student student = Provider.of<Student>(context, listen: false);
    _nameController.text = student.firstName + ' ' + student.middleName + ' ' + student.lastName;
    _emailController.text = student.email;
    _phoneController.text = student.contactNumber;
    _dobController.text = student.dateOfBirth;
    _rollNoController.text = student.rollNumber;
    _addressController.text = student.address;
    _gender = student.gender;
    _teacherID = student.classTeacher;
    _photo = student.photo;
  }

  void changePhoto() async {
    setState(() {
      _isImageLoading = true;
    });
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 300, maxWidth: 300);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _photo = base64Encode(bytes);
        _isImageLoading = false;
      });
    } else {
      setState(() {
        _isImageLoading = false;
      });
    }
  }

  void getTeacherList() async {
    var res = await NetworkHelper.getData(path: 'studentModule/getClassTeacherList.php');
    if (res['status']) {
      teacherList = res['data'];
      _teacherID = res['data'][0]['ID'];
      setState(() {
        _isLoading = false;
      });
    } else {
      //TODO: Remove this comment during deployment
      // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
    }
  }

  void updateProfile() async {
    List<String> name = _nameController.text.trim().split(' ');
    Student student = Student(
      firstName: name[0],
      lastName: name.length == 3 ? name[2] : name[1],
      middleName: name.length == 3 ? name[1] : '',
      email: _emailController.text.trim(),
      contactNumber: _phoneController.text.trim(),
      dateOfBirth: _dobController.text.trim(),
      rollNumber: _rollNoController.text.trim(),
      classTeacher: _teacherID,
      address: _addressController.text.trim(),
      photo: _photo,
      gender: _gender,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await StudentService.updateStudentData(prefs.getString('UserID')!, student);
    SnackBar snackBar = SnackBar(
      content: Text(
        res['message'],
        style: TextStyle(fontSize: 16.0),
      ),
      backgroundColor: res['status'] ? Colors.teal : Colors.redAccent,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (res['status']) {
      Provider.of<Student>(context, listen: false).updateStudent(student);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    getTeacherList();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LoadingScreen()
        : CustomScaffold(
            title: 'My Profile',
            actions: [
              GestureDetector(
                onTap: updateProfile,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        color: kPrimaryBlue,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "DONE",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            body: Container(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: ClipRRect(
                              child: _isImageLoading
                                  ? LoadingScreen()
                                  : _photo == ''
                                      ? Image.asset(
                                          'assets/images/student.png',
                                          fit: BoxFit.contain,
                                        )
                                      : Image.memory(
                                          base64Decode(_photo),
                                          fit: BoxFit.contain,
                                        ),
                              //image
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFF5278C1)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _nameController.text,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                'Class ${Provider.of<Student>(context).standard}-${Provider.of<Student>(context).section}   |  Roll no: ${_rollNoController.text}',
                                // class and roll num
                                style: TextStyle(fontSize: 16, color: Color(0xFF777777)
                                    //fontWeight: FontWeight.bold
                                    ),
                              )
                            ],
                          ),
                          Container(
                              child: IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 22,
                              color: Color(0XFF777777),
                            ),
                            onPressed: changePhoto,
                          ))
                        ],
                      ),
                    ),
                    Form(
                      key: _signUPFormKey,
                      child: Column(
                        children: [
                          TextInput(
                            hintText: 'John Doe',
                            labelText: 'Name',
                            textInputType: TextInputType.name,
                            validatorFunction: (String str) {
                              if (str.isEmpty)
                                return 'This field can not be empty.';
                              else
                                return null;
                            },
                            textEditingController: _nameController,
                            isPassword: false,
                          ),
                          TextInput(
                            hintText: 'jhondoe@mail.com',
                            labelText: 'Email',
                            textInputType: TextInputType.emailAddress,
                            validatorFunction: (String str) {
                              if (str.isEmpty) {
                                return 'This field cannot be empty.';
                              } else if (!RegExp(kEmailValidationRegex, caseSensitive: false)
                                  .hasMatch(str)) {
                                return ('Invalid email.');
                              }
                              return null;
                            },
                            textEditingController: _emailController,
                            isPassword: false,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextInput(
                                  hintText: '9876543210',
                                  labelText: 'Contact Number',
                                  textInputType: TextInputType.phone,
                                  validatorFunction: (String str) {
                                    if (str.isEmpty) {
                                      return 'This field cannot be empty.';
                                    } else if (!RegExp(kPhoneValidationRegex, caseSensitive: false)
                                        .hasMatch(str)) {
                                      return ('Invalid Contact Number.');
                                    }
                                    return null;
                                  },
                                  textEditingController: _phoneController,
                                  isPassword: false,
                                ),
                              ),
                              Expanded(
                                child: DropDown(
                                  title: 'Gender',
                                  value: _gender,
                                  items: kGenderList,
                                  onChange: (String? newValue) {
                                    setState(() {
                                      _gender = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextInput(
                                  hintText: '',
                                  labelText: 'Date Of Birth',
                                  textInputType: TextInputType.datetime,
                                  validatorFunction: (String str) {
                                    if (str.isEmpty)
                                      return 'This field can not be empty.';
                                    else
                                      return null;
                                  },
                                  textEditingController: _dobController,
                                  isPassword: false,
                                  isReadOnly: true,
                                  onClick: () async {
                                    List<String> date = _dobController.text.split('-');
                                    DateTime selectedDate = date.length > 1
                                        ? DateTime(
                                            int.parse(date[0]),
                                            int.parse(date[1]),
                                            int.parse(date[2]),
                                          )
                                        : DateTime.now();
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate, // Refer step 1
                                      firstDate: DateTime(1930),
                                      lastDate: DateTime.now(),
                                    );
                                    if (picked != null && picked != selectedDate)
                                      setState(() {
                                        selectedDate = picked;
                                        _dobController.text =
                                            '${picked.year}-${picked.month}-${picked.day}';
                                      });
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextInput(
                                  hintText: 'D19CE152',
                                  labelText: 'Roll Number',
                                  textInputType: TextInputType.name,
                                  validatorFunction: (String str) {
                                    if (str.isEmpty)
                                      return 'This field can not be empty.';
                                    else
                                      return null;
                                  },
                                  textEditingController: _rollNoController,
                                  isPassword: false,
                                ),
                              ),
                            ],
                          ),
                          DropDown(
                            title: 'Class Teacher',
                            value: _teacherID,
                            items: teacherList,
                            onChange: (String? newValue) {
                              setState(() {
                                _teacherID = newValue!;
                                print(newValue);
                              });
                            },
                          ),
                          TextInput(
                            hintText: 'Street 1, Street 2, City, Pin, State',
                            labelText: 'Address',
                            textInputType: TextInputType.streetAddress,
                            validatorFunction: (String str) {
                              if (str.isEmpty)
                                return 'This field can not be empty.';
                              else
                                return null;
                            },
                            textEditingController: _addressController,
                            isPassword: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
