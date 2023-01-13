// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/models/SellerModels.dart';
import 'package:thinkon/screen/posts/postClient_page.dart';
import 'package:thinkon/screen/posts/postSeller_page.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/widget/constant.dart';

import '../../models/clientModel.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.clientList, required this.sellerList})
      : super(key: key);
  final List<ClientModel> clientList;
  final List<SellerModel> sellerList;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'Seller',
                  ),
                  Tab(
                    text: 'Client',
                  ),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Seller(
              sellerList: widget.sellerList,
            ),
            Client(
              clientList: widget.clientList,
            )
          ],
        ),
      ),
    );
  }
}

class Seller extends StatefulWidget {
  Seller({Key? key, required this.sellerList}) : super(key: key);
  final List<SellerModel> sellerList;
  @override
  State<Seller> createState() => _SellerState();
}

class _SellerState extends State<Seller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width /2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: widget.sellerList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return PostSellers(seller: widget.sellerList[index]);
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 3),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.sellerList[index].uid)
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
                                      color: Colors.black,
                                      fontSize: 15,
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(widget.sellerList[index].subCategory,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )),
                            Row(
                              children: [
                                Text(widget.sellerList[index].premiumprice,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class Client extends StatefulWidget {
  const Client({Key? key, required this.clientList}) : super(key: key);
  final List<ClientModel> clientList;

  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // go to _PostsClient()
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          child: Container(
            height: 300,
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width /2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: widget.clientList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return PostClients(client: widget.clientList[index]);
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 3),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.clientList[index].uid)
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
                                      fontSize: 15,
                                    ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(widget.clientList[index].subCategory,
                                style: TextStyle(
                                  color: coloruses,
                                  fontSize: 15,
                                )),
                            SizedBox(height: 35,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [

                                Text("Budget:${widget.clientList[index].budget}",
                                    style: TextStyle(
                                      color:coloruses,
                                      fontSize: 15,

                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
