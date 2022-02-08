import 'package:eventmate/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<dynamic> login(String email, String password) async {
    var map = new Map<String, dynamic>();
    map['email'] = email;
    map['password'] = password;
    try {
      var res = await http.post(
        Uri.parse('http://10.0.2.2:8000/eventmate_api/login'),
        body: map,
      );
      return res.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await prefs.getString('token') != null) {
      return true;
    }
    return false;
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<void> logOut() async {
    var map = new Map<String, dynamic>();
    map['token'] = await AuthService.getToken();
    try {
      var res = await http.post(
        Uri.parse('http://10.0.2.2:8000/eventmate_api/logout'),
        body: map,
      );
    } catch (e) {
      print(e);
    }
    deleteToken();
  }
}
