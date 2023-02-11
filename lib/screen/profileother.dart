// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:thinkon/screen/posts/postclientUser.dart';
import 'package:thinkon/screen/posts/postsellerUser.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/clientuserModel.dart';
import '../models/selleruserModel.dart';
import 'chat/letsChat_page.dart';

class ProfileOther extends StatefulWidget {
  ProfileOther({Key? key, required this.Uuiduser}) : super(key: key);
  String Uuiduser;
  @override
  State<ProfileOther> createState() => _ProfileOtherState();
}

class _ProfileOtherState extends State<ProfileOther> {
  late String id = "";

  String? UserUid = FirebaseAuth.instance.currentUser?.uid;
  String? reUid, docId;
  void initState() {
    super.initState();
    getID();
  }

  getID() {
    String email = loggedInUser!.email.toString();
    for (int i = 0; i < 9; i++) {
      id = id + email[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    docId = (UserUid! + widget.Uuiduser);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 200,
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
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Container(
                      child: PhotoView(
                    imageProvider: AssetImage("images/ASU.jpg"),
                  ));
                }));
              },
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.Uuiduser)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.lightBlueAccent,
                                  ),
                                );
                              }
                              final String messages =
                              snapshot.data!.get("Gender");
                              if (messages.toLowerCase() == "male") {
                                return Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(0, 0, 20, 10),
                                  width: 80,
                                  height: 80,
                                  child: MaterialButton(onPressed: () {}),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFF223843),
                                            blurRadius: 5),
                                      ],
                                      borderRadius: BorderRadius.circular(360),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "images/profile.jpg"))),
                                );
                              } else {
                                return Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(0, 0, 20, 10),
                                  width: 80,
                                  height: 80,
                                  child: MaterialButton(onPressed: () {}),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xFF223843),
                                            blurRadius: 5),
                                      ],
                                      borderRadius: BorderRadius.circular(360),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "images/girl.jpg"))),
                                );
                              }
                            },
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.Uuiduser)
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

                              return Text(messages,
                                  style: TextStyle(
                                    color: coloruses,
                                  ));
                            },
                          ),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: coloruses,
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                                onPressed: () {
                                  if (widget.Uuiduser !=
                                      FirebaseAuth.instance.currentUser?.uid) {
                                    FirebaseFirestore.instance
                                        .collection("messages-userUuid")
                                        .doc(docId)
                                        .set({
                                      "receiver-Uuid": widget.Uuiduser,
                                      "sender-Uuid": FirebaseAuth
                                          .instance.currentUser?.uid,
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LetsChat(
                                        otherUser: widget.Uuiduser,
                                      );
                                    }));
                                  }
                                },
                                child: Text(
                                  "Message",
                                  style: TextStyle(color: Colors.white),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Id: $id"),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.Uuiduser)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                            );
                          }
                          final messages = snapshot.data!.get("Phone");

                          return Text(
                            "Phone: $messages",
                          );
                        },
                      ),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.Uuiduser)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.lightBlueAccent,
                              ),
                            );
                          }
                          final messages = snapshot.data!.get("Bio");

                          return Text(
                            "$messages",
                          );
                        },
                      ),
                      DefaultTabController(
                        length: 3, // length of tabs
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                labelColor: Color(0xFF223843),
                                indicatorColor: Color(0xFF223843),
                                unselectedLabelColor: Colors.black,
                                indicatorSize: TabBarIndicatorSize.label,
                                tabs: [
                                  Tab(child: Text("Social Media"),),
                                  Tab(child: Text("Seller")),
                                  Tab(child: Text("Client"),),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height,
                              height: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                children: [
                                  _Profilepost(),
                                  _Sellerothersuer(widget.Uuiduser),
                                  _Clientothersuer(widget.Uuiduser),

                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              )),
        ));
  }
}

class _Profilepost extends StatefulWidget {
  const _Profilepost({Key? key}) : super(key: key);

  @override
  State<_Profilepost> createState() => _ProfilepostState();
}

class _ProfilepostState extends State<_Profilepost> {
  late final Height = MediaQuery.of(context).size.height;
  late final Width = MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Width * 0.28,
              height: 100,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("images/1.jpg"), fit: BoxFit.fill)),
            ),
            Container(
              width: Width * 0.28,
              height: 100,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("images/2.jpg"), fit: BoxFit.fill)),
            ),
            Container(
              width: Width * 0.28,
              height: 100,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("images/3.jpg"), fit: BoxFit.fill)),
            ),
          ],
        ),
      ],
    );
  }
}

class _Clientothersuer extends StatefulWidget {
  String Uuiduser;
  @override
  State<_Clientothersuer> createState() => __ClientothersuerState();

  _Clientothersuer(this.Uuiduser);
}

class __ClientothersuerState extends State<_Clientothersuer> {
  final List<ClientUserModel> clientList = [];
  bool loading = true;
  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.Uuiduser)
        .collection("ClientPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    clientList.add(ClientUserModel(doc["Category"],
                        doc["SubCategory"], doc["Description"], doc["Budget"]))
                  })
            });
  }

  @override
  void initState() {
    getData().then((value) => setState(() {
          loading = false;
        }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: clientList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostClientsUser(
                          client: clientList[index],
                        );
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: coloruses,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 3),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(clientList[index].subCategory,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}

class _Sellerothersuer extends StatefulWidget {
  String Uuiduser;

  @override
  State<_Sellerothersuer> createState() => __SellerothersuerState();

  _Sellerothersuer(this.Uuiduser);
}

class __SellerothersuerState extends State<_Sellerothersuer> {
  final List<SellerUserModel> sellerList = [];
  bool loading = true;
  Future<void> getsellerData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.Uuiduser)
        .collection("SellerPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    sellerList.add(SellerUserModel(
                      doc["Category"],
                      doc["SubCategory"],
                      doc["BasicDescription"],
                      doc["PremiumPrice"],
                      doc["PremiumDescription"],
                      doc["BasicPrice"],
                    ))
                  })
            });
  }

  @override
  void initState() {
    getsellerData().then((value) => setState(() {
          loading = false;
        }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: sellerList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostSellersUser(
                          seller: sellerList[index],
                        );
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: coloruses,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 3),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(sellerList[index].subCategory,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }
}
