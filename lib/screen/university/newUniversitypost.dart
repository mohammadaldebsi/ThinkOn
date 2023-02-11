// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/Category.dart';
import 'package:thinkon/screen/search_page.dart';
import 'package:thinkon/screen/subcategory_page.dart';
import 'package:thinkon/screen/university/university_page.dart';
import 'package:thinkon/widget/constant.dart';

import '../home_page.dart';



class NewUpost extends StatefulWidget {
  const NewUpost({Key? key}) : super(key: key);

  @override
  State<NewUpost> createState() => _NewUpostState();
}

class _NewUpostState extends State<NewUpost> {
  TextEditingController _disc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xFF223843),
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
        ),
        body:  Form(
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
                          const BorderSide(color: coloruses, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text(
                          "What in your mind ?",
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
                              .collection('University-Post')
                              .doc()
                              .set({
                            "Description": _disc.text,
                            "Uuid": FirebaseAuth.instance.currentUser!.uid,
                            'timestamp': Timestamp.now(),
                          });
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(loggedInUser?.uid)
                              .collection('University-Post')
                              .doc()
                              .set({
                            "Description": _disc.text,
                            'timestamp': Timestamp.now(),
                          });
                          _disc.clear();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return University();
                              }));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    
    );
  }
}

