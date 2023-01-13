// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';


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
        toolbarHeight: 80,
        title: Text("ThinkOn",style:TextStyle(color:Colors.blue)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
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
                    child: _Events(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Events(),
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
  const _Events({Key? key}) : super(key: key);

  @override
  State<_Events> createState() => _EventsState();
}

class _EventsState extends State<_Events> {
  @override
  Widget build(BuildContext context) {
    return Container(

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
              height: 100,
              child: Row(children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage("images/hultprize.jpg"),
                          fit: BoxFit.fitHeight)),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Hult prize",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                    ]))
              ]))
        ]));
  }
}
