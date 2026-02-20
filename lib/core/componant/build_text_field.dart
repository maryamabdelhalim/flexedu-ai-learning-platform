import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';

class BuildTextFiled extends StatelessWidget {
  TextEditingController? controller;
  String? hint;
  String? label;
  IconData? icon;
  int? maxLines;
  final String? Function(String?)? validator;
  final String? Function(String?)? changed;
  IconData? suffixIcon;
  bool obscure;
  bool? enable;
  Widget? prefix;
  bool? autoFocus;
  TextInputType? type;
  final FormFieldSetter<String>? onSaved;
  Function()? press;
  Function()? ontap;
  List<TextInputFormatter>? inputFormatters;
  List<String>? autoFill;

  BuildTextFiled({
    super.key,
    this.changed,
    this.prefix,
    this.autoFill,
    this.maxLines = 1,
    this.autoFocus = false,
    this.enable = true,
    this.onSaved,
    this.controller,
    this.hint,
    this.icon,
    this.label,
    this.obscure = false,
    this.ontap,
    this.press,
    this.suffixIcon,
    this.type,
    this.validator,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // style: const TextStyle(color: Colors.grey, fontSize: 12),
      autofillHints: autoFill,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      obscureText: obscure,
      obscuringCharacter: '*',
      enabled: enable,
      onChanged: changed,
      keyboardType: type,
      cursorColor: Colors.black,
      autofocus: autoFocus!,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        prefix: prefix,
        suffixIcon: Icon(suffixIcon),
        contentPadding: EdgeInsets.only(left: 14.w, right: 10.w),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade400)),

        labelStyle: TextStyle(color: AppColors.mainColor),
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),

        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
