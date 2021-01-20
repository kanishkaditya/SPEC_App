import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spec_app/Objects/Class.dart';
import 'package:spec_app/Objects/ManualEvent.dart';
import 'package:spec_app/Pages/Home.dart';
import 'package:spec_app/main.dart';
import 'package:table_calendar/table_calendar.dart';



final listenable=new ValueNotifier(true);
class Calender extends StatelessWidget {
  final CalendarController controller;
  Calender({this.controller});
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: controller,
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats:{CalendarFormat.month:'',CalendarFormat.week:''},
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.horizontalSwipe,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
        contentDecoration: BoxDecoration(color: Colors.white),
        contentPadding: EdgeInsets.only(left:0.0,right: 0.0,bottom: 0.0)
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
        decoration: BoxDecoration(color: Colors.white,),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
          decoration: BoxDecoration(color: Colors.white)
      ),
      onDaySelected: (date,events,_){
        selectedDay=date;
        initEvents();
      },
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, _) {
          return Stack(
            alignment: Alignment.center,
            children:<Widget> [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(247, 64, 106, 1.0)
                ),
            ),),
          Text(
          '${date.day}',
          style: TextStyle().copyWith(fontSize: 16.0),
          ),
          ],
      );
        },
    ),
    );
  }

  initEvents()
  {

    comingEvents.clear();
    var document= Firestore.instance.document('Timetable/$year/$branch/${(selectedDay.weekday-1).toString()}');
    List<dynamic>l;
    document.get().then((value){
      try{
        int i=0;
      l=value.data['schedule'];

      l.forEach((element) {
        comingEvents.add(Class(title: element['course'],subtitle: "${8+i}:00-${9+i++}:00",isToday: controller.isToday(selectedDay),teacher: element['teacher']));
      });}
      catch(e)
      {print(e);}
      listenable.value=!listenable.value;
    }
    );
  }
  }
