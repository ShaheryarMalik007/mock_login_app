

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mock_login_flutter/Controllers/MockServer.dart';

import '../Controllers/Utils.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}




class _EmailLoginState extends State<EmailLogin> {
  static String? email;
  static String? password;
  static GlobalKey? key;


  // GoogleSignIn googleAuth googleAuth= GoogleSignIn();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final _formKey= GlobalKey<FormState>();


  bool isLoading = false;

  var fnEmail = FocusNode();
  var fnPassword = FocusNode();

  bool _autoValidate= false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if(mounted) {
        fnEmail.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled ,
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
                              height: 80,
                              child: TextFormField(
                                initialValue: email ?? "",
                                decoration: const InputDecoration(
                                    hintText: 'Enter your email',
                                    filled: true,
                                    labelText: 'Email',
                                    border: OutlineInputBorder()),
                                focusNode: fnEmail,
                                keyboardType: TextInputType.emailAddress,
                                validator: validateEmail,
                                onSaved: (String? value) {
                                  email = value;
                                },
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context)
                                      .requestFocus(fnPassword);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              child: Column(
                                children: [

                                  TextFormField(
                                    initialValue: password ?? "",
                                    decoration: const InputDecoration(
                                        hintText: 'Enter your password',
                                        filled: true,
                                        labelText: 'Password',
                                        border: OutlineInputBorder(

                                        )
                                    ),
                                    focusNode: fnPassword,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: validatePassword,
                                    obscureText: true,
                                    onSaved: (String? value) {
                                      password = value;
                                    },
                                    onFieldSubmitted: (val){
                                      proceed();
                                    },
                                  ),

                                ],
                              ),
                            ),
                            Center(
                              child :Container(
                                height: 50,
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
                                      proceed();
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
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
                                setState(() {
                                  // _isSigningIn = true;
                                });

                                _handleGoogleSignIn();
                                // TODO: Add method call to the Google Sign-In authentication

                                setState(() {
                                  // _isSigningIn = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage("assets/google_logo.png"),
                                      height: 35.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
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
      );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      if(await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
     var res= await _googleSignIn.signIn();
     if (kDebugMode) {
       print(res);
     }
    } catch (error) {
      print(error);
    }
  }
  void proceed() async{
    if(_formKey.currentState!.validate() && !isLoading)
    {

      setState(() {
        isLoading= true;
      });
      _formKey.currentState!.save();


      var res = await myMockHttpClient.get(Uri.parse('https://staging.company.com/api/customer/123'));
      if (kDebugMode) {
        print((res.body.toString()));
      }
      // ApiCaller.callAdminLoginAPI({
      //   'email':email,
      //   'password':password,
      // }, context) .then((var response) async {
      //   printLog('response: ${response}');
      //   if (response.status == Status.COMPLETED) {
      //
      //     var loginResponse = LoginResponseModel.fromJson(response.data);
      //     await SharedPrefManager.setString(
      //       SharedPrefManager.userType,
      //       loginResponse.user!.type!,
      //     );
      //     await SharedPrefManager.save(
      //         SharedPrefManager.userModel, loginResponse.user);
      //     await SharedPrefManager.setString(
      //         SharedPrefManager.token, loginResponse.token!);
      //
      //
      //     Get.find<HomeController>().isAdmin.value=true;
      //     Helper.pushPageAndPopAll(context, Home());
      //
      //   }
      //   setState(() {
      //     isLoading = false;
      //   });
      //
      // });
    }else {
      setState(() {
        _autoValidate=true;
      });
      // Helper.showSnackBar(title: 'Please note!',message: "Please enter valid email & password",type: SnackType.fail);
    }

  }

//  Future<Null> _onAnimationComplete() async {
//    if (_formKey.currentState.validate()) {
//      try {
//        var response = await ApiBaseHelper.getInstance(context).post_(
//            ApiBaseHelper.LOGIN_API, {
//          'email': _emailController.text,
//          'password': _passController.text,
//        });
////      log_it("response parsed   ${response}");
//        if(response.status==Status.COMPLETED)
//        {
//          var loginResponse = LoginResponseModel.fromJson(response.data) ;
////      if(msg!=null)
//          Fluttertoast.showToast(
//            msg: "User Logged In successfully.",
//            fontSize: 11,
//            backgroundColor: themeSuccessColor,
//            textColor: Colors.white,
//          );
//          await SharedPrefManager.setString(
//            SharedPrefManager.userType,
//            loginResponse.user.type,
//          );
//          ApiBaseHelper.userType = loginResponse.user.type;
//
//          await SharedPrefManager.save(SharedPrefManager.userModel, loginResponse.user);
//          await SharedPrefManager.setString(SharedPrefManager.token, loginResponse.token);
//          Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//              builder: (context) => Home(),
//            ),
//          );
//        } else if(response.status==Status.ERROR)
//        {
//          var msg = response.data['message'];
//          if(msg!=null)
//            Fluttertoast.showToast(
//              msg: msg,
//              fontSize: 11,
//              backgroundColor: themeErrorColor,
//              textColor: Colors.white,
//            );
//        }
//      } catch (e) {
//        log_it(e.toString());
//        Fluttertoast.showToast(
//          msg: e.toString(),
//          fontSize: 11,
//          backgroundColor: themePrimaryColor,
//          textColor: Colors.white,
//        );
//      }
//    }else{
//      setState(() {
//        _autoValidate = true;
//      });
//    }
//    return null;
//  }
}