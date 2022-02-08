import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              // name, surname, gender, city, age
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
                        hintText: 'Email',
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
                  SizedBox(height: size.height * 0.02),
                  TextField(
                      controller: _passwordAgainController,
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
                        hintText: 'Password Again',
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
                      controller: _nameController,
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
                        hintText: 'Name',
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
                  SizedBox(height: size.height * 0.02),
                  TextField(
                      controller: _surnameController,
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
                        hintText: 'Surname',
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
                  SizedBox(height: size.height * 0.02),
                  TextField(
                      controller: _genderController,
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
                        hintText: 'Gender',
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
                  SizedBox(height: size.height * 0.02),
                  TextField(
                      controller: _cityController,
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
                        hintText: 'City',
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
                      controller: _ageController,
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
                        hintText: 'Age',
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
                    onPressed: () async {
                      Person person = Person(
                          _emailController.text,
                          _passwordController.text,
                          _passwordAgainController.text,
                          _nameController.text,
                          _surnameController.text,
                          _genderController.text,
                          _cityController.text,
                          _ageController.text);
                      var statusC = await createUser(person);
                      print(statusC);
                    },
                    child: Text('Register'),
                    style: TextButton.styleFrom(
                        primary: Colors.white, backgroundColor: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<http.Response> createUser(Person person) {
    var map = new Map<String, dynamic>();
    map['email'] = person.email;
    map['password'] = person.password;
    map['password2'] = person.password2;
    map['name'] = person.name;
    map['surname'] = person.surname;
    map['gender'] = person.gender;
    map['city'] = person.city;
    map['age'] = person.age;
    return http.post(
      Uri.parse('http://10.0.2.2:8000/eventmate_api/register'),
      body: map,
    );
  }
}

class Person {
  String email;
  String password;
  String password2;
  String name;
  String surname;
  String gender;
  String city;
  String age;

  Person(this.email, this.password, this.password2, this.name, this.surname,
      this.gender, this.city, this.age);
}
