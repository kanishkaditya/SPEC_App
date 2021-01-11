import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:spec_app/Components/ListViewContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:spec_app/Components/TransitionTopView.dart';
import 'dart:async';
import '../main.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key key}) : super(key: key);

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin,TickerProviderStateMixin {
  Animation<double> containerGrowAnimation;
  AnimationController _screenController;
  AnimationController _buttonController;
  Animation<double> buttonGrowAnimation;
  Animation<double> listTileWidth;
  ScrollController scrollController;
  Animation<Alignment> listSlideAnimation;
  Animation<Alignment> buttonSwingAnimation;
  Animation<EdgeInsets> listSlidePosition;
  Animation<Color> fadeScreenAnimation;
  var animateStatus = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scrollController=ScrollController();
    scrollController.addListener(() {
      if(scrollController.offset<350&&scrollController.offset>=50&&scrollController.position.userScrollDirection==ScrollDirection.reverse)
        scrollController.animateTo(350, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
      else if(scrollController.offset>0&&scrollController.offset<300&&scrollController.position.userScrollDirection==ScrollDirection.forward)
        scrollController.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    });
    _screenController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1500), vsync: this);

    fadeScreenAnimation = new ColorTween(
      begin: const Color.fromRGBO(247, 64, 106, 1.0),
      end: const Color.fromRGBO(247, 64, 106, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: Curves.ease,
      ),
    );
    containerGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeIn,
    );

    buttonGrowAnimation = new CurvedAnimation(
      parent: _screenController,
      curve: Curves.easeOut,
    );
    containerGrowAnimation.addListener(() {
      this.setState(() {});
    });
    containerGrowAnimation.addStatusListener((AnimationStatus status) {});
    listTileWidth = new Tween<double>(
      begin: 1000.0,
      end: 600.0,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.bounceIn,
        ),
      ),
    );

    listSlideAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.700,
          curve: Curves.ease,
        ),
      ),
    );
    buttonSwingAnimation = new AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.225,
          0.600,
          curve: Curves.ease,
        ),
      ),
    );
    listSlidePosition = new EdgeInsetsTween(
      begin: const EdgeInsets.only(bottom: 16.0),
      end: const EdgeInsets.only(bottom: 80.0),
    ).animate(
      new CurvedAnimation(
        parent: _screenController,
        curve: new Interval(
          0.325,
          0.800,
          curve: Curves.ease,
        ),
      ),
    );
    _screenController.forward();
  }

  @override
  void dispose() {
    _screenController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    timeDilation = 0.8;
    //  Size screenSize = MediaQuery.of(context).size;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers:<Widget>[TransitionAppBar(title: Text(user.displayName),),
            new SliverList(
              delegate: SliverChildBuilderDelegate((context,index){
                return new ListViewContent(
                  listSlideAnimation: listSlideAnimation,
                  listSlidePosition: listSlidePosition,
                  listTileWidth: listTileWidth,
                );
                },
              ),
            ),
          ]
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
