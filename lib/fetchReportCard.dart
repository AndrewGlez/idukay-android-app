import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';


String BASE_URL = "https://idukay.net/api/student_year_summary?include_averages=true&student=644005763211a66a09b80675";


Future<Map> fetchReportCard(Map<String, String> headers) async {

  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load card');

  }

}
