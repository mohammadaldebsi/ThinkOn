// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/posts/post_page.dart';
import 'package:readmore/readmore.dart';
import 'package:thinkon/widget/constant.dart';

import '../../models/UserModel.dart';
import '../../models/clientModel.dart';
import '../chat/letsChat_page.dart';
import '../profileother.dart';

class PostClients extends StatefulWidget {
  PostClients({Key? key, required this.client}) : super(key: key);
  final ClientModel client;

  @override
  State<PostClients> createState() => _PostClientsState();
}

class _PostClientsState extends State<PostClients> {
  bool load = true;
  UserModel user = UserModel("", "", "");
  @override
  void initState() {
    // TODO: implement initState
    getdata().then((value) => setState(() {
          load = false;
        }));
  }

  String? UserUid = FirebaseAuth.instance.currentUser?.uid;
  String? reUid, docId;
  @override
  Widget build(BuildContext context) {
    docId = (UserUid! + widget.client.uid);
    return load
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: coloruses,
              toolbarHeight: 80,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context)),
            ),
            body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            maxRadius: MediaQuery.of(context).size.width / 10,
                            backgroundImage: AssetImage("images/profile.jpg"),
                            child: MaterialButton(onPressed: () {}),
                          ),
                          Text(user.name.toString(),
                              style: TextStyle(
                                  color: coloruses,
                                  fontWeight: FontWeight.bold)),

                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: coloruses,
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileOther(
                                      Uuiduser: widget.client.uid,
                                    );
                                  }));
                                },
                                child: Text(
                                  "Profile",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                      ListTile(
                        leading: Icon(Icons.email_outlined,color: coloruses,),
                        title: Text(user.email),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone_outlined,color: coloruses,),
                        title: Text(user.phone),
                      ),
                      DefaultTabController(
                        length: 1, // length of tabs
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: coloruses,
                                indicatorColor: coloruses,
                                tabs: [
                                  Tab(
                                    text: 'Description',
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 300,
                              height: 300,
                              child: TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: coloruses,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                    widget.client.description,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    "Budget: ${widget.client.budget}",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              )
                                            ]),
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            color: coloruses,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            if (widget.client.uid !=
                                                FirebaseAuth.instance
                                                    .currentUser?.uid) {
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      "messages-userUuid")
                                                  .doc(docId)
                                                  .set({
                                                "receiver-Uuid":
                                                    widget.client.uid,
                                                "sender-Uuid": FirebaseAuth
                                                    .instance.currentUser?.uid,
                                              });
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return LetsChat(
                                                  otherUser: widget.client.uid,
                                                );
                                              }));
                                            }
                                          },
                                          child: Text("Contact Us",style: TextStyle(color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ])));
  }

  Future<void> getdata() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.client.uid)
        .get()
        .then((querySnapshot) => {
              user = UserModel(
                  querySnapshot.data()!["Email"] ?? "",
                  querySnapshot.data()!["Phone"] ?? "",
                  querySnapshot.data()!["Username"] ?? "")
            });
  }
}