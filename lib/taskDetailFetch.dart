import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';




Future<Map> taskDetailFetch(String taskId) async {
  String BASE_URL = "https://idukay.net/api/student_tasks?_id=$taskId&student=644005763211a66a09b80675";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authorization = prefs.getString("Authorization")!;
  Map<String, String> reqHeaders = {
    "Authorization":
    authorization,
    "User-Agent": "PostmanRuntime/7.32.1",
    "selectedstudent": "644005763211a66a09b80675",
    "workingyear": "64d4f946782ad5e57bd5db54",
    "workingschool": "6081ef0b5802c45d1bdc5330",
    "workingprofile": "6440056186b45644cb5e99e9",
    "clientversion": "0.9.68"
  };
  final response = await http.get(Uri.parse(BASE_URL), headers: reqHeaders);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load card');

  }

}
