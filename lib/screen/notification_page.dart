// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/posts/postClient_page.dart';
import 'package:thinkon/screen/posts/postSeller_page.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:thinkon/screen/profileother.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/SellerModels.dart';
import '../models/clientModel.dart';

class Notification1 extends StatelessWidget {
  const Notification1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: _Notification1(),);
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
      body:DefaultTabController(
        length: 2, // length of tabs
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Color(0xFF223843),
                  indicatorColor: Color(0xFF223843),
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs:const [
                    Tab(child: Text("Seller ")),
                    Tab(child: Text("Client "),),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [

                    Seller_Notification(sellers),
                    Client_Notification(clients),
                  ],
                ),
              )
            ],
          ),
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
              querySnapshot.docs.reversed.forEach((doc) => {
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
              querySnapshot.docs.reversed.forEach((doc) => {
                    sellers.add(SellerModel(
                      doc["Category"],
                      doc["SubCategory"],
                      doc["Uuid"],
                      doc["BasicDescription"],
                      doc["PremiumPrice"],
                      doc["PremiumDescription"],
                      doc["BasicPrice"],
                    ))
                  })
            });
  }
}
class Seller_Notification extends StatefulWidget {
  List<SellerModel> sellers = [];

  @override
  State<Seller_Notification> createState() => _Seller_NotificationState();

  Seller_Notification(this.sellers);
}

class _Seller_NotificationState extends State<Seller_Notification> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
                itemCount:widget.sellers.length,
                itemBuilder: (context, index) => Column(
                  children: [
                      ListTile(
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                            return PostSellers(seller:  widget.sellers[index],);
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
                                    .doc(widget.sellers[index].uid)
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
                            ],
                          ),
                          trailing: Text(widget.sellers[index].subCategory)),

                  ],
                ),
              );
  }
}
class Client_Notification extends StatefulWidget {

  List<ClientModel> clients = [];
  @override
  State<Client_Notification> createState() => _Client_NotificationState();

  Client_Notification(this.clients);
}

class _Client_NotificationState extends State<Client_Notification> {
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
                itemCount:widget.clients.length,
                itemBuilder: (context, index) => Column(
                  children: [
                      ListTile(
                          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context){
                            return PostClients(client:  widget.clients[index],);
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
                                    .doc(widget.clients[index].uid)
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

                            ],
                          ),
                          trailing: Text(widget.clients[index].subCategory)),

                  ],
                ),
              );
  }
}
