
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String? validateEmail(String? value,{FocusNode? fn,BuildContext? context }) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern as String);
  if (!regex.hasMatch(value!)) {
    if(fn!=null && context!=null) {
      FocusScope.of(context).requestFocus(fn);
    }
    return 'Enter Valid Email';
  } else {
    return null;
  }
}

String? validatePassword(String? value,{FocusNode? fn,BuildContext? context }) {
  if (value!.trim().length <4 ) {
    if(fn!=null && context!=null) {
      FocusScope.of(context).requestFocus(fn);
    }
    return 'password must be of at least 4 digits.';
  } else {
    return null;
  }
}
enum SnackType { info, success, fail, none }
showSnackBar(
    {String? title, String? message, SnackType type = SnackType.none, int milliseconds=1500}) {
  Get.showSnackbar(GetBar(
    icon: type == SnackType.none
        ? null
        : type == SnackType.success
        ? const Icon(
      Icons.check_circle,
      color: Colors.green,
    )
        : type == SnackType.fail
        ? const Icon(
      Icons.close_rounded,
      color: Colors.red,
    )
        : const Icon(
      Icons.info,
      // color: themePrimaryColor,
    ),
    title: title,
    message: message,
    isDismissible: true,
    duration: Duration(milliseconds: milliseconds),
  ));
}