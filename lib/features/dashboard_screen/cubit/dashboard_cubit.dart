import 'package:flexedu/features/dashboard_screen/cubit/dashboard_state.dart';
import 'package:flexedu/features/home_screen/features/screens/chatbot.dart';
import 'package:flexedu/features/home_screen/features/screens/home_screen.dart';
import 'package:flexedu/features/home_screen/features/screens/lessons_screen.dart';
import 'package:flexedu/features/profile/features/screens/profile.dart';
import 'package:flexedu/features/home_screen/features/screens/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  static DashboardCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    Lessons(),
    Chatbot(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'assets/images/home (1) 1.png',
    "assets/images/success 1.png",
    "assets/images/AI_Robot_03_3d 1.png",
    'assets/images/graphic-progression 1.png',
    "assets/images/profile-user 1.png"
  ];

  changeIndex(index) {
    currentIndex = index;
    emit(ChangeIndexState());
  }
}
