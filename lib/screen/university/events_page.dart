// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';
import 'package:thinkon/widget/constant.dart';


class EventUniversity extends StatelessWidget {
  const EventUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,home: const _EventUniversity());
  }
}

class _EventUniversity extends StatefulWidget {
  const _EventUniversity({Key? key}) : super(key: key);

  @override
  State<_EventUniversity> createState() => _EventUniversityState();
}

class _EventUniversityState extends State<_EventUniversity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Text("ThinkOn",style:TextStyle(color:coloruses)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: coloruses),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return University();
              }));}),
        actionsIconTheme: const IconThemeData(color: Colors.white),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(AssetImage("images/hultprize.jpg")),
                  ),
  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(AssetImage("images/JPC.jpg")),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(AssetImage("images/UIUX.jpg")),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(AssetImage("images/SEC.jpg")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Events extends StatefulWidget {

AssetImage view;
  @override
  State<_Events> createState() => _EventsState();

_Events(this.view);
}

class _EventsState extends State<_Events> {
  @override
  Widget build(BuildContext context) {
    return Container(

        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image:widget.view,fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 5),
          ],
        ),
        );
  }
}
