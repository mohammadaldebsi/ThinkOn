// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/posts/postClient_page.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:thinkon/screen/profileother.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/SellerModels.dart';
import '../models/clientModel.dart';

class Notification1 extends StatelessWidget {
  const Notification1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Notification1();
  }
}

class _Notification1 extends StatefulWidget {
  const _Notification1({Key? key}) : super(key: key);

  @override
  State<_Notification1> createState() => _Notification1State();
}

class _Notification1State extends State<_Notification1> {
  User? user = FirebaseAuth.instance.currentUser;
  List<ClientModel> clients = [];
  List<SellerModel> sellers = [];
  bool loading = true;
  @override
  void initState() {
    _getData().then((value) => setState(() {}));
    _getsellerData().then((value) => setState(() {
          loading = false;
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text(
            "Notifications",
            style: TextStyle(fontSize: 25),
          )),
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
              itemCount:3,
              itemBuilder: (context, index) => Column(
                children: [
                    ListTile(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                          return PostClients(client:  clients[index],);
                        }));},
                        leading: const Icon(
                          Icons.notifications,
                          color: coloruses,
                          size: 30,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(clients[index].uid)
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold));
                              },
                            ),
                            Text("client",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                          ],
                        ),
                        trailing: Text(clients[index].subCategory)),

                ],
              ),
            ),
    );
  }

  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection("ClientPosts")
        .orderBy('timestamp')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    clients.add(ClientModel(doc["Category"], doc["SubCategory"],
                        doc["Uuid"], doc["Description"], doc["Budget"]))
                  })
            });
  }

  Future<void> _getsellerData() async {
    await FirebaseFirestore.instance
        .collection("SellerPosts")
        .orderBy('timestamp')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    sellers.add(SellerModel(
                      doc["Category"],
                      doc["SubCategory"],
                      doc["Uuid"],
                      doc["Description"],
                      doc["BasicDescription"],
                      doc["PremiumPrice"],
                      doc["PremiumDescription"],
                      doc["BasicPrice"],
                    ))
                  })
            });
  }
}
