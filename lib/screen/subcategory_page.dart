// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/models/clientModel.dart';
import 'package:thinkon/screen/posts/post_page.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/SellerModels.dart';

class SubCategory extends StatelessWidget {
  const SubCategory(
      {Key? key,
      required this.Categoryname,
      required this.clientList,
      required this.sellerList})
      : super(key: key);
  final String Categoryname;
  final List<ClientModel> clientList;
  final List<SellerModel> sellerList;
  @override
  Widget build(BuildContext context) {
    return SubCategory1(
      Categoriesname: Categoryname,
      clientList: clientList,
      sellerList: sellerList,
    );
  }
}

class SubCategory1 extends StatefulWidget {
  SubCategory1(
      {Key? key,
      required this.Categoriesname,
      required this.clientList,
      required this.sellerList})
      : super(key: key);
  late final String Categoriesname;
  late final List<ClientModel> clientList;
  final List<SellerModel> sellerList;

  @override
  State<SubCategory1> createState() => _SubCategory1State();
}

class _SubCategory1State extends State<SubCategory1> {
  late List<String> names = listfill(widget.Categoriesname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  Navigator.pop(context)),
          title:
              Text(widget.Categoriesname, style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 8),
        child: Container(
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.height),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                for (int i = 0; i < names.length; i++) ...[
                  Row(
                    children: [
                      _CreateSubCategory(
                          name: names[i],
                          clientList: widget.clientList
                              .where((element) =>
                                  element.subCategory.toLowerCase().trim() ==
                                  names[i].toLowerCase().trim())
                              .toList(),
                          sellerList: widget.sellerList
                              .where((element) =>
                                  element.subCategory.toLowerCase().trim() ==
                                  names[i].toLowerCase().trim())
                              .toList()),
                      _CreateSubCategory(
                          name: names[++i],
                          clientList: widget.clientList
                              .where((element) =>
                                  element.subCategory.toLowerCase().trim() ==
                                  names[i].toLowerCase().trim())
                              .toList(),
                          sellerList: widget.sellerList
                              .where((element) =>
                                  element.subCategory.toLowerCase().trim() ==
                                  names[i].toLowerCase().trim())
                              .toList()),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CreateSubCategory extends StatefulWidget {
  const _CreateSubCategory(
      {Key? key,
      required this.name,
      required this.clientList,
      required this.sellerList})
      : super(key: key);
  final String name;
  final List<ClientModel> clientList;
  final List<SellerModel> sellerList;

  @override
  State<_CreateSubCategory> createState() => _CreateSubCategoryState();
}

class _CreateSubCategoryState extends State<_CreateSubCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: (MediaQuery.of(context).size.width) / 2.1001,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          boxShadow: const [ BoxShadow(color: Colors.black, blurRadius: 1),]
        ),
        child: MaterialButton(
            child: Text(widget.name,style: TextStyle(fontSize: 18,color: coloruses),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Post(clientList: widget.clientList,sellerList:widget.sellerList);
              }));
            }),
      ),
    );
  }
}

List<String> listfill(String name) {
  List<String> Programming = [
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

  List<String> Data = [
    "	Data Entry",
    "	Data Processing",
    "	Data Analytics",
    "	Data Visualization",
    "	Data Science",
    "	Databases",
    "	Data Engineering",
    "	Other",
  ];
  List<String> DigitalMarketing = [
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
  List<String> GraphicsDesign = [
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
  List<String> WritingTranslation = [
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
  List<String> VideoAnimation = [
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
  List<String> MusicAudio = [
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
  List<String> Business = [
    "E-Commerce Management",
    "Market Research",
    "Business Plans",
    "Presentations",
    "Sales",
    "Other",
  ];

  switch (name) {
    case "Data":
      return Data;

    case "Programming":
      return Programming;
    case "Digital Marketing":
      return DigitalMarketing;

    case "Graphics & Design":
      return GraphicsDesign;
    case "Writing & Translation":
      return WritingTranslation;
    case "Video & Animation":
      return VideoAnimation;
    case "Music & Audio":
      return MusicAudio;
    case "Business":
      return Business;
    case "Other":
      return ["Other"];
  }
  return [];
}
