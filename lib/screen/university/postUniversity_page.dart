// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';

class PostUniversity extends StatelessWidget {
  const PostUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,home:  _PostUniversity());
  }
}

class _PostUniversity extends StatefulWidget {
  const _PostUniversity({Key? key}) : super(key: key);

  @override
  State<_PostUniversity> createState() => _PostUniversityState();
}

class _PostUniversityState extends State<_PostUniversity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF223843),
        toolbarHeight: 80,
        title: Text("ThinkOn",style:TextStyle(color:Colors.white)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return University();
                }));}),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline,
                  color: Colors.white, size: 30),
              iconSize: 20),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
              child: Column(
                children: [
                  _Posts(),
                  _Posts(),
                  _Posts(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Posts extends StatefulWidget {
  const _Posts({Key? key}) : super(key: key);

  @override
  State<_Posts> createState() => _PostsState();
}

class _PostsState extends State<_Posts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color:Color(0xFF223843), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: AssetImage("images/profile.jpg"))),
                ),
                Text("poster name",style: TextStyle(color: Colors.white),),
                SizedBox(
                  width: 200,
                ),
                Icon(Icons.more_vert)
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/profile.jpg"),
                    fit: BoxFit.cover)),
          ),
          ReadMoreText(
            'Hello,\n can any help me to create application using flutter please??',

            trimLines: 2,
            style: TextStyle(color: Colors.white),
            colorClickableText: Colors.black,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: ' ..Less',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.chat_bubble_outline)),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_border)),
            ],
          )
        ],
      ),
    );
  }
}
