import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_login_flutter/Controllers/LoginController.dart';
import 'package:mock_login_flutter/Views/EmailLogin.dart';

import 'Controllers/MockServer.dart';

void main() async{

  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mock Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: EmailLogin()  //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}