import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieNotFound extends StatelessWidget {
  const MovieNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
        child: SizedBox(
          height: size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
                size: 150.r,
              ),
              SizedBox(
                height: 20.h,
              ),
              const Text('Movie Not Found :('),
              SizedBox(
                height: 10.h,
              ),
              const Text('Search Again')
            ],
          ),
        ),
      ),
    );
  }
}
