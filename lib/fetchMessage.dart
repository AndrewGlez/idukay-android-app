import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

String BASE_URL = "https://idukay.net/api/notifications_inbox?__page=1&__per_page=50&__search_properties=%7B%22name%22:%22Asunto%22,%22property%22:%22subject%22,%22selected%22:true%7D&__search_properties=%7B%22name%22:%22Destinatarios%22,%22property%22:%22relational_data.recipients_names%22,%22selected%22:true%7D&__search_properties=%7B%22name%22:%22Remitente%22,%22property%22:%22relational_data.sender.full_name%22,%22selected%22:true%7D&__search_properties=%7B%22name%22:%22Texto+del+mensaje%22,%22property%22:%22content%22,%22selected%22:true%7D&__sort=%7B%22date%22:%22desc%22%7D&global_search=&populate=%7B%22sender%22:%22name+surname+second_name+second_surname+photo%22%7D&select=_id+subject+sender+date+recipient+attachments+advertisement+video_call";

Future<Map> fetchMessages(Map<String, String> headers) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authorization = prefs.getString("Authorization")!;

  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load messages');

  }

}

Future<Map> fetchMessagesContent(String id, Map<String, String> headers) async {
  String BASE_URL = "https://idukay.net/api/notifications_inbox?_id=$id&populate=%7B%22sender%22%3A%22name+surname+second_name+second_surname+photo%22%7D";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authorization = prefs.getString("Authorization")!;

  final response = await http.get(Uri.parse(BASE_URL), headers: headers);

  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map;
    return jsonResponse;
  }else {
    throw Exception('Failed to load messages');

  }

}


