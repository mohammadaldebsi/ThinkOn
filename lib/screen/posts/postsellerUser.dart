// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:thinkon/widget/constant.dart';

import '../../models/SellerModels.dart';
import '../../models/UserModel.dart';
import '../../models/selleruserModel.dart';
import '../chat/letsChat_page.dart';
import '../profileother.dart';

class PostSellersUser extends StatefulWidget {
  const PostSellersUser({Key? key, required this.seller}) : super(key: key);
  final SellerUserModel seller;
  @override
  State<PostSellersUser> createState() => _PostSellersUserState();
}

class _PostSellersUserState extends State<PostSellersUser> {
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
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),

        ),
        body: load
            ? Center(child: CircularProgressIndicator())
            : Padding(
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
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(color: coloruses, blurRadius: 10),
                                ],
                                borderRadius: BorderRadius.circular(360),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/profile.jpg"))),
                            child: MaterialButton(onPressed: () {}),
                          ),
                          Text(user.name.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: coloruses,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      ListTile(
                        leading: Icon(Icons.email_outlined),
                        title: Text(user.email,
                            style: TextStyle(color: coloruses)),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone_outlined),
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
                                labelColor: coloruses,
                                unselectedLabelColor: Colors.black,
                                indicatorColor: coloruses,

                                tabs: [
                                  Tab(text: 'Basic'),
                                  Tab(text: 'Premium'),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 300,
                              height: 300,
                              child: TabBarView(
                                children: [
                                  _Basicinformation(seller: widget.seller),
                                  _Premiuminformation(seller: widget.seller)
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

class _Basicinformation extends StatefulWidget {
  const _Basicinformation({Key? key, required this.seller}) : super(key: key);
  final SellerUserModel seller;
  @override
  State<_Basicinformation> createState() => _BasicinformationState();
}

class _BasicinformationState extends State<_Basicinformation> {
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: coloruses, borderRadius: BorderRadius.circular(10)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.seller.basicdesc,
                style: TextStyle(color: Colors.white),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Basic Price:${widget.seller.premiumprice}",
                  style: TextStyle(color: Colors.white)),
            )
          ]),
        ),
      ],
    );
  }
}

class _Premiuminformation extends StatefulWidget {
  final SellerUserModel seller;
  @override
  State<_Premiuminformation> createState() => _PremiuminformationState();

  _Premiuminformation({required this.seller});
}

class _PremiuminformationState extends State<_Premiuminformation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,

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
              child: Text(widget.seller.subCategory,
                  style: TextStyle(color: Colors.white)),
            ),
          ]),
        ),
      ],
    );
  }
}
