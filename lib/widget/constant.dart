import 'dart:ui';

import 'package:flutter/material.dart';


const Color coloruses=Color(0xFF223843);
  InputDecoration decorationTextField( String name){
    InputDecoration decorationText= InputDecoration(
        label: Text(name),
        labelStyle: TextStyle(color: coloruses),
        hoverColor: coloruses,
        focusColor: coloruses,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: coloruses),
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color:coloruses),
           ),
    );
  return decorationText;
}


