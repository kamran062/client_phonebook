import 'package:client_phonebook/screens/adminScreens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../adminScreen.dart';
import '../button.dart';
import '../selectionScreen.dart';
import 'forgotPassword.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        borderSide:
                                            BorderSide(color: Colors.white)),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, right: 20),
                                child: TextFormField(
                                  obscureText: _isObscure,
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
                              SizedBox(
                                height: sizeH * 0.01,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: SizedBox(
                                  height: sizeH * 0.07,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Get.to(const ForgotPassword(),
                                                transition:
                                                    Transition.leftToRight,
                                                duration: const Duration(
                                                    microseconds: 100000));
                                          },
                                          child: const Text(
                                            "Forgot your Password?",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeH * 0.28,
                        ),
                        ///////*** LoginButton ***\\\\\\\

                        CustomBotton(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              signIn(_emailEditingController.text.trim(),
                                  _passwordEditingController.text);
                            }
                          },
                          colorButtonText: Colors.black,
                          title: 'Log In',
                          colorButton: Colors.white,
                        ),

                        ///////*** SignUp option ***\\\\\\\
                        Container(
                          height: sizeH * 0.07,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.to(const SignUpScreen(),
                                        transition: Transition.leftToRight,
                                        duration: const Duration(
                                            microseconds: 100000));
                                  },
                                  child: Text(
                                    "Sign Up",
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
    Get.offAll(const SelectionScreen());
    return true;
  }

  signIn(String email, String password) async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => const AdminScreen());
    } on FirebaseAuthException catch (e) {
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
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
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white24,
        // colorText: kBackgroundColor,
      );
    }
  }
}
