import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_movie/presentation/home/widgets/cool_line.dart';

class CoolLinearProgressIndicator extends StatelessWidget {
  const CoolLinearProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Expanded(
            child: RotatedBox(
              quarterTurns: 2,
              child: CoolLine(),
            ),
          ),
          Expanded(
            child: CoolLine(),
          )
        ],
      ),
    );
  }
}
