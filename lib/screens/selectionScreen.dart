import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'adminScreens/loginScreen.dart';
import 'button.dart';
import 'homeScreen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: sizeH,
        width: sizeW,
        color: Color(0xFF323A40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBotton(
              title: 'Join as User',
              colorButtonText: Colors.white,
              onPress: () {
                Get.to(HomeScreen(),
                    transition: Transition.leftToRight,
                    duration: Duration(microseconds: 100000));
              },
              colorButton: Colors.black,
            ),
            SizedBox(
              height: sizeH * 0.02,
            ),
            CustomBotton(
              title: 'Join as Admin',
              colorButtonText: Colors.white,
              onPress: () {
                Get.to(LoginScreen(),
                    transition: Transition.leftToRight,
                    duration: Duration(microseconds: 100000));
              },
              colorButton: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
