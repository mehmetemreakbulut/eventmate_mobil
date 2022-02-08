import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventsService {
  final String _baseUrl = '';

  static Future<dynamic> getHits() async {
    var response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/eventmate_api/BiletixEvents?ordering=-numberUserq2&limit=10'));
    return await jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> getEvents(String url) async {
    var response = await http.get(Uri.parse(url));
    return await jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<bool> addInterestedEvent(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();

    var response = await http.patch(Uri.parse(url), headers: map);
    return response.statusCode == 200 ? true : false;
  }

  static Future<dynamic> getEventDetails(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();

    var response = await http.get(Uri.parse(url), headers: map);
    return await jsonDecode(utf8.decode(response.bodyBytes));
  }
}
