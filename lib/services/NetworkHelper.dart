import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkHelper {
  static Future getData({required String path, Map<String, dynamic>? parameters}) async {
    Uri url = Uri(
      path: 'api/' + path,
      scheme: 'http',
      host: '10.0.2.2',
      queryParameters: parameters,
    );
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return {'data': jsonDecode(response.body), 'status': true};
      } else {
        print(response.statusCode);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  static Future postData({
    required String path,
    Map<String, dynamic>? parameters,
    required Object body,
  }) async {
    Uri url = Uri(
      path: 'api/' + path,
      scheme: 'http',
      host: '10.0.2.2',
      queryParameters: parameters,
    );
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      // print(jsonEncode(body));
      http.Response response = await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 201) {
        // print(response.body);
        return {'data': jsonDecode(response.body), 'status': true};
      } else {
        print(response.statusCode);
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future putData({
    required String path,
    Map<String, dynamic>? parameters,
    required Object body,
  }) async {
    Uri url = Uri(
      path: 'api/' + path,
      scheme: 'http',
      host: '10.0.2.2',
      queryParameters: parameters,
    );
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      http.Response response = await http.put(url, headers: headers, body: jsonEncode(body));
      print(response.statusCode);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future deleteData({required String path, Map<String, dynamic>? parameters}) async {
    Uri url = Uri(
      path: 'api/' + path,
      scheme: 'http',
      host: '10.0.2.2',
      queryParameters: parameters,
    );
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      http.Response response = await http.delete(url, headers: headers);
      print(response.statusCode);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
