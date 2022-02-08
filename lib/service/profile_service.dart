import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static Future<dynamic> getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/eventmate_api/user'),
      headers: map,
    );
    return await jsonDecode(utf8.decode(response.bodyBytes));
  }

  static Future<dynamic> patchUserData(String field, dynamic data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();
    var patch = Map<String, dynamic>();
    patch[field] = data;
    print('$field // $data');
    var response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/eventmate_api/user'),
      headers: map,
      body: patch,
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> uploadImage(String path) async {
    Dio dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();
    var formData = FormData.fromMap({
      'profile_photo': await MultipartFile.fromFile(path),
    });
    var response = await dio.patch('http://10.0.2.2:8000/eventmate_api/user',
        data: formData, options: Options(headers: map));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<dynamic> getEvents(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var map = Map<String, String>();
    map['token'] = prefs.getString('token').toString();

    var response = await http.get(Uri.parse(url), headers: map);
    return await jsonDecode(utf8.decode(response.bodyBytes));
  }
}
