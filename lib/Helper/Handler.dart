import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:spec_app/Helper/navbar.dart';
import 'package:spec_app/Home/index.dart';
import '../Pages/event_page.dart';
import '../Pages/home.dart';
import '../Pages/settings.dart';

class Handler extends StatefulWidget {
  @override
  _HandlerState createState() =>
      _HandlerState();
}

class _HandlerState extends State<Handler>with AutomaticKeepAliveClientMixin {

  PageController pageController = PageController();
  int currentIndex = 0;
  List<NavBarItemData> _navBarItems;
  int _selectedNavIndex = 0;

  List<Widget> _viewsByIndex=[
    HomeScreen(),
    Event_Page(),
    Setting(),
  ];


  @override
  void initState() {
    _navBarItems = [
      NavBarItemData("Home", OMIcons.home, 110, Color(0xff01b87d)),
      NavBarItemData("Events", OMIcons.image, 110, Color(0xff594ccf)),
      NavBarItemData("Setting", OMIcons.save, 110, Color(0xfff2873f)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var navBar = NavBar(
      items: _navBarItems,
      itemTapped: _handleNavBtnTapped,
      currentIndex: _selectedNavIndex,
    );
    //Display the correct child view for the current index

    return Scaffold(
        body: PageView(
        children: _viewsByIndex,
        controller: pageController,
        onPageChanged: (int index) {
          setState(() {
            _selectedNavIndex = index;
          });
        },
      ),
      bottomNavigationBar:navBar
    );
  }
  void _handleNavBtnTapped(int index) {
    //Save the new index and trigger a rebuild
    setState(() {
      //This will be passed into the NavBar and change it's selected state, also controls the active content page
      _selectedNavIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
