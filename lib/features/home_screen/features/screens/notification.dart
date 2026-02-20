import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/core/componant/componant.dart';
import 'package:flexedu/features/login_screen/features/componant/login_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flexedu/core/colors/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        body: Center(child: Text("Please log in first.")),
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 12.w, right: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginHeader(txt: 'Notifications'),
            SizedBox(height: 30.h),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("notifications")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final notifications = snapshot.data!.docs;

                  if (notifications.isEmpty) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/images/image-removebg-preview (2) 1.png',
                          height: 200.h,
                        ),
                        defaultText(
                          txt: 'Currently No notifications 💤',
                          fontSize: 20.sp,
                          color: AppColors.textColor,
                        )
                      ],
                    );
                  }

                  return ListView.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final data = notifications[index].data() as Map<String, dynamic>;
                      final timestamp = data["timestamp"] != null
                          ? (data["timestamp"] as Timestamp).toDate()
                          : null;

                      return Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.mainColor),
                        ),
                        child: ListTile(
                          title: Text(
                            data["title"] ?? "Notification",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data["message"] ?? ""),
                              if (timestamp != null)
                                Text(
                                  DateFormat.yMMMd().add_jm().format(timestamp),
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                ),
                            ],
                          ),
                          leading: Icon(Icons.notifications, color: AppColors.mainColor),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
