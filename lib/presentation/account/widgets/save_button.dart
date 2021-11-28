import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 40.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        splashColor: Colors.green,
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: const Center(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
