// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';


class SurveyUniversity extends StatelessWidget {
  const SurveyUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,home: const _SurveyUniversity());
  }
}

class _SurveyUniversity extends StatefulWidget {
  const _SurveyUniversity({Key? key}) : super(key: key);

  @override
  State<_SurveyUniversity> createState() => _SurveyUniversityState();
}

class _SurveyUniversityState extends State<_SurveyUniversity> {
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
                    child: _Surveys(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Surveys(),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Surveys(),
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

class _Surveys extends StatefulWidget {
  const _Surveys({Key? key}) : super(key: key);

  @override
  State<_Surveys> createState() => _SurveysState();
}

class _SurveysState extends State<_Surveys> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
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
                          image: AssetImage("images/hultprize.jpg"),
                          fit: BoxFit.fitHeight)),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Row(
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
        ]));
  }
}
