import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:i_movie/data/models/user.dart';
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/presentation/core/locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool shouldAutoLogin = false;
  double fontSize = 0;

  @override
  void initState() {
    try {
      User? lastUser = Hive.box('auth').get('lastUser');
      if (lastUser != null) {
        shouldAutoLogin = true;
        registerCurrentUserSingleton(lastUser.email);
      }
    } catch (e) {
      print(e.toString());
    }

    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        setState(() {
          fontSize = 50.sp;
        });
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(
              context, shouldAutoLogin ? homeRouteName : loginRouteName);
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedSize(
          duration: const Duration(seconds: 1),
          alignment: Alignment.center,
          child: Text(
            'I-Movie',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
