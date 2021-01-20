import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spec_app/Components/Animations/liquid_painter.dart';
import 'package:spec_app/Components/ParallaxImageGen.dart';

import 'package:spec_app/Components/rounded_shadow.dart';
import 'package:spec_app/Components/syles.dart';
import 'package:spec_app/Objects/Class.dart';


List s=['dinner','bbq','basketball','lunch'];

class ClassCard extends StatefulWidget {
  static double nominalHeightClosed = 96;
  static double nominalHeightOpen = 290;

  final Function(Class) onTap;

  final bool isOpen;
  final Class classData;
  final int currentAttendance;
  final ScrollController scrollController;
  final int imgIndex;

  const ClassCard({Key key, this.classData, this.onTap, this.isOpen = false, this.currentAttendance = 100,this.scrollController,this.imgIndex}) : super(key: key);

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> with TickerProviderStateMixin {
  bool _wasOpen;
  Animation<double> _fillTween;
  Animation<double> _attendanceTween;
  AnimationController _liquidSimController;

  //Create 2 simulations, that will be passed to the LiquidPainter to be drawn.
  LiquidSimulation _liquidSim1 = LiquidSimulation();
  LiquidSimulation _liquidSim2 = LiquidSimulation();

  @override
  void initState() {

    //Create a controller to drive the "fill" animations
    _liquidSimController = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _liquidSimController.addListener(_rebuildIfOpen);
    //create tween to raise the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _liquidSimController, curve: Interval(.12, .45, curve: Curves.easeOut)),
    );
    //create tween to animate the 'attendance remaining' text
    _attendanceTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _liquidSimController, curve: Interval(.1, .5, curve: Curves.easeOutQuart)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _liquidSimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //If our open state has changed...
    if (widget.isOpen != _wasOpen) {
      //Kickoff the fill animations if we're opening up
      if (widget.isOpen) {
        //Start both of the liquid simulations, they will initialize to random values
        _liquidSim1.start(_liquidSimController, true);
        _liquidSim2.start(_liquidSimController, false);
        //Run the animation controller, kicking off all tweens
        _liquidSimController.forward(from: 0);
      }
      _wasOpen = widget.isOpen;
    }

    //Determine the attendance required text value, using the _attendanceTween
    var attendanceRequired = 60;
    var attendanceValue = attendanceRequired - _attendanceTween.value * min(widget.currentAttendance, attendanceRequired);
    //Determine current fill level, based on _fillTween
    double _maxFillLevel = min(1, widget.currentAttendance / 60);
    double fillLevel = _maxFillLevel; //_maxFillLevel * _fillTween.value;
    double cardHeight = widget.isOpen ? ClassCard.nominalHeightOpen : ClassCard.nominalHeightClosed;
    bool isnotbreak=widget.classData.title!='break'&&widget.classData.title!='lunch';


    return GestureDetector(
      onTap: _handleTap,
      //Use an animated container so we can easily animate our widget height
      child: AnimatedContainer(
        curve: !_wasOpen ? ElasticOutCurve(0.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !_wasOpen ? 1200 : 1500),
        height: cardHeight,
        //Wrap content in a rounded shadow widget, so it will be rounded on the corners but also have a drop shadow
        child: RoundedShadow.fromRadius(
          12,
          child: Card(
            child: Container(
             // color: Colors.blue,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  //Background liquid layer
                  AnimatedOpacity(
                    opacity: widget.isOpen ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: _buildLiquidBackground(_maxFillLevel, fillLevel),
                  ),

                  isnotbreak?
                  Container(
                decoration:BoxDecoration(gradient: LinearGradient(colors: [Colors.orange,Colors.white54.withOpacity(0)],end:Alignment(0.8,0.4)),borderRadius: BorderRadius.all(Radius.circular(5))),
                    //Wrap content in a ScrollView, so there's no errors on over scroll.
                    child: SingleChildScrollView(
                      //We don't actually want the scrollview to scroll, disable it.
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                         // SizedBox(height: 15),
                          //Top Header R
                          _buildTopContent(),
                          //Spacer
                          SizedBox(height: 12),
                          //Bottom Content, use AnimatedOpacity to fade
                          AnimatedOpacity(
                            duration: Duration(milliseconds: widget.isOpen ? 1000 : 500),
                            curve: Curves.easeOut,
                            opacity: widget.isOpen ? 1 : 0,
                            //Bottom Content
                            child: _buildBottomContent(attendanceValue),
                          ),
                        ],
                      ),
                    ),
                  ):
                  ParallaxImage(
                      image:Image.network(
                    "https://ssl.gstatic.com/tmly/f8944938hffheth4ew890ht4i8/flairs/xxhdpi/img_"+s[widget.imgIndex]+".jpg",
                    loadingBuilder: (BuildContext context,Widget widget,ImageChunkEvent loaded){
                      double progress=loaded.cumulativeBytesLoaded/loaded.expectedTotalBytes;
                      return CircularProgressIndicator(value:progress);
                    },).image, extent: 96
                      ,child:Align(alignment: Alignment.bottomLeft,child: Padding(
                        padding: const EdgeInsets.only(left: 10,bottom: 10),
                        child: Text(widget.classData.title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white)),
                      )
                  )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // else
    //   {
    //   return
    //   }
  }

  Stack _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset:
              Offset(0, ClassCard.nominalHeightOpen * 1.2 - ClassCard.nominalHeightOpen * _fillTween.value * _maxFillLevel * 1.2),
          child: CustomPaint(
            painter: LiquidPainter(fillLevel, _liquidSim1, _liquidSim2, waveHeight: 100),
          ),
        ),
      ],
    );
  }

  Row _buildTopContent() {
    return Row(
     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //Label
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left:10,top:10),
            child: Text(
              widget.classData.title,
              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left:10,top:10),
          child: Text(
              "Time :- "+widget.classData.subtitle,
              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)
          ),
        ),
        if(widget.classData.isToday)
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.lightGreen,
          child: ImageIcon(AssetImage('assets/Image/tick.png'),size: 15,),
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
        ),
        if(widget.classData.isToday)
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.redAccent,
          child:ImageIcon(AssetImage('assets/Image/multiply.png'),size:15,),
          padding: EdgeInsets.all(10),
          shape: CircleBorder(),
        ),
        //Icon(Icons.star, size: 20, color: AppColors.orangeAccent),
        SizedBox(width: 4),
        //attendance Text
        //Text("${60}", style: Styles.text(18, Colors.black, false))
      ],
    );
  }

  Column _buildBottomContent(double attendanceValue) {
    List<Widget> rowChildren = [];
    // under progress
    // if (attendanceValue == 0) {
    //   rowChildren.add(Text("Congratulations!", style: Styles.text(16, Colors.white, true)));
    // }
    // else {
    //   rowChildren.addAll([
    //     Text("You're only ", style: Styles.text(12, Colors.white, false)),
    //     Text(" ${attendanceValue.round()} ", style: Styles.text(16, AppColors.orangeAccent, true)),
    //     Text(" attendance away", style: Styles.text(12, Colors.white, false)),
    //   ]);
    // }
    return Column(
      children: [
        //Body Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowChildren,
        ),
        SizedBox(height: 16),
        Text(
          widget.classData.teacher,
          textAlign: TextAlign.center,
          style: Styles.text(14, Colors.white, false, height: 1.5),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap(widget.classData);
    }
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }
}
