import 'package:conversor/home.dart';
import 'package:conversor/sales_tax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(hintColor: Colors.lightBlue, primaryColor: Colors.white),
  ));
}

