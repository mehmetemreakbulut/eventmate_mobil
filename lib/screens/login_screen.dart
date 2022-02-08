import 'dart:convert';

import 'package:eventmate/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: size.height * 0.8,
              width: size.width * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 25),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        hintText: 'Username',
                        prefixText: ' ',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                      )),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextField(
                      controller: _passwordController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.black,
                        ),
                        hintText: 'Password',
                        prefixText: ' ',
                        hintStyle: TextStyle(color: Colors.grey),
                        focusColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                      )),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      AuthService as = AuthService();
                      as
                          .login(
                              _emailController.text, _passwordController.text)
                          .then((value) async {
                        print(value);
                        var data = jsonDecode(value);
                        print(data['token']);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('token', data['token']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    },
                    child: Text('Log In'),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.blue),
                  ),
                  SizedBox(height: 25),
                  FutureBuilder(
                      future: AuthService.getToken(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.toString());
                        } else {
                          return Text('Token yok aga');
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
