import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:spec_app/Cards/class_card.dart';
import 'package:spec_app/Objects/Class.dart';
import 'package:spec_app/Pages/Home.dart';



class TimeTableList extends StatefulWidget {
  final ScrollController scrollController;
  final int a;
  TimeTableList(this.scrollController,this.a);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
           return Stack(
             children: [
               ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount:comingEvents.length,
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context, index) => _buildListItem(index),
               ),
             ],
           );
        }

  Widget _buildListItem(int index) {
    return Container(
      margin:comingEvents[index].title=='break'||comingEvents[index].title=='lunch'?EdgeInsets.symmetric(vertical: _listPadding / 4, horizontal: 0):EdgeInsets.symmetric(vertical: _listPadding / 2, horizontal: 0),
      child: comingEvents[index] is Class ? ClassCard(
        currentAttendance: _currentAttendance,
        classData: comingEvents[index],
        isOpen: comingEvents[index] == _selectedClass,
        onTap: comingEvents[index].title!="break"&&comingEvents[index].title!="lunch"?_handleCardTapped:null,
        scrollController: _scrollController,
        imgIndex:(index+widget.a)%s.length,
      ) : Container(),
    );
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
          _scrollController.animateTo(350, duration: Duration(milliseconds: 700), curve: Curves.easeIn);
        else if(offset>0&&offset<300)
          _scrollController.animateTo(0, duration: Duration(milliseconds: 700), curve: Curves.easeIn);
        else
        _scrollController.animateTo(offset, duration: Duration(milliseconds: 700), curve: Curves.easeOutQuad);
      }
    });
  }
}
