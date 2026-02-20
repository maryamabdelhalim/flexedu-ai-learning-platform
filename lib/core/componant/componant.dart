import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/fonts/fonts.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';

nextPage(
  context,
  Widget? page,
) {
  Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.fade,
          child: page!,
          inheritTheme: true,
          ctx: context));
}

pop(context) {
  Navigator.pop(
    context,
  );
}

nextPageUntil(
  context,
  Widget? page,
) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => page!), (route) => false);
}

Widget defaultText(
        {String? txt,
        Color? color,
        FontWeight? fontWeight,
        double? fontSize,
        int? maxLines}) =>
    Text(
      txt!,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color ?? Theme.of(context).primaryColor,
        fontFamily: FontFamilies.BALOOCHETTAN,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );

// buildTextField({
//   context,
//   TextEditingController? controller,
//   String? hint,
//   String? label,
//   Color color = Colors.white,
//   IconData? icon,
//   Function()? validate,
//   Function? changed,
//   IconData? suffixIcon,
//   bool obscure = false,
//   double width = double.infinity,
//   TextInputType? type,
//   Function()? press,
//   Function()? ontap,
// }) {
//   var h = MediaQuery.of(context).size.height;
//   var w = MediaQuery.of(context).size.width;
//   return Container(
//     height: h * .060,
//     width: w,
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: color,
//         border: Border.all(color: Colors.black, width: .4)),
//     child: TextFormField(
//       validator: (value) => validate!(),
//       onChanged: (value) => changed!(value),
//       cursorColor: Colors.black,
//       controller: controller,
//       decoration: InputDecoration(
//         hintStyle: TextStyle(color: Colors.black),
//         contentPadding: EdgeInsets.only(left: 10),
//         hintText: hint,
//         border: InputBorder.none,
//       ),
//     ),
//   );
// }

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15.h),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

// final otpInputDecoration = InputDecoration(
//   contentPadding:
//       EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: AppColors.textColor),
  );
}

final headingStyle = TextStyle(
  fontSize: 28.sp,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
