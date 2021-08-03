import 'package:school_management_system/models/Student.dart';
import 'package:school_management_system/services/NetworkHelper.dart';

class StudentService {
  static Future getStudentData(String id) async {
    var data = await NetworkHelper.getData(
      path: 'studentModule/getStudentData.php',
      parameters: {'sid': id},
    );
    return data;
  }

  static Future updateStudentData(String id, Student student) async {
    var response = await NetworkHelper.putData(
      path: 'studentModule/updateProfile.php',
      parameters: {'sid': id},
      body: student.toJson(),
    );
    return response;
  }
}
