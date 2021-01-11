
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spec_app/Pages/register.dart';
import 'Helper/AuthService.dart';
import 'Helper/Handler.dart';
import 'Objects/Event.dart';
import 'Pages/loginPage.dart';

AuthService service;
FirebaseUser user;
File file;
List<Event>upcoming;
void main() async {
  //SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn =false;
  if(prefs.containsKey('IsLoggedInFirebase')&&prefs.containsKey('IsLoggedInGoogle')){
      isLoggedIn=prefs.getBool('IsLoggedInFirebase')||prefs.getBool('IsLoggedInGoogle');
    }
  else{
    prefs.setBool('IsLoggedInFirebase',false);
    prefs.setBool('IsLoggedInGoogle',false);
  }
  service = AuthService();

  if (prefs.getBool('IsLoggedInGoogle')){user = await service.signInWithGoogle();}

    if(prefs.getBool('IsLoggedInFirebase'))
      {
        user=await service.SignIn();
       print(user.displayName + " " + user.email+" "+user.photoUrl);
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

