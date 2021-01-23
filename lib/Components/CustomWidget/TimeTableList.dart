import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spec_app/Cards/class_card.dart';
import 'package:spec_app/Components/Animations/fade_in_ui.dart';
import 'package:spec_app/Objects/Class.dart';
import 'package:spec_app/Pages/Home.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class TimeTableList extends StatefulWidget {

  final ScrollController scrollController;
  final ScrollController parentscrollController;
  final int a;
  TimeTableList(this.scrollController,this.a,this.parentscrollController);
  @override
  _TimeTableListState createState() => _TimeTableListState(scrollController);
}

class _TimeTableListState extends State<TimeTableList> {
  double _listPadding = 20;
  Class _selectedClass;

  int _currentAttendance;
  ScrollController _scrollController;
  _TimeTableListState(this._scrollController);

  @override
  void initState() {
    _currentAttendance = 150;
    //scrollController=ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InfiniteList(
      controller: _scrollController,
    //  physics: NeverScrollableScrollPhysics(),
      builder: (BuildContext context, int index) {
        return InfiniteListItem(
            contentBuilder: (context){ return FadeIn(index+0.5,_buildListItem(index));}
            ,headerBuilder: (BuildContext context){
              return Padding(
                padding: const EdgeInsets.only(left:8),
                child: Container(
                //  color:Colors.teal,
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                         "Time :- "+comingEvents[index].subtitle,
                         style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)
                     ),
                  ),
                ),
              );},);
      },
      posChildCount: comingEvents.length,

    );

        }

  Widget _buildListItem(int index){
    return comingEvents[index] is Class ? Container(
      margin:comingEvents[index].title=='break'||comingEvents[index].title=='lunch'?EdgeInsets.symmetric(vertical: _listPadding / 4, horizontal: 0):EdgeInsets.symmetric(vertical: _listPadding / 2, horizontal: 0),
      child:  ClassCard(
        currentAttendance: _currentAttendance,
        classData: comingEvents[index],
        isOpen: comingEvents[index] == _selectedClass,
        onTap: comingEvents[index].title!="break"&&comingEvents[index].title!="lunch"?_handleCardTapped:null,
        scrollController: _scrollController,
        imgIndex:(index+widget.a)%s.length,
      ),
    ) : Container(height:100, width: 20,);
  }

  void _handleCardTapped(Class data) {
    setState(() {
      //If the same drink was tapped twice, un-select it
      if (_selectedClass == data) {
        _selectedClass = null;
      }
      //Open tapped drink card and scroll to it
      else {
        _selectedClass = data;
        var selectedIndex =comingEvents.indexOf(_selectedClass);
        var closedHeight = ClassCard.nominalHeightClosed;
        //Calculate scrollTo offset, subtract a bit so we don't end up perfectly at the top
        var offset = selectedIndex * (closedHeight + _listPadding) - closedHeight * .35;
        if(offset<350&&offset>100)
          widget.parentscrollController.animateTo(350, duration: Duration(milliseconds: 700), curve: Curves.easeOut);
        else if(offset>0&&offset<300)
          widget.parentscrollController.animateTo(0, duration: Duration(milliseconds: 700), curve: Curves.easeIn);
        else
        _scrollController.animateTo(offset, duration: Duration(milliseconds: 700), curve: Curves.easeOutQuad);
      }
    });
  }
}
