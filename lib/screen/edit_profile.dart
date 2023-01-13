// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/screen/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thinkon/widget/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? name;
  String? phone, bio;
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: coloruses,
          toolbarHeight: 80,
          title: Text(
            "Edit Info",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }))),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: ListView(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text(
                    "Phone",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    bio = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: const Text(
                    "Bio",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: coloruses, borderRadius: BorderRadius.circular(10)),
                child: MaterialButton(
                    onPressed: () {
                      if (name!.isNotEmpty) {
                        _Auth.currentUser!.updateDisplayName(name);

                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(_Auth.currentUser!.uid)
                            .update({
                          "Username": name,
                        });
                      }
                      if (phone!.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(_Auth.currentUser!.uid)
                            .update({
                          "Phone": phone,
                        });
                      }
                      if (bio!.isNotEmpty) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(_Auth.currentUser!.uid)
                            .update({
                          "Bio": bio,
                        });
                      }

                      return Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
