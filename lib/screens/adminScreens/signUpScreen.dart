import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/authController.dart';
import '../button.dart';
import 'loginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  // final _authController = Get.find<AuthController>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: SafeArea(
          child: Scaffold(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 20),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  controller: _nameEditingController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name required!';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.person,
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
                                    hintText: 'Enter Your Name',
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  // onChanged: (value) {
                                  //   email = value.toString().trim();
                                  // },
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Enter Your Email',
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 20),
                                child: TextFormField(
                                  obscureText: _isObscure,
                                  // onChanged: (value) {
                                  //   password = value;
                                  // },
                                  cursorColor: Colors.black,
                                  controller: _passwordEditingController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password required!';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    hintText: 'Enter Password',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeH * 0.26,
                        ),
                        ///////*** SignUp button ***\\\\\\\

                        CustomBotton(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              signUp(_nameEditingController.text,_emailEditingController.text.trim(), _passwordEditingController.text,);
                              // try {
                              //   final credential = await FirebaseAuth.instance
                              //       .createUserWithEmailAndPassword(
                              //     email: _emailEditingController.text.trim(),
                              //     password: _passwordEditingController.text,
                              //   );
                              //   Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const LoginScreen()),
                              //   );
                              //   // Get.to(AdminScreen());
                              // } on FirebaseAuthException catch (e) {
                              //   if (e.code == 'user-not-found') {
                              //     print('No user found for that email.');
                              //   } else if (e.code == 'wrong-password') {
                              //     print(
                              //         'Wrong password provided for that user.');
                              //   }
                              // }
                              // Get.to(AdminScreen());
                            }
                            // if (_formKey.currentState!.validate()) {
                            //   // _formKey.currentState?.save();
                            //   _authController.signUp(
                            //     _nameEditingController.text,
                            //     _emailEditingController.text.trim(),
                            //     _passwordEditingController.text,
                            //   );
                            //   // Get.to(AdminScreen());
                            // }
                          },
                          colorButtonText: Colors.black,
                          title: 'Sign Up',
                          colorButton: Colors.white,
                        ),

                        ///////*** LogIn option ***\\\\\\\
                        Container(
                          height: sizeH * 0.07,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const LoginScreen(),
                                        transition: Transition.leftToRight,
                                        duration:
                                            Duration(microseconds: 100000));
                                  },
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: sizeW * 0.033),
                                  ))
                            ],
                          ),
                        )
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

  signUp(String name, String email, String password) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) {
        FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      });
      final User? user = FirebaseAuth.instance.currentUser;
      final _uid = user?.uid;
      FirebaseFirestore.instance.collection('phonebookData').doc(_uid).set({
        'userName': nameEditingController.text,
        'phone': phoneEditingController.text,
        'email': emailEditingController.text,
        'designation': designationEditingController.text,
        'address': addressEditingController.text,
        'description': descriptionEditingController.text,
      });
      Get.to(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(
        title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white24,
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
