import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mock_login_flutter/Controllers/MockServer.dart';
import 'package:mock_login_flutter/Controllers/Utils.dart';
import 'package:mock_login_flutter/Models/UserModel.dart';

class LoginController extends GetxController{
  //properties
  String? email;
  String? password;
  GlobalKey? key;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final formKey= GlobalKey<FormState>();

  var isLoading = false.obs;

  var fnEmail = FocusNode();
  var fnPassword = FocusNode();

  var autoValidate= false.obs;



  // functions

  Future<void> handleGoogleSignIn() async {
    isLoading.value=true;
    try {
      if(await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
       _googleSignIn.signIn().then((res) {
         if ( res!=null) {
           showSnackBar(title: "Congratulations!",message: "Logged in successfully \n ${res}",type: SnackType.success);

         }
       }).catchError((error){

       });

    } catch (error) {

      showSnackBar(title: "Please note!",message: "Something went wrong\n details: ${error.toString()}",type: SnackType.fail);
      print(error);
    }

    isLoading.value=false;
  }
  void handleLogin() async{
    if(formKey.currentState!.validate() && !isLoading.value)
    {
      isLoading.value= true;
      formKey.currentState!.save();

      var res = await myMockHttpClient.post(
          Uri.parse('https://mymockwebserver/api/login'),
          body: {
            "email":email,
            "password":password
          }
      );
      if (res.statusCode ==200 ) {
        print((res.body.toString()));
        try{
          UserModel user = UserModel.fromJson(jsonDecode(res.body.toString()));

          showSnackBar(title: "Congratulations!",message: "Logged in successfully \n ${user}",type: SnackType.success);
          print(user);
        } catch(e){print(e);}
      }else{
        showSnackBar(title: "Please note!",message: "Invalid login credentials",type: SnackType.fail);
      }
    }else {
        autoValidate.value=true;
    }

    isLoading.value= false;
  }
}