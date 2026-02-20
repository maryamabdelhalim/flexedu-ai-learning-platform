import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexedu/core/colors/colors.dart';
import 'package:flexedu/core/componant/custome_progress_bar.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid;
  }

  Future<List<Map<String, dynamic>>> fetchProgressFromFlatDoc() async {
    if (userId == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection("progress")
        .doc(userId)
        .get();

    if (!snapshot.exists) return [];

    final data = snapshot.data()!;
    return data.entries.map((entry) {
      final title = entry.key;
      final score = entry.value;
      final total = 10; // assume fixed total
      final percent = ((score / total) * 100).clamp(0, 100).toStringAsFixed(1);
      return {
        "title": title,
        "score": score,
        "total": total,
        "percentage": percent,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: Text("Your Learning Progress", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProgressFromFlatDoc(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          final results = snapshot.data ?? [];
          if (results.isEmpty) {
            return Center(
              child: Text(
                "You haven't completed any lessons yet.",
                style: TextStyle(color: AppColors.textColor, fontSize: 16),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📈 Overview",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blacColor,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Track your completed lessons and scores below.",
                  style: TextStyle(color: AppColors.textColor, fontSize: 14),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    itemCount: results.length,
                    separatorBuilder: (_, __) => SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final r = results[index];
                      final percent = double.tryParse(r["percentage"]) ?? 0;
                      return Container(
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.mainColor, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r["title"],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blacColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Score: ${r["score"]} / ${r["total"]}  (${r["percentage"]}%)",
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textColor,
                              ),
                            ),
                            SizedBox(height: 12),
                            customProgressBar(context, percent / 100),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
