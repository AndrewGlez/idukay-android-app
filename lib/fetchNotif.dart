import 'package:http/http.dart' as http;
import 'dart:convert' as convert;





Future<Map> fetchNotifications(Map<String, String> headers) async {
  String BASE_URL = "https://idukay.net/api/alerts?__page=1&__per_page=20&__sort=%7B%22date%22%3A%22desc%22%2C%22_id%22%3A%22desc%22%7D&select=title+read+date+type+reference+student";


  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load notifications');

  }

}

Future<Map> fetchNotifiContent(String notifId, Map<String, String> headers) async {
  String BASE_URL = "https://idukay.net/api/read_alert";

  Map<String, String> body = {
    "_id": notifId
  };
  final response = await http.put(Uri.parse(BASE_URL), headers: headers, body: body);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load notifications');

  }

}

