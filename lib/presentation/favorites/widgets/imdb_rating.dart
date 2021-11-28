import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IMDBRating extends StatelessWidget {
  const IMDBRating({Key? key, required this.rating}) : super(key: key);

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          color: const Color(0xfff5c611)),
      padding: EdgeInsets.all(4.w),
      child: Text(
        rating,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
