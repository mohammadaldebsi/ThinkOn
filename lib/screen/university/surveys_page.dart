// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widget/constant.dart';

class SurveyUniversity extends StatelessWidget {
  const SurveyUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: const _SurveyUniversity());
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: coloruses,
        toolbarHeight: 70,
        title: Text("ThinkOn", style: TextStyle(color: Colors.white)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return University();
              }));
            }),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      body: DefaultTabController(
        length: 2, // length of tabs
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Color(0xFF223843),
                  indicatorColor: Color(0xFF223843),
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: const [
                    Tab(child: Text("Contact ")),
                    Tab(
                      child: Text("Surveys "),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Surveys11(),
                    Contact(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Surveys11 extends StatefulWidget {
  const Surveys11({Key? key}) : super(key: key);

  @override
  State<Surveys11> createState() => _Surveys11State();
}

class _Surveys11State extends State<Surveys11> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Surveys(phone: "065609999", name: "القبول والتسجيل"),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Surveys(phone: "065601715", name: " الحاسب الالي")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      _Surveys(phone: "065601229 ", name: " الدائرة المالية"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Surveys(
                      phone: "065601255", name: "  كلية تكنولوجيا المعلومات"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Surveys(
                      phone: "065601344", name: " رئيس قسم علم الحاسوب"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Surveys(
                      phone: "(06) 560 1708-1709",
                      name: " رئيس قسم هندسة البرمجيات"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _Surveys(
                      phone: "06 560 1814 ",
                      name: " رئيس قسم الأمن السيبراني "),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Surveys extends StatefulWidget {
  _Surveys({Key? key, required this.phone, required this.name})
      : super(key: key);
  String phone;
  String name;
  @override
  State<_Surveys> createState() => _SurveysState();
}

class _SurveysState extends State<_Surveys> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: coloruses, blurRadius: 4),
          ]),
      child: MaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.call,
              color: coloruses,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.name,
              style: TextStyle(color: Color(0xFF223843), fontSize: 20),
            )
          ],
        ),
        onPressed: () async {
          final call = Uri.parse('tel:${widget.phone}');
          if (await canLaunchUrl(call)) {
            launchUrl(call);
          } else {
            throw 'Could not launch $call';
          }
        },
      ),
    );
  }
}

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Contact1(
                        url: "https://forms.office.com/pages/responsepage.aspx?id=Huu9piR3ZUG3lmQANPUHuoM0EMkNMWlPuOg0JfmkfXhUOUNNTVdMTVAxWktPUzNYOVBQSkM0OUszRi4u&fbclid=IwAR3Z7fboR4V-8A6HQ7HMJ_gGCa9kd1LtK76GxhuOSA3JKLcV6sDVxNtK76g",
                        name:"تحديث البيانات"),
                  )
                ])))));
  }
}

class _Contact1 extends StatefulWidget {
  String url;
  String name;
  @override
  State<_Contact1> createState() => _Contact1State();

  _Contact1({required this.url, required this.name});
}

class _Contact1State extends State<_Contact1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: coloruses, blurRadius: 4),
          ]),
      child: MaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.newspaper,
              color: coloruses,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              widget.name,
              style: TextStyle(color: Color(0xFF223843), fontSize: 20),
            )
          ],
        ),
        onPressed: () async {
          String url =widget.url;
          if (await canLaunch(url)) {
            await launch(url, forceSafariVC: true, forceWebView: true);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}
