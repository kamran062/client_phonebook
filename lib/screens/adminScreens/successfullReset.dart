import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'loginScreen.dart';

class SuccessfullRegister extends StatefulWidget {
  const SuccessfullRegister({Key? key}) : super(key: key);

  @override
  _SuccessfullRegisterState createState() => _SuccessfullRegisterState();
}

class _SuccessfullRegisterState extends State<SuccessfullRegister> {
  startTime() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Get.off(LoginScreen(),
        transition: Transition.leftToRight,
        duration: Duration(microseconds: 100000));
  }

  @override
  void initState() {
    startTime();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xFF323A40),
            body: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Kindly check your given email for reset your password",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )));
  }
}
