// import 'package:client_phonebook/screens/tabBarScreens/detailsScreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'Controller/authController.dart';
//
// class UserScreen extends StatefulWidget {
//   const UserScreen({Key? key}) : super(key: key);
//
//   @override
//   _UserScreenState createState() => _UserScreenState();
// }
//
// class _UserScreenState extends State<UserScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF323A40),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: pendingDataSnapshot,
//           builder:
//               (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.hasError) {
//               return const Text('Something went wrong');
//             }
//
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(
//                 color: Colors.white70,
//               ));
//             }
//             var data = snapshot.data!.docs;
//             return ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     onTap: () {
//                       var nameData = data[index]["userName"];
//                       var phoneData = data[index]["phone"];
//                       var emailData = data[index]["email"];
//                       var designationData = data[index]["designation"];
//                       var addressData = data[index]["address"];
//                       var imgData = data[index]["imgUrl"];
//                       var descriptionData = data[index]["description"];
//                       print("tapped");
//                       Get.to(
//                           DetailScreen(
//                             nameData: nameData,
//                             phoneData: phoneData,
//                             emailData: emailData,
//                             designationData: designationData,
//                             addressData: addressData,
//                             imgData: imgData,
//                             descriptionData: descriptionData,
//                           ),
//                           transition: Transition.leftToRight,
//                           duration: Duration(microseconds: 100000));
//                     },
//                     leading: ClipRRect(
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(data[index]["imgUrl"]),
//                         radius: 30,
//                       ),
//                     ),
//                     title: Text(data[index]["userName"],
//                         style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w400)),
//                     subtitle: Text(data[index]["phone"],
//                         style: TextStyle(
//                             fontSize: 14, color: Colors.white.withOpacity(.5))),
//                     trailing: InkWell(
//                       onTap: () {},
//                       child: const Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                       ),
//                     ),
//                   );
//                 });
//           }),
//     );
//   }
// }
