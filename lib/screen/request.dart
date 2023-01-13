// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thinkon/widget/constant.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => RequestState();
}

class RequestState extends State<Request> {
  User? user = FirebaseAuth.instance.currentUser;
  late List<String> requestUuid;
  bool loading =false;
  @override
  void initState() {
_getData().then((value) => loading = false);
    super.initState();
  }
  Future<void> _getData() async {
    await FirebaseFirestore.instance
      .collection("Users")
          .doc()
          .collection("Seller-Request")
          .orderBy('timestamp')
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs
                    .forEach((doc) => {requestUuid.add(doc["request-from"])})
              });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Request  ",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: coloruses,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)))),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount:3,
        itemBuilder: (context, index) => Column(
          children: [
            ListTile(
                leading: const Icon(
                  Icons.request_page_outlined,
                  color: coloruses,
                  size: 30,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(requestUuid[index])
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

                        return Text(messages,
                            style: TextStyle(
                                color: coloruses,
                                fontSize: 18,
                                fontWeight: FontWeight.bold));
                      },
                    ),
                    Text("client",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                  ],
                ),
                trailing: Row(children: [GestureDetector(onTap: (){},child: Container(color: coloruses,),),],)
            )
          ],
        ),
      ),
    );
  }
}
