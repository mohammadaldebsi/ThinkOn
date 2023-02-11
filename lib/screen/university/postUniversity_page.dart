// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/screen/university/university_page.dart';
import 'package:thinkon/widget/constant.dart';

import '../../models/commetModel.dart';
import '../../models/soialmediaModel.dart';
import 'newUniversitypost.dart';

class PostUniversity extends StatelessWidget {
  const PostUniversity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: _PostUniversity());
  }
}

class _PostUniversity extends StatefulWidget {
  const _PostUniversity({Key? key}) : super(key: key);

  @override
  State<_PostUniversity> createState() => _PostUniversityState();
}

class _PostUniversityState extends State<_PostUniversity> {
  List<SocialModel> socialMedia = [];
  bool load = true;
  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection("University-Post")
        .orderBy("timestamp")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
                    socialMedia.add(
                        SocialModel(doc["Uuid"], doc["Description"], doc.id))
                  })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData().then((value) => setState(() {
          load = false;
          for (var x in socialMedia) {
            print(x.id);
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF223843),
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text("ThinkOn", style: TextStyle(color: Colors.white)),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return University();
                }));
              }),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewUpost();
                  }));
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 30),
                iconSize: 20),
          ],
        ),
        body: load
            ? Center(
                child: CircularProgressIndicator(
                color: coloruses,
              ))
            : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: socialMedia.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, bottom: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF223843),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(socialMedia[index].Uuid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  Colors.lightBlueAccent,
                                            ),
                                          );
                                        }
                                        final String messages =
                                            snapshot.data!.get("Gender");
                                        if (messages.toLowerCase() == "male") {
                                          return Container(
                                            width: 30,
                                            height: 30,
                                            child: MaterialButton(
                                                onPressed: () {}),
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color(0xFF223843),
                                                      blurRadius: 5),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                                image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "images/profile.jpg"))),
                                          );
                                        } else {
                                          return Container(
                                            width: 30,
                                            height: 30,
                                            child: MaterialButton(
                                                onPressed: () {}),
                                            decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Color(0xFF223843),
                                                      blurRadius: 5),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(360),
                                                image: const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "images/girl.jpg"))),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(socialMedia[index].Uuid)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor:
                                                  Colors.lightBlueAccent,
                                            ),
                                          );
                                        }
                                        final messages =
                                            snapshot.data!.get("Username");

                                        return Text(messages,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ));
                                      },
                                    ),
                                  ],
                                ),
                                PopupMenuButton<int>(
                                  splashRadius: 100,
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  itemBuilder: (context) => [
                                    if (socialMedia[index].Uuid ==
                                        FirebaseAuth
                                            .instance.currentUser?.uid) ...{
                                      PopupMenuItem(
                                          value: 1,
                                          child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("University-Post")
                                                  .doc(socialMedia[index].id)
                                                  .delete();
                                              FirebaseFirestore.instance
                                                  .collection("Users")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser?.uid)
                                                  .collection("University-Post")
                                                  .doc(socialMedia[index].id)
                                                  .delete();
                                              socialMedia.clear();
                                              initState();
                                            },
                                          )),
                                    }
                                  ],
                                  offset: Offset(0, 50),
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ReadMoreText(
                              socialMedia[index].description,
                              trimLines: 2,
                              style: TextStyle(color: Colors.white),
                              colorClickableText: Colors.black,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: ' ..Less',
                            ),
                          ),
                          Divider(color: Colors.white, height: 0.0001),
                          Center(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return _Comments(socialMedia[index].id);
                                    }));
                                  },
                                  child: Text(
                                    "Comments",
                                    style: TextStyle(color: Colors.white),
                                  )))
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}

class _Comments extends StatefulWidget {
  String id;

  @override
  State<_Comments> createState() => _CommentsState();

  _Comments(this.id);
}

class _CommentsState extends State<_Comments> {
  TextEditingController commentTextController = TextEditingController();
  List<CommentModel> comments = [];
  bool load = true;
  String? message;
  @override
  void initState() {
    // TODO: implement initState
    _getData().then((value) => setState(() {
          load = false;
        }));
  }

  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection("University-Post")
        .doc(widget.id)
        .collection("Comments")
        .orderBy("timestamp")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
                    comments.add(
                      CommentModel(
                        doc["comment"],
                        doc["From"],
                      ),
                    )
                  })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: coloruses,
          title: Text("Comments"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: load
          ? Center(
              child: CircularProgressIndicator(
              color: coloruses,
            ))
          : SafeArea(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: coloruses),
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        String name;
                        return ListTile(
                          leading: Icon(Icons.account_circle,
                              size: 40, color: coloruses),
                          title: StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(comments[index].Uuid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                );
                              }
                              final messages = snapshot.data!.get("Username");
                              name = messages[1];
                              return Text(messages,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: coloruses,
                                  ));
                            },
                          ),
                          trailing: Icon(
                            Icons.comment,
                            color: coloruses,
                          ),
                          subtitle: Text(comments[index].comment,
                              style: TextStyle(
                                fontSize: 18,
                                color: coloruses,
                              )),
                        );
                      }),
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: commentTextController,
                    onChanged: (value) {
                      setState(() {
                        message = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      label: Text(
                        "Comment",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("University-Post")
                              .doc(widget.id)
                              .collection("Comments")
                              .doc()
                              .set({
                            "comment": message,
                            "From": FirebaseAuth.instance.currentUser!.uid,
                            'timestamp': Timestamp.now(),
                          });
                          commentTextController.clear();
                          comments.clear();
                          initState();
                        },
                        icon: Icon(
                          Icons.send_outlined,
                          color: coloruses,
                        )),
                  ],
                )
              ],
            )),
    );
  }
}
