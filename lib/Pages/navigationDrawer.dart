import 'package:flutter/material.dart';
import 'package:spec_app/Pages/attendenceCalender.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      "https://images.unsplash.com/photo-1594616838951-c155f8d978a0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Nabin Nath",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "nabinnath9@gmail.com",
                    style: TextStyle(
                      fontSize: 16.0,
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
              color: Colors.black,
            ),
            title: Text("Study Material"),
          ),

          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Colors.black,
            ),
            title: Text("Attendence Manager"),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.help,
              color: Colors.black,
            ),
            title: Text("About SPEC"),
          ),

          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text("Settings"),
          )
        ],
    );
  }
}
