// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/subcategory_page.dart';
import 'package:icons_plus/icons_plus.dart';

import '../models/SellerModels.dart';
import '../models/clientModel.dart';
import '../widget/constant.dart';



class Category1 extends StatefulWidget {
  const Category1({Key? key}) : super(key: key);

  @override
  State<Category1> createState() => _Category1State();
}

class _Category1State extends State<Category1> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> categories = [
    "Programming",
    "Data",
    "Digital Marketing",
    "Graphics & Design",
    "Writing & Translation",
    "Video & Animation",
    "Music & Audio",
    "Business",
    "Other",
  ];
  List<Logo> Icons = [
    Logo(Logos.code_cademy),
    Logo(Logos.amazon),
    Logo(Logos.marketo),
    Logo(Logos.adobe_illustrator),
    Logo(Logos.apple),
    Logo(Logos.viadeo),
    Logo(Logos.apple_music),
    Logo(Logos.wheniwork),
    Logo(Logos.addthis),
  ];

  List<ClientModel> clients = [];
  List<SellerModel> sellers = [];
  bool loading = true;
  @override
  void initState() {
    getData().then((value) => setState(() {
        }));
    getsellerData().then((value) => setState(() {
          loading = false;
        }));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "ThinkOn",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white),
            ),
          ),
            backgroundColor: Color(0xFF223843),
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)))),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                        width: 200,
                        child: const Text(
                          "Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: coloruses),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (int i = 0; i < categories.length; i++)
                        Button1(
                            sellerList: sellers
                                .where((element) =>
                                    element.category.toLowerCase().trim() ==
                                    categories[i].toLowerCase().trim())
                                .toList(),
                            buttonname: categories[i],
                            icons: Icons[i],
                            clientList: clients
                                .where((element) =>
                                    element.category.toLowerCase().trim() ==
                                    categories[i].toLowerCase().trim())
                                .toList()),
                    ]),
              ),
      ),
    );
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("ClientPosts")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    clients.add(ClientModel(doc["Category"], doc["SubCategory"],
                        doc["Uuid"], doc["Description"],doc["Budget"]))
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

class Button1 extends StatelessWidget {
  Button1(
      {required this.buttonname,
      required this.icons,
      required this.clientList,
      required this.sellerList});
  final String buttonname;
  final Logo icons;
  final List<ClientModel> clientList;
  final List<SellerModel> sellerList;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow:  [BoxShadow(color: coloruses,blurRadius: 4) , ]
        ),
        child: MaterialButton(
          child: Row(
            children: [
              icons,
              SizedBox(
                width: 20,
              ),
              Text(
                buttonname,
                style: TextStyle(color: Color(0xFF223843), fontSize: 15),
              )
            ],
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SubCategory(
                Categoryname: buttonname,
                clientList: clientList,
                  sellerList:sellerList,
              );
            }));
          },
        ),
      ),
    );
  }
}

List<String> addList() {
  List<String> categories = [
    "Programming",
    "Data",
    "Digital Marketing",
    "Graphics & Design",
    "Writing & Translation",
    "Video & Animation",
    "Music & Audio",
    "Business",
    "Other",
  ];

  return categories;
}
