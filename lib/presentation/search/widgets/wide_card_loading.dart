import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WideCardLoading extends StatelessWidget {
  const WideCardLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey[400]),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              height: 0.2 * size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white30,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        color: Colors.white30,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 40.w,
                          color: Colors.white30,
                          height: 40.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white30,
                          height: 15.h,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white30,
                          height: 15.h,
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.white30,
                          height: 15.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: SizedBox(
                width: 20.w,
                height: 20.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
