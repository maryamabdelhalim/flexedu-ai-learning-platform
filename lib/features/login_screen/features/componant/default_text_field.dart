import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/componant.dart';

class DefaultTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String? label;
  String? txt;
  bool obscure;
  IconData? icon;
  TextInputType? type;
  bool enable;
  bool autoFocus;
  Function()? press;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  DefaultTextField({
    super.key,
    required this.controller,
    this.label,
    this.onChanged,
    this.enable = true,
    this.autoFocus = false,
    this.validator,
    this.press,
    this.txt,
    this.obscure = false,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultText(
          txt: txt,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(height: 5.h),
        Container(
          height: 50.h,
          width: double.infinity,
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              color: Color(0xffFEFEEEE),
              border: Border.all(color: AppColors.mainColor),
              borderRadius: BorderRadius.circular(12)),
          child: TextFormField(
            onChanged: onChanged,
            enabled: enable,
            autofocus: autoFocus,
            obscuringCharacter: '*',
            controller: controller,
            obscureText: obscure,
            keyboardType: type,
            validator: validator,
            decoration: InputDecoration(
              suffix: InkWell(onTap: press, child: Icon(icon)),
              border: InputBorder.none,
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(14),
              //   borderSide: BorderSide(color: Colors.grey.shade400),
              // ),
              // focusedErrorBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(14),
              //   borderSide: BorderSide(color: Colors.grey.shade400),
              // ),
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(14),
              //   borderSide: BorderSide(color: Colors.grey.shade400),
              // ),

              label: defaultText(
                  txt: label, fontSize: 14.sp, color: AppColors.textColor),
            ),
          ),
        ),
      ],
    );
  }
}
