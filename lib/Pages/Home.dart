import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:spec_app/Cards/class_card.dart';
import 'package:spec_app/Components/AddButton.dart';
import 'package:spec_app/Components/Calender.dart';
import 'package:spec_app/Components/FadeContainer.dart';
import 'package:spec_app/Components/TransitionTopView.dart';
import 'package:spec_app/Objects/Class.dart';
import 'package:spec_app/main.dart';

import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:spec_app/Components/TimeTableList.dart';
import 'package:spec_app/navigationDrawer.dart';


import 'homeAnimation.dart';

List<Class>comingEvents=[];
DateTime selectedDay=DateTime.now();

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin {
  Animation<double> containerGrowAnimation;
  AnimationController _buttonController;
  Animation<double> buttonGrowAnimation;
  AnimationController screenController;
  ScrollController scrollController;
  Animation<Alignment> buttonSwingAnimation;
  Animation<Color> fadeScreenAnimation;
  GlobalKey<ScaffoldState> drawerKey;
  var animateStatus = 0;
  int a;

  @override
  void initState() {
    super.initState();
    drawerKey=GlobalKey();
    a=Random().nextInt(s.length);
    listenable.addListener(() {
    //  screenController.reset();
      setState(() {});
    }
    );
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scrollController=ScrollController();
    scrollController.addListener(() {
      if(scrollController.offset<350&&scrollController.offset>=50&&scrollController.position.userScrollDirection==ScrollDirection.reverse)
        scrollController.animateTo(350, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      else if(scrollController.offset>0&&scrollController.offset<300&&scrollController.position.userScrollDirection==ScrollDirection.forward)
        scrollController.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    });
    screenController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);

    fadeScreenAnimation = new ColorTween(
      begin: const Color.fromRGBO(247, 64, 106, 1.0),
      end: const Color.fromRGBO(247, 64, 106, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: screenController,
        curve: Curves.ease,
      ),
    );
    containerGrowAnimation = new CurvedAnimation(
      parent: screenController,
      curve: Curves.easeIn,
    );

    buttonGrowAnimation = new CurvedAnimation(
      parent: screenController,
      curve: Curves.easeOut,
    );
    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});
    buttonSwingAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ).animate(
      new CurvedAnimation(
        parent: screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.ease,
        ),
      ),
    );
    screenController.forward();
  }


  @override
  void setState(VoidCallback fn) {
    super.setState(() {});
   screenController.forward();
  }

  @override
  void dispose() {
    screenController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward(from: 0.0);
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    drawerOpen.addListener(() {drawerKey.currentState.openDrawer();});
    super.build(context);
   // bool isLandscape = MediaQuery.of(context).size.aspectRatio > 1;
  //  double headerHeight = MediaQuery.of(context).size.height * (isLandscape? .25 : .2);
    timeDilation = 0.8;
    //  Size screenSize = MediaQuery.of(context).size;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        key: drawerKey,
        drawerEdgeDragWidth: 100,
        drawerDragStartBehavior: DragStartBehavior.down,
        drawer: NavigationDrawer(),
        body: Stack(
          children: [
            new FadeBox(
              fadeScreenAnimation: fadeScreenAnimation,
              containerGrowAnimation: containerGrowAnimation,
            ),
            CustomScrollView(
              controller: scrollController,
               slivers:  [
                  TransitionAppBar(title: Text(user.displayName)),
               //  DrinkRewardsListDemo(),
               //],
                 new SliverList(
                  delegate: SliverChildBuilderDelegate((context,index){
                      while(comingEvents!=null&&index<1&&comingEvents.length!=0){
                        return TimeTableList(scrollController,a);
                       // return ListViewContent(listTileWidth: listTileWidth,listSlideAnimation: listSlideAnimation,listSlidePosition: listSlidePosition,);
                      }
                      return null;
                    },
                  ),
                ),
              ]
            ),
            new FadeBox(
              fadeScreenAnimation: fadeScreenAnimation,
              containerGrowAnimation: containerGrowAnimation,
            ),
            animateStatus == 0
                ? new Align(
              alignment: Alignment.bottomRight,
                child: new InkWell(
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    onTap: () {
                      setState(() {});
                      animateStatus = 1;
                      _playAnimation();
                    },
                    child: new AddButton(
                      buttonGrowAnimation: buttonGrowAnimation,
                    )))
                : new StaggerAnimation(buttonController: _buttonController.view),
          ],
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
