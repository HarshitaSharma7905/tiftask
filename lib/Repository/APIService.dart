import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:task/Model/EventModel.dart';

class APIService
{
String url = 'https://sde-007.api.assignment.theinternetfolks.works/v1/event';
//fetch all data
Future<List<EventData>> getData() async {
 var response = await http.get(Uri.parse(url));

 if (response.statusCode == 200) {
  Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  EventContent eventContent = EventContent.fromJson(jsonResponse['content']);

// Access the data
  List<EventData> eventDataList = eventContent.data;
  return eventDataList;
 }
 throw Exception(response.body);
}
}

