import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spec_app/Components/ResultTab/ResultList.dart';
import 'package:spec_app/Helper/AuthService.dart';
import 'package:spec_app/Pages/courses.dart';
import 'package:spec_app/Pages/event_page.dart';
import 'package:spec_app/Pages/loginPage.dart';
import 'package:spec_app/Pages/manual_events.dart';
import 'package:spec_app/Pages/register.dart';
import 'Pages/Home.dart';

AuthService service;
FirebaseUser user;
bool notCR;
String year;
String branch;
String rollno;

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
      '/Register': (context) => Register(),
      '/Courses': (context) => courses(),
      '/Result':(context)=>ResultList(),
      '/addEvents' : (context) => addEvents(),
      '/Home':(context)=>HomeScreen(),
      '/Events':(context)=>Event_Page(),
    },
    initialRoute: isLoggedIn ? '/Home' : '/LoginPage',
  ));
    
}

