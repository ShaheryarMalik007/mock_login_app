
import 'package:flutter/material.dart';

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