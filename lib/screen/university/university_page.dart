// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/university/events_page.dart';
import 'package:thinkon/screen/university/postUniversity_page.dart';
import 'package:thinkon/screen/university/surveys_page.dart';
import 'package:thinkon/widget/constant.dart';

class University extends StatelessWidget {
  const University({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _University());
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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Events",
                      style: TextStyle(
                          color: coloruses,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
                child: Row(
                  children: [
                    _CreateEventContainer(AssetImage("images/hultprize.jpg")),
                    _CreateEventContainer(AssetImage("images/JPC.jpg")),
                    _CreateEventContainer(AssetImage("images/UIUX.jpg")),
                    _CreateEventContainer(AssetImage("images/SEC.jpg")),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Social media at ASU",
                      style: TextStyle(
                          color: coloruses,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
                  Text("Surveys",
                      style: TextStyle(
                          color: coloruses,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SurveyUniversity();
                        }));
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, blurRadius: 5),
                    ],
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          "images/logo.png",
                        ))),
              ),
              SizedBox(
                height: 20,
              )
            ]),
          ),
        ));
  }
}

class _CreateEventContainer extends StatefulWidget {
  AssetImage view;
  @override
  State<_CreateEventContainer> createState() => _CreateEventContainerState();

  _CreateEventContainer(this.view);
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
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(image: widget.view, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 5),
            ],
          ),
        ));
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
                              image: AssetImage("images/study.jpeg"),
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
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mohammad aldebsi",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: coloruses),
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
                                    color: coloruses,
                                  )))
                        ]))
                  ]))
            ])));
  }
}
