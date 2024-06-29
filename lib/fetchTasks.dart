import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';


Future<Map<String, dynamic>> fetchArticles(Map<String, String> headers) async {


  DateTime startOfDay = DateTime.now().toLocal();
  DateTime startOfCurrentDay = DateTime(startOfDay.year, startOfDay.month, startOfDay.day, 0, 0, 0, 0).subtract(const Duration(hours: 5));
  int secondsSinceEpoch = startOfCurrentDay.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  final response = await http.get(
      Uri.parse(
          'https://idukay.net/api/student_tasks?gte=%7B%22property%22:%22due_date%22,%22parameters%22:$secondsSinceEpoch%7D&lte=%7B%22property%22:%22start_date%22,%22parameters%22:$secondsSinceEpoch%7D&select=_id+course+name+optional+student+status+relative_due_date+start_date+attachments&student=${headers["selectedstudent"]}&year=${headers["workingyear"]}'),
      headers: headers);

  if (response.statusCode == 200) {

    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;

    return jsonResponse;

  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load tasks');
  }
}
Future<String> postLogin(SharedPreferences prefs) async {
  prefs = await SharedPreferences.getInstance();

  Map<String, String> reqHeaders = {
    "User-Agent": "PostmanRuntime/7.32.1"
  };
  Map<String, String> body = {
    "email": "fiorellabc0205@gmail.com",
    "password": "aplanforus20"
  };


  final response = await http.post(Uri.parse("https://idukay.net/api/login"), body: body, headers: reqHeaders);

  if (response.statusCode == 200) {

    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    prefs.setString("Authorization", jsonResponse["response"]["token"]);
    return jsonResponse["response"]["token"];

  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load tasks');
  }

}
Future<Map> fetchPreviousT(Map<String, String> headers) async {

  DateTime startOfDay = DateTime.now().toLocal();
  DateTime startOfCurrentDay = DateTime(startOfDay.year, startOfDay.month, startOfDay.day, 0, 0, 0, 0).subtract(const Duration(hours: 5));
  int secondsSinceEpoch = startOfCurrentDay.millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;

  String BASE_URL = "https://idukay.net/api/student_tasks?lt=%7B%22property%22%3A%22due_date%22%2C%22parameters%22%3A$secondsSinceEpoch%7D&select=_id+course+name+optional+student+status+relative_due_date+start_date+attachments&student=${headers["selectedstudent"]}&year=${headers["workingyear"]}";



  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    List<dynamic> reversedResponse = List<dynamic>.from(jsonResponse["response"].reversed);

    jsonResponse["response"] = reversedResponse;
    return jsonResponse;
  }else {
    throw Exception('Failed to load notifications');

  }

}
