import 'package:eventmate/service/events_service.dart';
import 'package:flutter/material.dart';
import 'package:eventmate/model/hits.dart';

class EventInfoScreen extends StatefulWidget {
  late Hits hits;

  EventInfoScreen({required this.hits});

  @override
  _EventInfoScreenState createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  Future showEventDetails() async {
    return await EventsService.getEventDetails(
        'http://10.0.2.2:8000/eventmate_api/BiletixEvents/${widget.hits.id}/');
  }

  @override
  void initState() {
    super.initState();
    showEventDetails().then((value) {
      setState(() {
        widget.hits.isInterested = value['isInterested'];
        widget.hits.description = value['response']['description'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopRow(size),
              Container(
                height: size.height * 0.2,
                width: size.width * 0.9,
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.network(
                      widget.hits.image.toString(),
                      headers: {'Cookie': 'BXID'},
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                height: size.height * 0.1,
                width: size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.75,
                          child: Text(
                            widget.hits.title.toString(),
                            maxLines: 2,
                            softWrap: true,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Text(
                          widget.hits.location.toString(),
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        String url =
                            'http://10.0.2.2:8000/eventmate_api/BiletixEvents/${widget.hits.id}/';
                        bool data = await EventsService.addInterestedEvent(url);
                        if (data) {
                          setState(() {
                            widget.hits.isInterested =
                                !widget.hits.isInterested;
                          });
                        }
                      },
                      child: Container(
                          height: size.height * 0.07,
                          width: size.width * 0.07,
                          child: widget.hits.isInterested
                              ? Image(
                                  image: AssetImage('assets/star.png'),
                                )
                              : Image(
                                  image: AssetImage('assets/empty-star.png'),
                                )),
                    )
                  ],
                ),
              ),
              /*Container(
                width: size.width * 0.85,
                //height: size.height * 0.1,
                child: Text(
                  'Peter Shaffer tarafından kaleme alınan, dünya müzik tarihinin unutulmaz bestecileri'
                  ' Wolfgang Amadeus Mozart ile Antonio Salleri\'nin hikayesi AMADEUS sahnede!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),*/
              Container(
                width: size.width * 0.85,
                child: Text(widget.hits.description),
              ),
              Container(
                width: size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width * 0.07,
                          height: size.height * 0.07,
                          child: Image(
                            image: AssetImage('assets/group.png'),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(widget.hits.personCount.toString())
                      ],
                    ),
                    Row(
                      children: [
                        Text('Eşleşmeye Müsait! '),
                        Container(
                          width: size.width * 0.07,
                          height: size.height * 0.07,
                          child: Image(
                            image: AssetImage('assets/check.png'),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.1,
                    height: size.height * 0.1,
                    child: Image(
                      image: AssetImage('assets/lottery.png'),
                    ),
                  ),
                ],
              )
            ],
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
}
