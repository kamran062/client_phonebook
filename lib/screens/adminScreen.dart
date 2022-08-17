import 'package:client_phonebook/screens/selectionScreen.dart';
import 'package:client_phonebook/screens/tabBarScreens/detailsScreen.dart';
import 'package:client_phonebook/screens/tabBarScreens/newMemberDetaails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/authController.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // var data = [];
  // get_data() async {
  //   final res =
  //       await FirebaseFirestore.instance.collection("phonebookData").get();
  //   print("here is the data ${res}");
  //   data = res.docs;
  //   setState(() {});
  // }
  var Auth = Get.put(AuthController());
  // final _authController = Get.find<AuthController>();
  bool isfav = false;
  @override
  void initState() {
    // get_data();
    // TODO: implement initState
    super.initState();
  }

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
              leading: IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectionScreen()),
                  );
                },
                icon: const Icon(Icons.logout),
              ),
              title: Text(
                "Admin Panel",
                style: GoogleFonts.magra(fontSize: 16, color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(const NewContactDetailsScreen(),
                        transition: Transition.leftToRight,
                        duration: const Duration(microseconds: 100000));
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            backgroundColor: const Color(0xFF323A40),
            body: StreamBuilder<QuerySnapshot>(
                stream: pendingDataSnapshot,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white70,
                    ));
                  }
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            var nameData = data[index]["userName"];
                            var phoneData = data[index]["phone"];
                            var emailData = data[index]["email"];
                            var designationData = data[index]["designation"];
                            var addressData = data[index]["address"];
                            var imgData = data[index]["imgUrl"];
                            var descriptionData = data[index]["description"];
                            Get.to(
                                DetailScreen(
                                  nameData: nameData,
                                  phoneData: phoneData,
                                  emailData: emailData,
                                  designationData: designationData,
                                  addressData: addressData,
                                  imgData: imgData,
                                  descriptionData: descriptionData,
                                ),
                                transition: Transition.leftToRight,
                                duration: Duration(microseconds: 100000));
                          },
                          leading: ClipRRect(
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data[index]["imgUrl"]),
                              radius: 30,
                            ),
                          ),
                          title: Text(data[index]["userName"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          subtitle: Text(data[index]["phone"],
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(.5))),
                          // trailing: InkWell(
                          //   onTap: () {
                          //     // FirebaseFirestore.instance
                          //     //     .collection('phonebookData')
                          //     //     .doc()
                          //     //     .update({
                          //     //   'userName': nameEditingController.text,
                          //     //   'phone': phoneEditingController.text,
                          //     //   'email': emailEditingController.text,
                          //     //   'designation':
                          //     //       designationEditingController.text,
                          //     //   'address': addressEditingController.text,
                          //     //   'description':
                          //     //       descriptionEditingController.text,
                          //     // });
                          //     // Get.to(const NewContactDetailsScreen(),
                          //     //     transition: Transition.leftToRight,
                          //     //     duration:
                          //     //         const Duration(microseconds: 100000));
                          //
                          //     // final docUser = FirebaseFirestore.instance
                          //     //     .collection("phonebookData")
                          //     //     .doc();
                          //     // docUser.update({
                          //     //   "userName": nameEditingController,
                          //     //   "phone": phoneEditingController,
                          //     //   "address": addressEditingController,
                          //     //   "email": emailEditingController,
                          //     //   "designation": designationEditingController,
                          //     //   "description": descriptionEditingController,
                          //     // });
                          //   },
                          //   child: const Icon(
                          //     Icons.edit,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        );
                      });
                })));
  }
}
