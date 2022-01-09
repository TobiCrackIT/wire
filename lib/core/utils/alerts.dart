import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alerts{

  static showAlert(BuildContext context, String message){
    Flushbar(
      title:"Error",
      titleColor: Colors.white,
      message: "$message",
      messageColor: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      borderRadius: BorderRadius.all(Radius.circular(10),),
      backgroundColor: Colors.redAccent,
      isDismissible: false,
      duration: Duration(seconds: 3),
      showProgressIndicator: false,
      progressIndicatorBackgroundColor: Colors.transparent,
    ).show(context);
  }

  static showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: color,
        elevation: 2,
        padding: const EdgeInsets.all(
          10,
        ), // Inner padding for SnackBar content.
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}