import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/core/componant/success_message.dart';
import 'package:flexedu/core/const/const.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page1.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page2.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page3.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page4.dart';
import 'package:flexedu/features/collect_data/presentaion/screen/page5.dart';
import 'package:flexedu/features/dashboard_screen/screens/dashboard_screen.dart';
import 'package:flexedu/features/home_screen/data/model/course_model.dart';
import 'package:flexedu/features/home_screen/features/screens/my_learning.dart';
import 'package:flexedu/features/login_screen/data/model/login_model.dart';
import 'package:flexedu/features/splash_screen/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexedu/features/home_screen/features/cubit/home_state.dart';
import 'package:uuid/uuid.dart';

class HomeWidgets {
  String? name;
  String? image;
  HomeWidgets({this.name, this.image});
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<HomeWidgets> pageIcons = [
    HomeWidgets(
      name: 'Home',
      image: 'assets/images/material-symbols-light_home-outline-rounded.png',
    ),
    HomeWidgets(
      name: 'Labs',
      image: 'assets/images/Frame.png',
    ),
    HomeWidgets(
      name: 'Factories',
      image: 'assets/images/Frame (1).png',
    ),
    HomeWidgets(
      name: 'Reports',
      image: 'assets/images/Frame (2).png',
    ),
    HomeWidgets(
      name: 'profile',
      image: 'assets/images/iconamoon_profile-circle-thin.png',
    ),
  ];

  int indexScreen = 0;

  changeIndex(index) {
    indexScreen = index;
    emit(ChangeIndexState());
  }

  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();

  UserModel? userModel;

  // ✅ New variable
  String? learningStyle;

  // ✅ Updated to fetch learningStyle from Firestore
  getUserData() {
    emit(GetUserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      learningStyle = value.data()?['learningStyle']; // <-- Added line
      log(userModel.toString());
      emit(GetUserDataSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(GetUserDataError());
    });
  }

  collectData() {
    var model = UserModel(
      email: userModel!.email,
      id: uid,
      firstName: userModel!.firstName,
      lastName: userModel!.lastName,
      image: userModel?.image ?? '',
      englishLevel: englishLevel,
      age: ageController.text,
      englishStudy: englishStudy,
      hobbies: selectedHobbies,
      language: language,
    );
    emit(CollectDataLoading());
    getUserData();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toJson())
        .then((val) {
      nextPageUntil(context, DashboardScreen());
      emit(CollectDataSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(CollectDataError());
    });
  }

  editcollectData() {
    var model = UserModel(
      email: userModel?.email ?? '',
      id: uid,
      firstName: userModel?.firstName ?? '',
      lastName: userModel?.lastName ?? '',
      image: userModel?.image ?? '',
      englishLevel: englishLevel,
      age: ageController.text,
      englishStudy: englishStudy,
      hobbies: selectedHobbies,
      language: language,
    );
    emit(CollectDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toJson())
        .then((val) {
      getUserData();
      nextPageUntil(context, DashboardScreen());
      emit(CollectDataSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(CollectDataError());
    });
  }

  editProfile() {
    var model = UserModel(
      email: emailController.text.isEmpty
          ? userModel!.email
          : emailController.text,
      id: uid,
      firstName: nameController.text.isEmpty
          ? userModel!.firstName
          : nameController.text,
      lastName: lastNameController.text.isEmpty
          ? userModel!.lastName
          : lastNameController.text,
      image: userModel?.image ?? '',
      englishLevel: userModel?.englishLevel ?? '',
      age: userModel?.age ?? '',
      englishStudy: userModel?.englishStudy ?? '',
      hobbies: userModel?.hobbies ?? [],
      language: userModel?.language ?? '',
    );
    emit(EditProfileLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toJson())
        .then((val) {
      succesMasseges('Profile updated successfully');
      emit(EditProfileSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(EditProfileError());
    });
  }

  chooseCourseData({
    String? title,
    String? description,
    String? price,
    String? level,
    String? progress,
    String? trueAnswers,
    bool? isSubcripe,
  }) {
    titleCourse = title;
    descriptionCourse = description;
    priceCourse = price;
    levelCourse = level;
    progressCourse = progress;
    trueAnswersCourse = trueAnswers;
    isSubcripeCourse = isSubcripe;
    emit(ChooseCourseData());
  }

  CourseModel? courseModel;

  chooseCourse() {
    var uuid = Uuid().v4();
    var model = CourseModel(
      description: descriptionCourse,
      id: uuid,
      isSubcripe: isSubcripeCourse,
      level: levelCourse,
      price: priceCourse,
      progress: progressCourse,
      title: titleCourse,
      trueAnswers: trueAnswersCourse,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('courses')
        .doc(uuid)
        .set(model.toJson())
        .then((value) {
      getCourses();
      emit(ChooseCourseSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(ChooseCourseError());
    });
  }

  List<CourseModel> courses = [];

  getCourses() {
    emit(GetCoursesLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('courses')
        .snapshots()
        .listen((event) {
      courses.clear();
      for (var element in event.docs) {
        final data = element.data();
        final newCourse = CourseModel.fromJson(data);

        final isDuplicate = courses.any((course) => course.title == newCourse.title);

        if (!isDuplicate) {
          courses.add(newCourse);
        }
      }

      emit(GetCoursesSuccess());
    });
  }

  editCourse() {
    var model = CourseModel(
      description: courseModel?.description ?? descriptionCourse,
      id: courseModel?.id,
      isSubcripe: isSubcripeCourse ?? courseModel?.isSubcripe,
      level: courseModel?.level ?? levelCourse,
      price: courseModel?.price ?? priceCourse,
      progress: courseModel?.progress ?? progressCourse,
      title: courseModel?.title ?? titleCourse,
      trueAnswers: courseModel?.trueAnswers ?? trueAnswersCourse,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('courses')
        .doc(courseModel?.id)
        .set(model.toJson())
        .then((value) {
      getCourses();
      emit(ChooseCourseSuccess());
    }).catchError((er) {
      print(er.toString());
      emit(ChooseCourseError());
    });
  }
}
