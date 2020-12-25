
import 'package:flutter/material.dart';

import '../Pages/event_page.dart';
import '../Pages/home.dart';
import '../Pages/library.dart';
import '../Pages/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPEC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  PageController pageController = PageController();
  int currentIndex = 0;
  var currentTab = [
    Home(),
    Event_Page(),
    //Library(),
    Setting(),
  ];

  // PageStorageBucket _bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: currentTab,
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      // body: PageStorage(
      //   bucket: _bucket,
      //   child: currentTab[currentIndex],
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            pageController.animateToPage(index,
                duration: Duration(milliseconds: 500), curve: Curves.easeIn);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: new Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.update),
            label: 'Events',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.library_add),
          //   label: 'Library',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
