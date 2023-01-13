// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thinkon/screen/information.dart';
import '../widget/constant.dart';
import 'Login_Page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register1 extends StatefulWidget {
  const Register1({Key? key}) : super(key: key);

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  FirebaseAuth _Auth = FirebaseAuth.instance;
  late String Email, Password, ConfirmPassword;
  bool result = false;
  bool resultPassword = false;
  bool foundEmail=false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
        Flexible(
          child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Image(image: AssetImage("images/Consent.png")),),
        ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: coloruses,
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      Email = value + "@thinkon.com";
                    },
                    decoration: decorationTextField("ID"),
                    validator: (String? value) {
                      for (int i = 0; i < value!.length; i++) {
                    if(value[i].contains( RegExp(r'[0-9]'))) {
                      return null;
                    }
                    else {
                      return "id should be number";
                    }
                    }
                      if(value.length !=10) {
                        return "Id should be 10 index";
                      }
                      if(foundEmail) {
                        return "The email address is already in use";
                      }

                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      Password = value;
                    },
                    decoration: decorationTextField("Password"),
                    validator: (String? value) {
                      if (value!.length <= 7) {
                        return "password should be more than 7";
                      } else
                        return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    onChanged: (Value) {
                      setState(() {
                        if (Value == Password) {
                          ConfirmPassword = Value;
                          resultPassword = true;
                        } else {
                          resultPassword = false;
                        }
                      });
                    },
                    decoration: decorationTextField("Confirm Password"),
                    validator: (value) {
                      if (resultPassword) {
                        return null;
                      } else {
                        return "password not same";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
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
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final newUser = await _Auth
                                  .createUserWithEmailAndPassword(
                                      email: Email, password: Password);
                              _Auth.signInWithEmailAndPassword(
                                  email: Email, password: Password);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return information();
                              }));
                            } catch (e) {
                              setState(() {
                                foundEmail=true;
                              });
                              print(e);
                            }
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already member?",
                        style:
                            TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      TextButton(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.blueGrey, fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Login();
                          }));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
