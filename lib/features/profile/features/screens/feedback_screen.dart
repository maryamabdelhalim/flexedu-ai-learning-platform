import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double _rating = 3;
  TextEditingController _descriptionController = TextEditingController();

  void _submitFeedback() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('feedbacks').add({
      'userId': userId,
      'rating': _rating,
      'description': _descriptionController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Feedback submitted!")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Rate your experience", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) => setState(() => _rating = rating),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Additional comments",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
