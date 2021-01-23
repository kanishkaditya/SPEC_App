import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:spec_app/Cards/class_card.dart';
import 'package:spec_app/Components/Animations/homeAnimation.dart';
import 'package:spec_app/Components/Animations/star_field.dart';
import 'package:spec_app/Components/CustomWidget/Calender.dart';
import 'package:spec_app/Components/CustomWidget/TimeTableList.dart';
import 'package:spec_app/Components/CustomWidget/TransitionTopView.dart';
import 'package:spec_app/Components/FadeContainer.dart';
import 'package:spec_app/Components/Navdrawer/navigationDrawer.dart';
import 'package:spec_app/main.dart';
import 'package:flutter/scheduler.dart' show timeDilation;



List comingEvents=[];
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
  ScrollController nestedscrollController;
  Animation buttondisappearanim;
  Animation<Alignment> buttonSwingAnimation;
  Animation<Color> fadeScreenAnimation;
  GlobalKey<ScaffoldState> drawerKey;
  var animateStatus = 0;
  int a;

  @override
  void initState() {
    super.initState();
    //initManualEvents();
    drawerKey=GlobalKey();
    a=Random().nextInt(s.length);
    listenable.addListener(() {
      //screenController.reset();
      setState(() {});
    }
    );
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    scrollController=ScrollController();
    // scrollController.addListener(() {
    //   if(scrollController.offset!=0&&nestedscrollController.offset==0)
    //     scrollController.animateTo(0, duration: Duration(milliseconds: 2), curve: Curves.easeOut);
    //   // else if(scrollController.offset<350&&scrollController.offset>=50&&scrollController.position.userScrollDirection==ScrollDirection.reverse)
    //   //   {scrollController.animateTo(350, duration: Duration(milliseconds: 500), curve: Curves.easeOut);}
    //   // else if(scrollController.offset>0&&scrollController.offset<300&&scrollController.position.userScrollDirection==ScrollDirection.forward)
    //   //   {scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeIn);}
    // });
    nestedscrollController=ScrollController();
    nestedscrollController.addListener(() {
      if(nestedscrollController.offset<350&&nestedscrollController.offset>=50&&nestedscrollController.position.userScrollDirection==ScrollDirection.reverse)
      {scrollController.animateTo(350, duration: Duration(milliseconds: 700), curve: Curves.easeOut);}
      else if(nestedscrollController.offset>0&&nestedscrollController.offset<300&&nestedscrollController.position.userScrollDirection==ScrollDirection.forward)
      {scrollController.animateTo(0, duration: Duration(milliseconds: 700), curve: Curves.easeIn);}
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
    buttondisappearanim=new SizeTween(
      begin: Size.fromRadius(15),
      end:Size.fromRadius(0.0),
    ).animate(_buttonController);
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
    timeDilation = 0.8;

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        key: drawerKey,
        floatingActionButton: notCR ==false?
        animateStatus == 0
    ? Container(
           width: buttonGrowAnimation.value * 60,
           height: buttonGrowAnimation.value * 60,
      child: NeumorphicFloatingActionButton(
            style: NeumorphicStyle(
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
                depth: buttonGrowAnimation.value * 20,
                lightSource: LightSource.topLeft,
                shadowLightColor: Colors.black54,
                shadowDarkColor: Colors.orangeAccent,
                color: Colors.white
            ),
            onPressed: () {
              setState(() {});
              animateStatus = 1;
              _playAnimation();
            },
        child:Padding(
          padding: EdgeInsets.only(left: buttonGrowAnimation.value * 40.0/12,top:buttonGrowAnimation.value * 40.0/4),
          child: NeumorphicIcon(
            Icons.add,
             size: buttonGrowAnimation.value * 40.0,
            style: NeumorphicStyle(color: Colors.orange,lightSource: LightSource.topLeft,depth: buttonGrowAnimation.value * 40,shadowDarkColor: Colors.black,shadowLightColor: Colors.black38),
          ),
        ),
      ),
    )
        : new StaggerAnimation(buttonController: _buttonController.view)
        :null,
        drawerEdgeDragWidth: 100,
        drawerDragStartBehavior: DragStartBehavior.down,
        drawer: NavigationDrawer(),
        body: Stack(
          children: [
            StarField(starCount: 400,starSpeed: 0.5,),
            new FadeBox(
              fadeScreenAnimation: fadeScreenAnimation,
              containerGrowAnimation: containerGrowAnimation,
            ),
            NestedScrollView(
            //  shrinkWrap: true,
              controller: scrollController,
               //slivers:  [
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { return [TransitionAppBar(title: Text(user.displayName)),]; },
        body:  TimeTableList(nestedscrollController,a,scrollController),
               //  DrinkRewardsListDemo(),
               //],
               //   new SliverList(
               //    delegate: SliverChildBuilderDelegate((context,index){
               //        while(comingEvents!=null&&index<1&&comingEvents.length!=0){
               //
               //         // return ListViewContent(listTileWidth: listTileWidth,listSlideAnimation: listSlideAnimation,listSlidePosition: listSlidePosition,);
               //        }
               //        return null;
               //      },
               //    ),
               //  ),
         //     ]
            ),

            new FadeBox(
              fadeScreenAnimation: fadeScreenAnimation,
              containerGrowAnimation: containerGrowAnimation,
            ),
          ],
        ),
      ),
    ));
  }
// initManualEvents()async{
//     var snaps=await Firestore.instance.collection('ManualEvents').getDocuments();
//     snaps.documents.forEach((element) {
//       comingEvents.add(ManualEvent(name:element.data['name'],summary: element.data['summary'],Doc_url: element.data['urls'],lastDate: element.data['lastdata']
//       ));
//     });
//
// }
  @override
  bool get wantKeepAlive => true;
}
