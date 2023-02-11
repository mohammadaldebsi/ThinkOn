// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/request-Model.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => RequestState();
}

class RequestState extends State<Request> {
  User? user = FirebaseAuth.instance.currentUser;
  final List<RequestModel> requestSellerUuid = [];
  final List<RequestModel> requestClientUuid = [];
  final List<RequestModel> requestWaitUuid = [];
  bool loading = true;

  @override
  void initState() {
    _getData().then((value) => setState(() {
          loading = false;
        }));
    super.initState();
  }

  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Seller-Request")
        .orderBy('timestamp')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
                    requestSellerUuid.add(RequestModel(
                        doc['request-from'], doc["Price"], doc["status"]))
                  })
            });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Client-Request")
        .orderBy('timestamp')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) => {
                    requestClientUuid.add(RequestModel(
                        doc['request-from'], doc["Price"], doc["status"]))
                  })
            });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Wait-Accept")
        .orderBy('timestamp')
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.reversed.forEach((doc) {
                requestWaitUuid.add(RequestModel(
                    doc["request-to"], doc["status"], doc["status"]));
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Request  ",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: coloruses,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)))),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: coloruses,
              ),
            )
          : DefaultTabController(
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
                      tabs: const [
                        Tab(child: Text("Seller Request")),
                        Tab(
                          child: Text("Client Request"),
                        ),
                        Tab(
                          child: Text("Wait"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      children: [
                        Seller_Request(requestSellerUuid),
                        Client_Request(requestClientUuid),
                        Wait_Request(requestWaitUuid),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class Seller_Request extends StatefulWidget {
  Seller_Request(this.requestSellerUuid, {super.key});
  List<RequestModel> requestSellerUuid;

  @override
  State<Seller_Request> createState() => _Seller_RequestState();
}

class _Seller_RequestState extends State<Seller_Request> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: widget.requestSellerUuid.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: coloruses, blurRadius: 3),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.home_repair_service),
                        SizedBox(
                          width: 10,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.requestSellerUuid[index].UserUid)
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
                                    fontWeight: FontWeight.w600));
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("${widget.requestSellerUuid[index].price} JD"),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 30,
                            Icons.check_box,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 30,
                            Icons.indeterminate_check_box_rounded,
                            color: Colors.red,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Client_Request extends StatefulWidget {
  Client_Request(this.requestSellerUuid, {super.key});
  List<RequestModel> requestSellerUuid;
  @override
  State<Client_Request> createState() => _Client_RequestState();
}

class _Client_RequestState extends State<Client_Request> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: widget.requestSellerUuid.length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: coloruses, blurRadius: 3),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.request_page_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.requestSellerUuid[index].UserUid)
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
                                    fontWeight: FontWeight.w600));
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text("${widget.requestSellerUuid[index].price} JD"),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 30,
                            Icons.check_box,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            size: 30,
                            Icons.indeterminate_check_box_rounded,
                            color: Colors.red,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Wait_Request extends StatefulWidget {
  final List<RequestModel> requestWaitUuid;

  @override
  State<Wait_Request> createState() => _Wait_RequestState();

  Wait_Request(this.requestWaitUuid);
}

class _Wait_RequestState extends State<Wait_Request> {
  String? status;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: widget.requestWaitUuid.length,
        itemBuilder: (context, index) {
          status=widget.requestWaitUuid[index].status;
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: coloruses, blurRadius: 3),
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.request_page_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.requestWaitUuid[index].UserUid)
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
                                      fontWeight: FontWeight.w600));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if(status!.toLowerCase()=="wait")...[
                            Text("Wait...",style: TextStyle(
                                color: coloruses,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                          ],
                          if(status!.toLowerCase()=="accept")...[
                            Text("Accept",style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                          ],
                          if(status!.toLowerCase()=="reject")...[
                            Text("Reject",style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w600))
                          ],
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
