// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:thinkon/screen/chat/letsChat_page.dart';

import 'package:thinkon/widget/constant.dart';


class ChatScreen extends StatefulWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lets chat"),
          backgroundColor: coloruses,
          toolbarHeight: 80,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  Navigator.pop(context)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body:SafeArea(child: _MessagesStream())
    );
  }
}

class Listtile extends StatelessWidget {
  late String uuid;

  Listtile({Key? key, required this.uuid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: coloruses,blurRadius: 3) , ]
      ),
      child: ListTile(
        title:  StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(uuid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            final messages = snapshot.data!.get("Username");

            return Text(messages,
                style: const TextStyle(
                  color:coloruses,
                  fontSize: 18,
                ));
          },
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LetsChat(otherUser: uuid,);
          }));
        },
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: AssetImage("images/profile.jpg"),
              )),
        ),
      ),
    );
  }
}


class _MessagesStream extends StatelessWidget {

  _MessagesStream({Key? key}) : super(key: key);
  List<String>uuuid=[];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages-userUuid')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs;
        List<Listtile> listTile = [];
        for (var message in messages) {
          if ((message.get('receiver-Uuid') == loggedInUser!.uid ||
              message.get('sender-Uuid') == loggedInUser!.uid)){
            if(message.get('receiver-Uuid') == loggedInUser!.uid && !uuuid.contains(message.get('sender-Uuid'))  ) {
           final  fromUuid=message.get('sender-Uuid');
           uuuid.add(fromUuid);
              final names = Listtile(
               uuid: fromUuid,
              );
           listTile.add(names);
            }else if( !uuuid.contains(message.get('receiver-Uuid')) && message.get('receiver-Uuid') != loggedInUser!.uid ){
              final  fromUuid=message.get('receiver-Uuid');
              uuuid.add(fromUuid);
              final names = Listtile(
                uuid: fromUuid,
              );
              listTile.add(names);
            }
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: listTile,
          ),
        );
      },
    );
  }
}
