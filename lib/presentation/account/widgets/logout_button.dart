import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:i_movie/presentation/core/const.dart';
import 'package:i_movie/presentation/core/dialogs.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(24.r),
      splashColor: Colors.red[600],
      onTap: () => onTap(context),
      child: Container(
        height: (size.height * 0.1),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey,
            width: 0.5.w,
          ),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              padding: EdgeInsets.all(8.r),
              child: const Icon(
                Icons.power_settings_new,
                color: Colors.red,
              ),
              decoration:
                  BoxDecoration(color: Colors.red[100], shape: BoxShape.circle),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    Dialogs.showInfoDialog(
      context: context,
      message: 'Do you want to log out?',
      onConfirm: () async {
        await Hive.box('auth').delete('lastUser');

        FirebaseAuth.instance.signOut();

        Navigator.pushNamedAndRemoveUntil(
          context,
          loginRouteName,
          (route) => route.isFirst,
        );
      },
    );
  }
}
