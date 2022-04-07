

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mock_login_flutter/Controllers/LoginController.dart';
import 'package:mock_login_flutter/Controllers/MockServer.dart';
import 'package:mock_login_flutter/Models/UserModel.dart';

import '../Controllers/Utils.dart';

class EmailLogin extends StatelessWidget {
   EmailLogin({Key? key}) : super(key: key);
   
  final LoginController lc= Get.find();

  @override
  Widget build(BuildContext context) {
    return
      Obx(()=> Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              key: lc.formKey,
              autovalidateMode: lc.autoValidate.value ? AutovalidateMode.onUserInteraction:AutovalidateMode.disabled ,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(height: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 27,
                              color: Color(0xff000000),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Enter your email address  \n& password to login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color:Color(0xff000000),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Container(

                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3.00,3.00),
                              color: const Color(0xff000000).withOpacity(0.11),
                              blurRadius: 25,
                            ),
                          ], borderRadius: BorderRadius.circular(9.00),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 85,
                                child: TextFormField(
                                  initialValue: lc.email ?? "",
                                  decoration: const InputDecoration(
                                      hintText: 'Enter your email',
                                      filled: true,
                                      labelText: 'Email',
                                      border: OutlineInputBorder()),
                                  focusNode: lc.fnEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: validateEmail,
                                  onSaved: (String? value) {
                                    lc.email = value;
                                  },
                                  onFieldSubmitted: (val) {
                                    FocusScope.of(context)
                                        .requestFocus(lc.fnPassword);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 85,
                                child: Column(
                                  children: [

                                    TextFormField(
                                      initialValue: lc.password ?? "",
                                      decoration: const InputDecoration(
                                          hintText: 'Enter your password',
                                          filled: true,
                                          labelText: 'Password',
                                          border: OutlineInputBorder(

                                          )
                                      ),
                                      focusNode: lc.fnPassword,
                                      keyboardType: TextInputType.visiblePassword,
                                      validator: validatePassword,
                                      obscureText: true,
                                      onSaved: (String? value) {
                                        lc.password = value;
                                      },
                                      onFieldSubmitted: (val){
                                        lc.handleLogin();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5,),
                              Center(
                                child :
                                lc.isLoading.value?const CircularProgressIndicator():Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      stops: const [0.1, 0.9],
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).primaryColor.withAlpha(95)
                                      ],
                                    ),
                                  ),
                                  child:
                                  SizedBox(height: 50,
                                    child:
                                    MaterialButton(
                                      child:const Text('Login') ,
                                      onPressed:(){
                                        lc.handleLogin();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  lc.handleGoogleSignIn();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Image(
                                        image: AssetImage("assets/google_logo.png"),
                                        height: 35.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Sign in with Google',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }


}