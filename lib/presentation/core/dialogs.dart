import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dialogs {
  static void showErrorDialog(BuildContext context, String message) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: '',
        widget: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ));
  }

  static void showInfoDialog({
    required BuildContext context,
    required String message,
    required Function() onConfirm,
  }) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        title: '',
        onConfirmBtnTap: () => Navigator.pop(context),
        onCancelBtnTap: onConfirm,
        confirmBtnText: 'No',
        cancelBtnText: 'Yes',
        showCancelBtn: true,
        widget: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ));
  }

  static void showProgressDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 260.h),
        child: const AlertDialog(
          content: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  static void showFlushbar({
    required BuildContext context,
    required String message,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 1),
  }) async {
    final flushbar = Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      duration: duration,
      backgroundColor: color,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );

    flushbar.show(context);
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color color = Colors.green,
    Duration duration = const Duration(seconds: 2),
  }) {
    final _snackbar = SnackBar(
      duration: duration,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(vertical: 20),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(_snackbar)
        .closed
        .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
  }
}
