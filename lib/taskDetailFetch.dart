import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';




Future<Map> taskDetailFetch(Map<String, String> headers, String taskId) async {
  String BASE_URL = "https://idukay.net/api/student_tasks?_id=$taskId&student=${headers["selectedstudent"]}";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authorization = prefs.getString("Authorization")!;

  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load card');

  }

}
