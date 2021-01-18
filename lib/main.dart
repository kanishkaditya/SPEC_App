

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spec_app/Helper/AuthService.dart';
import 'package:spec_app/Helper/Handler.dart';
import 'package:spec_app/Pages/loginPage.dart';
import 'package:spec_app/Pages/register.dart';

AuthService service;
FirebaseUser user;
bool notCR;
String year;
String branch;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn =false;
  if(prefs.containsKey('IsLoggedInFirebase')){
      isLoggedIn=prefs.getBool('IsLoggedInFirebase');
    }
  else{
    prefs.setBool('IsLoggedInFirebase',false);
  }
  service = AuthService();


    if(prefs.getBool('IsLoggedInFirebase'))
      {
        user=await service.SignIn();
      }
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/LoginPage': (context) => LoginPage(title: 'Login Page'),
      '/Handler': (context) => Handler(),
      '/Register': (context) => Register(),
    },
    initialRoute: isLoggedIn ? '/Handler' : '/LoginPage',
  ));
    
}

