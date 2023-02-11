// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thinkon/screen/chat/chat_page.dart';
import 'package:thinkon/screen/posts/newPost_page.dart';
import 'package:thinkon/screen/posts/postSeller_page.dart';
import 'package:thinkon/widget/constant.dart';
import '../models/SellerModels.dart';
import '../models/clientModel.dart';
import '../models/cubcategory.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  late User LoggedInUser;
  List<ClientModel> clients = [];
  List<SellerModel> sellers = [];
  bool loading = true;
  @override
  void initState() {
    getData().then((value) => setState(() {}));
    getsellerData().then((value) => setState(() {
          loading = false;
        }));
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _Auth.currentUser;

      LoggedInUser = user!;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("ClientPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    clients.add(ClientModel(doc["Category"], doc["SubCategory"],
                        doc["Uuid"], doc["Description"], doc["Budget"]))
                  })
            });
  }

  Future<void> getsellerData() async {
    await FirebaseFirestore.instance
        .collection("SellerPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "ThinkOn",
            style: TextStyle(color: Colors.white),
          ),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewPost();
                  }));
                },
                icon: const Icon(Icons.add_box_outlined),
                iconSize: 20),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatScreen();
                  }));
                },
                icon: const Icon(Icons.messenger_outline_outlined),
                iconSize: 20),
          ],
          backgroundColor: Color(0xFF223843),
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
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: const Text(
                        "Overview",
                        style: TextStyle(
                            color: Color(0xFF223843),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black, blurRadius: 5),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage("images/hultprize.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: const Text(
                        "Trends",
                        style: TextStyle(
                            color: Color(0xFF223843),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  _subcategorytrend(clients, sellers),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: const Text(
                        "Best Seller",
                        style: TextStyle(
                            color: Color(0xFF223843),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  Trending(),
                ],
              ),
            ),
    );
  }
}

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  List<SellerModel> sellerList = [];
  bool loading = true;
  @override
  void initState() {
    getsellerData().then((value) => setState(() {
          loading = false;
        }));
    // TODO: implement initState
    super.initState();
  }

  Future<void> getsellerData() async {
    await FirebaseFirestore.instance
        .collection("SellerPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    sellerList.add(SellerModel(
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(
            color: coloruses,
          ))
        : Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  physics: ScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing:10),
                  itemCount: sellerList.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PostSellers(seller: sellerList[index]);
                        }));
                      },
                      child: Container(
                        alignment: Alignment.center,
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
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(sellerList[index].uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlueAccent,
                                      ),
                                    );
                                  }
                                  final messages =
                                      snapshot.data!.get("Username");

                                  return Text(messages,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
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
            ),
          );
  }
}

class _subcategorytrend extends StatefulWidget {
  List<ClientModel> clients = [];
  List<SellerModel> sellers = [];
  @override
  State<_subcategorytrend> createState() => _CreateEventContainerState();

  _subcategorytrend(this.clients, this.sellers);
}

class _CreateEventContainerState extends State<_subcategorytrend> {
  List<SubCategoryModel> subCategory = [
    SubCategoryModel(
        "Website Builders", AssetImage("images/website builder 1.png")),
    SubCategoryModel("	Data Science", AssetImage("images/data science.jpg")),
    SubCategoryModel("App Design", AssetImage("images/App Design.jpg")),
    SubCategoryModel(
        "Video Marketing", AssetImage("images/Video Marketing.jpg")),
    SubCategoryModel("UX Design", AssetImage("images/UIUXdesign.jpeg")),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var x in subCategory) ...[
            MaterialButton(
                onPressed: () {},
                child: Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: x.image, fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black, blurRadius: 5),
                    ],
                  ),
                )),
          ]
        ],
      ),
    );
  }
}
