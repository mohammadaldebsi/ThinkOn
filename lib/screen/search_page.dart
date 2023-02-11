// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/profileother.dart';
import 'package:thinkon/screen/subcategory_page.dart';
import 'package:thinkon/widget/constant.dart';
import '../models/SellerModels.dart';
import '../models/clientModel.dart';
import '../models/contactModel.dart';

User? loggedInUser = FirebaseAuth.instance.currentUser;

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,home: Search1());
  }
}

class Search1 extends StatefulWidget {
  const Search1({Key? key}) : super(key: key);

  @override
  State<Search1> createState() => _Search1State();
}

class _Search1State extends State<Search1> {
  TextEditingController search = TextEditingController();

  List<String> searchList = [];
  List<ContactModel> users = [];
  List<ClientModel> clients = [];
  List<SellerModel> sellers = [];
  List<ClientModel> clientList = [];
  List<SellerModel> sellerList = [];
  bool loading = true;
  void initState() {
    getData().then((value) => setState(() {
          loading = false;
        }));
    getDatast();
    getsellerData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Center(child: const Text("Let's Search")),
            backgroundColor: coloruses,
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50)))),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all( 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: search,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchList.removeRange(0, searchList.length);
                                  for (var i in users) {
                                    if (i.name
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i.name);
                                    }
                                  }
                                  for (var i in categories) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in programmingList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in dataList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in musicAudioList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in videoAnimationList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in graphicsDesignList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in writingTranslationList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in businessList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                  for (var i in digitalMarketingList) {
                                    if (i
                                        .toLowerCase()
                                        .contains(search.text.toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                });
                              },
                              icon: Icon(Icons.search),
                            ),
                            label: const Text("Search"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: searchList.length,
                        itemBuilder: ((context, index) => ListTile(
                              textColor: coloruses,
                              title: Text(searchList[index]),
                              onTap: () {
                                if (categories.contains(searchList[index])) {
                                  for (var client in clients) {
                                    if (client.category.toLowerCase() ==
                                        searchList[index].toLowerCase()) {
                                      clientList.add(client);
                                    }
                                  }
                                  for (var seller in sellers) {
                                    if (seller.category.toLowerCase() ==
                                        searchList[index].toLowerCase()) {
                                      sellerList.add(seller);
                                    }
                                  }
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SubCategory(
                                      Categoryname: searchList[index],
                                      clientList: clientList,
                                      sellerList: sellerList,
                                    );
                                  }));
                                }
                                for (var userI in users) {
                                  if (userI.name.contains(searchList[index])) {
                                    if (userI != loggedInUser!.uid) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ProfileOther(
                                            Uuiduser: userI.Uuid);
                                      }));
                                    }
                                  }
                                }
                              },
                            )),
                      ),
                    )
                  ],
                ),
              ));
  }

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs.forEach((doc) => {
                    users.add(ContactModel(doc["Email"], doc["Phone"],
                        doc["Username"], doc["Uuid"]))
                  })
            });
  }

  Future<void> getDatast() async {
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
  List<String> programmingList = [
    "WordPress",
    "Website Builders",
    "Game Development",
    "Mobile Apps",
    "Web Programming",
    "Desktop Applications",
    "Chatbots",
    "Cyber security",
    "User Testing",
    "QA & Review",
    "E-Commerce Development",
    "Other",
  ];

  List<String> dataList = [
    "	Data Entry",
    "	Data Processing",
    "	Data Analytics",
    "	Data Visualization",
    "	Data Science",
    "	Databases",
    "	Data Engineering",
    "	Other",
  ];
  List<String> digitalMarketingList = [
    "Marketing Strategy",
    "Social Media Marketing",
    "Social Media Advertising",
    "Search Engine Optimization (SEO)",
    "Search Engine Marketing (SEM)",
    "Local SEO",
    "Public Relations",
    "Marketing Advice",
    "Video Marketing",
    "Email Marketing",
    "Influencer Marketing",
    "Web Analytics",
    "Mobile App Marketing",
    "Other",
  ];
  List<String> graphicsDesignList = [
    "Website Design",
    "App Design",
    "UX Design",
    "Landing Page Design",
    "Icon Design",
    "Logo Design",
    "Fashion Design",
    "Image Editing",
    "Social Media Design",
    "AR Filters & Lenses",
    "Email Design",
    "Other",
  ];
  List<String> writingTranslationList = [
    "	Articles & Blog Posts",
    "	Translation",
    "	Website Content",
    "	Brand Voice & Tone",
    "	Product Descriptions",
    "	Social Media Copy",
    "	Sales Copy",
    "	Book & eBook Writing",
    "	Email Copy",
    "	Ad Copy",
    "	Case Studies",
    "	Technical Writing",
    "	Scriptwriting",
    "	Other",
  ];
  List<String> videoAnimationList = [
    "Video Editing",
    "Short Video Ads",
    "Animated GIFs",
    "Logo Animation",
    "Spokesperson Videos",
    "Lyric & Music Videos",
    "Character Animation",
    "Lottie & Website Animation",
    "3D Product Animation",
    "E-Commerce Product Videos",
    "Social Media Videos",
    "Subtitles & Captions",
    "App & Website Previews",
    "Other",
  ];
  List<String> musicAudioList = [
    "Voice Over",
    "Mixing & Mastering",
    "Producers & Composers",
    "Podcast Editing",
    "Audiobook Production",
    "Sound Design",
    "Audio Logo & Sonic Branding",
    "Singers & Vocalists",
    "Songwriters",
    "Other",
  ];
  List<String> businessList = [
    "E-Commerce Management",
    "Market Research",
    "Business Plans",
    "Presentations",
    "Sales",
    "Other",
  ];
}
