// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../NavigationBar_page.dart';
import '../widget/constant.dart';
import 'register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login1(),
    );
  }
}

class Login1 extends StatefulWidget {
  const Login1({Key? key}) : super(key: key);

  @override
  State<Login1> createState() => _Login1State();
}

class _Login1State extends State<Login1> {
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  late String email, password, result;
  final _formKey = GlobalKey<FormState>();
  late Icon textfeildicon = Icon(Icons.remove_red_eye_outlined);
  List<String> UsersEmail = [""];
  bool view = true;
  bool loading = true;
  bool validation = false;
  void initState() {
    _getUserValidation().then((value) => setState(() {
          loading = false;
        }));

    super.initState();
  }

  Future<void> _getUserValidation() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((querySnapshot) => {
              querySnapshot.docs
                  .forEach((doc) => {UsersEmail.add(doc["Email"])})
            });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(
              color: coloruses,
            ))
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Image(
                          image: AssetImage("images/Tablet login.png"),
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: 60,
                        width: 60,
                        image: AssetImage("images/think.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: coloruses,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value + "@thinkon.com";
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter your Id";
                                } else if (!UsersEmail.contains(
                                    "$value@thinkon.com")) {
                                  return "Id not found";
                                } else {
                                  for (int i = 0; i < value!.length; i++) {
                                    if (value[i].contains(RegExp(r'[0-9]'))) {
                                      return null;
                                    } else {
                                      return "id should be number";
                                    }
                                  }
                                }
                              },
                              decoration: decorationTextField("ID")),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            obscureText: view,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (view) {
                                      textfeildicon =
                                          Icon(Icons.visibility_off_outlined);
                                      view = false;
                                    } else {
                                      textfeildicon =
                                          Icon(Icons.visibility_outlined);
                                      view = true;
                                    }
                                  });
                                },
                                icon: textfeildicon,
                              ),
                              label: Text("Password"),
                              labelStyle: TextStyle(color: coloruses),
                              hoverColor: coloruses,
                              focusColor: coloruses,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: coloruses),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: coloruses),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: const Text(
                                  "forget password?",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: coloruses,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.all(5),
                            child: MaterialButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      final user = await _Auth
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Navigatorbar1();
                                      }));
                                    } on FirebaseAuthException catch (e) {
                                      print(e.message);
                                    }
                                  }
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account ?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Register1(UsersEmail);
                                  }));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
