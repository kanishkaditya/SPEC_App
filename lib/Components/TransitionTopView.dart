import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spec_app/Components/Calender.dart';
import 'package:spec_app/main.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarController controller;
final drawerOpen=new ValueNotifier(true);
class TransitionAppBar extends StatefulWidget {
  final Widget title;
  const TransitionAppBar({this.title});

  @override
  _TransitionAppBarState createState() => _TransitionAppBarState(title:this.title);
}

class _TransitionAppBarState extends State<TransitionAppBar> {
  final Widget title;

  @override
  void initState() {
    if(controller==null)
    controller=CalendarController();
  }

  _TransitionAppBarState({this.title});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
        title: this.title,
      ),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarTween =
  SizeTween(begin: Size(150.0, 150.0), end: Size(50.0, 50.0));
  final _avatarMarginTween =
  EdgeInsetsTween(begin: EdgeInsets.zero, end: EdgeInsets.only(left: 10.0+30));
  final _avatarAlignTween =
  AlignmentTween(begin: Alignment.topCenter, end: Alignment.centerLeft);
  final _menuTween=EdgeInsetsTween(begin:EdgeInsets.only(left:15,top:25),end:EdgeInsets.only(left:10,top:45));
  final _titleMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 150.0 + 5.0),
      end: EdgeInsets.only(left: 10.0 + 50.0 + 5.0+30));
  final _titleAlignTween =
  AlignmentTween(begin: Alignment.center, end: Alignment.centerLeft);
  final Widget title;
  _TransitionAppBarDelegate({ this.title})
      :assert(title != null&&controller!=null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / 350.0;

    final avatarSize = _avatarTween.lerp(progress);
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);
    final menuAlign=_menuTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);
    final titleAlign = _titleAlignTween.lerp(progress);
    return Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          child: Stack(
           // fit: StackFit.expand,
            children: <Widget>[
              ClipRect(
                child: Container(
                  child:BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 5,sigmaX: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: menuAlign,
                        child: InkWell(
                                child:Icon(Icons.menu),
                          onTap:(){
                                  drawerOpen.value=!drawerOpen.value;
                          },
                        ),
                      ),
                    ),
                  ) ,
                ),
              ),
              Padding(
                padding: avatarMargin,
                child: Align(
                  alignment: avatarAlign,
                  child: Container(
                      width: avatarSize.width,
                      height: avatarSize.height,
                      margin: EdgeInsets.only(top:10),
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(user.photoUrl)
                          )
                      )
                  ),
                ),
              ),
              Padding(
                padding: titleMargin,
                child: Align(
                  alignment: titleAlign,
                  child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.title, child: title),
                ),
              )
            ],
          ),
        ),
        new Calender(controller:controller),
      ],
    );
  }

  @override
  double get maxExtent => 350.0;

  @override
  double get minExtent => 250.0;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return title != oldDelegate.title;
  }
}