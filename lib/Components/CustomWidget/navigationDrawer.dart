import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spec_app/main.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 10.0,
        sigmaY: 10.0,
      ),
      child: Column(
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
                      color:Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 16.0,
                      color:Colors.black,
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
          //Now let's Add the button for the Menu
          //and let's copy that and modify it
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.book,
              color: Colors.white,
            ),
            title: Text("Study Material",style:TextStyle(color:Colors.white),),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.help,
              color: Colors.white,
            ),
            title: Text("About SPEC",style:TextStyle(color:Colors.white),),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text("Settings",style: TextStyle(color:Colors.white),),
          )
        ],
      ),
    );
  }
}
