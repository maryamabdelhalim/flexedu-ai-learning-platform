import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/core/componant/success_message.dart';
import 'package:flexedu/core/database/api/dio_consumer.dart';
import 'package:flexedu/core/database/api/end_point.dart';
import 'package:flexedu/features/profile/data/model/contact_us.dart';
import 'package:flexedu/features/tests/features/cubit/test_state.dart';
import 'package:flexedu/features/profile/features/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileStateInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var messageController = TextEditingController();

  ContactUsModel? contactUsModel;
  contactUs() {
    emit(ContactUsLoading());
    DioHelper.postData(path: ApiUrls.CONTACT_US, data: {
      'email': emailController.text,
      'name': nameController.text,
      'phone': phoneController.text,
      'message': messageController.text,
    }).then((value) {
      contactUsModel = ContactUsModel.fromJson(value.data);
      if (contactUsModel!.success == false) {
        emit(ContactUsError());
      } else {
        succesMasseges(contactUsModel!.message);
        emailController.clear();
        nameController.clear();
        phoneController.clear();
        messageController.clear();
        emit(ContactUsSuccess());
      }
    }).catchError((error) {
      emit(ContactUsError());
    });
  }
}
