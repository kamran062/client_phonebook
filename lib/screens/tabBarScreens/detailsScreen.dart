import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  var nameData;
  var phoneData;
  var emailData;
  var designationData;
  var addressData;
  var imgData;
  var descriptionData;
  DetailScreen(
      {Key? key,
      this.imgData,
      this.nameData,
      this.phoneData,
      this.emailData,
      this.designationData,
      this.addressData,
      this.descriptionData})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
            "Contact Info",
            style: GoogleFonts.magra(fontSize: 16, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: const Color(0xFF323A40),
        body: SingleChildScrollView(
          child: Container(
            height: sizeH,
            width: sizeW,
            color: Color(0xFF323A40),
            child: Column(
              children: [
                ClipRRect(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.imgData),
                    radius: 30,
                  ),
                ),
                SizedBox(
                  height: sizeH * 0.02,
                ),
                Text(widget.nameData,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: sizeH * 0.02,
                ),
                Container(
                    height: sizeH * 0.8,
                    width: sizeW,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF202329),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeW * 0.05,
                              right: sizeW * 0.05,
                              top: sizeW * 0.05,
                              bottom: sizeW * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF2DC15F),
                                ),
                                height: sizeH * 0.07,
                                width: sizeW * 0.18,
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        launch('sms:${widget.phoneData}');
                                      },
                                      icon: const Icon(
                                        Icons.message_outlined,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF017BFF),
                                ),
                                height: sizeH * 0.07,
                                width: sizeW * 0.18,
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        launch('tel:${widget.phoneData}');
                                      },
                                      icon: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFFF41F43),
                                ),
                                height: sizeH * 0.07,
                                width: sizeW * 0.18,
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        launch('mailto:${widget.emailData}');
                                      },
                                      icon: const Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            height: sizeH * 0.67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFF2A3035),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ///name
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Name:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.nameData,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),

                                  ///phone
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Phone:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.phoneData,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),

                                  ///mail
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Email:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.emailData,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.mail_outline,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),

                                  ///Designation
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Designation:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.designationData,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.menu_book,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),

                                  ///address
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Address:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.addressData,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.location_on_sharp,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),

                                  ///description
                                  ListTile(
                                    // onTap: () {
                                    //   print("tapped");
                                    //   Get.to(DetailScreen(),
                                    //       transition: Transition.leftToRight,
                                    //       duration:
                                    //           Duration(microseconds: 100000));
                                    // },
                                    title: Text('Description:',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white.withOpacity(.5),
                                            fontWeight: FontWeight.w400)),
                                    subtitle: Text(widget.descriptionData,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.description_outlined,
                                          color: Colors.white,
                                        )),
                                  ),
                                  Divider(
                                    endIndent: sizeW * 0.09,
                                    indent: sizeW * 0.07,
                                    thickness: 1.2,
                                  ),
                                  SizedBox(
                                    height: sizeH * 0.1,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
