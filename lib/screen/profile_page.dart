// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:thinkon/screen/edit_profile.dart';
import 'package:thinkon/screen/Login_Page.dart';
import 'package:thinkon/screen/payment.dart';
import 'package:thinkon/screen/posts/postclientUser.dart';
import 'package:thinkon/screen/posts/postsellerUser.dart';
import 'package:thinkon/screen/request.dart';
import 'package:thinkon/screen/search_page.dart';
import '../models/SellerModels.dart';
import '../models/clientuserModel.dart';
import '../models/selleruserModel.dart';
import '../widget/constant.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: _ProfilePage());
  }
}

class _ProfilePage extends StatefulWidget {
  const _ProfilePage({Key? key}) : super(key: key);

  @override
  State<_ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<_ProfilePage> {
  final FirebaseAuth _Auth = FirebaseAuth.instance;

  late User? LoggedInUser = _Auth.currentUser;
  late String id = "";
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getID();
  }

  getCurrentUser() async {
    late final user;
    try {
      user = await _Auth.currentUser?.email;
      LoggedInUser = user!;
    } catch (e) {
      print(e);
    }
  }

  getID() {
    String email = loggedInUser!.email.toString();
    for (int i = 0; i < 9; i++) {
      id = id + email[i];
    }
  }

  Widget BuildButtomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff757575),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6,
                ),
                _CreateListinDrawer("Setting"),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xFF223843),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      child: Text(
                        "Request",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Request();
                        }));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xFF223843),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      child: Text(
                        "Payment",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MySample();
                        }));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xFF223843),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EditProfile();
                        }));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                _CreateListinDrawer("Help"),
                SizedBox(
                  height: 6,
                ),
                Center(
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(0xFF223843),
                        borderRadius: BorderRadius.circular(20)),
                    child: MaterialButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _Auth.signOut();
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return Login();
                            },
                          ),
                          (_) => false,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 200,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          flexibleSpace: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
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
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: BuildButtomSheet);
                },
                icon: Icon(Icons.format_list_bulleted))
          ],
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
                        children: [
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
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
                          Text(
                            "${FirebaseAuth.instance.currentUser?.displayName}",
                            style: TextStyle(color: coloruses, fontSize: 20),
                          ),
                        ],
                      ),
                      Text("Id: $id"),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
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
                            .doc(FirebaseAuth.instance.currentUser!.uid)
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
                                  Tab(
                                    child: Text("Social Media"),
                                  ),
                                  Tab(child: Text("Seller")),
                                  Tab(
                                    child: Text("Client"),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.height,
                              height: MediaQuery.of(context).size.width,
                              child: TabBarView(
                                children: [
                                  _Profilepost(),
                                  SellerUser(),
                                  ClientUser()
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

  _CreateListinDrawer(String Name) {
    return Center(
      child: Container(
          width: 300,
          decoration: BoxDecoration(
              color: Color(0xFF223843),
              borderRadius: BorderRadius.circular(20)),
          child: MaterialButton(
            child: Text(
              Name,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )),
    );
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

class ClientUser extends StatefulWidget {
  const ClientUser({Key? key}) : super(key: key);

  @override
  State<ClientUser> createState() => _ClientUserState();
}

class _ClientUserState extends State<ClientUser> {
  final List<ClientUserModel> clientList = [];
  final List<SellerModel> sellerList = [];
  bool loading = true;
  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(loggedInUser?.uid)
        .collection("ClientPosts")
        .orderBy("timestamp")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
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

class SellerUser extends StatefulWidget {
  const SellerUser({Key? key}) : super(key: key);

  @override
  State<SellerUser> createState() => _SellerUserState();
}

class _SellerUserState extends State<SellerUser> {
  final List<ClientUserModel> clientList = [];
  final List<SellerUserModel> sellerList = [];
  bool loading = true;
  Future<void> getsellerData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(loggedInUser?.uid)
        .collection("SellerPosts")
        .orderBy("timestamp")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
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
