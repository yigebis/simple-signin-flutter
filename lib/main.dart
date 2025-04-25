import 'package:flutter/material.dart';
import 'package:signin/signin.dart';
import 'package:signin/dashboard.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/signin",
      routes: {
        "/signin" : (context) => Signin(),
        "/dashboard" : (context) => Dashboard(),
      }
    )
  );
}

