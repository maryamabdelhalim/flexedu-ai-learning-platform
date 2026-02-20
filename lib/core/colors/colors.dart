import 'package:flutter/material.dart';

class AppColors {
  static Color containerColor = Colors.grey.shade400;
  static Color containerGreenColor = Color(0xffDFFFEA);
  static Color containerRedColor = Color(0xffFFEEF3);
  static Color blacColor = Color(0xff0B1215);
  static Color greenText = Color(0xff17C653);
  static Color mainColor = Color(0xff384CFC);
  static Color redColor = Color(0xffF8285A);
  static Color secandColors = Color(0xff23414D);
  static Color greyColor = Color(0xffEFEEEE);
  static Color textColor = Color(0xFF777777);

  // black
  static Color blueColor = Color(0xFF4089c4);
  static Color greyBLACKColor = Color(0xFF9d9faf);
  static Color BLACKColor = Color(0xFF0f1014);
  static Color BLACKContainerColor = Color(0xFF15171c);
  static Color BLACKWhiteColor = Color(0xFFdee0e5);
  static Color BLACKGreenColor = Color(0xFF309058);
  static Color BLACKRedColor = Color(0xFFd52751);
  static Color BLACKContainerRedColor = Color(0xFF302024);
  static Color BLACKContainerGreenColor = Color(0xFF1f212a);
}

const Color defcolor = Color.fromARGB(255, 29, 117, 149);
Color seccolor = const Color.fromARGB(255, 170, 125, 248);

Widget crdientColor() {
  return Container(
      decoration: BoxDecoration(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffF12323), Color(0xffFFEB37)])),
      ));
}
