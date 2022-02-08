import 'package:eventmate/screens/event_info_screen.dart';
import 'package:eventmate/screens/home_screen.dart';
import 'package:eventmate/screens/events_screen.dart';
import 'package:eventmate/screens/messages_screen.dart';
import 'package:eventmate/service/auth_service.dart';
import 'package:eventmate/widget/CustomBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //return EventInfoScreen();
    //return HomeScreen();
    //return LoginScreen();
    /*return FutureBuilder(
        future: AuthService.hasToken(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return CircularProgressIndicator();
          } else if (snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        });*/
    return Scaffold(
      body: Stack(children: [
        FutureBuilder(
            future: AuthService.hasToken(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              } else if (snapshot.data == true) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }),
        Positioned(
          width: size.width,
          height: 50,
          left: 0,
          bottom: 0,
          child: Stack(children: [
            CustomPaint(
              size: Size(size.width, 50),
              painter: CustomBottomNavigationBar(),
            ),
            Center(
                heightFactor: 0.5,
                child: Image.asset(
                  'assets/eventmate-logo.png',
                  width: 100,
                  height: 100,
                )),
            Container(
              color: Colors.transparent,
              width: size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 32,
                    icon: Icon(
                      Icons.home,
                      color: currentIndex == 0
                          ? Colors.white
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setBottomBarIndex(0);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.favorite,
                        color: currentIndex == 1
                            ? Colors.white
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(1);
                      }),
                  Container(
                    width: size.width * 0.16,
                  ),
                  IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.bookmark,
                        color: currentIndex == 2
                            ? Colors.white
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(2);
                      }),
                  IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.person,
                        color: currentIndex == 3
                            ? Colors.white
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        setBottomBarIndex(3);
                      }),
                ],
              ),
            )
          ]),
        ),
      ]),
    );
    //return RegisterScreen();
    return ProfileScreen();
    //return MessagesScreen();
    //return EventsScreen();
  }
}
