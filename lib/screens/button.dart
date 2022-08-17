import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ticket/constant/color.dart';

class CustomBotton extends StatelessWidget {
  String title = "";
  var colorButton;
  var colorButtonText;
  final VoidCallback onPress;
  CustomBotton(
      {Key? key,
      required this.onPress,
      required this.colorButton,
      required this.colorButtonText,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.0600,
      width: Get.width * 0.750,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorButton,
            onPrimary: Colors.white,
            shadowColor: Colors.red,
            elevation: 1,
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: onPress,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: colorButtonText,
            ),
          )),
    );
  }
}
