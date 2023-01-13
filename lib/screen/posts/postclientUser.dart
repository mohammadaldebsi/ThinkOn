// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/models/clientuserModel.dart';
import 'package:thinkon/widget/constant.dart';
import '../../models/UserModel.dart';
import '../chat/letsChat_page.dart';
import '../profileother.dart';

class PostClientsUser extends StatefulWidget {
  PostClientsUser({Key? key, required this.client}) : super(key: key);
  final ClientUserModel client;

  @override
  State<PostClientsUser> createState() => _PostClientsUserState();
}

class _PostClientsUserState extends State<PostClientsUser> {
  bool load = true;
  UserModel user = UserModel("", "", "");
  @override
  void initState() {
    // TODO: implement initState
    getdata().then((value) => setState(() {
          load = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                            width: 80,
                            height: 80,
                            child: MaterialButton(onPressed: () {}),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: coloruses, blurRadius: 10),
                                ],
                                borderRadius: BorderRadius.circular(360),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/profile.jpg"))),
                          ),
                          Text(user.name.toString(),
                              style: TextStyle(
                                  color: coloruses,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email_outlined,
                          color: coloruses,
                        ),
                        title: Text(user.email),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_outlined,
                          color: coloruses,
                        ),
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
                                unselectedLabelColor: Colors.black,
                                indicatorColor: coloruses,
                                tabs: [
                                  Tab(text: 'Description'),
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
        .doc(loggedInUser!.uid)
        .get()
        .then((querySnapshot) => {
              user = UserModel(
                  querySnapshot.data()!["Email"] ?? "",
                  querySnapshot.data()!["Phone"] ?? "",
                  querySnapshot.data()!["Username"] ?? "")
            });
  }
}
