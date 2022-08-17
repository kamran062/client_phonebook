import 'dart:async';

import 'package:client_phonebook/screens/selectionScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const SelectionScreen())));
  }

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF323A40),
      body: Container(
        color: Color(0xFF323A40),
        height: sizeH,
        width: sizeW,
        child: Center(
            child: Image.asset(
          "assets/images/phone-book.png",
        )),
      ),
    );
  }
}
