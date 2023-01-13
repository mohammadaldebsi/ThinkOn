import 'package:flutter/material.dart';

class ChatData extends ChangeNotifier {
  List<String> sendername = [];
  add(String name) {
    sendername.add(name);
  }
}
