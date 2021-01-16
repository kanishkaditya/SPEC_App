import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
      startingDayOfWeek: StartingDayOfWeek.sunday,
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
                  color: const Color.fromRGBO(247, 64, 106, 1.0)
                ),
            ),
              ),
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
  }
