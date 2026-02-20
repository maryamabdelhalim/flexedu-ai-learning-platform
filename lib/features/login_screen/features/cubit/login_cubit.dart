import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_cubit.dart';
import 'package:flexedu/features/login_screen/data/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/error_message.dart';
import 'package:flexedu/core/componant/success_message.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/core/database/cache/cache_helper.dart';
import 'package:flexedu/features/login_screen/data/model/otp_model.dart';
import 'package:flexedu/features/login_screen/features/cubit/login_state.dart';
import 'package:flexedu/features/login_screen/features/screens/login_screen.dart';
import 'package:flexedu/features/login_screen/features/screens/reset_password.dart';
import 'package:flexedu/features/login_screen/features/screens/send_otp.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var otpCodeController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool isAgree = false;
  changeAgree(val) {
    isAgree = val;
    emit(ChangeAgree());
  }

  bool isCheck = false;
  changeCheck(val) {
    isCheck = val;
    emit(ChangeAgree());
  }

  UserModel? userModel;

  setUserData() {
    var model = UserModel(
      email: emailController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      id: FirebaseAuth.instance.currentUser!.uid,
      image: '',
    );
    emit(RegisterLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(model.toJson())
        .then((value) async {
      await CacheHelper.setShared(
          key: AppConst.kLogin,
          value: FirebaseAuth.instance.currentUser!.uid.toString());
      uid = CacheHelper.getShared(key: AppConst.kLogin);
      emit(RegisterSuccess());
    }).catchError((error) {
      emit(RegisterError());
    });
  }

  register() {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      setUserData();
      print(value);
      nextPage(context, LoginScreen());
      succesMasseges("Register Successfully".tr());

      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      emit(RegisterSuccess());
    }).catchError((error) {
      print(error.toString());
      errorMasseges(error.toString());
      emit(RegisterError());
    });
  }

  Login() async {
    emit(LoginLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // ✅ Cache UID
      await CacheHelper.setShared(
          key: AppConst.kLogin,
          value: FirebaseAuth.instance.currentUser!.uid.toString());
      uid = CacheHelper.getShared(key: AppConst.kLogin);

      // ✅ Load user model before going to dashboard
      await HomeCubit.get(context).getUserData();

      // ✅ Navigate directly to dashboard
      nextPageUntil(context, DashboardScreen());

      // ✅ Clear fields
      emailController.clear();
      passwordController.clear();

      emit(LoginSuccess());
    } catch (error) {
      print(error.toString());
      errorMasseges(error.toString());
      emit(LoginError());
    }
  }

  forgetPassword() {
    emit(ForgetPasswordLoading());
    DioHelper.postData(path: ApiUrls.FORGOTPASSWORD, data: {
      "email": emailController.text,
    }).then((value) {
      print(value.data);
      succesMasseges("Please check your email".tr());
      nextPage(context, SendOtp());
      emit(ForgetPasswordSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(ForgetPasswordError());
    });
  }

  String? otpCode;
  verifyOTP(code) {
    otpCode = code;
    emit(ChangeOtpCode());
  }

  verifyCode() {
    emit(VerifyLoading());
    DioHelper.postData(path: ApiUrls.VERIFYCODE, data: {
      "email": emailController.text,
      "resetCode": otpCode,
      "newPassword": newPasswordController.text
    }).then((value) {
      print(value.data);
      succesMasseges("Password changed successfully".tr());
      nextPage(context, LoginScreen());
      emailController.clear();
      otpCode = null;
      newPasswordController.clear();
      passwordController.clear();
      emit(VerifySuccess());
    }).catchError((error) {
      print(error.toString());
      emit(VerifyError());
    });
  }

  OtpModel? otpModel;
  incorrectOtp() {
    emit(IncorrectOtpLoading());
    DioHelper.postData(
        path: ApiUrls.ISCORRECTOTP,
        data: {"email": emailController.text, "otp": otpCode}).then((value) {
      print(value.data);

      otpModel = OtpModel.fromJson(value.data);
      if (otpModel!.success == true) {
        nextPage(context, ResetPassword());
      } else {
        errorMasseges("Invalid OTP".tr());
      }
      emit(IncorrectOtpSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(IncorrectOtpError());
    });
  }
}
