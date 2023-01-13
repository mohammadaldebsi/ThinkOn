// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/screen/search_page.dart';
import 'package:thinkon/screen/subcategory_page.dart';
import 'package:thinkon/widget/constant.dart';

import '../home_page.dart';

TextEditingController premiumDescription = TextEditingController();
TextEditingController premiumPrice = TextEditingController();
TextEditingController basicDescription = TextEditingController();
TextEditingController basicPrice = TextEditingController();

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: NewPostOption());
  }
}

class NewPostOption extends StatefulWidget {
  const NewPostOption({Key? key}) : super(key: key);

  @override
  State<NewPostOption> createState() => _NewPostOptionState();
}

class _NewPostOptionState extends State<NewPostOption> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xFF223843),
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Homepage();
                    }))),
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      text: 'Post Seller',
                    ),
                    Tab(
                      text: 'Post Client',
                    ),
                  ],
                )
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              PostSeller(),
              PostClient(),
            ],
          )),
    );
  }
}

class PostSeller extends StatefulWidget {
  const PostSeller({Key? key}) : super(key: key);

  @override
  State<PostSeller> createState() => _PostSellerState();
}

class _PostSellerState extends State<PostSeller> {
  List<String> categoryList = addList();
  late String valueCategoryList = categoryList[0];
  late String newValue = valueCategoryList;
  late List<String> subCategoryList = listfill(newValue);
  late String valueSubCategoryList = subCategoryList[0];
  TextEditingController discseller = TextEditingController();
  final _formK = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formK,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                height: 100,
                width: 500,
                child: TextFormField(
                  controller: discseller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blueGrey, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: const Text(
                      "About you",
                      style: TextStyle(color: coloruses),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "Enter some info about you";
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.5, color: Colors.blue)),
                child: DropdownButton(
                  value: valueCategoryList,
                  onChanged: (String? value) {
                    setState(() {
                      valueCategoryList = value!;
                      subCategoryList = listfill(valueCategoryList);
                      valueSubCategoryList = subCategoryList[0];
                    });
                  },
                  items: categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.5, color: Colors.blue)),
                child: DropdownButton(
                  value: valueSubCategoryList,
                  onChanged: (String? value) {
                    setState(() {
                      valueSubCategoryList = value!;
                    });
                  },
                  items: subCategoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            DefaultTabController(
              length: 2, // length of tabs
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(child: Text("Basic")),
                        Tab(child: Text("Premium")),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 300,
                    height: 300,
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                                child: Container(
                                  height: 50,
                                  width: 500,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: basicPrice,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey, width: 1.5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      label: const Text(
                                        "Basic Price",
                                        style: TextStyle(color: coloruses),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (int.parse(value!) <= 0) {
                                        return "Enter true price";
                                      }
                                      if (value.isNotEmpty) {
                                        return null;
                                      }  else {
                                        return "enter your Price";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                                child: Container(
                                  height: 100,
                                  width: 500,
                                  child: TextFormField(
                                    controller: basicDescription,
                                    maxLines: null,
                                    expands: true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey, width: 1.5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      label: const Text(
                                        "Basic Description",
                                        style: TextStyle(color: coloruses),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "enter your Description";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                                child: Container(
                                  height: 100,
                                  width: 500,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: premiumPrice,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey, width: 1.5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      label: const Text(
                                        "Premium Price",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (int.parse(value!) <= 0) {
                                        return "Enter true price";
                                      }
                                      if (value.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "enter your price";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Container(
                                  height: 100,
                                  width: 500,
                                  child: TextFormField(
                                    controller: premiumDescription,
                                    maxLines: null,
                                    expands: true,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey, width: 1.5),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      label: const Text(
                                        "Premium Description",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    validator: (String? value) {
                                      if (value!.isNotEmpty) {
                                        return null;
                                      } else {
                                        return "enter your Description";
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: coloruses,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (_formK.currentState!.validate()) {
                              FirebaseFirestore.instance
                                  .collection('SellerPosts')
                                  .doc()
                                  .set({
                                "Description": discseller.text,
                                "Category": valueCategoryList,
                                "SubCategory": valueSubCategoryList,
                                "Uuid": FirebaseAuth.instance.currentUser!.uid,
                                "BasicPrice": basicPrice.text,
                                "BasicDescription": basicDescription.text,
                                "PremiumPrice": premiumPrice.text,
                                "PremiumDescription": premiumDescription.text,
                                'timestamp': Timestamp.now(),
                              });

                              FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(loggedInUser!.uid)
                                  .collection('SellerPosts')
                                  .doc()
                                  .set({
                                "Description": discseller.text,
                                "Category": valueCategoryList,
                                "SubCategory": valueSubCategoryList,
                                "BasicPrice": basicPrice.text,
                                "BasicDescription": basicDescription.text,
                                "PremiumPrice": premiumPrice.text,
                                "PremiumDescription": premiumDescription.text,
                                'timestamp': Timestamp.now(),
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Homepage();
                              }));
                            }
                          }),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostClient extends StatefulWidget {
  const PostClient({Key? key}) : super(key: key);

  @override
  State<PostClient> createState() => _PostClientState();
}

class _PostClientState extends State<PostClient> {
  List<String> categoryList = addList();
  late String valueCategoryList = categoryList[0];
  String newValue = "Programming";
  List<String> subCategoryList = listfill("Programming");
  late String valueSubCategoryList = subCategoryList[0];
  TextEditingController _disc = TextEditingController();
  TextEditingController _budget = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                height: 100,
                width: 500,
                child: TextFormField(
                  controller: _disc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blueGrey, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: const Text(
                      "Description",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return "enter your Description";
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.5, color: coloruses)),
                child: DropdownButton(
                  value: valueCategoryList,
                  onChanged: (String? value) {
                    setState(() {
                      valueCategoryList = value!;
                      subCategoryList = listfill(valueCategoryList);
                      valueSubCategoryList = subCategoryList[0];
                    });
                  },
                  items: categoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.5, color: coloruses)),
                child: DropdownButton(
                  value: valueSubCategoryList,
                  onChanged: (String? value) {
                    setState(() {
                      valueSubCategoryList = value!;
                    });
                  },
                  items: subCategoryList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                height: 50,
                width: 500,
                child: TextFormField(
                  controller: _budget,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blueGrey, width: 1.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: const Text(
                      "Budget",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  validator: (String? value) {
                     if (int.parse(value!) <= 0) {
                    return "Enter true price";
                    }
                    if (value.isNotEmpty) {
                      return null;
                    } else {
                      return "enter your budget";
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: coloruses, borderRadius: BorderRadius.circular(15)),
                child: MaterialButton(
                  child: Text(
                    "Post",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('ClientPosts')
                          .doc()
                          .set({
                        "Description": _disc.text,
                        "Category": valueCategoryList,
                        "SubCategory": valueSubCategoryList,
                        "Uuid": FirebaseAuth.instance.currentUser!.uid,
                        "Budget": _budget.text,
                        'timestamp': Timestamp.now(),
                      });
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(loggedInUser?.uid)
                          .collection('ClientPosts')
                          .doc()
                          .set({
                        "Description": _disc.text,
                        "Category": valueCategoryList,
                        "SubCategory": valueSubCategoryList,
                        "Budget": _budget.text,
                        'timestamp': Timestamp.now(),
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Homepage();
                      }));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
