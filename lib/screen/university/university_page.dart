// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/university/events_page.dart';
import 'package:thinkon/screen/university/postUniversity_page.dart';
import 'package:thinkon/screen/university/surveys_page.dart';

class University extends StatelessWidget {
  const University({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,home: _University());
  }
}

class _University extends StatefulWidget {
  const _University({Key? key}) : super(key: key);

  @override
  State<_University> createState() => _UniversityState();
}

class _UniversityState extends State<_University> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 210,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          flexibleSpace: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage("images/ASU.jpg"), fit: BoxFit.cover)),
          ),
        ),
        body: Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Events",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return EventUniversity();
                              }));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          _CreateEventContainer(),
                          _CreateEventContainer(),
                          _CreateEventContainer(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Social media at ASU",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return PostUniversity();
                              }));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          _CreatePostContainer(),
                          _CreatePostContainer(),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Surveys",
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return SurveyUniversity();
                              }));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: MaterialButton(
                      onPressed: () {},
                      child: Container(
                          width: 350,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, blurRadius: 5),
                            ],
                          ),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                                width: 350,
                                height: 120,
                                child: Row(children: [
                                  Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: AssetImage("images/contactasu.jpg"),
                                            fit: BoxFit.fitHeight)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Center(
                                          child: Text(
                                            "Applied science private\n university",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo),
                                          ),
                                        ),

                                      ]))
                                ]))
                          ]))),
                ),
                    SizedBox(height: 20,)
                  ]),
            )));
  }
}

class _CreateEventContainer extends StatefulWidget {
  @override
  State<_CreateEventContainer> createState() => _CreateEventContainerState();
}

class _CreateEventContainerState extends State<_CreateEventContainer> {
  var MONTHS = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("images/hultprize.jpg"),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formattedDateTime() + " ",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 10)),
                  Text("Hult prize",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.redAccent, size: 15),
                      Text(formattedDateTime() + " ",
                          style: TextStyle(color: Colors.blueGrey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formattedDateTime() {
    DateTime now = new DateTime.now();
    return now.day.toString() +
        " " +
        MONTHS[now.month - 1] +
        " " +
        now.year.toString() +
        " ";
  }
}

class _CreatePostContainer extends StatefulWidget {
  const _CreatePostContainer({Key? key}) : super(key: key);

  @override
  State<_CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<_CreatePostContainer> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        child: Container(
            width: 250,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.black, blurRadius: 5),
              ],
            ),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: 250,
                  height: 100,
                  child: Row(children: [
                    Container(
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          image: DecorationImage(
                              image: AssetImage("images/post.jpg"),
                              fit: BoxFit.fitHeight)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(360),
                                    image: DecorationImage(
                                        image: AssetImage("images/profile.jpg"),
                                        fit: BoxFit.fitHeight)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mohammad aldebsi",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo),
                              )
                            ],
                          ),
                          SizedBox(height: 40),
                          Padding(
                              padding: const EdgeInsets.only(left: 80.0),
                              child: Text("View post",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  )))
                        ]))
                  ]))
            ])));
  }
}
