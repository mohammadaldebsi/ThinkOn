// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thinkon/widget/constant.dart';

import '../../models/UserModel.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser = FirebaseAuth.instance.currentUser;

class LetsChat extends StatefulWidget {
  LetsChat({Key? key, required this.otherUser}) : super(key: key);
  String otherUser;
  @override
  State<LetsChat> createState() => LetsChatState();
}

class LetsChatState extends State<LetsChat> {
  final FirebaseAuth _Auth = FirebaseAuth.instance;
  final TextEditingController messageTextController = TextEditingController();
  late String message;
  String? imageUrl;
  bool load = true;
  String userUid = loggedInUser!.uid;
  UserModel user = UserModel("", "", "");
  final now = DateTime.now();
  @override
  void initState() {
    getUserdata().then((value) => setState(() {
          load = false;
        }));
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    late final user;
    try {
      user = await _Auth.currentUser?.email;

      loggedInUser = user!;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserdata() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(widget.otherUser)
        .get()
        .then((querySnapshot) => {
              user = UserModel(
                  querySnapshot.data()!["Email"] ?? "",
                  querySnapshot.data()!["Phone"] ?? "",
                  querySnapshot.data()!["Username"] ?? "")
            });
  }

  uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    final imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = (await imagePicker.getImage(source: ImageSource.gallery))!;
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await firebaseStorage.ref().child('images/imageName').putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path ');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: coloruses,
          title: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(widget.otherUser)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final messages = snapshot.data!.get("Username");

              return Text(
                "$messages",
              );
            },
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MessagesStream(otherUser: widget.otherUser),
          SizedBox(
            height: 50,
            child: TextField(
              controller: messageTextController,
              onChanged: (value) {
                message = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                label: Text(
                  "Message",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => uploadImage(),
                  child: Icon(
                    Icons.attach_file_outlined,
                    color: coloruses,
                  )),
              IconButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore
                        .collection("Users")
                        .doc(loggedInUser!.uid)
                        .collection("messages")
                        .doc()
                        .set({
                      "Text": message,
                      "From": loggedInUser!.uid,
                      "To": widget.otherUser,
                      'timestamp': Timestamp.now(),
                    });

                    _firestore
                        .collection("Users")
                        .doc(widget.otherUser)
                        .collection("messages")
                        .doc()
                        .set({
                      "Text": message,
                      "From": loggedInUser!.uid,
                      "To": widget.otherUser,
                      'timestamp': Timestamp.now(),
                    });
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: coloruses,
                  )),
            ],
          )
        ],
      )),
    );
  }
}

class MessagesStream extends StatelessWidget {
  String? otherUser;
  MessagesStream({Key? key, required this.otherUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Users')
          .doc(loggedInUser?.uid)
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        messages.runtimeType;
        for (var message in messages) {
          if ((message.get('From') == loggedInUser!.uid &&
                  message.get('To') == otherUser) ||
              (message.get('From') == otherUser &&
                  message.get('To') == loggedInUser!.uid)) {
            String messageText = message.get('Text');
            final messageSender = message.get('From');

            final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: loggedInUser?.uid == messageSender,
            );

            messageBubbles.add(messageBubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender, required this.text, required this.isMe});

  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(sender)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final messages = snapshot.data!.get("Username");

              return isMe
                  ? Text("Me",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ))
                  : Text(messages,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ));
            },
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
