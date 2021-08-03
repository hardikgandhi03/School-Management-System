import 'package:school_management_system/models/LeaveApplication.dart';
import 'package:school_management_system/services/NetworkHelper.dart';

class LeaveApplicationService {
  static Future getLeaveApplicationData(String id) async {
    var data = await NetworkHelper.getData(
      path: 'studentModule/getLeaveApplication.php',
      parameters: {'sid': id},
    );
    return data;
  }

  static Future updateLeaveApplicationData(String id, LeaveApplication leaveApplication) async {
    var response = await NetworkHelper.putData(
      path: 'studentModule/updateLeaveApplication.php',
      parameters: {'sid': id},
      body: leaveApplication.toJson(),
    );
    return response;
  }

  static Future addLeaveApplicationData(String id, LeaveApplication leaveApplication) async {
    var response = await NetworkHelper.postData(
      path: 'studentModule/addLeaveApplication.php',
      parameters: {'sid': id},
      body: leaveApplication.toJson(),
    );
    print(response);
    return response;
  }

  static Future deleteLeaveApplicationData(String sid, String id) async {
    var response = await NetworkHelper.deleteData(
      path: 'studentModule/deleteLeaveApplication.php',
      parameters: {'sid': sid, 'id': id},
    );
    print(response);
    return response;
  }
}
