// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:thinkon/widget/constant.dart';

import '../../models/SellerModels.dart';
import '../../models/UserModel.dart';
import '../chat/letsChat_page.dart';
import '../profileother.dart';

class PostSellers extends StatefulWidget {
  const PostSellers({Key? key, required this.seller}) : super(key: key);
  final SellerModel seller;
  @override
  State<PostSellers> createState() => _PostSellersState();
}

class _PostSellersState extends State<PostSellers> {
  bool load = true;
  UserModel user = UserModel("", "", "");
  @override
  void initState() {
    getsellerdata().then((value) => setState(() {
          load = false;
        }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    if (widget.seller.uid !=
                        FirebaseAuth.instance.currentUser?.uid) {
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.seller.uid)
                          .collection("Seller-Request")
                          .doc()
                          .set({
                        "request-from": FirebaseAuth.instance.currentUser?.uid,
                        "timestamp": Timestamp.now(),
                      });
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.seller.uid)
                          .collection("User-Request")
                          .doc()
                          .set({
                        "request-from": FirebaseAuth.instance.currentUser?.uid,
                        "timestamp": Timestamp.now(),
                      });
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                  )),
            )
          ],
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
        ),
        body: load
            ? Center(child: CircularProgressIndicator())
            : Padding(
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
                                      Uuiduser: widget.seller.uid,
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
                        leading: Icon(
                          Icons.email_outlined,
                          color: coloruses,
                        ),
                        title: Text(user.email,
                            style: TextStyle(color: coloruses)),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.phone_outlined,
                          color: coloruses,
                        ),
                        title: Text(user.phone,
                            style: TextStyle(
                              color: coloruses,
                            )),
                      ),
                      DefaultTabController(
                        length: 2, // length of tabs
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                indicatorColor: coloruses,
                                labelColor: coloruses,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Tab(text: 'Basic'),
                                  Tab(text: 'Premium'),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              child: TabBarView(
                                children: [
                                  _Basicinformation(seller: widget.seller),
                                  _Premiuminformation(
                                    seller: widget.seller,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ])));
  }

  Future<void> getsellerdata() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.seller.uid)
        .get()
        .then((querySnapshot) => {
              user = UserModel(
                  querySnapshot.data()!["Email"] ?? "",
                  querySnapshot.data()!["Phone"] ?? "",
                  querySnapshot.data()!["Username"] ?? "")
            });
  }
}

class _Basicinformation extends StatefulWidget {
  const _Basicinformation({Key? key, required this.seller}) : super(key: key);
  final SellerModel seller;
  @override
  State<_Basicinformation> createState() => _BasicinformationState();
}

class _BasicinformationState extends State<_Basicinformation> {
  String? UserUid = FirebaseAuth.instance.currentUser?.uid;
  String? reUid, docId;
  bool result = false;
  @override
  Widget build(BuildContext context) {
    docId = (UserUid! + widget.seller.uid);
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: coloruses, borderRadius: BorderRadius.circular(10)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.seller.premiumdesc,
                  style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.seller.premiumprice,
                  style: TextStyle(color: Colors.white)),
            ),
          ]),
        ),
        SizedBox(height: 30),
        Container(
          height: 40,
          decoration: BoxDecoration(
              color: coloruses, borderRadius: BorderRadius.circular(20)),
          child: MaterialButton(
            onPressed: () {
              if (widget.seller.uid != FirebaseAuth.instance.currentUser?.uid) {
                FirebaseFirestore.instance
                    .collection("messages-userUuid")
                    .doc(docId)
                    .set({
                  "receiver-Uuid": widget.seller.uid,
                  "sender-Uuid": FirebaseAuth.instance.currentUser?.uid,
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LetsChat(
                    otherUser: widget.seller.uid,
                  );
                }));
              }
            },
            child: Text("Contact Us", style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }
}

class _Premiuminformation extends StatefulWidget {
  final SellerModel seller;
  _Premiuminformation({required this.seller});
  @override
  State<_Premiuminformation> createState() => _PremiuminformationState();
}

class _PremiuminformationState extends State<_Premiuminformation> {
  String? UserUid = FirebaseAuth.instance.currentUser?.uid;
  String? reUid, docId;
  bool result = false;
  @override
  Widget build(BuildContext context) {
    docId = (UserUid! + widget.seller.uid);
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: coloruses, borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.seller.premiumdesc,
                style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.seller.description,
                style: TextStyle(color: Colors.white)),
          ),
        ]),
      ),
      SizedBox(height: 30),
      Container(
        height: 40,
        decoration: BoxDecoration(
            color: coloruses, borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
          onPressed: () {
            if (widget.seller.uid != FirebaseAuth.instance.currentUser?.uid) {
              FirebaseFirestore.instance
                  .collection("messages-userUuid")
                  .doc(docId)
                  .set({
                "receiver-Uuid": widget.seller.uid,
                "sender-Uuid": FirebaseAuth.instance.currentUser?.uid,
              });
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LetsChat(
                  otherUser: widget.seller.uid,
                );
              }));
            }
          },
          child: Text("Contact Us", style: TextStyle(color: Colors.white)),
        ),
      ),
    ]);
  }
}
