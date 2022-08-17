import 'package:client_phonebook/screens/tabBarScreens/detailsScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

import '../Controller/authController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalStorage storage = LocalStorage('fav');
  TextEditingController editingController = TextEditingController();
  final duplicateItems = <String>[];
  var items = <String>[];
  @override
  void initState() {
    super.initState();
  }

  List favList = [];
  var isfav;
  var data;
  final TextEditingController _searchController = TextEditingController();
  bool showOrgList = true;
  @override
  Widget build(BuildContext context) {
    var sizeH = MediaQuery.of(context).size.height;
    var sizeW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF323A40),
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Phone",
            style: GoogleFonts.magra(fontSize: 16, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFF323A40),
        body: SingleChildScrollView(
          child: Container(
              height: sizeH,
              width: sizeW,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF2A3035),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      autofocus: false,
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Search Contact',
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_searchController.text.isNotEmpty) {
                                showOrgList = false;
                              } else {
                                showOrgList = true;
                              }
                            });
                          },
                          child: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: sizeH * 0.8,
                    width: sizeW,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF202329),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: pendingDataSnapshot,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.white70,
                            ));
                          }

                          data = snapshot.data!.docs;
                          return showOrgList
                              ? ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print("tapped");
                                    var isfav = storage.getItem(
                                            "${data[index]["phone"]}") ??
                                        false;
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            var nameData =
                                                data[index]["userName"];
                                            var phoneData =
                                                data[index]["phone"];
                                            var emailData =
                                                data[index]["email"];
                                            var designationData =
                                                data[index]["designation"];
                                            var addressData =
                                                data[index]["address"];
                                            var imgData = data[index]["imgUrl"];
                                            var descriptionData =
                                                data[index]["description"];
                                            print("tapped");
                                            Get.to(
                                                DetailScreen(
                                                  nameData: nameData,
                                                  phoneData: phoneData,
                                                  emailData: emailData,
                                                  designationData:
                                                      designationData,
                                                  addressData: addressData,
                                                  imgData: imgData,
                                                  descriptionData:
                                                      descriptionData,
                                                ),
                                                transition:
                                                    Transition.leftToRight,
                                                duration: Duration(
                                                    microseconds: 100000));
                                          },
                                          leading: ClipRRect(
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  data[index]["imgUrl"]),
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
                                                  color: Colors.white
                                                      .withOpacity(.5))),
                                          trailing: GestureDetector(
                                            onTap: () async {
                                              if (isfav) {
                                                await storage.deleteItem(
                                                    data[index]["phone"]);
                                              } else {
                                                await storage.setItem(
                                                    data[index]["phone"], true);
                                              }
                                              setState(() {});
                                            },
                                            child: isfav
                                                ? Icon(
                                                    Icons.favorite,
                                                    size: sizeH * 0.025,
                                                    color: Colors.white,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    size: sizeH * 0.025,
                                                    color: Colors.white,
                                                  ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black.withOpacity(.5),
                                          endIndent: 20,
                                          indent: 20,
                                        ),
                                      ],
                                    );
                                  })
                              : ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var isfav = storage.getItem(
                                            "${data[index]["phone"]}") ??
                                        false;
                                    return data[index]["userName"].contains(
                                            _searchController.text
                                                .toLowerCase()
                                                .trim())
                                        ? Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  var nameData =
                                                      data[index]["userName"];
                                                  var phoneData =
                                                      data[index]["phone"];
                                                  var emailData =
                                                      data[index]["email"];
                                                  var designationData =
                                                      data[index]
                                                          ["designation"];
                                                  var addressData =
                                                      data[index]["address"];
                                                  var imgData =
                                                      data[index]["imgUrl"];
                                                  var descriptionData =
                                                      data[index]
                                                          ["description"];
                                                  print("tapped");
                                                  Get.to(
                                                      DetailScreen(
                                                        nameData: nameData,
                                                        phoneData: phoneData,
                                                        emailData: emailData,
                                                        designationData:
                                                            designationData,
                                                        addressData:
                                                            addressData,
                                                        imgData: imgData,
                                                        descriptionData:
                                                            descriptionData,
                                                      ),
                                                      transition: Transition
                                                          .leftToRight,
                                                      duration: Duration(
                                                          microseconds:
                                                              100000));
                                                },
                                                leading: ClipRRect(
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(data[index]
                                                            ["imgUrl"]),
                                                    radius: 30,
                                                  ),
                                                ),
                                                title: Text(
                                                    data[index]["userName"],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                subtitle: Text(
                                                    data[index]["phone"],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white
                                                            .withOpacity(.5))),
                                                trailing: GestureDetector(
                                                  onTap: () async {
                                                    if (isfav) {
                                                      await storage.deleteItem(
                                                          data[index]["phone"]);
                                                    } else {
                                                      await storage.setItem(
                                                          data[index]["phone"],
                                                          true);
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: isfav
                                                      ? Icon(
                                                          Icons.favorite,
                                                          size: sizeH * 0.025,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          size: sizeH * 0.025,
                                                          color: Colors.white,
                                                        ),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                color: Colors.black
                                                    .withOpacity(.5),
                                                endIndent: 20,
                                                indent: 20,
                                              ),
                                            ],
                                          )
                                        : SizedBox();
                                    // return Column(
                                    //   children: [
                                    //     ListTile(
                                    //       onTap: () {
                                    //         var nameData =
                                    //             data[index]["userName"];
                                    //         var phoneData =
                                    //             data[index]["phone"];
                                    //         var emailData =
                                    //             data[index]["email"];
                                    //         var designationData =
                                    //             data[index]["designation"];
                                    //         var addressData =
                                    //             data[index]["address"];
                                    //         var imgData =
                                    //             data[index]["imgUrl"];
                                    //         var descriptionData =
                                    //             data[index]["description"];
                                    //         print("tapped");
                                    //         Get.to(
                                    //             DetailScreen(
                                    //               nameData: nameData,
                                    //               phoneData: phoneData,
                                    //               emailData: emailData,
                                    //               designationData:
                                    //                   designationData,
                                    //               addressData: addressData,
                                    //               imgData: imgData,
                                    //               descriptionData:
                                    //                   descriptionData,
                                    //             ),
                                    //             transition:
                                    //                 Transition.leftToRight,
                                    //             duration: Duration(
                                    //                 microseconds: 100000));
                                    //       },
                                    //       leading: ClipRRect(
                                    //         child: CircleAvatar(
                                    //           backgroundImage: NetworkImage(
                                    //               data[index]["imgUrl"]),
                                    //           radius: 30,
                                    //         ),
                                    //       ),
                                    //       title: Text(
                                    //           data[index]["userName"],
                                    //           style: const TextStyle(
                                    //               fontSize: 16,
                                    //               color: Colors.white,
                                    //               fontWeight:
                                    //                   FontWeight.w400)),
                                    //       subtitle: Text(
                                    //           data[index]["phone"],
                                    //           style: TextStyle(
                                    //               fontSize: 14,
                                    //               color: Colors.white
                                    //                   .withOpacity(.5))),
                                    //       trailing: GestureDetector(
                                    //         onTap: () async {
                                    //           if (isfav) {
                                    //             await storage.deleteItem(
                                    //                 data[index]["phone"]);
                                    //           } else {
                                    //             await storage.setItem(
                                    //                 data[index]["phone"],
                                    //                 true);
                                    //           }
                                    //           setState(() {});
                                    //         },
                                    //         child: isfav
                                    //             ? Icon(
                                    //                 Icons.favorite,
                                    //                 size: sizeH * 0.025,
                                    //                 color: Colors.white,
                                    //               )
                                    //             : Icon(
                                    //                 Icons.favorite_border,
                                    //                 size: sizeH * 0.025,
                                    //                 color: Colors.white,
                                    //               ),
                                    //       ),
                                    //     ),
                                    //     Divider(
                                    //       thickness: 1,
                                    //       color:
                                    //           Colors.black.withOpacity(.5),
                                    //       endIndent: 20,
                                    //       indent: 20,
                                    //     ),
                                    //   ],
                                    // );
                                  });
                          // print("dta is here$data");

                          // return ListView.builder(
                          //     itemCount: data.length,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       print("tapped");
                          //       // data[index]["imgUrl"];
                          //       var isfav = storage
                          //               .getItem("${data[index]["phone"]}") ??
                          //           false;
                          //       return Column(
                          //         children: [
                          //           ListTile(
                          //             onTap: () {
                          //               var nameData = data[index]["userName"];
                          //               var phoneData = data[index]["phone"];
                          //               var emailData = data[index]["email"];
                          //               var designationData =
                          //                   data[index]["designation"];
                          //               var addressData =
                          //                   data[index]["address"];
                          //               var imgData = data[index]["imgUrl"];
                          //               var descriptionData =
                          //                   data[index]["description"];
                          //               print("tapped");
                          //               Get.to(
                          //                   DetailScreen(
                          //                     nameData: nameData,
                          //                     phoneData: phoneData,
                          //                     emailData: emailData,
                          //                     designationData: designationData,
                          //                     addressData: addressData,
                          //                     imgData: imgData,
                          //                     descriptionData: descriptionData,
                          //                   ),
                          //                   transition: Transition.leftToRight,
                          //                   duration:
                          //                       Duration(microseconds: 100000));
                          //             },
                          //             leading: ClipRRect(
                          //               child: CircleAvatar(
                          //                 backgroundImage: NetworkImage(
                          //                     data[index]["imgUrl"]),
                          //                 radius: 30,
                          //               ),
                          //             ),
                          //             title: Text(data[index]["userName"],
                          //                 style: const TextStyle(
                          //                     fontSize: 16,
                          //                     color: Colors.white,
                          //                     fontWeight: FontWeight.w400)),
                          //             subtitle: Text(data[index]["phone"],
                          //                 style: TextStyle(
                          //                     fontSize: 14,
                          //                     color: Colors.white
                          //                         .withOpacity(.5))),
                          //             trailing: GestureDetector(
                          //               onTap: () async {
                          //                 if (isfav) {
                          //                   await storage.deleteItem(
                          //                       data[index]["phone"]);
                          //                 } else {
                          //                   await storage.setItem(
                          //                       data[index]["phone"], true);
                          //                 }
                          //                 setState(() {});
                          //               },
                          //               child: isfav
                          //                   ? Icon(
                          //                       Icons.favorite,
                          //                       size: sizeH * 0.025,
                          //                       color: Colors.white,
                          //                     )
                          //                   : Icon(
                          //                       Icons.favorite_border,
                          //                       size: sizeH * 0.025,
                          //                       color: Colors.white,
                          //                     ),
                          //             ),
                          //           ),
                          //           Divider(
                          //             thickness: 1,
                          //             color: Colors.black.withOpacity(.5),
                          //             endIndent: 20,
                          //             indent: 20,
                          //           ),
                          //         ],
                          //       );
                          //     });
                        }),
                    // child: DefaultTabController(
                    //     length: 2, // length of tabs
                    //     initialIndex: 0,
                    //     child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.stretch,
                    //         children: <Widget>[
                    //           // TextField(
                    //           //   onChanged: (value) {
                    //           //     filterSearchResults(value);
                    //           //   },
                    //           //   controller: editingController,
                    //           //   decoration: InputDecoration(
                    //           //       labelText: "Search",
                    //           //       hintText: "Search",
                    //           //       prefixIcon: Icon(Icons.search),
                    //           //       border: OutlineInputBorder(
                    //           //           borderRadius: BorderRadius.all(
                    //           //               Radius.circular(25.0)))),
                    //           // ),
                    //           Container(
                    //             height: sizeH * 0.1,
                    //             child: TabBar(
                    //               indicatorColor: const Color(0xFF202329),
                    //               labelColor: Colors.white,
                    //               unselectedLabelColor:
                    //                   Colors.white.withOpacity(.2),
                    //               tabs: [
                    //                 Tab(
                    //                   child: Text(
                    //                     "Contacts",
                    //                     style: GoogleFonts.magra(
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Tab(
                    //                   child: Text(
                    //                     "Favorites",
                    //                     style: GoogleFonts.magra(
                    //                       fontSize: 16,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //           Container(
                    //               height: sizeH * 0.7, //height of TabBarView
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(30),
                    //                 color: const Color(0xFF2A3035),
                    //               ),
                    //               child: TabBarView(children: <Widget>[
                    //                 // Container(
                    //                 //   child: StreamBuilder<QuerySnapshot>(
                    //                 //       stream: pendingDataSnapshot,
                    //                 //       builder: (BuildContext context,
                    //                 //           AsyncSnapshot<QuerySnapshot>
                    //                 //               snapshot) {
                    //                 //         if (snapshot.hasError) {
                    //                 //           return const Text(
                    //                 //               'Something went wrong');
                    //                 //         }
                    //                 //
                    //                 //         if (snapshot.connectionState ==
                    //                 //             ConnectionState.waiting) {
                    //                 //           return const Center(
                    //                 //               child:
                    //                 //                   CircularProgressIndicator(
                    //                 //             color: Colors.white70,
                    //                 //           ));
                    //                 //         }
                    //                 //
                    //                 //         data = snapshot.data!.docs;
                    //                 //         // print("dta is here$data");
                    //                 //         return ListView.builder(
                    //                 //             itemCount: data.length,
                    //                 //             itemBuilder:
                    //                 //                 (BuildContext context,
                    //                 //                     int index) {
                    //                 //               print("tapped");
                    //                 //               // data[index]["imgUrl"];
                    //                 //               return Column(
                    //                 //                 children: [
                    //                 //                   ListTile(
                    //                 //                     onTap: () {
                    //                 //                       var nameData =
                    //                 //                           data[index]
                    //                 //                               ["userName"];
                    //                 //                       var phoneData =
                    //                 //                           data[index]
                    //                 //                               ["phone"];
                    //                 //                       var emailData =
                    //                 //                           data[index]
                    //                 //                               ["email"];
                    //                 //                       var designationData =
                    //                 //                           data[index][
                    //                 //                               "designation"];
                    //                 //                       var addressData =
                    //                 //                           data[index]
                    //                 //                               ["address"];
                    //                 //                       var imgData =
                    //                 //                           data[index]
                    //                 //                               ["imgUrl"];
                    //                 //                       var descriptionData =
                    //                 //                           data[index][
                    //                 //                               "description"];
                    //                 //                       print("tapped");
                    //                 //                       Get.to(
                    //                 //                           DetailScreen(
                    //                 //                             nameData:
                    //                 //                                 nameData,
                    //                 //                             phoneData:
                    //                 //                                 phoneData,
                    //                 //                             emailData:
                    //                 //                                 emailData,
                    //                 //                             designationData:
                    //                 //                                 designationData,
                    //                 //                             addressData:
                    //                 //                                 addressData,
                    //                 //                             imgData:
                    //                 //                                 imgData,
                    //                 //                             descriptionData:
                    //                 //                                 descriptionData,
                    //                 //                           ),
                    //                 //                           transition:
                    //                 //                               Transition
                    //                 //                                   .leftToRight,
                    //                 //                           duration: Duration(
                    //                 //                               microseconds:
                    //                 //                                   100000));
                    //                 //                     },
                    //                 //                     leading: ClipRRect(
                    //                 //                       child: CircleAvatar(
                    //                 //                         backgroundImage:
                    //                 //                             NetworkImage(data[
                    //                 //                                     index]
                    //                 //                                 ["imgUrl"]),
                    //                 //                         radius: 30,
                    //                 //                       ),
                    //                 //                     ),
                    //                 //                     title: Text(
                    //                 //                         data[index]
                    //                 //                             ["userName"],
                    //                 //                         style: const TextStyle(
                    //                 //                             fontSize: 16,
                    //                 //                             color: Colors
                    //                 //                                 .white,
                    //                 //                             fontWeight:
                    //                 //                                 FontWeight
                    //                 //                                     .w400)),
                    //                 //                     subtitle: Text(
                    //                 //                         data[index]
                    //                 //                             ["phone"],
                    //                 //                         style: TextStyle(
                    //                 //                             fontSize: 14,
                    //                 //                             color: Colors
                    //                 //                                 .white
                    //                 //                                 .withOpacity(
                    //                 //                                     .5))),
                    //                 //                     trailing:
                    //                 //                         GestureDetector(
                    //                 //                       onTap: () async {},
                    //                 //                       child: isfav
                    //                 //                           ? Icon(
                    //                 //                               Icons
                    //                 //                                   .favorite,
                    //                 //                               size: sizeH *
                    //                 //                                   0.025,
                    //                 //                               color: Colors
                    //                 //                                   .white,
                    //                 //                             )
                    //                 //                           : Icon(
                    //                 //                               Icons
                    //                 //                                   .favorite_border,
                    //                 //                               size: sizeH *
                    //                 //                                   0.025,
                    //                 //                               color: Colors
                    //                 //                                   .white,
                    //                 //                             ),
                    //                 //                     ),
                    //                 //                   ),
                    //                 //                   Divider(
                    //                 //                     thickness: 1,
                    //                 //                     color: Colors.black
                    //                 //                         .withOpacity(.5),
                    //                 //                     endIndent: 20,
                    //                 //                     indent: 20,
                    //                 //                   ),
                    //                 //                 ],
                    //                 //               );
                    //                 //             });
                    //                 //       }),
                    //                 // ),
                    //                 Container(
                    //                   child: StreamBuilder<QuerySnapshot>(
                    //                       stream: pendingDataSnapshot,
                    //                       builder: (BuildContext context,
                    //                           AsyncSnapshot<QuerySnapshot>
                    //                               snapshot) {
                    //                         if (snapshot.hasError) {
                    //                           return const Text(
                    //                               'Something went wrong');
                    //                         }
                    //
                    //                         if (snapshot.connectionState ==
                    //                             ConnectionState.waiting) {
                    //                           return const Center(
                    //                               child:
                    //                                   CircularProgressIndicator(
                    //                             color: Colors.white70,
                    //                           ));
                    //                         }
                    //
                    //                         data = snapshot.data!.docs;
                    //                         data1 = snapshot.data!.docs;
                    //                         // print("dta is here$data");
                    //
                    //                         return ListView.builder(
                    //                             itemCount: data.length,
                    //                             itemBuilder:
                    //                                 (BuildContext context,
                    //                                     int index) {
                    //                               print("tapped");
                    //                               // data[index]["imgUrl"];
                    //                               var isfav = storage.getItem(
                    //                                       "${data[index]["phone"]}") ??
                    //                                   false;
                    //                               return Column(
                    //                                 children: [
                    //                                   ListTile(
                    //                                     onTap: () {
                    //                                       var nameData =
                    //                                           data[index]
                    //                                               ["userName"];
                    //                                       var phoneData =
                    //                                           data[index]
                    //                                               ["phone"];
                    //                                       var emailData =
                    //                                           data[index]
                    //                                               ["email"];
                    //                                       var designationData =
                    //                                           data[index][
                    //                                               "designation"];
                    //                                       var addressData =
                    //                                           data[index]
                    //                                               ["address"];
                    //                                       var imgData =
                    //                                           data[index]
                    //                                               ["imgUrl"];
                    //                                       var descriptionData =
                    //                                           data[index][
                    //                                               "description"];
                    //                                       print("tapped");
                    //                                       Get.to(
                    //                                           DetailScreen(
                    //                                             nameData:
                    //                                                 nameData,
                    //                                             phoneData:
                    //                                                 phoneData,
                    //                                             emailData:
                    //                                                 emailData,
                    //                                             designationData:
                    //                                                 designationData,
                    //                                             addressData:
                    //                                                 addressData,
                    //                                             imgData:
                    //                                                 imgData,
                    //                                             descriptionData:
                    //                                                 descriptionData,
                    //                                           ),
                    //                                           transition:
                    //                                               Transition
                    //                                                   .leftToRight,
                    //                                           duration: Duration(
                    //                                               microseconds:
                    //                                                   100000));
                    //                                     },
                    //                                     leading: ClipRRect(
                    //                                       child: CircleAvatar(
                    //                                         backgroundImage:
                    //                                             NetworkImage(data[
                    //                                                     index]
                    //                                                 ["imgUrl"]),
                    //                                         radius: 30,
                    //                                       ),
                    //                                     ),
                    //                                     title: Text(
                    //                                         data[index]
                    //                                             ["userName"],
                    //                                         style: const TextStyle(
                    //                                             fontSize: 16,
                    //                                             color: Colors
                    //                                                 .white,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .w400)),
                    //                                     subtitle: Text(
                    //                                         data[index]
                    //                                             ["phone"],
                    //                                         style: TextStyle(
                    //                                             fontSize: 14,
                    //                                             color: Colors
                    //                                                 .white
                    //                                                 .withOpacity(
                    //                                                     .5))),
                    //                                     trailing:
                    //                                         GestureDetector(
                    //                                       onTap: () async {
                    //                                         if (isfav) {
                    //                                           await storage
                    //                                               .deleteItem(data[
                    //                                                       index]
                    //                                                   [
                    //                                                   "phone"]);
                    //                                         } else {
                    //                                           await storage.setItem(
                    //                                               data[index]
                    //                                                   ["phone"],
                    //                                               true);
                    //                                         }
                    //                                         setState(() {});
                    //                                       },
                    //                                       child: isfav
                    //                                           ? Icon(
                    //                                               Icons
                    //                                                   .favorite,
                    //                                               size: sizeH *
                    //                                                   0.025,
                    //                                               color: Colors
                    //                                                   .white,
                    //                                             )
                    //                                           : Icon(
                    //                                               Icons
                    //                                                   .favorite_border,
                    //                                               size: sizeH *
                    //                                                   0.025,
                    //                                               color: Colors
                    //                                                   .white,
                    //                                             ),
                    //                                     ),
                    //                                   ),
                    //                                   Divider(
                    //                                     thickness: 1,
                    //                                     color: Colors.black
                    //                                         .withOpacity(.5),
                    //                                     endIndent: 20,
                    //                                     indent: 20,
                    //                                   ),
                    //                                 ],
                    //                               );
                    //                             });
                    //                       }),
                    //                 ),
                    //                 Container(
                    //                   child: ListView.builder(
                    //                     itemCount: favList.length,
                    //                     itemBuilder: (context, index) {
                    //                       var isfav = storage.getItem(
                    //                               "${data[index]["phone"]}") ??
                    //                           false;
                    //                       // box.read('key');
                    //                       // var isfav = box.read('key') ?? false;
                    //                       return isfav
                    //                           ? listTile(
                    //                               "${data[index]["imgUrl"]}",
                    //                               "${data[index]["userName"]}",
                    //                               "${data[index]["phone"]}",
                    //                             )
                    //                           : Container();
                    //                     },
                    //                   ),
                    //                 ),
                    //               ]))
                    //         ])),
                  ),
                ],
              )),
        ));
  }

  Widget _listTile(
      String imagePath, String nameUser, String phoneUser, bool isFvrt) {
    return ListTile(
      leading: ClipRRect(
        child: CircleAvatar(
          backgroundImage: NetworkImage(imagePath),
          radius: 30,
        ),
      ),
      title: Text(nameUser,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
      subtitle: Text(phoneUser,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
      trailing: IconButton(
        iconSize: 30.0,
        onPressed: () async {},
        icon: isFvrt
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite,
                color: Colors.black26,
              ),
      ),
    );
  }

  Widget listTile(String imagePath, String nameUser, String phoneUser) {
    return ListTile(
      leading: ClipRRect(
        child: CircleAvatar(
          backgroundImage: NetworkImage(imagePath),
          radius: 30,
        ),
      ),
      title: Text(nameUser,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
      subtitle: Text(phoneUser,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5))),
    );
  }
}
