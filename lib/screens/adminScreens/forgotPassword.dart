import 'package:client_phonebook/screens/adminScreens/successfullReset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../button.dart';
import 'loginScreen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailEditingController = TextEditingController();
  // final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF323A40),
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.offAll(LoginScreen());
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: const Color(0xFF323A40),
              body: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///////*** TextFields ***\\\\\\\

                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeW * 0.07,
                              right: sizeW * 0.07,
                              top: sizeH * 0.09),
                          child: Column(
                            children: [
                              Image.asset("assets/images/phone-book.png"),
                              SizedBox(
                                height: sizeH * 0.05,
                              ),
                              Container(
                                height: sizeH * 0.07,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Enter Email for reset your password",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.black,
                                  controller: _emailEditingController,
                                  validator: (value) {
                                    bool isValidEmail = RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value!);

                                    if (!isValidEmail) {
                                      return 'Invalid Email';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide: const BorderSide(
                                            color: Colors.white)),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Enter Email',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: sizeH * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeH * 0.28,
                        ),
                        ///////*** LoginButton ***\\\\\\\

                        CustomBotton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              resetPassword(
                                  _emailEditingController.text.trim());
                              // Get.to(AdminScreen());
                            }
                          },
                          colorButtonText: Colors.black,
                          title: 'Reset Password',
                          colorButton: Colors.white,
                        ),
                      ],
                    )),
              ))),
      onWillPop: () async {
        return showExitPopup(context);
      },
    );
  }

  Future<bool> showExitPopup(context) async {
    print('willPopScope');
    Get.offAll(LoginScreen());
    return true;
  }

  resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessfullRegister()),
      );
      // Get.to(SuccessfullRegister(),
      //     transition: Transition.leftToRight, duration: Duration(seconds: 6));
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(
        title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        // colorText: kBackgroundColor
      );
    } catch (e) {
      Get.snackbar(
        'Error occured!', e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white24,
        // colorText: kBackgroundColor
      );
    }
  }
}
