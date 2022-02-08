import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<String> images = [
    'assets/profile_images/pp1.jpeg',
    'assets/profile_images/pp2.jpeg',
    'assets/profile_images/pp3.jpeg',
    'assets/profile_images/pp4.jpeg',
    'assets/profile_images/pp1.jpeg',
    'assets/profile_images/pp2.jpeg',
    'assets/profile_images/pp3.jpeg',
    'assets/profile_images/pp4.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TopRow(),
                Container(
                  width: size.width * 0.85,
                  child: Text(
                    'Bekleyen Eşleşmeler',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 20),
                  ),
                ),
                Container(
                  height: size.height * 0.1,
                  width: size.width * 0.85,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.025),
                          child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(images[index]),
                                  //backgroundColor: Colors.blue,
                                ),
                                Positioned(
                                  left: 30,
                                  child: Container(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Text(
                                        '23.59.59',
                                        style: TextStyle(
                                            fontFamily: 'Rubik', fontSize: 10),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                )
                              ]),
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.85,
                  child: Text(
                    'Eşleşmelerin',
                    style: TextStyle(fontFamily: 'Rubik', fontSize: 20),
                  ),
                ),
                Container(
                  width: size.width * 0.85,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(1, 1))
                              ]),
                          child: ListTile(
                            leading: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage(images[index]),
                                      //backgroundColor: Colors.blue,
                                    ),
                                  ),
                                  Positioned(
                                    left: 30,
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          '23.59.59',
                                          style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 10),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  )
                                ]),
                            /*CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(images[index]),
                            ),*/
                            title: Text(
                              'Mesajı Gönderen',
                              style:
                                  TextStyle(fontFamily: 'Rubik', fontSize: 15),
                            ),
                            subtitle: Text(
                              'Mesaj',
                              style:
                                  TextStyle(fontFamily: 'Rubik', fontSize: 14),
                            ),
                            trailing: Text(
                              '17:42',
                              style:
                                  TextStyle(fontFamily: 'Rubik', fontSize: 12),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
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
