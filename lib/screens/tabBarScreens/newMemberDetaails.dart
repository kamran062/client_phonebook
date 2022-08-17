import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/authController.dart';

class NewContactDetailsScreen extends StatefulWidget {
  const NewContactDetailsScreen({Key? key}) : super(key: key);

  @override
  _NewContactDetailsScreenState createState() =>
      _NewContactDetailsScreenState();
}

class _NewContactDetailsScreenState extends State<NewContactDetailsScreen> {
  // final _authController = Get.find<AuthController>();
  var loading = false;
  File? _pickedImage;
  getImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final pickedImage = (await _picker.pickImage(source: ImageSource.gallery));
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  addNewData() async {
    try {
      loading = true;
      final ref = FirebaseStorage.instance
          .ref()
          .child("usersImage")
          .child(nameEditingController.text + '.jpg');
      await ref.putFile(_pickedImage!);
      var url = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('phonebookData').add({
        'imgUrl': url,
        'userName': nameEditingController.text,
        'phone': phoneEditingController.text,
        'email': emailEditingController.text,
        'designation': designationEditingController.text,
        'address': addressEditingController.text,
        'description': descriptionEditingController.text,
      });
      loading = false;
      Get.snackbar(
        "Successfully Added Contact to list",
        "Add more contacts",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white24,
        // colorText: kBackgroundColor
      );
      nameEditingController.clear();
      phoneEditingController.clear();
      emailEditingController.clear();
      designationEditingController.clear();
      addressEditingController.clear();
      descriptionEditingController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Not Added Contact to list",
        "Try again later",
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

  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF323A40),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "New Contact",
          style: GoogleFonts.magra(fontSize: 16, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  addNewData();
                }
              },
              icon: loading ? CircularProgressIndicator() : Icon(Icons.done))
        ],
      ),
      backgroundColor: const Color(0xFF323A40),
      body: Container(
          height: sizeH,
          width: sizeW,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF2A3035),
          ),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //************** image picker *****************//
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeW * 0.36, top: sizeH * 0.05),
                      child: CircleAvatar(
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(File(_pickedImage!.path)),
                          backgroundColor: Colors.white12,
                          radius: 55,
                          child: InkWell(
                            onTap: () {
                              getImageFromGallery();
                            },
                            child: _pickedImage == null
                                ? const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )
                                : null,
                          )),
                    ),
                    //************** TextFields *****************//
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Name",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        controller: nameEditingController,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Name',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Phone",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        controller: phoneEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Number required!';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Number',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Email",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email required!';
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Designation",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: designationEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Designation required!';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.menu_book,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Designation',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Address",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.streetAddress,
                        controller: addressEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Address required!';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.location_on_sharp,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Address',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0, top: 12),
                      child: Text(
                        "Description",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20.0, top: 10, right: 20),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        controller: descriptionEditingController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Description required!';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(
                            Icons.description_outlined,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Description',
                          hintStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    ));
  }
}
