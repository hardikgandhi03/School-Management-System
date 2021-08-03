import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/screens/Student/DashBoardScreen.dart';
import 'package:school_management_system/screens/Student/SignUpScreen.dart';
import 'package:school_management_system/services/AuthService.dart';
import 'package:school_management_system/utils/constants.dart';
import 'package:school_management_system/widgets/PillButton.dart';
import 'package:school_management_system/widgets/RoundedButton.dart';
import 'package:school_management_system/widgets/TextInput.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginType { Email, Phone }

class LoginScreen extends StatefulWidget {
  static final String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginType _loginType = LoginType.Email;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _OTPController = TextEditingController();
  String _animationState = 'idle';

  var _emailFormKey = GlobalKey<FormState>();
  var _phoneFormKey = GlobalKey<FormState>();

  bool _isObscure = true;

  void login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kUser user = ModalRoute.of(context)!.settings.arguments as kUser;
    prefs.setString('User', user.toString());
    if (_loginType == LoginType.Email) {
      if (_emailFormKey.currentState!.validate()) {
        var data = await AuthService.emailLogin(
            email: _emailController.text.trim(), password: _passwordController.text.trim());
        if (data['status']) {
          setState(() {
            _animationState = 'success';
          });
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, DashBoardScreen.id);
          });
        } else {
          setState(() {
            _animationState = 'fail';
          });
        }
        SnackBar snackBar = SnackBar(
          content: Text(
            data!['message'],
            style: TextStyle(fontSize: 16.0),
          ),
          backgroundColor: (data['status']) ? Colors.teal : Colors.redAccent,
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else if (_phoneFormKey.currentState!.validate())
      Navigator.pushReplacementNamed(context, DashBoardScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryBlue, kPrimaryBlue, kSecondaryBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: FlareActor(
                  'assets/login_screen_bg.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  animation: _animationState,
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(35.0, 10.0, 35.0, 60.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(30.0),
                                elevation: 15.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: PillButton(
                                        onPressed: () {
                                          setState(() {
                                            _loginType = LoginType.Email;
                                          });
                                        },
                                        bgColor: _loginType == LoginType.Email
                                            ? kPrimaryBlue
                                            : Colors.white,
                                        fgColor: _loginType == LoginType.Email
                                            ? Colors.white
                                            : Colors.black,
                                        icon: Icons.mail_outline_rounded,
                                      ),
                                    ),
                                    Expanded(
                                      child: PillButton(
                                        onPressed: () {
                                          setState(() {
                                            _loginType = LoginType.Phone;
                                          });
                                        },
                                        bgColor: _loginType == LoginType.Email
                                            ? Colors.white
                                            : kPrimaryBlue,
                                        fgColor: _loginType == LoginType.Email
                                            ? Colors.black
                                            : Colors.white,
                                        icon: Icons.phone_iphone_outlined,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.0),
                              child: _loginType == LoginType.Email
                                  ? Form(
                                      key: _emailFormKey,
                                      child: Column(
                                        children: [
                                          TextInput(
                                            hintText: 'abc@mail.com',
                                            labelText: 'Email',
                                            textInputType: TextInputType.emailAddress,
                                            validatorFunction: (String str) {
                                              if (str.isEmpty) {
                                                return 'This field cannot be empty.';
                                              } else if (!RegExp(kEmailValidationRegex,
                                                      caseSensitive: false)
                                                  .hasMatch(str)) {
                                                return ('Invalid email.');
                                              }
                                              return null;
                                            },
                                            isPassword: false,
                                            textEditingController: _emailController,
                                          ),
                                          TextInput(
                                            hintText: 'Password',
                                            labelText: 'Password',
                                            suffix: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            textInputType: TextInputType.text,
                                            validatorFunction: (String str) {
                                              if (str.isEmpty) {
                                                return 'This field cannot be empty.';
                                              } else if (!RegExp(kEmailValidationRegex,
                                                      caseSensitive: false)
                                                  .hasMatch(str)) {
                                                return ('Invalid Password.');
                                              }
                                              return null;
                                            },
                                            isPassword: _isObscure,
                                            textEditingController: _passwordController,
                                          )
                                        ],
                                      ),
                                    )
                                  : Form(
                                      key: _phoneFormKey,
                                      child: Column(
                                        children: [
                                          TextInput(
                                            hintText: '9876543210',
                                            labelText: 'Contact Number',
                                            textInputType: TextInputType.phone,
                                            validatorFunction: (String str) {
                                              if (str.isEmpty) {
                                                return 'This field cannot be empty.';
                                              } else if (!RegExp(kPhoneValidationRegex,
                                                      caseSensitive: false)
                                                  .hasMatch(str)) {
                                                return ('Invalid Contact Number.');
                                              }
                                              return null;
                                            },
                                            textEditingController: _phoneController,
                                            isPassword: false,
                                          ),
                                          TextInput(
                                            hintText: '',
                                            labelText: 'OTP',
                                            textInputType: TextInputType.number,
                                            validatorFunction: (String str) {
                                              if (str.isEmpty) {
                                                return 'This field cannot be empty.';
                                              } else if (!RegExp(kOTPValidationRegex,
                                                      caseSensitive: false)
                                                  .hasMatch(str)) {
                                                return ('Invalid OTP.');
                                              }
                                              return null;
                                            },
                                            textEditingController: _OTPController,
                                            isPassword: true,
                                            isDisabled: true,
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundedButton(
                                    onPressed: login,
                                    title: _loginType == LoginType.Email ? 'LOGIN' : 'Get OTP',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New User For Application? ',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, SignUpScreen.id);
                                  },
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
