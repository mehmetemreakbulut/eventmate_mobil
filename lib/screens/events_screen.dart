import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventmate/screens/event_info_screen.dart';
import 'package:eventmate/service/events_service.dart';
import 'package:flutter/material.dart';
import 'package:eventmate/model/hits.dart';

class EventsScreen extends StatefulWidget {
  final String title;
  const EventsScreen({Key? key, required this.title}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final ScrollController _scrollController = ScrollController();
  String? title;
  String nextUrl = '';
  bool isLoading = false;

  List<Hits> carouselImages = [];

  List<Hits> hitsList = [];

  @override
  void initState() {
    super.initState();
    fetchData(widget.title.toString());
    showEvents().then((value) => setCarouselImages());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          showEvents();
        });
      }
    });
  }

  setCarouselImages() {
    for (int i = 0; i < 5; i++) {
      carouselImages.add(hitsList[i]);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                TopRow(size),
                SearchBar(size),
                SizedBox(
                  height: 10,
                ),
                buildCarouselSlider(),
                EventsHeadline(
                    widget.title.toString(), 'assets/filter.png', size),
                CreateHits(size)
              ],
            ),
          ),
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
                  fit: BoxFit.fitHeight,
                  headers: {'Cookie': 'BXID'},
                ),
              ),
            );
          },
        );
      }).toList(),
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

  Container CreateHits(Size size) {
    return Container(
        width: size.width * 0.9,
        child: Stack(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: hitsList.length,
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
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    child: Text(
                                      hitsList[index].title.toString(),
                                      softWrap: true,
                                      maxLines: 2,
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
                                        ),
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
                }),
            if (isLoading) ...[
              Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.05,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
            ]
          ],
        ));
  }

  fetchData(String category) {
    switch (category) {
      case 'Müzik':
        {
          nextUrl =
              'http://10.0.2.2:8000/eventmate_api/BiletixEvents?category=M%C3%9CZ%C4%B0K&ordering=-numberUserq2&limit=10';
        }
        break;

      case 'Tiyatro':
        {
          nextUrl =
              'http://10.0.2.2:8000/eventmate_api/BiletixEvents?subCategory=Tiyatro&ordering=-numberUserq2&limit=10';
        }
        break;

      case 'Gösteri':
        {
          nextUrl =
              'http://10.0.2.2:8000/eventmate_api/BiletixEvents?subCategory=G%C3%B6steri&ordering=-numberUserq2&limit=10';
        }
        break;
      case 'Sinema':
        {
          nextUrl =
              'http://10.0.2.2:8000/eventmate_api/BiletixEvents?subCategory=Sinema&ordering=-numberUserq2&limit=10';
        }
        break;

      case 'Spor':
        {
          nextUrl =
              'http://10.0.2.2:8000/eventmate_api/BiletixEvents?category=SPOR&ordering=-numberUserq2&limit=10';
        }
        break;

      case 'Workshop':
        {
          nextUrl = '';
        }
        break;
    }
  }

  Future<void> showEvents() async {
    setState(() {
      isLoading = true;
    });
    var data = await EventsService.getEvents(nextUrl);
    nextUrl = data['next'];
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
      isLoading = false;
    });
  }
}
