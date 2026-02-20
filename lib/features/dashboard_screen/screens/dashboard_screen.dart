import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/features/dashboard_screen/cubit/dashboard_cubit.dart';
import 'package:flexedu/features/dashboard_screen/cubit/dashboard_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {},
        builder: (context, state) {
          DashboardCubit cubit = DashboardCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  selectedItemColor: Colors.white,
                  selectedIconTheme: IconThemeData(color: Colors.white),
                  backgroundColor: AppColors.mainColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
                  unselectedLabelStyle: TextStyle(fontSize: 0),
                  selectedLabelStyle: TextStyle(fontSize: 0),
                  onTap: (index) {
                    cubit.changeIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/home (1) 1.png',
                          height: 40.h,
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/success 1.png',
                          height: 30.h,
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/AI_Robot_03_3d 1.png',
                          height: 40.h,
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/graphic-progression 1.png',
                          height: 30.h,
                        ),
                        label: ''),
                    BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/profile-user 1.png',
                          height: 30.h,
                        ),
                        label: ''),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
