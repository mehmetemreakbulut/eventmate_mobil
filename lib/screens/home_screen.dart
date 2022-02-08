import 'package:carousel_slider/carousel_options.dart';
import 'package:eventmate/screens/events_screen.dart';
import 'package:eventmate/screens/login_screen.dart';
import 'package:eventmate/screens/profile_screen.dart';
import 'package:eventmate/service/auth_service.dart';
import 'package:eventmate/service/events_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventmate/model/hits.dart';

import 'event_info_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hits> carouselImages = [];

  List<EventModel> eventImages = [
    EventModel('assets/event_images/microphone.png', 'Müzik'),
    EventModel('assets/event_images/mask.png', 'Tiyatro'),
    EventModel('assets/event_images/popcorn.png', 'Gösteri'),
    EventModel('assets/event_images/popcorn.png', 'Sinema'),
    EventModel('assets/event_images/basketball-ball.png', 'Spor'),
    EventModel('assets/event_images/comedy-podcast.png', 'Workshop'),
  ];

  List<EventModel> placeImages = [
    EventModel('assets/place_images/art.png', 'Sanat'),
    EventModel('assets/place_images/coffee-cup.png', 'Sanat'),
    EventModel('assets/place_images/museum.png', 'Sanat'),
    EventModel('assets/place_images/open-book.png', 'Sanat'),
    EventModel('assets/place_images/park.png', 'Sanat'),
    EventModel('assets/place_images/tray.png', 'Sanat'),
  ];

  late Future check;
  List<Hits> hitsList = [];

  @override
  void initState() {
    super.initState();
    check = showHits();
  }

  setCarouselImages() {
    for (int i = 0; i < 5; i++) {
      carouselImages.add(hitsList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FutureBuilder(
                        future: AuthService.getToken(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.toString());
                          } else {
                            return Text('Wait for it');
                          }
                        }),
                    TextButton(
                      onPressed: () async {
                        await AuthService.logOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Log Out'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: Text('Profile Git'),
                    )
                  ],
                ), // müzik, tiyatro, gösteri, bale-dans, spor, workshop
                TopRow(size),
                SearchBar(size),
                SizedBox(height: 5),
                buildCarouselSlider(),
                EventsHeadline('Etkinlikler', 'assets/filter.png', size),
                ScrollRow(eventImages, size, context),
                EventsHeadline('Mekanlar', 'assets/filter.png', size),
                ScrollRow(placeImages, size, context),
                EventsHeadline('Hits', 'assets/fire.png', size),
                CreateHits(size),
                SizedBox(
                  height: 80,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container CreateHits(Size size) {
    return Container(
      width: size.width * 0.9,
      child: FutureBuilder(
        future: check,
        builder: (context, snapshot) {
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: hitsList.length, //hitsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EventInfoScreen(hits: hitsList[index])));
                    },
                    child: Container(
                      height: size.height * 0.085,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  hitsList[index].image.toString(),
                                  headers: {'Cookie': 'BXID'},
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.3,
                                  child: Text(
                                    hitsList[index].title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Text(hitsList[index].location.toString())
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Image(
                                            image: AssetImage(hitsList[index]
                                                .favImage
                                                .toString())),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Image(
                                            image: AssetImage(hitsList[index]
                                                .status
                                                .toString())),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: 20,
                                          height: 20,
                                          child: Text(hitsList[index]
                                              .personCount
                                              .toString())),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        child: Image(
                                            image: AssetImage(hitsList[index]
                                                .personImage
                                                .toString())),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Container ScrollRow(List<EventModel> list, Size size, BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.12,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EventsScreen(
                                title: list[index].title.toString(),
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(list[index].image.toString()),
                        width: MediaQuery.of(context).size.height * 0.08,
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Text(list[index].title.toString())
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Container EventsHeadline(String text, String image, Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      width: size.width * 0.90,
      height: size.height * 0.05,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image(
              image: AssetImage(image),
            ),
          )
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          enlargeCenterPage: true,
          viewportFraction: 1,
          height: MediaQuery.of(context).size.height * 0.25,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5)),
      items: carouselImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image.image.toString(),
                    headers: {'Cookie': 'BXID'},
                    fit: BoxFit.fitHeight,
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  Widget SearchBar(Size size) {
    return Container(
      width: size.width * 0.90,
      height: size.height * 0.05,
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: 'Etkinlik, Mekan...',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          focusColor: Colors.black,
        ),
      ),
    );
  }

  Widget TopRow(Size size) {
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.05,
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Image(
              image: AssetImage('assets/star.png'),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: Text('2'),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                Image(image: AssetImage('assets/dices.png')),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: Text('5'),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                Image(image: AssetImage('assets/lottery.png')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showHits() async {
    var data = await EventsService.getHits();

    for (int i = 0; i < 10; i++) {
      print(data['results'][i]);
      Hits newHit = Hits(
          data['results'][i]['id'],
          data['results'][i]['image_url'],
          data['results'][i]['title'],
          data['results'][i]['venueCity'],
          'assets/star.png',
          'assets/check.png',
          data['results'][i]['numberUserq2'].toString());
      hitsList.add(newHit);
    }
    setState(() {
      setCarouselImages();
    });
  }
}

class EventModel {
  String? image;
  String? title;

  EventModel(this.image, this.title);
}
