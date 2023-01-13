// ignore_for_file: file_names, unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:thinkon/screen/notification_page.dart';
import 'package:thinkon/screen/posts/post_page.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:thinkon/screen/Login_Page.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/screen/register.dart';
import 'package:flutter/services.dart';
import 'package:thinkon/screen/university/university_page.dart';
import 'package:thinkon/screen/search_page.dart';

import 'screen/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const Homepage());
}

class Navigatorbar1 extends StatefulWidget {
  const Navigatorbar1({Key? key}) : super(key: key);

  @override
  State<Navigatorbar1> createState() => _Navigatorbar1State();
}

class _Navigatorbar1State extends State<Navigatorbar1> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    University(),
    Category1(),
    Search(),
    Notification1(),
    Profile(),
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(color: Color(0xFF223843), blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,

                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      selectedFontSize: 0.1,
                      selectedIconTheme: const IconThemeData(
                          color: Color(0xFF223843), size: 40),

                      iconSize: 25,
                      unselectedItemColor: Colors.grey,
                      type: BottomNavigationBarType.fixed,

                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined), label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.school_outlined), label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.category_outlined), label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.search_outlined), label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.notifications_outlined,),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline), label: ""),
                      ],
                      currentIndex: _selectedIndex, //New
                      onTap: _onItemTapped,
                    )))));
  }
}
