import 'package:school_management_system/models/Question.dart';
import 'package:school_management_system/services/NetworkHelper.dart';

class QuestionService {
  static Future getQuestionData(String id) async {
    var data = await NetworkHelper.getData(
      path: 'studentModule/getQuestions.php',
      parameters: {'sid': id},
    );
    return data;
  }

  static Future updateQuestionData(String id, Question question) async {
    var response = await NetworkHelper.putData(
      path: 'studentModule/updateQuestion.php',
      parameters: {'sid': id},
      body: question.toJson(),
    );
    return response;
  }

  static Future addQuestionData(String id, Question question) async {
    var response = await NetworkHelper.postData(
      path: 'studentModule/addQuestion.php',
      parameters: {'sid': id},
      body: question.toJson(),
    );
    print(response);
    return response;
  }

  static Future deleteQuestionData(String sid, String id) async {
    var response = await NetworkHelper.deleteData(
      path: 'studentModule/deleteQuestion.php',
      parameters: {'sid': sid, 'id': id},
    );
    print(response);
    return response;
  }
}
