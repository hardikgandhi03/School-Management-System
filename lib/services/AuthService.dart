import 'package:dbcrypt/dbcrypt.dart';
import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/services/NetworkHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<dynamic> emailLogin({
    required String email,
    required String password,
  }) async {
    var res = await NetworkHelper.getData(
      path: 'studentModule/emailLogin.php',
      parameters: {'email': email},
    );
    DBCrypt _dBCrypt = DBCrypt();
    if (res['status']) {
      if (_dBCrypt.checkpw(password, res['data'][0]['password'])) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('UserID', res['data'][0]['ID']);
        return {'message': 'Login Successful!', 'status': true};
      }
    }
    return {'message': 'Invalid Email or password', 'status': false};
  }

  static dynamic signUp(Student student) async {
    DBCrypt _dBCrypt = DBCrypt();
    try {
      student.password = _dBCrypt.hashpw(student.password, _dBCrypt.gensalt());
      var res = await NetworkHelper.postData(
        path: 'studentModule/signup.php',
        body: student.toJson(),
      );
      return res;
    } catch (e) {
      print(e);
    }
  }
}
