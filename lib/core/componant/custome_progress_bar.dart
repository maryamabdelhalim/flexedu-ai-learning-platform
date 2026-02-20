import 'package:flutter/material.dart';

Widget customProgressBar(BuildContext context, double percentage) {
  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      Container(
        height: 20,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Container(
        height: 20,
        width: MediaQuery.of(context).size.width * percentage,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Positioned(
        left: MediaQuery.of(context).size.width * percentage - 25,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.yellow[700],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            '${(percentage * 100).round()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
        ),
      )
    ],
  );
}
