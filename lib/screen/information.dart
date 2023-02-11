// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/Login_Page.dart';

import '../NavigationBar_page.dart';
import '../widget/constant.dart';

class information extends StatelessWidget {
  const information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return information1();
  }
}

class information1 extends StatefulWidget {
  const information1({Key? key}) : super(key: key);

  @override
  State<information1> createState() => _information1State();
}
const List<String> list = <String>['Male', 'Female',];
class _information1State extends State<information1> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  User? loggedInUser = FirebaseAuth.instance.currentUser;
  late String username, bio, phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = list.first;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    late final user;
    try {
      user = await _Auth.currentUser?.email;
      loggedInUser = user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: Image(image: AssetImage("images/Consent.png")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Information",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    maxLength: 20,
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      label: Text(
                        "User name",
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter user name ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    maxLength: 10,
                    onChanged: (value) {
                      setState(() {
                        phone = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      label: Text(
                        "Phone number",
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter your phone";
                      } else if (value[0] != "0" && value[1] != "7") {
                        return "it's not phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      setState(() {
                        bio = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      label: Text(
                        "Bio",
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Enter your bio";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
              Center(

                child: DropdownButton<String>(

                  value: dropdownValue,

                  icon: const Icon(Icons.arrow_circle_down_outlined,color: coloruses,),
                  elevation: 16,
                  style: const TextStyle(color: coloruses),
                  underline: Container(
                    height: 2,
                    color: coloruses,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Color(0xFF223843),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.all(5),
                    child: MaterialButton(
                      child: const Text(
                        "save",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loggedInUser?.updateDisplayName(username);

                          _fireStore
                              .collection('Users')
                              .doc(loggedInUser!.uid)
                              .set({
                            "Email": loggedInUser?.email,
                            "Username": username,
                            "Phone": phone,
                            "Bio": bio,
                            "Uuid": loggedInUser!.uid,
                            "Gender":dropdownValue,
                          });

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Navigatorbar1();
                          }));
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
