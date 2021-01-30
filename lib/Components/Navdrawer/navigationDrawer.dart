import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:spec_app/main.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

int index = 1;

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: ListView(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                          user.photoUrl,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        user.displayName,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      NeumorphicText(
                        user.email,
                        style: NeumorphicStyle(
                            lightSource: LightSource.topLeft,
                            depth: 20,
                            shadowLightColor: Colors.black38,
                            shadowDarkColor: Colors.black),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 16.0,
                          //color:Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  if (index != 1) {
                    index = 1;
                    Navigator.of(context).pushNamed("/Home");
                  }
                },
                leading: Icon(
                  OMIcons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed("/mentor");
                },
                leading: Icon(
                  OMIcons.questionAnswer,
                  color: Colors.white,
                ),
                title: Text(
                  "Mentors",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  if (index != 2) {
                    index = 2;
                    Navigator.of(context).pushReplacementNamed("/Events");
                  }
                },
                leading: Icon(
                  OMIcons.image,
                  color: Colors.white,
                ),
                title: Text(
                  "Events",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Now let's Add the button for the Menu
              //and let's copy that and modify it
              ListTile(
                onTap: () {
                    Navigator.of(context).pushNamed("/Courses");
                },
                leading: Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                title: Text(
                  "Study Material",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  if (index != 4) {
                    index = 4;
                    Navigator.pushReplacementNamed(context, '/Result');
                  }
                },
                leading: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  "Results",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: Text(
                  "About SPEC",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
