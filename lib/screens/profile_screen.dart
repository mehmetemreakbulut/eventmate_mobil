import 'package:eventmate/model/hits.dart';
import 'package:eventmate/model/profile.dart';
import 'package:eventmate/service/events_service.dart';
import 'package:eventmate/service/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'event_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _textEditingController = TextEditingController();
  late Profile _profile;
  late Future isComplete;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  Future chooseImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    var result = await ProfileService.uploadImage(image!.path);
    print(result);
    setState(() {
      _image = image;
    });
  }

  List<String> cityNames = [
    "İstanbul",
    "Ankara",
    "İzmir",
    "Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkari",
    "Hatay",
    "Iğdır",
    "Isparta",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kilis",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Şanlıurfa",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak"
  ];

  Future<void> showProfile() async {
    var data = await ProfileService.getProfile();
    Profile profile = Profile(
        data['id'],
        data['email'],
        data['name'],
        data['surname'],
        data['gender'],
        data['city'],
        data['age'].toString(),
        data['isOnline'],
        'http://10.0.2.2:8000${data['profile_photo']}',
        data['aboutMe'],
        data['job'],
        data['workplace'],
        data['university']);
    print('http://10.0.2.2:8000${data['profile_photo']}');
    print(data['profile_photo']);
    print(data['aboutMe']);

    _profile = profile;
  }

  @override
  void initState() {
    super.initState();
    isComplete = showProfile();
    showEvents();
    /*_scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() {
          showEvents();
        });
      }
    });*/
  }

  /*@override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: isComplete,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator())),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: SingleChildScrollView(
                  //controller: _scrollController,
                  //physics: NeverScrollableScrollPhysics(),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TopRow(),
                        ProfilePhotos(size),
                        Container(
                          width: size.width * 0.87,
                          child: Column(
                            children: [
                              Container(
                                height: size.height * 0.07,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                await buildShowModalBottomSheet(
                                                    context, 'name');
                                              },
                                              child: Text(
                                                '${_profile.name} ',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.grey[700],
                                                    fontSize: 18),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                _profile.surname =
                                                    await buildShowModalBottomSheet(
                                                        context, 'surname');
                                              },
                                              child: Text(
                                                '${_profile.surname}, ',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.grey[700],
                                                    fontSize: 18),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                _profile.age =
                                                    await buildShowModalBottomSheet(
                                                        context, 'age');
                                              },
                                              child: Text(
                                                '${_profile.age}',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    color: Colors.grey[700],
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            _profile.job =
                                                await buildShowModalBottomSheet(
                                                    context, 'job');
                                          },
                                          child: Text(
                                            _profile.job.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Rubik',
                                                color: Colors.grey[600]),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.015),
                                      child: Image(
                                          image: AssetImage(
                                              'assets/check-blue.png')),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: size.height * 0.05,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await cityShowModalBottomSheet(context);
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.005),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/placeholder.png')),
                                          ),
                                          Text(
                                            _profile.city.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _profile.workplace =
                                            await buildShowModalBottomSheet(
                                                context, 'workplace');
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.005),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/portfolio.png')),
                                          ),
                                          Container(
                                            width: size.width * 0.18,
                                            child: Text(
                                              _profile.workplace.toString(),
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _profile.university =
                                            await buildShowModalBottomSheet(
                                                context, 'university');
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                size.height * 0.005),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/open-book.png')),
                                          ),
                                          Container(
                                            width: size.width * 0.18,
                                            child: Text(
                                              _profile.university.toString(),
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      _profile.aboutMe =
                                          await buildShowModalBottomSheet(
                                              context, 'aboutMe');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _profile.aboutMe.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                //height: size.height * 0.15,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: size.height * 0.03,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.height * 0.005),
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/hamburger.png')),
                                              ),
                                              Text(
                                                'Burger Delisi',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.03,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.height * 0.005),
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/theater.png')),
                                              ),
                                              Text(
                                                'Sahne Tozu',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.03,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    size.height * 0.005),
                                                child: Image(
                                                    image: AssetImage(
                                                        'assets/worldwide.png')),
                                              ),
                                              Text(
                                                'Kaşif',
                                                style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: size.height * 0.04,
                                          width: size.height * 0.04,
                                          child: Image(
                                            image:
                                                AssetImage('assets/point.png'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '3400 Eventpoint',
                                              style: TextStyle(
                                                  fontFamily: 'Rubik'),
                                            ),
                                            Text(
                                              '4.7 / 5',
                                              style: TextStyle(
                                                  fontFamily: 'Rubik'),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              EventsHeadline(
                                  'Etkinliklerin', 'assets/filter.png', size),
                              createEvents(size),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  //final ScrollController _scrollController = ScrollController();
  String nextUrl = 'http://10.0.2.2:8000/eventmate_api/userEvent';
  Future<void> showEvents() async {
    setState(() {
      isLoading = true;
    });
    var data = await ProfileService.getEvents(nextUrl);
    print(data['models_to_return'].length);
    for (int i = 0; i < data['models_to_return'].length; i++) {
      Hits newHit = Hits(
          data['models_to_return'][i]['id'],
          data['models_to_return'][i]['image_url'],
          data['models_to_return'][i]['title'],
          data['models_to_return'][i]['venueCity'],
          'assets/star.png',
          'assets/check.png',
          data['models_to_return'][i]['numberUserq2'].toString());

      eventList.add(newHit);
    }
    setState(() {
      isLoading = false;
    });
  }

  List<Hits> eventList = [];
  bool isLoading = false;

  Container createEvents(Size size) {
    return Container(
        width: size.width * 0.9,
        child: Stack(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: eventList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    EventInfoScreen(hits: eventList[index])));
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
                                  eventList[index].image.toString(),
                                  headers: {'Cookie': 'BXID'},
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.3,
                                    child: Text(
                                      eventList[index].title.toString(),
                                      softWrap: true,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(eventList[index].location.toString())
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
                                              image: AssetImage(eventList[index]
                                                  .favImage
                                                  .toString())),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Image(
                                              image: AssetImage(eventList[index]
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
                                            child: Text(eventList[index]
                                                .personCount
                                                .toString())),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          child: Image(
                                              image: AssetImage(eventList[index]
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

  buildShowModalBottomSheet(BuildContext context, String field) async {
    String text = '';
    bool result = false;
    var size = MediaQuery.of(context).size;
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(20),
              width: size.width * 0.8,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _textEditingController,
                    ),
                    TextButton(
                        onPressed: () async {
                          result = await ProfileService.patchUserData(
                              field, _textEditingController.text);
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.check))
                  ],
                ),
              ),
            ),
          );
        });
    if (result == true) {
      text = _textEditingController.text;
      _textEditingController.clear();
    }
    return text;
  }

  cityShowModalBottomSheet(BuildContext context) async {
    var size = MediaQuery.of(context).size;
    bool result = false;
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(20),
              height: size.height * 0.4,
              width: size.width * 0.8,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListView.builder(
                      itemCount: cityNames.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            result = await ProfileService.patchUserData(
                                'city', cityNames[index]);
                            Navigator.pop(context);
                            setState(() {
                              _profile.city = cityNames[index];
                            });
                          },
                          title: Text(cityNames[index]),
                        );
                      })),
            ),
          );
        });
    if (result) {
      return true;
    }
    return false;
  }

  Container ProfilePhotos(Size size) {
    return Container(
      width: size.width * 0.85,
      height: size.width * 0.85,
      decoration: BoxDecoration(border: Border.all()),
      child: Stack(children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: _image == null
                ? Image.network(
                    _profile.profile_photo.toString(),
                    fit: BoxFit.fitHeight,
                  )
                : Image.file(
                    File(_image!.path),
                    fit: BoxFit.fitWidth,
                  ),
          ),
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              onPressed: chooseImageFromGallery,
              child: Icon(Icons.camera_alt),
            ))
      ]),
    );
  }

  Widget TopRow() {
    var size = MediaQuery.of(context).size;
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
}
