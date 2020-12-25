import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spec_app/Objects/Event.dart';


class EventDetails extends StatelessWidget {
  final Event event;
  final TextStyle titleTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11,
      height: 1,
      letterSpacing: .2,
      fontWeight: FontWeight.w600,
      color: Color(0xffafafaf),);
  final TextStyle contentTextStyle =
  TextStyle(fontFamily: 'Oswald', fontSize: 16, height: 1.8, letterSpacing: .3, color: Color(0xff083e64),);

  EventDetails(this.event);

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4.0),
    ),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text('Opening Date'.toUpperCase(), style: titleTextStyle),
              Text(DateFormat('MMM d, H:mm').format(event.dateFrom), style: contentTextStyle),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text('Last Date'.toUpperCase(), style: titleTextStyle),
              Text(DateFormat('MMM d, H:mm').format(event.lastDate), style: contentTextStyle),
            ]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text('Prize1'.toUpperCase(), style: titleTextStyle),
              Text(event.prize1, style: contentTextStyle),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text('Prize2'.toUpperCase(), style: titleTextStyle),
              Text(event.prize2, style: contentTextStyle),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text('Prize3'.toUpperCase(), style: titleTextStyle),
              Text(event.prize3, style: contentTextStyle)
            ]),
          ],
        ),
      ],
    ),
  );
}
