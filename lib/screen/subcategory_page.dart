// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/models/clientModel.dart';
import 'package:thinkon/screen/posts/post_page.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/widget/constant.dart';

import '../models/SellerModels.dart';
import '../models/cubcategory.dart';

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
  late List<SubCategoryModel> names = listfill(widget.Categoriesname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          title: Text(widget.Categoriesname,
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: (MediaQuery.of(context).size.width),
            height: (MediaQuery.of(context).size.height),
            child: GridView.builder(  gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width /2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),itemCount: names.length, itemBuilder: (BuildContext ctx, index) {
              return   _CreateSubCategory(
                  name: names[index],
                  clientList: widget.clientList
                      .where((element) =>
                  element.subCategory.toLowerCase().trim() ==
                      names[index].subcategory.toLowerCase().trim())
                      .toList(),
                  sellerList: widget.sellerList
                      .where((element) =>
                  element.subCategory.toLowerCase().trim() ==
                      names[index].subcategory.toLowerCase().trim())
                      .toList());
            }),
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
  final SubCategoryModel name;
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
            boxShadow: [
              BoxShadow(color: coloruses, blurRadius: 4),
            ],
            image: DecorationImage(
              image: widget.name.image,
              fit: BoxFit.fill,
            )),
        child: MaterialButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Post(
                clientList: widget.clientList, sellerList: widget.sellerList);
          }));
        }),
      ),
    );
  }
}

List<SubCategoryModel> listfill(String name) {
  List<SubCategoryModel> Programming = [
    SubCategoryModel("WordPress", AssetImage("images/WordPress.jpg")),
    SubCategoryModel(
        "Website Builders", AssetImage("images/website builder 1.png")),
    SubCategoryModel(
        "Game Development", AssetImage("images/game-development.jpg")),
    SubCategoryModel("Mobile Apps", AssetImage("images/mobile app.png")),
    SubCategoryModel(
        "Web Programming", AssetImage("images/web programming.jpg")),
    SubCategoryModel(
        "Desktop Applications", AssetImage("images/desktop applications.png")),
    SubCategoryModel(
        "Cyber security", AssetImage("images/cyber security.jpeg")),
    SubCategoryModel("User Testing", AssetImage("images/user testing.png")),
    SubCategoryModel("QA & Review", AssetImage("images/Qa and review.png")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];

  List<SubCategoryModel> Data = [
    SubCategoryModel("	Data Entry", AssetImage("images/data entry.jpg")),
    SubCategoryModel(
        "	Data Processing", AssetImage("images/data processing.jpg")),
    SubCategoryModel(
        "	Data Analytics", AssetImage("images/data analytics.png")),
    SubCategoryModel(
        "	Data Visualization", AssetImage("images/data visualization.png")),
    SubCategoryModel("	Data Science", AssetImage("images/data science.jpg")),
    SubCategoryModel("	Databases", AssetImage("images/data base.jpg")),
    SubCategoryModel(
        "	Data Engineering", AssetImage("images/data engineering.jpg")),
    SubCategoryModel("	Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> DigitalMarketing = [
    SubCategoryModel(
        "Marketing Strategy", AssetImage("images/marketing strategy.jpg")),
    SubCategoryModel("Social Media Marketing",
        AssetImage("images/social media marketing.png")),
    SubCategoryModel("Social Media Advertising",
        AssetImage("images/social media advertising.jpg")),
    SubCategoryModel("Search Engine Optimization (SEO)",
        AssetImage("images/search engine optimization.jpg")),
    SubCategoryModel(
        "Marketing Advice", AssetImage("images/Marketing Advice.jpg")),
    SubCategoryModel(
        "Video Marketing", AssetImage("images/Video Marketing.jpg")),
    SubCategoryModel(
        "Email Marketing", AssetImage("images/Email Marketing.jpg")),
    SubCategoryModel(
        "Influencer Marketing", AssetImage("images/Influencer Marketing.jpeg")),
    SubCategoryModel(
        "Mobile App Marketing", AssetImage("images/Mobile App Marketing.png")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> GraphicsDesign = [
    SubCategoryModel("Website Design", AssetImage("images/Website Design.jpg")),
    SubCategoryModel("App Design", AssetImage("images/App Design.jpg")),
    SubCategoryModel("UX Design", AssetImage("images/UIUXdesign.jpeg")),
    SubCategoryModel(
        "Landing Page Design", AssetImage("images/Landing Page Design.jpg")),
    SubCategoryModel("Fashion Design", AssetImage("images/Fashion Design.png")),
    SubCategoryModel(
        "AR Filters & Lenses", AssetImage("images/AR Filters & Lenses.jpg")),
    SubCategoryModel("Email Design", AssetImage("images/Email Design.png")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> WritingTranslation = [
    SubCategoryModel("	Articles & Blog Posts", AssetImage("images/post.jpg")),
    SubCategoryModel("	Translation", AssetImage("images/Translation.jpg")),
    SubCategoryModel(
        "	Website Content", AssetImage("images/Website Content.jpg")),
    SubCategoryModel(
        "	Brand Voice & Tone", AssetImage("images/Brand Voice & Tone.png")),
    SubCategoryModel(
        "	Social Media Copy", AssetImage("images/Social Media Copy.jpg")),
    SubCategoryModel("	Sales Copy", AssetImage("images/Sales Copy.jpg")),
    SubCategoryModel(
        "	Book & eBook Writing", AssetImage("images/Book & eBook Writing.jpg")),
    SubCategoryModel("	Email Copy", AssetImage("images/EmailCopy.jpg")),
    SubCategoryModel("	Ad Copy", AssetImage("images/Ad Copy.png")),
    SubCategoryModel("	Case Studies", AssetImage("images/CaseStudies.png")),
    SubCategoryModel(
        "	Technical Writing", AssetImage("images/TechnicalWriting.jpg")),
    SubCategoryModel("	Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> VideoAnimation = [
    SubCategoryModel("Video Editing", AssetImage("images/VideoEditing.jpg")),
    SubCategoryModel("Logo Animation", AssetImage("images/LogoAnimation.png")),
    SubCategoryModel(
        "Spokesperson Videos", AssetImage("images/SpokespersonVideos.jpg")),
    SubCategoryModel(
        "3D Product Animation", AssetImage("images/3DProductAnimation.png")),
    SubCategoryModel("E-Commerce Product Videos",
        AssetImage("images/E-CommerceProductVideos.jpg")),
    SubCategoryModel(
        "Social Media Videos", AssetImage("images/SocialMediaVideos.jpg")),
    SubCategoryModel(
        "Subtitles & Captions", AssetImage("images/Subtitles&Captions.jpg")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> MusicAudio = [
    SubCategoryModel("Voice Over", AssetImage("images/VoiceOver.jpg")),
    SubCategoryModel(
        "Mixing & Mastering", AssetImage("images/Mixing &Mastering.jpg")),
    SubCategoryModel(
        "Podcast Editing", AssetImage("images/PodcastEditing.jpg")),
    SubCategoryModel("Sound Design", AssetImage("images/Sound Design.jpg")),
    SubCategoryModel("Audio Logo & Sonic Branding",
        AssetImage("images/Audio Logo & Sonic Branding.jpg")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];
  List<SubCategoryModel> Business = [
    SubCategoryModel("Market Research", AssetImage("images/researchmarketing")),
    SubCategoryModel("Business Plans", AssetImage("images/bussnisplan")),
    SubCategoryModel(
        "Presentations", AssetImage("images/business-presentation")),
    SubCategoryModel("Other", AssetImage("images/other.jpg")),
  ];
List<SubCategoryModel> Other = [
  SubCategoryModel("Other", AssetImage("images/other.jpg")),
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
    case "Other" :
      return Other;
  }
  return [];
}
